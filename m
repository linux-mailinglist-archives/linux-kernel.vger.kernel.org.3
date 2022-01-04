Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4D5483C22
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 08:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbiADHHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 02:07:24 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:33419 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233043AbiADHHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 02:07:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1641280041; x=1672816041;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GcKnZZiKEHHzUo6FOv3aF1ZnDT/WcQpxj2LqeoE8Itw=;
  b=oCSZvs+gqQ/1Kt2ahrVGJawmZHgKol9lRIvZgK9iBso1Tk6vEj2n1keI
   DNcpW7HOk2EPlahKrsnieuy71BNGgCdYwFGLMv4A05OKGpyrhEoTVMmSD
   ND7++bPRtMghhOfFloSXwzRhhNTOjy4m/hNa45p7j1zS0AvepK5GUs6yO
   bk8QN7rb4eGstRfH379xI0KO/D6n6fBRB2YNYDf1xcZRrffUP2cZRsGiX
   8vbcLcr6KC2P/fRWoNBAS5QYai7GPgwTB6+uADcYxLpR7C0oD+ux3ogMh
   ZjB8GIshIkl0XB62P+5WX29itB+bMXGhEp74uSvSuWp0sFpJJ7XIw88oR
   g==;
IronPort-SDR: StRgL3d5mnEVKtfDV6Eo+ESlJKtBuju/QNPQUTRMA5p3vcXRRRtkZ1QxlpFakcaQqx4dWBd7YZ
 0r49MhGL/mFqkB+YS/OJiYL1OvLELxOwms8JNjn6y28yLZgfZGtJilFbNotsGM2Bg+9Y0c2ADU
 8OJzDRC+xEkqpNfPwGh9K8yRG850WrmUF/eGIxkQxVRp4eK5ari7njDqRuMBWk7Swq0OxmBaq3
 SHIPc/gWFbRhf7MhfSJITcDS7JTEkGPCu9qIJeq2bWZ34EOnka6wzPcjprSLVFMBzW7ji376sy
 MZ3Ou3Vop7gS2bMSPYF+f8Q/
X-IronPort-AV: E=Sophos;i="5.88,260,1635231600"; 
   d="scan'208";a="144241175"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Jan 2022 00:07:18 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 4 Jan 2022 00:07:18 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Tue, 4 Jan 2022 00:07:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=liPpYeuXySDZbmvHqn0W9CuyXgBFiWWLzG5VB5L6b1ACG4NJmmVkD4lPwUWqqrb/muqYatJHRahVeaMA+UEqKjmbK3SWKyaDi1DMHvYZXTICRG4pKECLEYdwSOPbky0booV3gnre5svRLShxY5awb+bRVnq0YZdmbQUrTYD/9AYfKg9BbmW5ApMSKaYK8WDNORrsdps3ivT5EWcO7FMnlJtu7KolZQGUxcBgObCFFE9c8n4O8lrWnuUJ86r1v/csjtwuXjtxd6KHXQ+egi012GpMeVx142MhTjGmI8HhH41Xf+Zg2RzZ1SbnerrdbJn15us2eTamHDCEWgBkRDYzeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GcKnZZiKEHHzUo6FOv3aF1ZnDT/WcQpxj2LqeoE8Itw=;
 b=jksh0iRV9kV9KNshQt+cfi33YFhdNQhSmMHu/8kLkWEC5ZoLg0i16+uTbunHs/WJaptmdJTi7KgJJ7Kmb2apUisdI0C1RjfnmT6V0CRpIHz2CGA6M4KgaOybFBHiP0cbrHINyhDadeLFnnTJncioUSyUedR/fswiLoLE5v32we3aV/2WIvsI6n2LTaf3WTrPkAwhNv4GR3mjJTUVZyC2FTdIPF+ong8/2/C2m1xIAAkgy9OUQDKjTRdQ2juDxUeR7m252azTqcYYbQzmaYrqBfw5M167phNyIZML0kcyKUs1NkNEwagFcypA58U6oc8WpYuMue6tKkyfyPKd1fIhdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GcKnZZiKEHHzUo6FOv3aF1ZnDT/WcQpxj2LqeoE8Itw=;
 b=MKnNOdVADX4enpQvNpqbFpbYLjLkJJW40qU3waMBPB0BQAIKoabeUMZLGpQg5JwBcX1ibuvAkXFTQoYwmvXzk3P9CI2bvYhntCRO+ORxo5ierzBJ1wv9OAgb2Hdiq6yt07fM54P5q8piKGJ1/Eta04zjbS14kBFSAAM9PcpQKsQ=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SN6PR11MB2877.namprd11.prod.outlook.com (2603:10b6:805:5b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Tue, 4 Jan
 2022 07:07:12 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::5c96:23c3:4407:d3b1]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::5c96:23c3:4407:d3b1%9]) with mapi id 15.20.4844.016; Tue, 4 Jan 2022
 07:07:12 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <Kavyasree.Kotagiri@microchip.com>, <arnd@arndb.de>,
        <olof@lixom.net>, <robh+dt@kernel.org>,
        <Nicolas.Ferre@microchip.com>
CC:     <soc@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Manohar.Puri@microchip.com>
Subject: Re: [PATCH] ARM: dts: add DT for lan966x SoC and 2-port board pcb8291
Thread-Topic: [PATCH] ARM: dts: add DT for lan966x SoC and 2-port board
 pcb8291
Thread-Index: AQHYAKfBxAy1YVWf3k2O2unIgNc+5A==
Date:   Tue, 4 Jan 2022 07:07:12 +0000
Message-ID: <29f7e062-5669-ef1c-a80c-5e5b7b01af79@microchip.com>
References: <20220103124857.24351-1-kavyasree.kotagiri@microchip.com>
 <76804bd6-00e5-02ab-59df-d32586a55422@microchip.com>
 <CO1PR11MB48651B354ABAF04ABB53FB04924A9@CO1PR11MB4865.namprd11.prod.outlook.com>
In-Reply-To: <CO1PR11MB48651B354ABAF04ABB53FB04924A9@CO1PR11MB4865.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6e3314ad-53bf-4767-0d42-08d9cf50d4dd
x-ms-traffictypediagnostic: SN6PR11MB2877:EE_
x-microsoft-antispam-prvs: <SN6PR11MB28778A5BD36B38B19B324D48F04A9@SN6PR11MB2877.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mwMqKAClQoGc5u+9VPqn9Gm+thGWGAEEfoKLDZi33CPk9sVXqWBgsjqXURNJmo1b2+QOABlXnyDflmJbODJdpYWTMYAcjTq+EFJOvk9UdsDeGtzxEBoHoBCo4ol48GouXFyNnQGY8jMYOw/qyQB+SpHYCYaIZbUZfiCQ1/alnXhWK4iYkQe/c5xGvWLkjGJs/n2CgHjvoLf7LgRLPqxlcCPbLmwHiMg1qIP8IJbEoZPyvOJYvSVhpNsf/QdWfHw5lrV4cH8xdiRPIl0c+dO5gxhfGCmz+vXTM5UpHTcVbmBVGZvnSayfU/OaPFaQv1A7sARC/kGnWeSYkgl+DtYmlxI62A3FGDugc9HqzOuueRJ1/8RqgdUxtQH3gSZJ8lcTCqDP8tg5atBlVtaAVfjBDwFoTjgQZmLFCsCBV9XuDZkjLJmSrU56408QQaSqhxm2977IFICUdRglhZDg92WnGxGJW4wWTOoq9lmnFLWa7rfF9MpxjkGeG/MalZbMJkmDJeUC+y7msKfOg2n2tJH1UZeHEpoRZgtrUFnVzyvHd71WlQc2YzezocsFi/t3xOEufXLkpiXhE47zKAgWTdxmc61AVaHkmbjvfhxRDDYVznrv6WnrboExR5OCoiiq0gK1MZJpMAwhURAoTPc9cpzqo/zAVFWuiKKGdLSJvN1C9mnPxuVXSrFboogvWmDAFog0jT91tmM044kMrQYUSh1U5S0fmvyUopXKSGNpjj+rJ9rNG3rn4r0DTcXg7XAb/pJk5Ajr9yuSFck+WoYG13edpA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(66946007)(107886003)(86362001)(316002)(31696002)(26005)(186003)(122000001)(6636002)(8936002)(31686004)(38070700005)(71200400001)(66556008)(2616005)(54906003)(53546011)(38100700002)(76116006)(36756003)(91956017)(8676002)(4326008)(5660300002)(4744005)(2906002)(6512007)(110136005)(6486002)(66476007)(66446008)(6506007)(64756008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dnVFRFlWVjByTlRucWZibVNNM1pOTnNhOUFtYXM4dDFWTVBJamxLWHpkdnE3?=
 =?utf-8?B?NFhrZ0ZCZGFnOVpYN2NWVitPakl4TGQzUVNBeGZVdGlrdGwvb0NqR05XaVJ4?=
 =?utf-8?B?UDYxL2Z3VWw4Q0h1MUp3N2I3UHZyT0syeEd1TWUzQ2ZuL0llVkpqb2t0Rkdh?=
 =?utf-8?B?UzBGQ09PTCtUWFFUby9kRy8zbkp4Z2tpczkvSjVWL1ZSTmlrL3RjNXNIU3A0?=
 =?utf-8?B?R3hmNGtGSlNISFA4Tnp5QlRBd0pocGpQb3NZOEQ3aE04RDlvMGU5dmVOeWUz?=
 =?utf-8?B?eWFLUVUyVEh5eElnRlc2NEZ2QmRMaWZEd3djOXAzRUNqM29Ua0EvaWRYbHBn?=
 =?utf-8?B?NTlybGZVRDBCWFlpcnJ1VWZ3Wk40TndaVzdSV1YxaTNtb09YMnprS25aUVRW?=
 =?utf-8?B?U3dQaFU3dFhHTHd1M1JvR2s5RjZoY1d4UjNPYllYZVExWTdIcjN5bnEvT0F4?=
 =?utf-8?B?K0x0R2xiTmQzYnRnV1Z0RUx5SG04T050aC9mMkErVG1IRXF6SzdTM2IwYkU5?=
 =?utf-8?B?clN4bThDb2ozREdXa0tIM0oxZEkzdGJVc1czRjh0U0tLWnpiT21HZlE5MVk5?=
 =?utf-8?B?WWFvQi9ocWlhMndlaEhMeHBYVjBOUmxvTWFOT2g2Y1dHMFdxblZOa1dYY1VF?=
 =?utf-8?B?dytGMlpsaFdwSmM1QUl1WW1LUVluZjhFcHhXd2hiQnFpU0pKYjFBUmpEVlVs?=
 =?utf-8?B?UDBnTXFwRHd5a0R3WEV0UGYvb0ZoVmtldjBNS2tBKzVpMEhaV1VBY05DTEp5?=
 =?utf-8?B?b3pMcXVqUGpBaXpIc1JYcktsbnV6VHFGNXMzSmV5UkFGUWxaKy85VFptYjBa?=
 =?utf-8?B?M0JGY25XeWtyMjdxTlRlL0hRVGtsZWwrQlYyNVp6QVh2anpWMXpCMDlVQ2JD?=
 =?utf-8?B?aG5YODlDQjJTUVhBOXZrUk1RNEpRdUQzUUVsdTE5NUxTeGsrMGtWQXBWUno5?=
 =?utf-8?B?SmM2K3dONTB1RFBNS3AzdmJ5Ym9GZit4R3J6ZFFYUFNGQjVqTm1xeWhZYzlj?=
 =?utf-8?B?aVpGYjlDTXA2cHVjT1VVVUdJdG9zVlEzZUlXcnJqdlh2MHpjeTJpMithbWEx?=
 =?utf-8?B?ZGR4NCtBSy9GR0U2OWRtNEpvU0FsN3BVZ2NqQ0lyVEU1OTJDdmluZStsNVJh?=
 =?utf-8?B?MlZZSHZ4aDlJSkZvY2ZYbXJ0dkhOSTQrRzBxcjlLU2RMVU5UWEx4TUxDV043?=
 =?utf-8?B?NFQ2YzdXWWY3VzFaMGpWNkswL1NjSWFhYjR6dFFpVjllSGtNUk9UdTZtL0Rn?=
 =?utf-8?B?WXlMK0U1bWJ5QlpGdjYxNGZLZm5wdVdPWGlhK3QwSFlQbHFEVStDNDV3b054?=
 =?utf-8?B?V2o4NGZkUVZZMEpiUGE3SzlKeHNqdGZ0aTd6RjBQVnkwMHUxTGdsTW5XY2VH?=
 =?utf-8?B?NmkvSmNPQjZIdnE4bURteFFrVnNNeDg0dGtCQkJ5bytNb3kxY0VRNjc3V29o?=
 =?utf-8?B?N2dCVlV5TG9Oa0RTanQ5M2poMTdwbTR4TEttTlRqdHpZZVN4bEorUmdGYVpm?=
 =?utf-8?B?R2xVRVRaUlNaK3BySXVFSjlWTEtCZXRiaW1CVGF5UmY4TXVHcVI4TkFHOUVT?=
 =?utf-8?B?bDlqS0pZeUVPY0tmdEFZc2RyRFVUME8xY0IzVDBoMEZEdTd0SzlvQTZLeUR3?=
 =?utf-8?B?RzRFMTJMWW5ralcwdHE4bmxWY0c0TmdaMlJOQlpVM04zYVVFUWVORkxjTDM2?=
 =?utf-8?B?RHhUZncxcERXSVZQV3VmZmJBckl1QUk4MFpaSGFTWjEvTXlYTG92bzRSc2dU?=
 =?utf-8?B?bHorQ2dCVVM0cVM1aVJiTVNReG1vWkNUcE00anF5V29HN0RENVdMQVMxcjYx?=
 =?utf-8?B?OThQa21FY0dWUWV1TGd6U0IvNnpVTjdIV3Y1MExUTE1QU3pPcjlROCtRMkpU?=
 =?utf-8?B?UjVTemdaUkhTQ2t4UnE2Z0RYRzhudTg5eUhVNStzSTd4MW1yS1czZHJqOXFU?=
 =?utf-8?B?bWlOVEdtc0tHb3ZTbGZYREp2TGtBUWs0MGpDYTE0dVNQL1dKQ2tEY0tyV0pE?=
 =?utf-8?B?VHV3NFQ4MDRLdGlPOHFtVm95bnhEWllZMnVRRHh0U3luWmhudEw5dkRsUUtk?=
 =?utf-8?B?NUVsMy9uQWg4cWgwU0lkYTY0S2FObm84S054aURDY242SXY0TEVxNW9wMlJV?=
 =?utf-8?B?N0gwTTlmMTFibEE1UU5uZXkwRmxhNVYwOWgvZS9RenNBREp4T2dnb0xqL1Qv?=
 =?utf-8?B?MkRicU9FZ2pRWmJJaVNuVTdGL3ZzYUl5TWtKL05XcWsyZi9kcGY4TzdCVUpE?=
 =?utf-8?B?M2JrQUxMbEhJcW9wQ1NtOHA0MUlBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6156724E086E9445BB917CD7E4DAC1AA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e3314ad-53bf-4767-0d42-08d9cf50d4dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2022 07:07:12.4558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QVJi214ipJyABUiyuQm0yC9kaAehC3t+yznYC0Lg8qrFl2xbeSkpiBgufeCSxDK3MuOUiPGJCTRaRf5tFqHDbGZM+4OLgPQ5GyG2tpUdAGA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2877
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMS80LzIyIDc6MjAgQU0sIEthdnlhc3JlZSBLb3RhZ2lyaSAtIEkzMDk3OCB3cm90ZToNCj4+
IE9uIDEvMy8yMiAyOjQ4IFBNLCBLYXZ5YXNyZWUgS290YWdpcmkgd3JvdGU6DQo+Pj4gZGlmZiAt
LWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2xhbjk2NnhfcGNiODI5MS5kdHMNCj4+IGIvYXJjaC9h
cm0vYm9vdC9kdHMvbGFuOTY2eF9wY2I4MjkxLmR0cw0KPj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0
DQo+Pj4gaW5kZXggMDAwMDAwMDAwMDAwLi5jZDA0NTRhNzk1ZTcNCj4+PiAtLS0gL2Rldi9udWxs
DQo+Pj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvbGFuOTY2eF9wY2I4MjkxLmR0cw0KPj4+IEBA
IC0wLDAgKzEsNTUgQEANCj4+DQo+Pj4gKyZmbHgzIHsNCj4+PiArICAgICAgIGF0bWVsLGZsZXhj
b20tbW9kZSA9IDxBVE1FTF9GTEVYQ09NX01PREVfVVNBUlQ+Ow0KPj4+ICsgICAgICAgc3RhdHVz
ID0gIm9rYXkiOw0KPj4+ICsNCj4+PiArICAgICAgIHVzYXJ0MDogc2VyaWFsQDIwMCB7DQo+Pj4g
KyAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiYXRtZWwsYXQ5MXNhbTkyNjAtdXNhcnQiOw0K
Pj4NCj4+IFRoZSBmbGV4Y29tIHVzYXJ0IG1vZGUgc2hvdWxkIGJlIGRlZmluZWQgaW4gdGhlIGR0
c2kgZmlsZSwgc28gdGhhdCB5b3UNCj4+IHdvbid0IGR1cGxpY2F0ZSB0aGUgZGVmaW5pdGlvbiBp
biBlYWNoIGR0cyB0aGF0IGluY2x1ZGVzIHRoZSBkdHNpIGZpbGUuDQo+Pg0KPiBkZWZpbmluZyBm
bGV4Y29tIG1vZGUgaW4gZHRzIGFzIGZseDMgY2FuIGJlIHVzZWQgYXMgVVNBUlQvSTJDL1NQSSBv
biBkaWZmZXJlbnQgYm9hcmRzLg0KDQpSaWdodCwgeW91IHNob3VsZCBkZWZpbmUgdGhlIG1vZGUg
aW4gZHRzaSBhbmQgZW5hYmxlIGl0IGluIHRoZSBkdHMgZmlsZS4NCg0KPiBBbmQgaXQgaXMgbm90
IHRoZSBzYW1lIG1vZGUgZm9yIGFsbCBib2FyZHMuDQo+IA0KPj4gQ2hlZXJzLA0KPj4gdGENCg0K
