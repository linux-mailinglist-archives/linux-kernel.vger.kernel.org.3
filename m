Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2916C476EB8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 11:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235916AbhLPKSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 05:18:47 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:39424 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233185AbhLPKSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 05:18:46 -0500
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 68B9BC51A8;
        Thu, 16 Dec 2021 10:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1639649926; bh=0ED1qw5qwUd+dsdRK9JHhNMp0sH3Sp0EUwhiC15EUEw=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=B9tIYfAi0aN9zvsddC/ZQvRn9rscz2o+6jddo2UhaxElrobt4yrP0qIGNfMnkJ05u
         sJ6q2LxaZ11dwWmdXN1aWshaAr6ldgLYza4sVBncKcdPOjJ1EraWW9E/gf+qmYsmUe
         aEUflEVFrRQaITbKvnyrQllZYtAKWYMILGSGw0u2AzDpx/uiTpHYVOjC79iSW99ykY
         d/2+G6RunwnnNNV/CX1IaNNR/fEXhcnN8W+hNUbxgfWw4qgTdcDQbt0KbUww6+qZNA
         bl80S+hPYV/90+OTgUTPnz/nm1wi0au/3fdxRCOpYprUwnIJv/SMVoJEjBUHhvznmO
         NXnYaVjavq9AA==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 963BCA0071;
        Thu, 16 Dec 2021 10:18:45 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 08CE640096;
        Thu, 16 Dec 2021 10:18:44 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=hminas@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="K7sGrQMV";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SOW3pPsX70pcU2D0ZFiqE9plcqanu6Vy+yAhsTcs7zMH7XH7Vkujy0UjTjNviy6oKvH4ARTPP9GbyUJFXl6OJPF+58N4thn0CGcd37mTXQ9pIEV4cN9EmdtmhzFm+9teEgfQBDiUM++NoWKt9AjhxUeIJlEVB4xMb0Drh9rGJpUnZly6OW7Pnw+yj7cQimuI5yV2OqAiw+/Mrz6B2ziUW4fxw9pyZpz4ML5E4YYWg8sdSM9n1m+oJO3BpDRitWBY0eWGXTAlzE2ji8LhBxhGFjdddX/Zhr/p2IQHm1V+8e7WXNrtDPDkQU4WcKL18vwWCq7+d5Z/ZgL7U5feO+hxKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ED1qw5qwUd+dsdRK9JHhNMp0sH3Sp0EUwhiC15EUEw=;
 b=hMQLt0XECv3EVBjiO5azwVm/FQ9Ag1WRp0HfJDkXBpaHGDSM5cZMhEDUDn48cyQA0XC/LnZeFQl/jbY+PmPvlD28TFudv5usUCXEbUKUwMqOAiN8fJco/i0LdCpitz5pP8HGzFptRdtkXjcJhhS7R0mlC6XggLLflsEfxXlEV67rIMmk0GqlbXqZsMgT5HpOUUdrP7oLjjnq/2x/MFlKmrEuor5XDyJoC5fq63Pr0ecgEJS303mcwcegAALPl0YwQXDGixxqJgbqy1QBQZWJCUqmqGxJyyq+EQW5Zvc9oZzGIWpz2cPJCs6EpkONWfr4SJASrE5M7vmVKJ3sVtTgyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ED1qw5qwUd+dsdRK9JHhNMp0sH3Sp0EUwhiC15EUEw=;
 b=K7sGrQMVlkCQLkoPz6c/kPjPWUgwtX02lDUpaCFgN7s2Eh4nHa3yu3EaQthD9zVMwXlpHquTQo9jrQB5RB3Pc3ZzFwv/h7c/Xiv2nvCCuNkViqd7uj+z+wJfV95IrULFR+geZ0fIw7EJhq9p/fedEyC8FM+tcrnsAqqJOC5U3Bc=
Received: from BYAPR12MB3413.namprd12.prod.outlook.com (2603:10b6:a03:ab::15)
 by BY5PR12MB3891.namprd12.prod.outlook.com (2603:10b6:a03:1a3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Thu, 16 Dec
 2021 10:18:42 +0000
Received: from BYAPR12MB3413.namprd12.prod.outlook.com
 ([fe80::51c0:c3a7:fb8a:11e1]) by BYAPR12MB3413.namprd12.prod.outlook.com
 ([fe80::51c0:c3a7:fb8a:11e1%6]) with mapi id 15.20.4801.014; Thu, 16 Dec 2021
 10:18:42 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Amelie DELAUNAY <amelie.delaunay@foss.st.com>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: Re: [PATCH 1/1] usb: dwc2: gadget: don't try to disable ep0 in
 dwc2_hsotg_suspend
Thread-Topic: [PATCH 1/1] usb: dwc2: gadget: don't try to disable ep0 in
 dwc2_hsotg_suspend
Thread-Index: AQHX62qCxCNUA/jq7kGn/hM1/5MI16wxjyKAgABtQACAAvlhgA==
Date:   Thu, 16 Dec 2021 10:18:41 +0000
Message-ID: <e7aaa03c-ec36-f146-b721-02569c9ad9ad@synopsys.com>
References: <20211207130101.270314-1-amelie.delaunay@foss.st.com>
 <46125d28-b065-b882-8a62-9d494b271755@synopsys.com>
 <7bef0e3b-3430-1ad1-127d-7093511b6493@foss.st.com>
In-Reply-To: <7bef0e3b-3430-1ad1-127d-7093511b6493@foss.st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c6c90cbf-fe12-41fe-091e-08d9c07d6f5f
x-ms-traffictypediagnostic: BY5PR12MB3891:EE_
x-microsoft-antispam-prvs: <BY5PR12MB389166FC2EECD15F15E050B7A7779@BY5PR12MB3891.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vIZ02/nPa4BZjMpMkAw/9dA9D5elEoM9AAAQtPKDMOiHr08ykC6cH/ZEhJPdttTbPc/gkVtTHH0Wvr/fhe7mq03LSLdTThG/DjxY6KhA/hY8GvtiR/q6y+eLz6hA5XPw7d80KQN7GO3nt9E4jghWIga9InNsGsx/L0e87DGiLdhOl9jJl8EkAdy/e4MBdDTsoMEXcFKoCjVa6FKHmU9kZsSyx5j0pSfuPNMOdowzR+bgbfCC8ee4wkYlqVs7FDheZkQ97Slz2SpLmiiEMJ1HYgtmHEgH2XeKNr4Sz78tNBMh/J8mOLHfEQYhIMpVcyimUiXp0tUFngcTlNxtBpkrTI3hCoCfLS72O+2Sefg3AcrDratyfqIufEyuVEPusgudyytALqsuXiLBf1WWpCnclLonU7WV+lQhRVZsIdDH4lPDEy1W5wqBYu6B400lXKqeS33A5VYe6y+qivMTqYdZv7tQD64kPJ9HG1p53F/Z66I6s3H1PrV/SkQnZTlJ3U0mBz0+Jig+iiE+y2BcDsyF6MharX2J2wPXYNEVxuqviKQIrgJ0sjs/U/J9I3QbMrkhdIprTAYoJ0eaulF5RQhKWxuxvVe7mBjY2Q/TZmWl1dZ9eVTpijpDu+CI8Nsb3nfS8Xs0V7S+jQHQ524ShSQkalQCpupXV3MNd1CSAfi1WrmKFTTeveGL0bRyaw6uGeLNZ2OuN53bmlBgvbFBhT8J8wZ3EVbvSt61Zt2+TijXpwF7vYKCmNOYczKlfyxEfSDuRpjUYFNLLtHofi2PdFokwA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3413.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6506007)(8676002)(5660300002)(508600001)(91956017)(53546011)(6486002)(8936002)(2906002)(76116006)(4326008)(86362001)(83380400001)(31686004)(64756008)(2616005)(66556008)(66476007)(71200400001)(66946007)(26005)(66446008)(54906003)(6512007)(36756003)(31696002)(110136005)(316002)(122000001)(38100700002)(38070700005)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bU5lb0RnTU9lKzFXMEVyc0RENG9vdjY1RWlZZ1EzK3ExY1EwaUlFSUZyOFh5?=
 =?utf-8?B?YWFJM1pHR0xreG01TVZCZzAyN2ZyOXhmVE5Dd2ZyeWZSS3lDd0lxK0gxNGFm?=
 =?utf-8?B?OFpaNEhyM3l1bXJNZWxsV0dUNWhlVXVMOTZLR01GRkx1STJEbXVyWUprRWo2?=
 =?utf-8?B?bEVoUCs4djdtT2ZEcG1INENQLzY2eDR1VkxUdGlPLzZEd2hmcC9ZWVp1eU5W?=
 =?utf-8?B?eVprOThwdEQwT2xKL2lWejNYWGZIZ3Zlckhqekh4QlpybzJkT25Cbm94U2c3?=
 =?utf-8?B?L0NHTHpBMm41WWpXM3RSRFRKYk1tV1pXcVFXVGVOalpocGFHSVFIb1VsMUV0?=
 =?utf-8?B?YzRxbVhuZ3dRdEErTGdMZWVRbGhZbjJzdkJvUWxGS1A2RlRrRVArN2o2R3Aw?=
 =?utf-8?B?Wm9rUzNYRzh2d3o5TVpQdWxrWStXdjJZT3hmTjQ2WDhjR29QTFVoM2I0OWRV?=
 =?utf-8?B?YW5heU1BT2xiblM5M3QrdVh0UEJJc2FEOXZVVzNjZlB6MGFUMWxxRWpRTlI5?=
 =?utf-8?B?UlBmRzlCR1BmOVZzK3dSNE8wWWhLckp1R3NscnA4L3lSSzZ0QjBRM3Y3cUF4?=
 =?utf-8?B?VmJUMkpkOTZ1TU1KRmFiL08vSVozbFJ4UDl0R3dWVDBTMkp0QkxGZXg2WXZO?=
 =?utf-8?B?UTBXeXZWNktpNmNxQ1NrUGI1d2k1MlRvVmhNa2U2bG5lZ1lXQTlMUks4TG5h?=
 =?utf-8?B?QllINXhEU0pKRlZIMzVDOW1EMHdFa25RT3RHemYxMFJMM3U4OUxOL3orZUpr?=
 =?utf-8?B?dENhWndHTEI1YzZscmxUbmJMQjl3bzYzYlJzWURGdzEySklvbi9UcUhIZHlp?=
 =?utf-8?B?OThwcUF5REZEeGtRZy9SdkFrVVdzZzNaWmgySkJCbXJiNHZzYmZmcHhoTVZU?=
 =?utf-8?B?R2ZPbEFRUTB6VlU4RHFwTDRIVUdZQXRrZW55UzJrSXUraTZ0em9PbXQxdmZo?=
 =?utf-8?B?Unc4VS84NVdjRmpsdWE1dkd5aTllT3ZFRUkyQ1diWDdJWHQvMU9WbzFCeXJW?=
 =?utf-8?B?bE1iMlNLaUQ0ZFFGMVZlMlYzYWRDUGVxeStFTThTTWxCdzFrc2ZwYkxsUHpu?=
 =?utf-8?B?UDFSV2FIRGVjQ1k3L3RYQnl1SW02UE4wWDA5UHdlZTJhMUMvTDM1UkJpdWZ0?=
 =?utf-8?B?dmhXK09lV2V1eUFLR3dZWjEzcjJWc0xVNVFIUFFkL2MzNVhWeXFYcnNZU3R4?=
 =?utf-8?B?ZFZILzBUUDFuZnZIZzhwT0svTWJicHU0S3k2Q3c5NUUxV1N6STZGM1pERVAy?=
 =?utf-8?B?aXgzSnN5c3FCckhzd1VaMkdwMDd5VHczWnh2SzRyWUJHUy9jYURpa0pHUmdm?=
 =?utf-8?B?d1Z2T01OeUl1SW1jM29BaFhEM0lVQVEwQ3ZLcUlLbVQrMmt0UUlyUEJCTWFE?=
 =?utf-8?B?aUZEQ1ZGN0IxbWorSEZhZ0hhSzVJazg0TFdWRlBIZTRrWkJrQXFqNnBxWERM?=
 =?utf-8?B?VzBtNVFDNGdFMHFlNjN3QnBIZit1NlJZczhzdWovMlFYMnhJMERoQi9lbkFD?=
 =?utf-8?B?SGxKazV2TTFGSHBvSW03ZGY1Q0ROd0t1MmNzWXdBSkNwOVRJbytvekJROFls?=
 =?utf-8?B?SzUwbndEcGFOTEJzMENDcHVPRG5qcllwc253YWczZU5IbHF6S3ZxcEx4WHNP?=
 =?utf-8?B?K1h2ZDNaUUhPelhTRGh3K3dQcjF6TEhzYmlFN3psU1VOWlIwSVNoSUwzQzdr?=
 =?utf-8?B?T3Z3VmgweFl1bEoxQjQ4cVkxVFdyYWlmdXZOKzBWR3lGMlpRb2hOaFkvOUUw?=
 =?utf-8?B?c2xSRlFMQ0JhZCt4ZXJkcCtMYm1mNk9UQkRPTkdodnpSWDlUL3I4YU1MZlox?=
 =?utf-8?B?cUNOc0pmekQ0UFhnVzFScGJ6amxDbHZ0SHVtTFRsYlNMcTB3ZU42SkFJem5i?=
 =?utf-8?B?c1hjQkRuT0w1V1VBV09JamFCaHYvYUtVdXYxby9HV2wyZjU3U0RqZ2VEelh5?=
 =?utf-8?B?S2Z1TDR5YVRmaE9UZkRmYXh2RWZ4eGQ5M0NRWDhzUnJUQmJsTjdsSGZOOW1J?=
 =?utf-8?B?dWtXazYzcCtTNG1DdDIrS1JyamVxTmJOek9zMTdzU1ZtSTg1SlBrTllmQkkx?=
 =?utf-8?B?aGxqTjlDTm0vcWZWQ1VuOGpJK2hnb2RPR0JaZ2JwWlg4WjUvN0ZRMjMrVG1t?=
 =?utf-8?B?M1pId3lxWS91Ri9LT3VYRXcvVkNoWWZOclQ0QUo1SDRmWXF3N21CM2YrSVpt?=
 =?utf-8?B?TFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <163EE421C7B7D147BEDEC22DE8D027F3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6c90cbf-fe12-41fe-091e-08d9c07d6f5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2021 10:18:41.8455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F2XeOS/xMpY8B56F8TFMyat1qh6YumXtrz4E5b7fsEncv/2es6XXQXgdPOHwkQAFiDynKJ7CDaH65E0wUiIBJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3891
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW1lbGllLA0KDQpPbiAxMi8xNC8yMDIxIDQ6NTMgUE0sIEFtZWxpZSBERUxBVU5BWSB3cm90
ZToNCj4gSGkgTWluYXMsDQo+IA0KPiBPbiAxMi8xNC8yMSA3OjIyIEFNLCBNaW5hcyBIYXJ1dHl1
bnlhbiB3cm90ZToNCj4+IEhpIEFtZWxpZSwNCj4+DQo+PiBPbiAxMi83LzIwMjEgNTowMSBQTSwg
QW1lbGllIERlbGF1bmF5IHdyb3RlOg0KPj4+IENhbGxpbmcgZHdjMl9oc290Z19lcF9kaXNhYmxl
IG9uIGVwMCAoaW4vb3V0KSB3aWxsIGxlYWQgdG8gdGhlIGZvbGxvd2luZw0KPj4+IGxvZ3MgYmVm
b3JlIHJldHVybmluZyAtRUlOVkFMOg0KPj4+IGR3YzIgNDkwMDAwMDAudXNiLW90ZzogZHdjMl9o
c290Z19lcF9kaXNhYmxlOiBjYWxsZWQgZm9yIGVwMA0KPj4+IGR3YzIgNDkwMDAwMDAudXNiLW90
ZzogZHdjMl9oc290Z19lcF9kaXNhYmxlOiBjYWxsZWQgZm9yIGVwMA0KPj4+DQo+Pg0KPj4gVGhp
cyBtZXNzYWdlcyBwcmludGVkIGZvciBFUDAgT1VUIHdoaWNoIGNhbid0IGJlIGRpc2FibGVkLCBi
dXQgRVAwIElODQo+PiBjYW4gYW5kIHNob3VsZCBiZSBkaXNhYmxlZC4gWW91ciBwYXRjaCBleGNs
dWRlIEVQMCBJTiBmcm9tIGRpc2FibGluZyANCj4+IGZsb3cuDQo+IA0KPiANCj4gVGhhbmtzIGZv
ciB0aGUgcmV2aWV3LiBJIHdvbmRlciB3aHkgdGhlbiBpbiBkd2MyX2hzb3RnX3VkY19zdG9wIGFu
ZCANCj4gZHdjMl9oc290Z19jb3JlX2luaXRfZGlzY29ubmVjdGVkIEVQMCBJTiBpcyBub3QgZGlz
YWJsZWQgKGxvb3Agc3RhcnRzIA0KPiBmcm9tIEVQMSkgPw0KPiANCj4gRHVlIHRvOg0KPiAgwqDC
oMKgwqAvKiBTYW1lIGR3YzJfaHNvdGdfZXAgaXMgdXNlZCBpbiBib3RoIGRpcmVjdGlvbnMgZm9y
IGVwMCAqLw0KPiAgwqDCoMKgwqBoc290Zy0+ZXBzX291dFswXSA9IGhzb3RnLT5lcHNfaW5bMF07
DQoNClllcywgSSBtaXNzZWQgdGhpcy4NCg0KQWN0dWFsbHksIHRoZXJlIHZlcnkgc21hbGwgcHJv
YmFiaWxpdGllcyB0aGF0IEVQMCBJTiB3aWxsIGJlIGVuYWJsZWQgDQp3aGVuIHBlcmZvcm1pbmcg
c3RvcF91ZGMgb3Igc3VzcGVuZC4gU28sIEknbSBnb2luZyB0byBBQ0sgeW91ciBpbml0aWFsIA0K
cGF0Y2guDQoNClRoYW5rcywNCk1pbmFzDQoNCj4gDQo+IHRoZSBjb25kaXRpb24gaW4gZHdjMl9o
c290Z19lcF9kaXNhYmxlIHRvIGRpc3BsYXkgdGhlIGVycm9yIGlzIGFsd2F5cyANCj4gdHJ1ZSBm
b3IgRVAwLCB3aGF0ZXZlciB0aGUgZGlyZWN0aW9uLCBzbyB0aGUgbG9nIGFwcGVhcnMgZm9yIEVQ
MCBJTiAmIE9VVDoNCj4gIMKgwqDCoMKgaWYgKGVwID09ICZoc290Zy0+ZXBzX291dFswXS0+ZXAp
IHsNCj4gIMKgwqDCoMKgwqDCoMKgIGRldl9lcnIoaHNvdGctPmRldiwgIiVzOiBjYWxsZWQgZm9y
IGVwMFxuIiwgX19mdW5jX18pOw0KPiAgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FSU5WQUw7DQo+
ICDCoMKgwqDCoH0NCj4gDQo+IFNob3VsZCBhbGwgbG9vcHMgbmVlZCB0byBiZSBmaXhlZCB0byBz
dGFydCBsb29wIGZyb20gRVAwIGJ1dCBleGNsdWRlIEVQMCANCj4gT1VUIGZyb20gYmVpbmcgZGlz
YWJsZWQsIHNvIHRoYXQgRVAwIElOIGNhbiBiZSBkaXNhYmxlZCA/IGUuZy4gZm9yIA0KPiBkd2My
X2hzb3RnX3N1c3BlbmQ6DQo+IA0KPiANCj4gJCBnaXQgZGlmZiBkcml2ZXJzL3VzYi9kd2MyL2dh
ZGdldC5jDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MyL2dhZGdldC5jIGIvZHJpdmVy
cy91c2IvZHdjMi9nYWRnZXQuYw0KPiBpbmRleCAxMWQ4NWE2ZTBiMGQuLjBjMTIyMTliZmJmNCAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMi9nYWRnZXQuYw0KPiArKysgYi9kcml2ZXJz
L3VzYi9kd2MyL2dhZGdldC5jDQo+IEBAIC00MjMxLDcgKzQyMzEsNyBAQCBzdGF0aWMgaW50IGR3
YzJfaHNvdGdfZXBfZGlzYWJsZShzdHJ1Y3QgdXNiX2VwICplcCkNCj4gDQo+ICDCoMKgwqDCoMKg
wqDCoCBkZXZfZGJnKGhzb3RnLT5kZXYsICIlcyhlcCAlcClcbiIsIF9fZnVuY19fLCBlcCk7DQo+
IA0KPiAtwqDCoMKgwqDCoMKgIGlmIChlcCA9PSAmaHNvdGctPmVwc19vdXRbMF0tPmVwKSB7DQo+
ICvCoMKgwqDCoMKgwqAgaWYgKGVwID09ICZoc290Zy0+ZXBzX291dFswXS0+ZXAgJiYgIWRpcl9p
bikgew0KPiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRldl9lcnIoaHNvdGctPmRl
diwgIiVzOiBjYWxsZWQgZm9yIGVwMFxuIiwgX19mdW5jX18pOw0KPiAgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRUlOVkFMOw0KPiAgwqDCoMKgwqDCoMKgwqAgfQ0KPiBA
QCAtNTA3Nyw3ICs1MDc3LDcgQEAgaW50IGR3YzJfaHNvdGdfc3VzcGVuZChzdHJ1Y3QgZHdjMl9o
c290ZyAqaHNvdGcpDQo+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZm9yIChlcCA9
IDA7IGVwIDwgaHNvdGctPm51bV9vZl9lcHM7IGVwKyspIHsNCj4gIMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGhzb3RnLT5lcHNfaW5bZXBdKQ0KPiAN
Cj4gZHdjMl9oc290Z19lcF9kaXNhYmxlX2xvY2soJmhzb3RnLT5lcHNfaW5bZXBdLT5lcCk7DQo+
IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoaHNvdGct
PmVwc19vdXRbZXBdKQ0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgaWYgKGVwID4gMCAmJiBoc290Zy0+ZXBzX291dFtlcF0pDQo+IA0KPiBkd2MyX2hzb3Rn
X2VwX2Rpc2FibGVfbG9jaygmaHNvdGctPmVwc19vdXRbZXBdLT5lcCk7DQo+ICDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgfQ0KPiAgwqDCoMKgwqDCoMKgwqAgfQ0KPiANCj4gUmVnYXJk
cywNCj4gQW1lbGllDQo+IA0KPj4NCj4+IFRoYW5rcywNCj4+IE1pbmFzDQo+Pg0KPj4+IFRvIGF2
b2lkIHRoZXNlIHR3byBsb2dzIHdoaWxlIHN1c3BlbmRpbmcsIHN0YXJ0IGRpc2FibGluZyB0aGUg
ZW5kcG9pbnQNCj4+PiBmcm9tIHRoZSBpbmRleCAxLCBhcyBkb25lIGluIGR3YzJfaHNvdGdfdWRj
X3N0b3A6DQo+Pj4NCj4+PiDCoMKgwqDCoC8qIGFsbCBlbmRwb2ludHMgc2hvdWxkIGJlIHNodXRk
b3duICovDQo+Pj4gwqDCoMKgwqBmb3IgKGVwID0gMTsgZXAgPCBoc290Zy0+bnVtX29mX2Vwczsg
ZXArKykgew0KPj4+IMKgwqDCoMKgwqDCoMKgIGlmIChoc290Zy0+ZXBzX2luW2VwXSkNCj4+PiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGR3YzJfaHNvdGdfZXBfZGlzYWJsZV9sb2NrKCZoc290Zy0+
ZXBzX2luW2VwXS0+ZXApOw0KPj4+IMKgwqDCoMKgwqDCoMKgIGlmIChoc290Zy0+ZXBzX291dFtl
cF0pDQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkd2MyX2hzb3RnX2VwX2Rpc2FibGVfbG9j
aygmaHNvdGctPmVwc19vdXRbZXBdLT5lcCk7DQo+Pj4gwqDCoMKgwqB9DQo+Pj4NCj4+PiBTaWdu
ZWQtb2ZmLWJ5OiBBbWVsaWUgRGVsYXVuYXkgPGFtZWxpZS5kZWxhdW5heUBmb3NzLnN0LmNvbT4N
Cj4+PiAtLS0NCj4+PiDCoMKgIGRyaXZlcnMvdXNiL2R3YzIvZ2FkZ2V0LmMgfCAyICstDQo+Pj4g
wqDCoCAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4+Pg0K
Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MyL2dhZGdldC5jIGIvZHJpdmVycy91c2Iv
ZHdjMi9nYWRnZXQuYw0KPj4+IGluZGV4IGI4ODRhODNiMjZhNi4uZWUzMWY5YTMyOGRhIDEwMDY0
NA0KPj4+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzIvZ2FkZ2V0LmMNCj4+PiArKysgYi9kcml2ZXJz
L3VzYi9kd2MyL2dhZGdldC5jDQo+Pj4gQEAgLTUwODYsNyArNTA4Niw3IEBAIGludCBkd2MyX2hz
b3RnX3N1c3BlbmQoc3RydWN0IGR3YzJfaHNvdGcgKmhzb3RnKQ0KPj4+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGhzb3RnLT5nYWRnZXQuc3BlZWQgPSBVU0JfU1BFRURfVU5LTk9XTjsNCj4+PiDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBzcGluX3VubG9ja19pcnFyZXN0b3JlKCZoc290Zy0+bG9jaywgZmxh
Z3MpOw0KPj4+IC3CoMKgwqDCoMKgwqDCoCBmb3IgKGVwID0gMDsgZXAgPCBoc290Zy0+bnVtX29m
X2VwczsgZXArKykgew0KPj4+ICvCoMKgwqDCoMKgwqDCoCBmb3IgKGVwID0gMTsgZXAgPCBoc290
Zy0+bnVtX29mX2VwczsgZXArKykgew0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
aWYgKGhzb3RnLT5lcHNfaW5bZXBdKQ0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBkd2MyX2hzb3RnX2VwX2Rpc2FibGVfbG9jaygmaHNvdGctPmVwc19pbltlcF0tPmVw
KTsNCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChoc290Zy0+ZXBzX291dFtl
cF0pDQo+Pg0KDQo=
