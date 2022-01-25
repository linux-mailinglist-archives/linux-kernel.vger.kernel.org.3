Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB0BE49A88A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1319328AbiAYDIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 22:08:31 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:39534 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S3419981AbiAYCWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 21:22:00 -0500
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A8192C08F0;
        Tue, 25 Jan 2022 02:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1643077317; bh=annBQbltbMx+QDSmU5SaoWWGXUpbm6+5F2jGFx+x4ZE=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=P3lzW9a7EStOjDVVlklfdkj3HumVuFzwpXYy6d6CRCTxiBJWlNPVKxY1pudvjznmf
         GgXQckwvX7G6rCaI9Afi3jl5IjicVpL5X5jc3IHtY4ITclwD5FDVg5f5BELD2JbwJD
         SybYZ4WTDzWpxsH7Vv07WIxlzBvFnX6wUSlVTP4XpJg9dTauc9QqwNnmBfF30ydzZA
         1plgtqIVfNDQk2FnG7TNtYGjrYLRICvZ6bu0/2SAIhvq31jO5U3Eog6JCBVgWQgcLH
         tWvLS5+U3CWXXYWXCsj5g6KcSEzvmeRHxKAR6NzJe4J6qPmck0AwnqhVMWwglFUhww
         BtAgr+5C/MXuw==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 060D5A0071;
        Tue, 25 Jan 2022 02:21:56 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2173.outbound.protection.outlook.com [104.47.73.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 7218580071;
        Tue, 25 Jan 2022 02:21:55 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="qguyPbSl";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OMMnTepvW0uY6xXgruWJeoABMZUe27Cm3H+zich8XHFi+P/Uyn5yLVx2MFdBAEOf/9QnFQNgy6EVly/TCoGO+oDsWMcsPmHlSagEbLwe32wvK49GsW38OPa+r48dWkcXEfeO/FGTi1EGEhBorpxsVatzKaQ1EgStj39ZOp0hoKZ9s8giEVl063FfDSK5ISn1Np4oGRxiRYedMCzpEx/DWrvMUkZIYBaaUt4bk+N/9VHVf1IZCupU24hXIUsjWb8+1O3ENkIxJCd2G3ib+ILt7Dg2RbwpS/Rn/bSdfmlAlAo2G5NssuX1JN52m85QrGEVVNp/HQoDeiRZ0wjHKGGjvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=annBQbltbMx+QDSmU5SaoWWGXUpbm6+5F2jGFx+x4ZE=;
 b=gzYV6lSsHqe+QhazJyq94NNDMy1FSaoOc9O15cj1w/RYAEWpkFyui0qI6wYkRf/cSFaYj00d1NPhAjffe9IuowmTECG0xwTc8yrW8OuCNXCKcq7G1Qpv00q5GePjz0m+P6oGAPd6oL919TsFLl4Z1k74HiRZdya/5vW0LNK1zb5/vDsxew032/XRwHpEzUIaN/43fviWXeOd1/+fbRqq/0v3zGxg7F+AicHP/2u3Sv85wgzONOiPsuYtS9imtA5qiKutpYHVNKf8aBaeoB9CLJYz0sYDALk3UeqAhzQux/zhU6D/HIkvjbTn7N516Py8m4otUxDzyvZ1IxrnL7viKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=annBQbltbMx+QDSmU5SaoWWGXUpbm6+5F2jGFx+x4ZE=;
 b=qguyPbSlXNjEKqktVTZ6b9oRyCDn6y+NRD9MD/ueI2zaepAzNAhZVKx+lXvWV+j737WSDkHZo2sFNmhGg5bukbH8Qi7avyShg/cdNZAN/bWVzwKWUGxEu2zxgZt8QadfA7rHuBzJ4ljlTL8VS25phxsqlCZ+Tix79EgTl7grO60=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by CH2PR12MB3800.namprd12.prod.outlook.com (2603:10b6:610:2d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Tue, 25 Jan
 2022 02:21:52 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::c5f4:5df4:b5bf:b13e]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::c5f4:5df4:b5bf:b13e%3]) with mapi id 15.20.4909.017; Tue, 25 Jan 2022
 02:21:52 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Sean Anderson <sean.anderson@seco.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC:     Felipe Balbi <balbi@kernel.org>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Baruch Siach <baruch@tkos.co.il>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 5/7] usb: dwc3: Add snps,ref-clock-frequency-hz
 property for ACPI
Thread-Topic: [PATCH v2 5/7] usb: dwc3: Add snps,ref-clock-frequency-hz
 property for ACPI
Thread-Index: AQHYDMsCXryFLD+72Eq2rM87+o7aVaxyzjwAgAAGnICAAAHygIAAND+A
Date:   Tue, 25 Jan 2022 02:21:52 +0000
Message-ID: <7e64e9c7-70e3-d833-34dc-272048d29038@synopsys.com>
References: <20220119002438.106079-1-sean.anderson@seco.com>
 <20220119002438.106079-6-sean.anderson@seco.com>
 <5275ea80-400e-d1de-f03e-c2ea81f959dc@synopsys.com>
 <e808f3e2-55ad-e8bb-097c-81e4a82d0bb2@seco.com>
 <6ffae12d-3116-c4f2-09c3-32e448bb4717@seco.com>
In-Reply-To: <6ffae12d-3116-c4f2-09c3-32e448bb4717@seco.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d50063c9-7122-4632-e48b-08d9dfa9734f
x-ms-traffictypediagnostic: CH2PR12MB3800:EE_
x-microsoft-antispam-prvs: <CH2PR12MB38003BD4BC591AD20CD3F887AA5F9@CH2PR12MB3800.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X/Fj1swE3Hwab+ZnqCB5ABmnTC3JC4HfaI99fIeSXzYwxMG4lvpGr64n7kvvqgE/E3wlV3kdQ90lrM+HbwPNEC6psLlUrv7sXJKnxLI1g6cnEAyoiL9LBXbHLgi5JOkH7qBvfE80GY7RZE95ZutRi+L2aw+lzwUX82XAMhg7+cKMztTDVR6pCP/gCQ/Bn0hQyt8dkCJL8MiZjz86X+TyHtubEbx68qAdJtP16/oJoE5GM92y8ZZVaEz7HxUhvquHQzE2EOhf8h6CGCAgDGE2XRXUEAoU/BbYbcWSqY4DeZ8/NAZTHRvPcqM+bunIMJQbYNnW78+slGIfurzo16EdSoQmK1t08khL7HPikVYf/K8cdpgqWuVIaDFo1zNzfhVbdtFaEF8YPOoO+Zt98QS8Oi+nGz2LtfRFJdkMk8FIgMVWWPLW2/3sd85AVl30bg68WhBuGkcigUlxcGEDFRxldsWWrMMKB/09AteEJYxuJyWP/SY0TID3lGZcseLjHK7SHdHyJIQzwqgkMLgkXDWsyrP0qtemmgx/F91RFPwdqC2L857sHY7OeboVIJMHi6tqXhOMpLQxB84wdry5tlEpG7D2EmZZfjMLpS8LVYR86zieOI6g7f9mi+ybGgkHAzHQ4GwrNh6Jq5eOozY/GfK8e1SbXss+Qjov/MXAERVQTr3CaF0MvxVqATlwd/8YT59EyBM5tFIiWrmOnX/Pb8Bu/OHVkkDvc5fi8dAFSRlpSZJAVUg3HI/9XdrMzNPGTkmDLNBf6peFelu1ieP9VkW7QW+bQTZU/UBdUNllHHgJf8jRmQDmCPdMB40To8pcTQAWX4aAFTtdhOnSDkXOtST/T3x/OiJfMfiVn7sT5Pl/MB4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(66446008)(6512007)(966005)(26005)(2616005)(2906002)(38100700002)(186003)(6486002)(71200400001)(6506007)(8676002)(5660300002)(31686004)(53546011)(36756003)(8936002)(316002)(54906003)(66946007)(66556008)(508600001)(4326008)(31696002)(122000001)(83380400001)(38070700005)(76116006)(64756008)(110136005)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RW1Tb0o4MjF4QytSQmdNZUxMUzh1NFIwOE1MQjFJb0ExbGhEWkpMZ0N5NlBa?=
 =?utf-8?B?S0Rudk44WkJWZGRRRG5xSjFOTVZXY2lvdEtHR3pyQmNhRjVDWnFBTUZnVWdO?=
 =?utf-8?B?VjV6L1FGN0ZiUXpZQmI1Tld4LzJyUWRqWGF0QUlTeFlZYWFxS2lMSXlZNytM?=
 =?utf-8?B?bkFiNjd6UUVNcExaWlhlcVNDeEdVSE5KL2k3cHFOSUFuTkh0Ullod2pHY2g2?=
 =?utf-8?B?MW5PZFQxREZyOWUvaHVuQ25CT0htb0JnVjZpREk3ZzA1a28yVVhVcWp6RUxB?=
 =?utf-8?B?aDNDNGRQY1BCUFlWWGZ1T2xwZER3cUNKMFgwRkc0T1lub21Sa0NxRFV4WFZL?=
 =?utf-8?B?MEJuQlJxaWNuWDNZd3BEVjNhSStFL3dUUENvelBKMGRFcng5NUFUb3kyZmhM?=
 =?utf-8?B?K092K1hlbmNtN3ZiRGRzRFQ3M0poV3l5UE44TnZQQUVXUThNaFJIQWg0azZ1?=
 =?utf-8?B?OEdpMXZINmwrMFFydXBxRWtzWU9odFRuMVVTMUFzU0RGcWRQQXhxSmt4Y1B4?=
 =?utf-8?B?aExaK3p6VTVZQk9vM1RuNVZaaXpTbk1NMS9kWkNlckcvOEFBTlJ5SmU3ZmxZ?=
 =?utf-8?B?R2s3cDNVWTcyVU10VGp6UnhTTHVuT0ZWeVlDdnJHSjgxbkZ3c2MzMVdlRUJk?=
 =?utf-8?B?UFdYMEhlU3hKTzAySzd1eWtXdHpYR3BidzAzU1QrSGl3YVYyMnJKOFBVaWoz?=
 =?utf-8?B?ZkJkdkVGMlNwQzRBbHVNbGlQUjl2NjIrL3F6MktOcS9hbkhqVDAzeE9TQklp?=
 =?utf-8?B?UnRPUThoeEdPRUNhR1dlVXZBRUhub0lkdGhLdUY3Z3YyQjF0anJaUllZNmpz?=
 =?utf-8?B?VXZzck9pcXlPVEpObE5YMTJDOEt2TWZSakJSMDB5UUcyY2YwZTMxUlhwWGt6?=
 =?utf-8?B?WldQRnhwRENkU1V1aU5iVW1lQWt0TWdkV0JCL1M5dUpTL0lURkRwWEN6U0hr?=
 =?utf-8?B?RDJQUkhYN0VEQ1ZyMlVPTFJiK0xLQUZNaE9iOU05VzJSY2JWZ3hmd1luam9t?=
 =?utf-8?B?TXM4RFNheE9pTmhkdmlBVGt3S0RzZ25la1ArYWdFZWpKOXpPbGs5ajVCaGJO?=
 =?utf-8?B?L3VKK1A3MWRWVHNSR3djUTRMclhVeXdLSzY3cWZSWUlHdjQ3RkdUN3NVdU1K?=
 =?utf-8?B?aHQyc2Q0OTJaNGk3U1BUdXNDWklKWE4zZE1kV21VUGlGaWdGNmdBRk4yL3pk?=
 =?utf-8?B?OEdkRGFlaFBWSnBlOUFMdWJSS0pPUkFjZ25XWXlSdU5GdERUY3JhNlhSYWdM?=
 =?utf-8?B?alBDcFowSTY3OFdzUzQ5bFFwd1VCVE5iMzlvYnpHbWRrcEdJMG5zc3FpRk5k?=
 =?utf-8?B?S00vM0dwV0NsbncxOEdqS2tRam5nQUZnUG1kZjg0Zkw0clF0Tzh5STZsYlhH?=
 =?utf-8?B?MVpXOEpBdHlseW1lZnc2YmU4UGgwTU90bFkzS0JpakRjVUx1N2RoalVmb3I5?=
 =?utf-8?B?RFIvTmNIczVtelFKYldEQkpSMysrMVllTXY4UDNLY2FsclltYkVJS2QvWlR6?=
 =?utf-8?B?YVB6TlJVU3dmWGNySE0reGhKQ0wzU1BsUWNublYzRWpPR1UwYVRrNmtYTllz?=
 =?utf-8?B?WEwvaC9rNU44emZrREtoSXZNUHB5Nm5KTS9DeUhCdXdLL3laQ3ViNWlSRXE5?=
 =?utf-8?B?QkJpaXdyYytFaGlmWjlHalBpdUx4bFVkSFhVRVJqQWpnMkc2L0JNMXlLYmds?=
 =?utf-8?B?cTFFSCtqWWw4NFVRQ0tBYUo5RHZGNnFzY0dOaXVIQURoYVk5dmN2Qnk4MFpD?=
 =?utf-8?B?QnA4NXJLUVpvcmdsZmg0MTZoMWNzdmZkTTdnRDgxbHdTVU82eWJDRGVDajA0?=
 =?utf-8?B?bkNxeFJyMkhCOUNhQ1QvZmxJOWNIL0Z0YW10S0FZVnl1UDd2RGJuT050S0RC?=
 =?utf-8?B?WUZBb2MzU3NoVHVrS3lYbGtxOW8zY2RXZmJKU1NSUi9pMFFBK2JXMDVRbXB3?=
 =?utf-8?B?aVNVWWUyT1kyMG16UkUybHEwSUZjOHJrQnhhY1ZYZ1lTQ0RpbHdhb3ZuSTBK?=
 =?utf-8?B?bE5qWXl0TEVJblh3VS83SVZKSUZxbDhvaFNBWUo0SEhaMzg3b0ZTNkd3Y0RO?=
 =?utf-8?B?NjRnZk5vSDJtaVV2OEU4bE5hRVk3QSs5UlRWL0VhZmoxN2VsNCtDQ2N2MWRV?=
 =?utf-8?B?U1VINVVaRlIwdEIxbWF2bGMvVGJSMVlqaFByRzVmQXRqT09VQnI4eUNUSkdy?=
 =?utf-8?Q?hnEapYf9NqtLmcw8mufxAXo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B45C30EB70C3BA458E044CB96F3F050B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d50063c9-7122-4632-e48b-08d9dfa9734f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2022 02:21:52.4062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IfIbrIwhWXdNHLatzeBPb4r/2tyL5aD2f9drGlVpi4rwODSBtdvK+57cwZ2qjtR0HgeTJ7/5jRK3BN/lPqQ8Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3800
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U2VhbiBBbmRlcnNvbiB3cm90ZToNCj4gDQo+IA0KPiBPbiAxLzI0LzIyIDY6MDcgUE0sIFNlYW4g
QW5kZXJzb24gd3JvdGU6DQo+PiBPbiAxLzI0LzIyIDU6NDQgUE0sIFRoaW5oIE5ndXllbiB3cm90
ZToNCj4+PiBTZWFuIEFuZGVyc29uIHdyb3RlOg0KPj4+PiBUaGlzIHByb3BlcnR5IGFsbG93cyBz
ZXR0aW5nIHRoZSByZWZlcmVuY2UgY2xvY2sgZnJlcXVlbmN5IHByb3Blcmx5IGZvcg0KPj4+PiBB
Q1BJLWJhc2VkIHN5c3RlbXMuIEl0IGlzIG5vdCBkb2N1bWVudGVkIHVuZGVyIGR0LWJpbmRpbmdz
LCBzaW5jZSBpdCBpcw0KPj4+PiBub3QgaW50ZW5kZWQgZm9yIHVzZSBvbiBEVC1iYXNlZCBzeXN0
ZW1zLiBEVC1iYXNlZCBzeXN0ZW1zIHNob3VsZCB1c2UNCj4+Pj4gdGhlIGNsb2NrcyBwcm9wZXJ0
eSBpbnN0ZWFkLg0KPj4+Pg0KPj4+PiBGcmVxdWVuY3kgaXMgcHJlZmVycmVkIG92ZXIgcGVyaW9k
IHNpbmNlIGl0IGhhcyBncmVhdGVyIHByZWNpc2lvbiB3aGVuDQo+Pj4+IHVzZWQgaW4gY2FsY3Vs
YXRpb25zLg0KPj4+Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBTZWFuIEFuZGVyc29uIDxzZWFuLmFu
ZGVyc29uQHNlY28uY29tPg0KPj4+PiAtLS0NCj4+Pj4NCj4+Pj4gQ2hhbmdlcyBpbiB2MjoNCj4+
Pj4gLSBOZXcNCj4+Pj4NCj4+Pj4gIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5jIHwgNiArKysrLS0N
Cj4+Pj4gIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5oIHwgNCArKystDQo+Pj4+ICAyIGZpbGVzIGNo
YW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4+Pj4NCj4+Pj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMN
Cj4+Pj4gaW5kZXggODgzZTExOTM3N2YwLi41ZjNkYzVmNmNiY2IgMTAwNjQ0DQo+Pj4+IC0tLSBh
L2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+Pj4+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvY29y
ZS5jDQo+Pj4+IEBAIC0zNTAsOCArMzUwLDggQEAgc3RhdGljIHZvaWQgZHdjM19yZWZfY2xrX3Bl
cmlvZChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPj4+PiAgCXUzMiByZWc7DQo+Pj4+ICAJdW5zaWduZWQg
bG9uZyBkZWNyLCBmbGFkaiwgcmF0ZSwgcGVyaW9kOw0KPj4+PiAgDQo+Pj4+IC0JaWYgKGR3Yy0+
cmVmX2Nsaykgew0KPj4+PiAtCQlyYXRlID0gY2xrX2dldF9yYXRlKGR3Yy0+cmVmX2Nsayk7DQo+
Pj4+ICsJaWYgKGR3Yy0+cmVmX2NsayB8fCBkd2MtPnJlZl9jbGtfZnJlcSkgew0KPj4+PiArCQly
YXRlID0gY2xrX2dldF9yYXRlKGR3Yy0+cmVmX2NsaykgPzogZHdjLT5yZWZfY2xrX2ZyZXE7DQo+
Pj4+ICAJCWlmICghcmF0ZSkNCj4+Pj4gIAkJCXJldHVybjsNCj4+Pj4gIAkJcGVyaW9kID0gTlNF
Q19QRVJfU0VDIC8gcmF0ZTsNCj4+Pj4gQEAgLTE0OTIsNiArMTQ5Miw4IEBAIHN0YXRpYyB2b2lk
IGR3YzNfZ2V0X3Byb3BlcnRpZXMoc3RydWN0IGR3YzMgKmR3YykNCj4+Pj4gIAkJCQkgJmR3Yy0+
ZmxhZGopOw0KPj4+PiAgCWRldmljZV9wcm9wZXJ0eV9yZWFkX3UzMihkZXYsICJzbnBzLHJlZi1j
bG9jay1wZXJpb2QtbnMiLA0KPj4+PiAgCQkJCSAmZHdjLT5yZWZfY2xrX3Blcik7DQo+Pj4+ICsJ
ZGV2aWNlX3Byb3BlcnR5X3JlYWRfdTMyKGRldiwgInNucHMscmVmLWNsb2NrLWZyZXF1ZW5jeS1o
eiIsDQo+Pj4+ICsJCQkJICZkd2MtPnJlZl9jbGtfZnJlcSk7DQo+Pj4NCj4+PiBQbGVhc2UgYWxz
byBkb2N1bWVudCBpbiBkd2MzIERUIGZpbGUgd2hlbmV2ZXIgd2UgYWRkIGEgbmV3IHByb3BlcnR5
Lg0KPj4NCj4+IFRoaXMgaXMgaW50ZW50aW9uYWxseSB1bmRvY3VtZW50ZWQsIGFzIG5vdGVkIGlu
IHRoZSBjb21taXQgbWVzc2FnZS4gDQo+PiBSb2IgSGVycmluZyBoYXMgc2FpZCB0aGF0IGR0LWJp
bmRpbmdzIHNob3VsZCBvbmx5IGRvY3VtZW50IHByb3BlcnRpZXMNCj4+IGludGVuZGVkIGZvciBk
ZXZpY2UtdHJlZS4NCj4gDQo+IGNvbnRleHQ6IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19o
dHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAxODEyMTkyMDI3MzQuR0EzMTE3OEBib2d1cy9f
XzshIUE0RjJSOUdfcGchSUZhWkU3My1SUXpZbmhMU1BLdUZHcXJldWRCY3lWaTZUOWxHRzVieWJs
em9DOWlfZGlhQ0JlX3NvQXlIUEN1cHVhX1QkIA0KPiANCj4gVGhpcyBwYXRjaCB3YXMgbGF0ZXIg
cmVzdWJtaXR0ZWQgYXMgMjRiYzZlNjhlZmEwICgic2VyaWFsOiBzYzE2aXM3eHg6IA0KPiBSZXNw
ZWN0IGNsb2NrLWZyZXF1ZW5jeSBwcm9wZXJ0eSIpIHdpdGhvdXQgdGhlIGR0LWJpbmRpbmdzIGRv
Y3VtZW50YXRpb24uDQo+IA0KPiArQ0MgUm9iIGlmIGhlIHdhbnRzIHRvIGNvbW1lbnQgb24gdGhp
cyBzcGVjaWZpYyBzaXR1YXRpb24uDQo+IA0KPiAtLVNlYW4NCg0KSWYgdGhpcyBpcyBhY2NlcHRh
YmxlLCB0aGF0J3MgZ3JlYXQhIEl0IG9wZW5zIHVwIG1vcmUgb3B0aW9ucyB0byB0aGUgUENJDQpn
bHVlIGRyaXZlcnMuIE1heWJlIHdlIHNob3VsZCBhbHNvIGRvY3VtZW50IGlubGluZSBmb3IgcHJv
cGVydGllcyB0aGF0DQpkb24ndCBleGlzdCBpbiB0aGUgRFQgYmluZGluZy4NCg0KVGhhbmtzLA0K
VGhpbmgNCg0K
