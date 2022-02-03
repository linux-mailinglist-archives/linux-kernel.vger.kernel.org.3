Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9824A7E20
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 03:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349029AbiBCCyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 21:54:20 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:49804 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233002AbiBCCyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 21:54:18 -0500
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 2363F40399;
        Thu,  3 Feb 2022 02:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1643856858; bh=g58bStwD3wwhMbv9tdPnGGYBBNUPbE5jQLMDDh8xYjY=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=SCk25dcr0ginbnWHhLxUc3cAmVpIOByAx9ZwF4/bHhgUD/RZRT0J99h+pDhESB+eF
         Egg1p8jlioMT60GiIAZXWxFbE7MsNwktZIzXVcvWhyMd7GyJi6KsOpYDeQNHvuOBuY
         RgyXyGX+wZkfADrOHFCVz8MPBF8RLM20reMrGFmXIco15DbfnBlp7b4EiVRhVTFYOf
         Vxk2tOMylzQmNNVPTweL3sJjb29naCi0OeyYUuv3yy2MjOymYcxsMyqr/jyc6AWy5K
         LUG6PGBQo6TB0OEdN58e6KFqje97+5IqnZvEkNUFtw+KKCxxvmRDRebaDVI/pACepC
         BLpeGeP6tJCFQ==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id A14CFA0070;
        Thu,  3 Feb 2022 02:54:17 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 1BD5E4004F;
        Thu,  3 Feb 2022 02:54:17 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="hFhshdR0";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=huPT0IIWElVajEhkDWHqWPaX4fnTiuovBqRJLDrwOdSf7bq3JUdBnzDMs1byP++kU7qx/qnfamUeBs3ARzhWHZ7irWCfn73uCGuXcOXsxpPq/BDCZLmvVgf9SJ7KkY/FAMQ4qXhFJf8a6uIovJ7zD95qploLZV/1f16UyskSuJOjV+dJZJXZE5lToQFjL+qtnvY2f5oDx01NmRiBNdyjOnFrUa8os9mDG+YdEK4n2xHj8hkhGFk6YrX3Qn3G2ICyJYzLDAHsiZVVFF/mFSxF8nc4w444bI3uleN/chqCWnNAd9tbYsxTpo7/6sAz0gE8rgjR0piMYV12namZj953qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g58bStwD3wwhMbv9tdPnGGYBBNUPbE5jQLMDDh8xYjY=;
 b=mfuKX7X1XAOnt4rWDB7Pg7Ae4TkwnqjFacnxs0ySYx7zuwEbJTIjtI/WdHh02RDJDKoieMmq3S6dJLlnGQcVcRaJutdeEKwi674J84OQVSpFuHEf9dN6JCkdyKSp1ojVfGgEi6WHp9raGK7DD3dDcmPBRtWcR88CqrhliX3Esc4atK4Y+I4/xLSwbDJDpDBnWJA5OSlAL6f5+d95aJtkyKNBUjjs1NJUsLQz5fODzUnI2o4W1MxQ7qiVGG3jt26saHCwPOX4eiZ88NuidIxXUv3yUYmrikH8QNLCh0/dR9r/yieP4Dwrw768yY27T7C4JkrLqUuN5z+7xi3//S9iQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g58bStwD3wwhMbv9tdPnGGYBBNUPbE5jQLMDDh8xYjY=;
 b=hFhshdR0aUlXtIKRYw6zKyhOiyJuWpz0WwgINlXvN9Q80k1BTnGmh5a/hfQFMCaKigMAgJbOudaQxQOQv3Z+xQBUhENBxQQAlRZ8vygFXavKFIxWS44ClSE3thnZk+S5mEjlAymwVBemjXCxLUtAhsCz1g8efMlTl2+481uju/s=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BN8PR12MB3330.namprd12.prod.outlook.com (2603:10b6:408:43::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Thu, 3 Feb
 2022 02:54:14 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::c5f4:5df4:b5bf:b13e]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::c5f4:5df4:b5bf:b13e%3]) with mapi id 15.20.4930.022; Thu, 3 Feb 2022
 02:54:13 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Felipe Balbi <balbi@kernel.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: Prioritize extcon over USB role switching API
Thread-Topic: [PATCH] usb: dwc3: Prioritize extcon over USB role switching API
Thread-Index: AQHYFtfE0uDHnqoRTUCfYSch4bkt3ayBJPaA
Date:   Thu, 3 Feb 2022 02:54:13 +0000
Message-ID: <e0e36d42-5479-fd8c-3868-384161031738@synopsys.com>
References: <20220131192102.4115473-1-andrew.smirnov@gmail.com>
In-Reply-To: <20220131192102.4115473-1-andrew.smirnov@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2904f0bf-af12-42d6-c347-08d9e6c0761e
x-ms-traffictypediagnostic: BN8PR12MB3330:EE_
x-microsoft-antispam-prvs: <BN8PR12MB3330C08F2CB920B12DD2CF80AA289@BN8PR12MB3330.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fvLjrhW0A75rsFMXvOYfm8HB2k89P/nELz52E7xAEX78jbPMaL9pllLk2Z6vJv0UKDmOIHQsba1ohybdZFJqCU6C2+GLXjxjrvQntHNm2Yqr3cxent1mFnUeovhPBC8kxVecJWSUG1kMyg6jfrP3EalLi7RWXm94yEzKIek/SAsNxL47fvm8o5gQJaSSjIVCfIAjb9JzZxvpOuWGvRDAA0IrXXkdQZ9YbbJRDHicb5NcP2aZcPXgCB6a8QwKL0llpg9QRPfsh6MVf9umDn5pADMVJIb8ACyRKLkuZM7xkiEjjQIGhWCBLg3uIIdx71DHwrht/tNZDg9SASx1Aa1XOGqOQs11I/o3d05/EEXtEk7ssCnCfDejI9Ty/ED0sPWCFblK4KEK7KbOxNhI/om26fOWzeWTyUb1Y/nLlJ9CDm5OSqAXoDKAPDyReVvv+SYdu6sGTXfNZlgiU9chcxRlfBmS2wBl3O7tLwSuaHSe6LDI89iWwu+1GIbxibNuScsHKi5jVbB/dL1CiO1HTIFKWhdiKDqNmRjnw3729ixExChAaT1UMfj7beE/YpmnnSZLhgcSswHZ6Y3PX2kADKB7h36T8HJ8aCKTOUDf4SNJu1oNxjnSutxsVef/Fd0+gPDEZO8FGmyH5KFLsiDLUytrewm+LBjUVDL9urnredoxRZsUrRSzsQpDltvjgYOh2aa6VdfcoUIVL3XaeG5deqkCWWkom9Xrj7iUpICDgUWQgUMbInRC+UUwdvYRrw9m24iYCYbqclsp60OgO6RaUYGWog==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31686004)(31696002)(86362001)(6486002)(36756003)(54906003)(38070700005)(316002)(110136005)(122000001)(38100700002)(508600001)(8936002)(186003)(83380400001)(2906002)(4326008)(8676002)(71200400001)(66476007)(64756008)(66446008)(5660300002)(2616005)(6512007)(76116006)(26005)(66946007)(66556008)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Zzg5M0NIWVdZQkwvV1k5VCt0cmwyQitFeDYwWnU3SFVCem0vNEsxcUpudkZI?=
 =?utf-8?B?Z2d1VTd5U3lrd20rL1VwdkE4aDA4VEhNSUp2YS9HMEdOcWFIcWlXOVhjcGpn?=
 =?utf-8?B?eXNONjhZZmE5OGdQcDdwcmQ3cU1HYjlLcENIeEl5ZlZOb2NwQkdISXlNUHor?=
 =?utf-8?B?eWE5N0NPQmdwTENVNDh0d2JMZ1kxL1pBKzZUTUhzYnNDM0JsdTFTTUlyempZ?=
 =?utf-8?B?MTBQWEFpcEdNelR6bXBPQXFWR2NseEliQ0MwNmdDYi8zOW1pdXhyREtIQThF?=
 =?utf-8?B?eG1aK0ZxaWhvQ0F6M2tnd25qSzZKWmg2Y1M0dEdkSng5WlN0bVZ4T2s3SlR2?=
 =?utf-8?B?QlJEZE51Yi9KVWN1OVhJYmEvdzNXSURjRWx3MDZVL2VlWTJzSGFOSUM3ZTJC?=
 =?utf-8?B?ZEp2SEt1c3VyQ1hoMXRFdVZjU1k1SGJVQWtrWHFUQzd4ckUzSlNEdkd4cnZU?=
 =?utf-8?B?K2FSYnI2cXhjUmVrWGVqVlRZT2hCWE4yd25ZbXYxMEYxQnF4YS9zQ09sOFdP?=
 =?utf-8?B?dVlNNzRPVlZnQVBlRk51YW5KNUU5KzRac2FiZ0loL0ovRS94STlvbGcvY2Fm?=
 =?utf-8?B?R2gxQm9VNVg3WEQ1SFBPRGNNcnlVVVVIb2U1T2ErcnBUeE1nbDVJVU5BN0ZW?=
 =?utf-8?B?ZnZPKzJIT3EwdjZqQi9SN2Qva0Uwc3hDS2tSQWtIMnJla3B6UjluaTI1VW42?=
 =?utf-8?B?WHFvOXBsYTZsaFFWK2pFNjIxYmgxbjQvamFVcXJ0SmRISjQ1YnUxU2VzaW1V?=
 =?utf-8?B?bG1CZWU4RFUrMkFBRTMvcmFid1JxMUtRbDhSdW43Z3dBZFZPdFE5OWFwQTlP?=
 =?utf-8?B?ZENUNXR3RXNoRGJ3Z1V1OVNUemdNNWYvUXdYd1AxcEwyUVJ3QU5oZ0N4WllQ?=
 =?utf-8?B?SzFKR3lYMDJ4TjBRRnlNVWpqYStUdFphOWZ4eWJqNDdBUXp4M29MMDg5cldX?=
 =?utf-8?B?bGx0MUlIUWFrOHluQXliK0tEcmFzNDBSTkJVK280T0lVeHZHejl6TUJKTDI2?=
 =?utf-8?B?ajBEd0dhbndOUVFTa0Uzd2NlUnJMQWhZM0lSNlNKOFlYMHJEaTNnOUxsaVc4?=
 =?utf-8?B?SkFNenhLMGJKcStaYUdrdEJyLzdFQmlta3pQbGNBUEJZVWNuaFNROGlkR1dn?=
 =?utf-8?B?cXk2YlZFWkw4cVVSZWhLaFdLTStjVjd2aHhwb0JQc0tNOGNpdkU4THBVUmhZ?=
 =?utf-8?B?b3VGNjl6dGQ1a3FxUlhVbE5McUxFK3lwd3JPaUZtbUpnUWR4WHFhNmQ2ZEZl?=
 =?utf-8?B?ZnIzS0JvbURWVWlPeDZIL1M2cE1UeGZ0UnFCbjV0UjdpQUF4T1NmRjk1YXE3?=
 =?utf-8?B?aGg1cTlkanZlaUd0ekUweUJoOXpJL1FpSUx5ZnE5THFQbHA3cjhKRGZFOWow?=
 =?utf-8?B?T2d3VGZ2dlRHTzdEaEVDd1RqUGYxMTJvY3JBWVJUTDFLQUg5bkozWlBkSUQ0?=
 =?utf-8?B?RmhVL2xSM0dOWk53UWZHTUFTbUphZS9nY0Q5RCs1VVVHZlR5Z0RPRWhSWUxC?=
 =?utf-8?B?cENyWUtBM25xV2xhZ3VkemY4VnlCbFEyaHZTZGJUaWFBdC83OTJSUlRTL3E3?=
 =?utf-8?B?TVpYOXR2KzdoTEZpZzRCS2RIc01LU3lmQnhJOXFQV2w2d3pyNG1mazFndVVT?=
 =?utf-8?B?cExUUU91K1hxc3R4ZTBLc2xoaHd4RFdCYU1oNlVvU1ZSSFZNMkNUSUxYUmQ1?=
 =?utf-8?B?aVJRLzFWYXlqNnkrNjBKNzRNdGprSW1aU1U0dzhhT3g5ZjBuZHgwcEtUT0R5?=
 =?utf-8?B?Y1p0VkluR0syblZOcXlsa3Y4a2gvRFU5TzVCWEdqSis2RTZ6Y2hUU0EveDhP?=
 =?utf-8?B?dW1nWG91bDduclRrd1RUakw3eFBOc2V3N0FZN1NoMkRVUGZTK0FVcEhMVW1q?=
 =?utf-8?B?d08wV2J4YnNERjFJQVoyOHRzMUtsN3lRb1FZdHBubWxBK1RrSzdJL1JuaFd0?=
 =?utf-8?B?S3lWUHhudUZGcXpRN0NEMDhxWVJreVJkUGZzS3BYRGpScHhYRTdwd3g5aXFW?=
 =?utf-8?B?V2tXZ0h1OUw1bVRWWlBKNEZYYXo0ZlY3NUkrSlFLZDRGV0IwT2ZKSVZDYkQw?=
 =?utf-8?B?bm05cGRVS0FuaURSZ05Ya2V1cW0reE5IdGNGVXpsc0NDMFlENHlJN3g1d3dP?=
 =?utf-8?B?NFhvL2kvNnlla0VhcVlzUjYxZC9ZRzVLQUROUk9WaXpZQ1VuUXlnMGRIaVRH?=
 =?utf-8?B?V1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9273064B5F723243A78AC1B197CB832F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2904f0bf-af12-42d6-c347-08d9e6c0761e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2022 02:54:13.8847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fyEJg+Yw5l6f7G1EAerTkWhMNm/HuYySqu0JKs667J5oL7zsWDZq7Dc07tjA/8KmPHkG+x9TtejLmu9inblrcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3330
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QW5kcmV5IFNtaXJub3Ygd3JvdGU6DQo+IEl0IGlzIG5lY2Vzc2FyeSB0aGF0Og0KPiANCj4gICAg
Uk9MRV9TV0lUQ0ggJiYgZGV2aWNlX3Byb3BlcnR5X3JlYWRfYm9vbChkd2MtPmRldiwgInVzYi1y
b2xlLXN3aXRjaCIpDQo+IA0KPiBpcyB0cnVlIGluIG9yZGVyIGZvciBkd2MzX2dldF9kcl9tb2Rl
KCkgdG8gX25vdF8gZm9yY2UgdXMgZnJvbSBPVEcgdG8NCj4gUEVSSVBIRVJBTCBtb2RlIGhlcmU6
DQo+IA0KPiAgICBpZiAobW9kZSA9PSBVU0JfRFJfTU9ERV9PVEcgJiYNCj4gICAgICAgICghSVNf
RU5BQkxFRChDT05GSUdfVVNCX1JPTEVfU1dJVENIKSB8fA0KPiAgICAgICAgICFkZXZpY2VfcHJv
cGVydHlfcmVhZF9ib29sKGR3Yy0+ZGV2LCAidXNiLXJvbGUtc3dpdGNoIikpICYmDQo+IAkhRFdD
M19WRVJfSVNfUFJJT1IoRFdDMywgMzMwQSkpDQo+IAltb2RlID0gVVNCX0RSX01PREVfUEVSSVBI
RVJBTDsNCj4gDQo+IGFuZCBkd2MzX2RyZF9pbml0KCkgdG8gYmUgY2FsbGVkIGxhdGVyIGluIGR3
YzNfY29yZV9pbml0X21vZGUoKS4gU28sDQo+IHRvIGF2b2lkIGFsd2F5cyBpZ25vcmluZyBleHRj
b24gZGV2aWNlIHJldHVybmVkIGJ5IGR3YzNfZ2V0X2V4dGNvbigpDQo+IGNoYW5nZSBkd2MzX2Ry
ZF9pbml0KCkgdG8gY2hlY2sgYW5kIHVzZSBpdCBmaXJzdCwgYmVmb3JlIGNoZWNraW5nIGlmDQo+
IGR3YzNfc2V0dXBfcm9sZV9zd2l0Y2goKSBzaG91bGQgYmUgY2FsbGVkLg0KPiANCj4gQ2M6IEZl
bGlwZSBCYWxiaSA8YmFsYmlAa2VybmVsLm9yZz4NCj4gQ2M6IFRoaW5oIE5ndXllbiA8dGhpbmhu
QHN5bm9wc3lzLmNvbT4NCj4gQ2M6IGxpbnV4LXVzYkB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU2lnbmVkLW9mZi1ieTogQW5kcmV5IFNtaXJu
b3YgPGFuZHJldy5zbWlybm92QGdtYWlsLmNvbT4NCj4gLS0tDQo+IA0KPiBIb3BlZnVsbHkgSSBk
aWRuJ3QgbWlzcyBzb21ldGhpbmcgaW1wb3J0YW50IG1ha2luZyB0aGlzIHBhdGNoDQo+IHVubmVj
ZXNzYXJ5LiBEb24ndCBrbm93IGlmIHRoaXMgaXMgYSBnb29kIHNvbHV0aW9uIG9yIG5vdCwgcGFy
dCBvZiBtZQ0KPiB0aGlua3MgdGhhbiBtYXliZSBjaGFuZ2luZyB0aGUgYWZvcmVtZW50aW9uZWQg
Y29kZSBpbg0KPiBkd2MzX2dldF9kcl9tb2RlKCkgdG8gYWNjb3VudCBmb3IgZXh0Y29uIHdvcHVs
ZCBiZQ0KPiBzaW1wbGVyL2JldHRlci4gSGFwcHkgdG8gcmV3b3JrIHRoaXMuDQoNClRoZSBkcml2
ZXIgZWl0aGVyIHVzZSBleHRjb24gb3IgdXNiLXJvbGUtc3dpdGNoLiBJdCBkb2Vzbid0IG1ha2Ug
c2Vuc2UgdG8NCmVuYWJsZSB1c2Itcm9sZS1zd2l0Y2ggZm9yIGV4dGNvbiBqdXN0IHNvIHRoZSBk
cml2ZXIgZG9lc24ndCBkZWZhdWx0DQp0aGUgZHJfbW9kZSB0byBwZXJpcGhlcmFsLg0KDQpQZXJo
YXBzLCB0aGlzIGlzIHdoYXQgeW91J3JlIGxvb2tpbmcgZm9yPyAoY29kZSBpcyBub3QgdGVzdGVk
KQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgYi9kcml2ZXJzL3VzYi9k
d2MzL2NvcmUuYw0KaW5kZXggYmZmZDcxOWI4YjUyLi5hNTIzMzFlYTdhMGQgMTAwNjQ0DQotLS0g
YS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KKysrIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMN
CkBAIC04Niw3ICs4Niw3IEBAIHN0YXRpYyBpbnQgZHdjM19nZXRfZHJfbW9kZShzdHJ1Y3QgZHdj
MyAqZHdjKQ0KICAgICAgICAgICAgICAgICAqIG1vZGUuIElmIHRoZSBjb250cm9sbGVyIHN1cHBv
cnRzIERSRCBidXQgdGhlIGRyX21vZGUgaXMgbm90DQogICAgICAgICAgICAgICAgICogc3BlY2lm
aWVkIG9yIHNldCB0byBPVEcsIHRoZW4gc2V0IHRoZSBtb2RlIHRvIHBlcmlwaGVyYWwuDQogICAg
ICAgICAgICAgICAgICovDQotICAgICAgICAgICAgICAgaWYgKG1vZGUgPT0gVVNCX0RSX01PREVf
T1RHICYmDQorICAgICAgICAgICAgICAgaWYgKG1vZGUgPT0gVVNCX0RSX01PREVfT1RHICYmICFk
d2MtPmVkZXYgJiYNCiAgICAgICAgICAgICAgICAgICAgKCFJU19FTkFCTEVEKENPTkZJR19VU0Jf
Uk9MRV9TV0lUQ0gpIHx8DQogICAgICAgICAgICAgICAgICAgICAhZGV2aWNlX3Byb3BlcnR5X3Jl
YWRfYm9vbChkd2MtPmRldiwgInVzYi1yb2xlLXN3aXRjaCIpKSAmJg0KICAgICAgICAgICAgICAg
ICAgICAhRFdDM19WRVJfSVNfUFJJT1IoRFdDMywgMzMwQSkpDQpAQCAtMTcxNSw2ICsxNzE1LDEz
IEBAIHN0YXRpYyBpbnQgZHdjM19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0K
ICAgICAgICAgICAgICAgIGdvdG8gZXJyMjsNCiAgICAgICAgfQ0KIA0KKyAgICAgICBkd2MtPmVk
ZXYgPSBkd2MzX2dldF9leHRjb24oZHdjKTsNCisgICAgICAgaWYgKElTX0VSUihkd2MtPmVkZXYp
KSB7DQorICAgICAgICAgICAgICAgcmV0ID0gUFRSX0VSUihkd2MtPmVkZXYpOw0KKyAgICAgICAg
ICAgICAgIGRldl9lcnIoZHdjLT5kZXYsICJmYWlsZWQgdG8gZ2V0IGV4dGNvbiAlZFxuIiwgcmV0
KTsNCisgICAgICAgICAgICAgICBnb3RvIGVycjM7DQorICAgICAgIH0NCisNCiAgICAgICAgcmV0
ID0gZHdjM19nZXRfZHJfbW9kZShkd2MpOw0KICAgICAgICBpZiAocmV0KQ0KICAgICAgICAgICAg
ICAgIGdvdG8gZXJyMzsNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2RyZC5jIGIvZHJp
dmVycy91c2IvZHdjMy9kcmQuYw0KaW5kZXggNjMwODljN2ZiNTMwLi5kMDJmY2ZkYzc0ZGIgMTAw
NjQ0DQotLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2RyZC5jDQorKysgYi9kcml2ZXJzL3VzYi9kd2Mz
L2RyZC5jDQpAQCAtNTg1LDE2ICs1ODUsNyBAQCBpbnQgZHdjM19kcmRfaW5pdChzdHJ1Y3QgZHdj
MyAqZHdjKQ0KIHsNCiAgICAgICAgaW50IHJldCwgaXJxOw0KIA0KLSAgICAgICBkd2MtPmVkZXYg
PSBkd2MzX2dldF9leHRjb24oZHdjKTsNCi0gICAgICAgaWYgKElTX0VSUihkd2MtPmVkZXYpKQ0K
LSAgICAgICAgICAgICAgIHJldHVybiBQVFJfRVJSKGR3Yy0+ZWRldik7DQotDQotICAgICAgIGlm
IChST0xFX1NXSVRDSCAmJg0KLSAgICAgICAgICAgZGV2aWNlX3Byb3BlcnR5X3JlYWRfYm9vbChk
d2MtPmRldiwgInVzYi1yb2xlLXN3aXRjaCIpKSB7DQotICAgICAgICAgICAgICAgcmV0ID0gZHdj
M19zZXR1cF9yb2xlX3N3aXRjaChkd2MpOw0KLSAgICAgICAgICAgICAgIGlmIChyZXQgPCAwKQ0K
LSAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCi0gICAgICAgfSBlbHNlIGlmIChk
d2MtPmVkZXYpIHsNCisgICAgICAgaWYgKGR3Yy0+ZWRldikgew0KICAgICAgICAgICAgICAgIGR3
Yy0+ZWRldl9uYi5ub3RpZmllcl9jYWxsID0gZHdjM19kcmRfbm90aWZpZXI7DQogICAgICAgICAg
ICAgICAgcmV0ID0gZXh0Y29uX3JlZ2lzdGVyX25vdGlmaWVyKGR3Yy0+ZWRldiwgRVhUQ09OX1VT
Ql9IT1NULA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAm
ZHdjLT5lZGV2X25iKTsNCkBAIC02MDQsNiArNTk1LDExIEBAIGludCBkd2MzX2RyZF9pbml0KHN0
cnVjdCBkd2MzICpkd2MpDQogICAgICAgICAgICAgICAgfQ0KIA0KICAgICAgICAgICAgICAgIGR3
YzNfZHJkX3VwZGF0ZShkd2MpOw0KKyAgICAgICB9IGVsc2UgaWYgKFJPTEVfU1dJVENIICYmDQor
ICAgICAgICAgICAgICAgICAgZGV2aWNlX3Byb3BlcnR5X3JlYWRfYm9vbChkd2MtPmRldiwgInVz
Yi1yb2xlLXN3aXRjaCIpKSB7DQorICAgICAgICAgICAgICAgcmV0ID0gZHdjM19zZXR1cF9yb2xl
X3N3aXRjaChkd2MpOw0KKyAgICAgICAgICAgICAgIGlmIChyZXQgPCAwKQ0KKyAgICAgICAgICAg
ICAgICAgICAgICAgcmV0dXJuIHJldDsNCiAgICAgICAgfSBlbHNlIHsNCiAgICAgICAgICAgICAg
ICBkd2MzX3NldF9wcnRjYXAoZHdjLCBEV0MzX0dDVExfUFJUQ0FQX09URyk7DQogDQoNCg==
