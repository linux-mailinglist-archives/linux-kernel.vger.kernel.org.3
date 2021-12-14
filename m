Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52741473D24
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 07:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbhLNGWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 01:22:44 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:46714 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230462AbhLNGWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 01:22:40 -0500
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 2D7A4C0455;
        Tue, 14 Dec 2021 06:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1639462960; bh=4KbnA4kcO+xpAVOSiMCtD+NV3lsePn+vduUx33K3z+0=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=iNxmta3+nRW76r1+O+bapQjPzZbsqPXtU/GqQjQ3zy7Kan9Ot8bksLYJUJBhzlcAA
         9Ac4x6e1dTiS7iZbJAWdVYYX0MHEk2qEIcWEt5kjjHcDHE7Ej42mXfBy5QG5w4G9FM
         EUq8/CldDt6GY9MvDvqd8g/zeq+blVN2w+8Xcp96+gQM3oUb7+PBN1QSLlz7GRyprE
         4kibRa/JS6ezcJ9AtL/8DYK+f0xCe9RWhHI1KhEySE6xkFnhDktdv3RGXG43X3CuUK
         oNKA/1gf0zUJyOf3oV4XRTrV66TGPeTCPFURM64MyNmBJMYsEH2J+R5woyjsa/S/l0
         4T0piinig4Mdw==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 68563A0096;
        Tue, 14 Dec 2021 06:22:39 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 96704401C0;
        Tue, 14 Dec 2021 06:22:38 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=hminas@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="rR65mVZ8";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IzHoUONMcqUHE7TUAjQuW5dCYblJZDCfYQ8aqdJ+Vx4thoN42Ja4OITZlGjVuw3l3JnhZXrKnNW0pHNqsmazQ4sqOscxPikLDnTsVlfV8Q8D65n7hq1G0kJRu8DuFL7R7ih8PuE0KxAzoNtVO9rOkxUMggAXbyl9m4GwsxM4wJYoA0yJ0fCJy3Ml6+pGM2gkWkWc7+ZWm/IW4bCt9GErCnbzYjn/jRwG4dOYZRv+4QVTKXcRETX1yuNe5odgzC2i+Rk2hLvmzLasyIr7ViBplAm+iN5wPfZWC4QNX0Kw168EqjvUJzVCXlQ+IS6LyJLidPVmMZfwNF0ada7IWhlr+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4KbnA4kcO+xpAVOSiMCtD+NV3lsePn+vduUx33K3z+0=;
 b=mCjO73UHdlmPMOrrIUQkTwwwwpXaqIOYhaPUUNkIcylcyzK/OlXkU13MYeJXWe36Bm7Gtj4PUmuUM3iuseoNJBeRpRrhLfupEZVoGBP3ZJ/O0fxRQ0eTu1dNqrzxeJzKf68KW3RXavpm8fodMlViRmfQsz3ItcxrrofkokZXksX4fEc92NzHIE/1tsb8OWnmvRi+tXL9yU6xfMrASElkjFcXisT+0WTCy2S3GiOjZ3q6kaGY2FnlyG2/3d61fXYxv9mD5kJsPsnJYMAw74D1Pa3eOdRsddmRJFT+Odq5UMDcEe7OA4OUmHu201YOZL55Y6QKxykt9Oid4YcgGeCccQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4KbnA4kcO+xpAVOSiMCtD+NV3lsePn+vduUx33K3z+0=;
 b=rR65mVZ8ZdAKmGZHQQMIVk1n/fduey2bRkW5CknU87dveGmdfAGqf8cFpdNcN1nHZDf/fktQJqHhQud/h2KGRvsU1COoweoGAE1P1rI6DBB5cr3bubUVYT14s5q0+vykRISvNC7yYnlF55JlW7Yv2HGhG5IzgQABFY7x3GoNA6Q=
Received: from DM6PR12MB3419.namprd12.prod.outlook.com (2603:10b6:5:3c::32) by
 DM6PR12MB3754.namprd12.prod.outlook.com (2603:10b6:5:1c4::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.16; Tue, 14 Dec 2021 06:22:36 +0000
Received: from DM6PR12MB3419.namprd12.prod.outlook.com
 ([fe80::bc96:b3ed:1aa5:57b6]) by DM6PR12MB3419.namprd12.prod.outlook.com
 ([fe80::bc96:b3ed:1aa5:57b6%7]) with mapi id 15.20.4778.018; Tue, 14 Dec 2021
 06:22:36 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Amelie Delaunay <amelie.delaunay@foss.st.com>,
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
Thread-Index: AQHX62qCxCNUA/jq7kGn/hM1/5MI16wxjyKA
Date:   Tue, 14 Dec 2021 06:22:35 +0000
Message-ID: <46125d28-b065-b882-8a62-9d494b271755@synopsys.com>
References: <20211207130101.270314-1-amelie.delaunay@foss.st.com>
In-Reply-To: <20211207130101.270314-1-amelie.delaunay@foss.st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af7c8eb4-8917-4bdb-b2b0-08d9beca1f1b
x-ms-traffictypediagnostic: DM6PR12MB3754:EE_
x-microsoft-antispam-prvs: <DM6PR12MB3754A5F17A729B7DA633D373A7759@DM6PR12MB3754.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V1aYmsjOziZeP3C8IyfFmH0yoJXz32tnZAUvd+cqPaLyd0p36WFXHFtGghDAKKO4Af+iVs07RAFQqFXFOwG9a+w9uH3KGN71ZnA217RY9Vy7QNVETl4CppAdT7tCOxPczrCLl7ePY4LXftCZOmYy43uRHTDbE+7Ss9TZt0MhRfxNINI3dUFzlkfZd2tvLWnzVIk2wqJ+ImLOh2u9h9N/JPmNdmgefgO4+78v9dZ020XGA6ibsfjI4XAtqu9TKAKkZfo3j1K457LVxz2MX40HGi4tw8BKNjuifkfK8qOwFBr34iMIq3+Omm9dXYG1pv8wqeK+QKzi6eLBv0wqgc54xi0UvNM/sBmDkLNnJmmOpnsSZJFRm79hSgzNgP9ZLbSqHze+G/JcZ5O3eYfCUZ/xKqzhfUnMu+BAd2mfEyYfkroHq5lG0A73htpSEw3aIaUIZ93wOB37C98RIkBYJMafz5jxFYCUc3WJUs6BgtXewIu2PC7jfAyQuHQyODEYhvXQcmb5eQHLFBjIOpXReBiD0A/IjTp4pBBwVKBTDZHAxcnhJTuLgMEIg80i/sDuugy+ntIULRmwdKKYIm3Xl2zjwR5rQY3HT1SeiPwFEQWPhuh+BEe6ez90EKW6gIGlwW9Mi4KNa8SssrWDgg+pzrg990EgTsxcx0aVbuItBQ5Dpeoo5km560aQEnYDkq6kDbEb+AvBF0dczxvMgJZ+b0sbD+yXcYi8wQ87AIf/k9sVrtT9JQpyb5la2OginxV8NmJk8xFn/Zel4aRi6QZFXyMGug==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3419.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36756003)(53546011)(4326008)(83380400001)(2616005)(31686004)(64756008)(71200400001)(6486002)(8676002)(316002)(31696002)(66476007)(2906002)(26005)(66446008)(66556008)(186003)(76116006)(38070700005)(508600001)(6506007)(91956017)(110136005)(54906003)(8936002)(86362001)(122000001)(6512007)(5660300002)(38100700002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V0d3ajRTUms1T3ZkOVlLQ3JhMlNZdWdNeXl5SlBlcTNjbytxc1hVd0RkRURl?=
 =?utf-8?B?RlRkSVlJZmRxaXJod2hIUjY3VU5tcFQzbFNaVGZQL2JZdlgxeUpqR3FIeWlv?=
 =?utf-8?B?NTFDanRrU3lTNCs4blZaVVVjVnhkMXFKcDdGemljRjViRitINGIyVnJ1WlJv?=
 =?utf-8?B?czZKV0g4YWRVN0hpNStUdG9DMzh6ZVA1ekRtOHd0OEFNSUg0ZHNneG1GNDFB?=
 =?utf-8?B?cGxKdERvbFg5eTFkd3YxK3BvM2paMTI5N0szRnRVNmErcXZkeFFyZW13a3g2?=
 =?utf-8?B?Y3hNTWt5YzZFYjIrUGMzREVRNWtBeHNNMzJ6cXdVaWk0RWNxSll2NUUzTWdO?=
 =?utf-8?B?cmFiTmU1OTl1NE5Xc3l6Rjhzc0pDeDRwSmVWaERtRlphQVdjdG84R1g3Q011?=
 =?utf-8?B?ZHpsL3E5eDlOQWhIUEswVGpFZEQyTzNjcUxsN3ByOE9ScUhZRFdieU9mNGd3?=
 =?utf-8?B?VlJwQlFUKzUxT0JDRXJvbk9WUWtzU1VrVWgyWHhXdFZmWGtRRmYxdkFGVkhX?=
 =?utf-8?B?dnA2eEkySVZhMFAyRTQxRUpUMUdaVTJONlk3Tk5UaEtWSDg1cW5YVmNNL2sy?=
 =?utf-8?B?T1ozTituUHRQZzVTajJzWVRsdVROeWdXdG92U0RUam5IRlJ0YTlxa3FFd0Zx?=
 =?utf-8?B?L3BoZ3ZxV2ptTVBhbWFDVDdOYzI0NmpYRmlaa0VsMGdTanFtWEJYNFJOekcz?=
 =?utf-8?B?OWhBaUU1dCt0M0Jrcy84MUtZL3VvNldYTTM1RDRZSmR3K2NUcGlUYTVOaGNY?=
 =?utf-8?B?OUYxUU9ISkZoa291c3ppczdTdUFVTWhwZW1nRjhEanljZVNGTEFlNzlhSHJM?=
 =?utf-8?B?ck00Wm8rc0kzUmY5UU84Y0FuVW93MkY1UWVhemllMjRyUVZxWmNOTi94bTB1?=
 =?utf-8?B?T1h6L0Jvbm9XT2dBeDA3YkhJalhrZmJJdmFTMEUyemd5OXhIVDR6TFllMk9P?=
 =?utf-8?B?aVllakJxSXVGOTYvUnFLTDRUbWo2WGVjdTMrMmtBdlQ0N0NEQ29weHFNeENp?=
 =?utf-8?B?T1haK0VrOGhCK3V2OVNHWE5Sc0dJL0pHY0FnU0ZTK255RGtOYUpYaTlRTzNJ?=
 =?utf-8?B?Y3dKYkJIMmM5Q28vQzBxTEcwbEpEQ2t4NnRKMDNhNXc1d2RPZlJKUW5EN2RW?=
 =?utf-8?B?WnJTcE5mMW1NeCtVTUFIaUFvYWxycU91SWZVb1RVak5xQ0hrRXFQditJYWxi?=
 =?utf-8?B?UENDMTF4aldPSGlGQ2J0NFFZeGdPWFRyMEM3Tk1TV0ZCQUwxWWNyV3l5Q1pj?=
 =?utf-8?B?ZXRZcW82LzZCNUZxb3RFVTloU1h5QUd6ZlhXT1Q4OVFnUVoxSG9BYkJTQTBK?=
 =?utf-8?B?YzVhMU1lcFNRMDdSRDhtakF2a1VwK1g3a0t3ODJQdE9YM2FCSkFQK3h3dE5G?=
 =?utf-8?B?MnJDc1ZnSnRBNElvR0x1SmNZVU5tY0VTY0UrRkNFN01mMkhzTFoyWkhjTHZZ?=
 =?utf-8?B?U0FoQ3MwaEtiZ2lELzUyc1I2eEd6Z2JmdzdiWHFRMFFscC9wRjZ3bkhMRkhQ?=
 =?utf-8?B?MEliSmRZWWhFY3AwZFJhNXZtVUFzZlFjb2pxbnoyQ1ZUVkJhMG96OG0vdmZm?=
 =?utf-8?B?OWNMNHRSMTdaaUFUZUEvay8wOW0xVzEwSWgybk4rR3BCcFlxV0VOM0hNSUVp?=
 =?utf-8?B?OVhXV3JHYjNCT3N4QU9IcnorUVd6QnMwMmdxZ1NLZWZSN3AvdWtLNG5WY0Z3?=
 =?utf-8?B?Z05oVUtZdmU1OGNFUFZIK3lkV0pRbFZDbENQZnYxRkpNVTV6ell0L0NaRkhx?=
 =?utf-8?B?aFphb3orNzZQbTB3MkRZWGg5OXJCK1kzS1Z1a1g4dGtGUkR3bndIVkVzL3BX?=
 =?utf-8?B?UFNMaWpFR3RMT3ZjS2JXNEFTT3BYOWJ0Qm15SFZPQ015d2dsVGJidFdCMUYr?=
 =?utf-8?B?dVZnU3A5Tnh1cXMxVmoxbDZvQ29iMFZJVFhiYWRWRlQ3eDlCMUxNUjN2b05m?=
 =?utf-8?B?ZWhGZWhsV1FRWE91NFpLZFVBNUJVeUpMUS8xYi9pU3dHY2trek1obEpqSnVV?=
 =?utf-8?B?bDVKbkNwanJXVUhUcHY5MTB6VWxMVUFtc1I4ajEwNi9weURlZDZ4VFhEaXlv?=
 =?utf-8?B?eldkSHNPYWtLYWRBd2srUzdDcjkvUmVZQW1NeThDczlmcmhuNlFWTk84ejZD?=
 =?utf-8?B?aUh3RU1PNzJucnVvUE5DcDNLUjMxTy9SWG1IRTRNMW9UeEJUczdJY3Q5NE1T?=
 =?utf-8?B?cXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A548CC0280EE5141A15D794557CF156C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3419.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af7c8eb4-8917-4bdb-b2b0-08d9beca1f1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2021 06:22:36.0927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o9ibN3Z6ppIcSqnJyS4ZQSTybWrL4xPDunqc/+h8qZZD5Obz3be/f2UnBDWyTbKf0slOUS9mQ+igV8ZbY+5Mzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3754
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW1lbGllLA0KDQpPbiAxMi83LzIwMjEgNTowMSBQTSwgQW1lbGllIERlbGF1bmF5IHdyb3Rl
Og0KPiBDYWxsaW5nIGR3YzJfaHNvdGdfZXBfZGlzYWJsZSBvbiBlcDAgKGluL291dCkgd2lsbCBs
ZWFkIHRvIHRoZSBmb2xsb3dpbmcNCj4gbG9ncyBiZWZvcmUgcmV0dXJuaW5nIC1FSU5WQUw6DQo+
IGR3YzIgNDkwMDAwMDAudXNiLW90ZzogZHdjMl9oc290Z19lcF9kaXNhYmxlOiBjYWxsZWQgZm9y
IGVwMA0KPiBkd2MyIDQ5MDAwMDAwLnVzYi1vdGc6IGR3YzJfaHNvdGdfZXBfZGlzYWJsZTogY2Fs
bGVkIGZvciBlcDANCj4gDQoNClRoaXMgbWVzc2FnZXMgcHJpbnRlZCBmb3IgRVAwIE9VVCB3aGlj
aCBjYW4ndCBiZSBkaXNhYmxlZCwgYnV0IEVQMCBJTiANCmNhbiBhbmQgc2hvdWxkIGJlIGRpc2Fi
bGVkLiBZb3VyIHBhdGNoIGV4Y2x1ZGUgRVAwIElOIGZyb20gZGlzYWJsaW5nIGZsb3cuDQoNClRo
YW5rcywNCk1pbmFzDQoNCj4gVG8gYXZvaWQgdGhlc2UgdHdvIGxvZ3Mgd2hpbGUgc3VzcGVuZGlu
Zywgc3RhcnQgZGlzYWJsaW5nIHRoZSBlbmRwb2ludA0KPiBmcm9tIHRoZSBpbmRleCAxLCBhcyBk
b25lIGluIGR3YzJfaHNvdGdfdWRjX3N0b3A6DQo+IA0KPiAJLyogYWxsIGVuZHBvaW50cyBzaG91
bGQgYmUgc2h1dGRvd24gKi8NCj4gCWZvciAoZXAgPSAxOyBlcCA8IGhzb3RnLT5udW1fb2ZfZXBz
OyBlcCsrKSB7DQo+IAkJaWYgKGhzb3RnLT5lcHNfaW5bZXBdKQ0KPiAJCQlkd2MyX2hzb3RnX2Vw
X2Rpc2FibGVfbG9jaygmaHNvdGctPmVwc19pbltlcF0tPmVwKTsNCj4gCQlpZiAoaHNvdGctPmVw
c19vdXRbZXBdKQ0KPiAJCQlkd2MyX2hzb3RnX2VwX2Rpc2FibGVfbG9jaygmaHNvdGctPmVwc19v
dXRbZXBdLT5lcCk7DQo+IAl9DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbWVsaWUgRGVsYXVuYXkg
PGFtZWxpZS5kZWxhdW5heUBmb3NzLnN0LmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy91c2IvZHdj
Mi9nYWRnZXQuYyB8IDIgKy0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MyL2dhZGdldC5j
IGIvZHJpdmVycy91c2IvZHdjMi9nYWRnZXQuYw0KPiBpbmRleCBiODg0YTgzYjI2YTYuLmVlMzFm
OWEzMjhkYSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMi9nYWRnZXQuYw0KPiArKysg
Yi9kcml2ZXJzL3VzYi9kd2MyL2dhZGdldC5jDQo+IEBAIC01MDg2LDcgKzUwODYsNyBAQCBpbnQg
ZHdjMl9oc290Z19zdXNwZW5kKHN0cnVjdCBkd2MyX2hzb3RnICpoc290ZykNCj4gICAJCWhzb3Rn
LT5nYWRnZXQuc3BlZWQgPSBVU0JfU1BFRURfVU5LTk9XTjsNCj4gICAJCXNwaW5fdW5sb2NrX2ly
cXJlc3RvcmUoJmhzb3RnLT5sb2NrLCBmbGFncyk7DQo+ICAgDQo+IC0JCWZvciAoZXAgPSAwOyBl
cCA8IGhzb3RnLT5udW1fb2ZfZXBzOyBlcCsrKSB7DQo+ICsJCWZvciAoZXAgPSAxOyBlcCA8IGhz
b3RnLT5udW1fb2ZfZXBzOyBlcCsrKSB7DQo+ICAgCQkJaWYgKGhzb3RnLT5lcHNfaW5bZXBdKQ0K
PiAgIAkJCQlkd2MyX2hzb3RnX2VwX2Rpc2FibGVfbG9jaygmaHNvdGctPmVwc19pbltlcF0tPmVw
KTsNCj4gICAJCQlpZiAoaHNvdGctPmVwc19vdXRbZXBdKQ0KDQo=
