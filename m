Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6223747BB2F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 08:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235306AbhLUHhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 02:37:55 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:35733 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbhLUHhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 02:37:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1640072273; x=1671608273;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LVhR2RF15BfbcIj5jf2LE0hVD/Ojlzh35PrC0qglV1A=;
  b=VmfEsCvAOHdrUYjpIH8fjGSZCgf6A72zJrQ1k1/iRbVQexuIwvfotGu6
   iCVFctNa4kkBlzCfjkdw4u/aCbaQqROjCAtRfPBKmPGD8CTT+CZsi15FI
   wf0bigW+f/MJKorbL2q7p9oZbmWZFeSLB8/cU7SC7BeL4d3xYKzXp63BB
   VHuA+kCVfbiwQIUKktxuU03x1dNu0UMEs2kR1pKzabbIGyG0FsdzwEttE
   6CSwJQ+Jv7qZV38000E1z8F+hgtHMQ3s9eA+qkCBFXKd/jttDCotjWrAr
   TlmbqMPGto2GS7PDwaN0f16WXuqWqGMZngcu5POyBDAWnV+MjJF1GiM5p
   A==;
IronPort-SDR: z7/yhKLsGAaMsWC8cFAG7G/BKfCrb5f5flqiVsZmzVjMKQlg8mcRm/+MKQRc4mo/FgFbRggL9n
 WNT9smUIT4GtcDugnop4OXtVeHqpjDvPRz1DY2a6BLuNyO+FP3W61Tb/G4RaI6duQRq1smlvga
 5BiEXIpX4GLTPni3+NfNWF84WxFuGlaunCJC7D/jr5DFFrdFElSacrJR0204lxG0Q19Bf1lO0I
 3Arhix1PzrHm8ejMTlmIM4J19SlyKLflmmq6RiEiK2IKlwTnYIRdYLZiVh79SMN9CJERwpJiXF
 wzXtKzibg83+jwQy1t+VunBh
X-IronPort-AV: E=Sophos;i="5.88,222,1635231600"; 
   d="scan'208";a="143073545"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Dec 2021 00:37:52 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 21 Dec 2021 00:37:51 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Tue, 21 Dec 2021 00:37:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BhGtQIbzw3SMkkN7C/S9MPo6WP04VMKpZ1uZ5vK2Ru9FRcCYsQLGswXc/lhUN0Bg0MMg/Q1BcRK8MkE/Ods4sMi8FIporDCMrvnTYthzc/gEiS4S+QzmpYWj7ii4AsEQquuh05pmyPGMluB4javf51nLn3hZJxQBKldf6DJrs4dYPhqEHLGcxz4c0+otIMX40NAfKxS7idqcalvb89/pL4ZTdrb+WjcJu5qaZ1HgYMnKCt28POy+AxZwXbRPK8CywPN0aFxE4coD4q4JUmgXZLXQTfbJo0WLqt//7RTJKAIRthvj2f4w9iG6FxgljyNIu3p61AG9seTUXVLnG7K6JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LVhR2RF15BfbcIj5jf2LE0hVD/Ojlzh35PrC0qglV1A=;
 b=GerxdGqX2rm8KRC1CP6nVFl89nDkqg3eeJR9My0S+G1Rw6gc2NUwl6yLvgXk6wNuF3YuT6VNfAxC5ixkSSxpblTem+gnr/mE6ys9GNP6U9k4q2iNEud6qWKnX+meOPkqZsFbpNmE+LJX01mALnAM5ovkoySB+Oivlk7mcLFLJUi0R1Xeb6jj6d+od2RhfftnULS7zAmLVOIOEGJKcXyShniw6izQw5L9juEVorE1CT0Ij/JKwfBpZaoqTHfjeW/QeszlL8+paX0ZTrUJnTwFH8ec9sZLxijj4EGT4i28SKd3WwY53pZkNLufv/KjzHJxsRheiqnEIzWjhbDvU5sZeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LVhR2RF15BfbcIj5jf2LE0hVD/Ojlzh35PrC0qglV1A=;
 b=FOEKGS4yAptZNbxcVl+BViv7rr9NRnQuPouuawB2OevTdLvw4b5HH5HfOSp2hkLTberSiPXw7isNPOilRvyoHnGfaqhCaI8S2Mo1Zf0XatH7V8yipy41vUaqeH44l2hjjLzGEqWcIP3NnqJjwRFzBTFyZFbi5xNxMnpXFsoD2VE=
Received: from PH0PR11MB4920.namprd11.prod.outlook.com (2603:10b6:510:41::22)
 by PH0PR11MB5189.namprd11.prod.outlook.com (2603:10b6:510:3d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Tue, 21 Dec
 2021 07:37:47 +0000
Received: from PH0PR11MB4920.namprd11.prod.outlook.com
 ([fe80::1433:9dcf:4912:b8f]) by PH0PR11MB4920.namprd11.prod.outlook.com
 ([fe80::1433:9dcf:4912:b8f%9]) with mapi id 15.20.4801.020; Tue, 21 Dec 2021
 07:37:47 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <hugues.fruchet@st.com>, <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <jacopo+renesas@jmondi.org>, <sakari.ailus@linux.intel.com>,
        <laurent.pinchart@ideasonboard.com>, <slongerbeam@gmail.com>,
        <paul.kocialkowski@bootlin.com>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>, <biju.das.jz@bp.renesas.com>,
        <prabhakar.csengg@gmail.com>, <mchehab@kernel.org>
Subject: Re: [PATCH v4 1/6] media: i2c: ov5640: Remain in power down for DVP
 mode unless streaming
Thread-Topic: [PATCH v4 1/6] media: i2c: ov5640: Remain in power down for DVP
 mode unless streaming
Thread-Index: AQHWgvi4qdMvk8Y9N0iZFwzrul8/26lggxKAgcwfagCBEtLdAA==
Date:   Tue, 21 Dec 2021 07:37:47 +0000
Message-ID: <5c56c87d-ca48-5573-0606-da1441fab7ff@microchip.com>
References: <20200904201835.5958-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200904201835.5958-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <8b5d4928-2921-b876-7d1e-04bb42eff4fa@st.com>
 <3b54ab9b-4ffd-ab32-d495-fad6132ea504@microchip.com>
In-Reply-To: <3b54ab9b-4ffd-ab32-d495-fad6132ea504@microchip.com>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 456354c2-60aa-427a-94b7-08d9c454c8d7
x-ms-traffictypediagnostic: PH0PR11MB5189:EE_
x-microsoft-antispam-prvs: <PH0PR11MB518936F88B52B62FA5AC7270E87C9@PH0PR11MB5189.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FNJTHqsE6MXIfqGwyWCxyNcxTssORRk28eFo10QXWQhDaANp+PhrxWa0yJolpNzDEQ4TjjAC42ss7LkuhVIyDyLGmfW70LoSHk1RyvldmXn4tyBoaZwqP/D4hcgXa9tGMdY99iiFk5xCfPjTRKq5jUNO0OFPtBTZw+XQxRlO7wxevswJt7+mfFn3W4KatSfJmKl3jx2XcKCL7nzptllMvY8UuE+ul/ErjYwNRQB7iG6hpuCp4TPNGwdV/On9MYlajcs8nXL+ikyGTM9SJMuhCTCbFcuwRwriGx6Vh+50sk0p0nL6kekrsYTNOiVFqKFNc562CyRm7LWzg8m0x5659vqc+wzJJ3CPO4P/ixaIYHhhIHXhUWg/xhsyeQJy84nRDgAqPhWbq/49Lh6P6T6I+690iOjK06AVJejs0sW5valh8GDM1OxZfyv70b2dxL70AoYqQagQYDSqznLKI+T5ASPDQGdi0Nsq/Rg/9qEakm9yoYfSzuDFekubZC8OZpu1PK2roNEkMtRXfKODhuCYU3mMewUB5bgmU84BShKJ1en5nQBiyIlzOkonN1rLnTchbvZ8ZROSq0kya92EaWGmn6X+wEB6TO2ld/F0OMgGEkkZPFhQoonHsQW06yufNig4wxZrt4hB8/aWBbBfxqrHS24oiohbgBvd5ufrQoJ0HDm7Cx42xXGwYp6KPtaPkUMWTjQsmAgMqREcEdiTEgbYgBvCyc1hUoXm1kyCk6p058/Pv0YzInuBhhYQexylaoBJeGi+5Bmc557zZHvzAoo94g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4920.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(7416002)(4326008)(110136005)(186003)(8676002)(66476007)(54906003)(6486002)(71200400001)(6506007)(53546011)(316002)(26005)(6512007)(91956017)(66946007)(66446008)(8936002)(76116006)(66556008)(36756003)(508600001)(38100700002)(38070700005)(31686004)(122000001)(2906002)(83380400001)(86362001)(64756008)(5660300002)(2616005)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWJucWlxb2FIZXdPdWp2TmdPaDdCajFXQXdZMjFJSWxiRWNwVVFxTGdJSjlQ?=
 =?utf-8?B?d3Fqd0dXdDMxaGdEbkxncEFOempSR2J4N2Yyd0VGbG1LSkpIZm5JYTE3OXpZ?=
 =?utf-8?B?cHhKZVFGRHg1M2Rhd3BYbmJGQzFFbUVBTnovNDhBQ1JhbUFCSTBLOHZZWlM0?=
 =?utf-8?B?aVp6SnFGWk1KQ1dxNWtibEZXY3RnYnAyTUU4eHNoSGtOTm0yZllraFh0WVdR?=
 =?utf-8?B?L2M1OWpCeUxyTU9FVDZkcHArQlB1N2sxZVZybHRGM2tyd1dtYThlNWJ5OW1C?=
 =?utf-8?B?VDRCT0xuTEpyZHJLeW5DVW9wOCtWdEVLMEtodWl3eG5DaS9ML2VHRW9JNGtI?=
 =?utf-8?B?QjVRMUNSZ1JmS0RKMjRicVE4Q1pZSWtuV2dUbGN6VkU5RXE3TyttN3NpK2Q0?=
 =?utf-8?B?VHczWWJZdHJkYXdUY2k1U1hvQWNCRERXRWpMN3d1RW5OaTMzRUM4Ymkva1FE?=
 =?utf-8?B?cmtPUTgyV2lUNTNQUVhNalFuZzArZGkxRWh4RGJJUzlqUkRrc2wrOUNHcSsy?=
 =?utf-8?B?ZXR0V2dTeFR4ZmlRamt5bWRqVXRRNlk0ZlBLVis3bHNYamxzbGZ5Z0d0OCtC?=
 =?utf-8?B?YW1ZZEU4ekRidmZvOFZPT1lDMnlETk5lZTRDcDdzUGtnd3QwOUFMSmNndnZY?=
 =?utf-8?B?anVWZXIyTFdUSS9nd2xpZll0NmdXNlR4WVlaKzZnOTI2MlY3aFpVaDdtMnBC?=
 =?utf-8?B?ZDVzcWVDdS9HYmd0czFuRGxlYjJjTUtObk5Ra3JZSmMrWWNYbDZqU1BOTGha?=
 =?utf-8?B?Zm9xaVhxazRPVkVlUHZNc0x3ZGVWQlVqcFlBSFRjY2hrNXRhMDM5WThLSE5j?=
 =?utf-8?B?RGlVU1RJU1BsVUU0UVRmN1l2c1hpRjB4QThscFZ0cjBUMmpvMlpjTzRnQm01?=
 =?utf-8?B?bTZwak1VUG9yQWhSbmRubGpZdHhMSjNpQ3Q1a3BIdnFRMTQ3RzBDY2hCdlhX?=
 =?utf-8?B?NktaZVFzRFN3eTNFMFg3TGYxT2NVUEMva3BVak03VENDS055VGtLY2EwUUhu?=
 =?utf-8?B?U05LWWF1VzFJODZEUnl1WXhlLzc4UGZOclN3UzIwODgxRXJ6R1ZUZGpPNzR4?=
 =?utf-8?B?VkJaZXptYjFXRDM2OFJObkxqUTRaYzF4bHlTQ0lJaHZDc25CUXdpNXhzYlNQ?=
 =?utf-8?B?RGVRaHVDeSs5RWg1OGExTHRpYzNnY2VwUW5meE00K09TUXFMempzL1lYYVNR?=
 =?utf-8?B?VXUwSFVUMUUvMVZpWDQycWc2c01PZDB1M2xrcW53RzUzZEVWU2NFdXZFendD?=
 =?utf-8?B?TU5YYXNYS3lCWWlCVXlpUWFjVDhLRlRhaUc3ekRHQjBtbjY3M3RmRzRqdSts?=
 =?utf-8?B?a3FYanM0Z3RGQnpJcXdOekZPS05hODlZVG1lYVdtOGU5WWtHTHIvUlU4QjRy?=
 =?utf-8?B?SUVXTExvc01XVXhSb2tRL09WbnlqeUdXZFoyMlkzeVJoc2RnK2lqSkVnR2hR?=
 =?utf-8?B?R1dRbWtPVUx2di9UYW9NdGFJMG12eDNWdVhMd3dFZmJ0UGdFdy9Ud1kxanJ4?=
 =?utf-8?B?eHRTcHFuT2FJRjhBbXFFT09hbzNESDJBY1lqWTFMd1JmS0ZzMm5laVdQamxZ?=
 =?utf-8?B?bzdyY0czR0pnejZQb1NtYWdXTGx2M01wcVJiV0psS28vTFh4ZHl1MS85bkdL?=
 =?utf-8?B?aDZaVW96Ym9VRFQyUm1YQldPSElCdTFBU09WYmplNnhvWWw3ZmJJaGlaWHdJ?=
 =?utf-8?B?dGljM0t5enc2TEQ4VHRtak1qY3VFcEhKdW05bzZ3bGE0dUwwanVQNmtNQ3Jv?=
 =?utf-8?B?c3U3Smc4R1kwZGZnaHZLRTZNSVVxTEhmenZVeGtWN2RidzdpbTh4YXAzd3dK?=
 =?utf-8?B?dTFSamZGYkNTYWhWdDNndUpTd1BobkdYeW5BL2ErMnQvOC82b1JtVnRnM3JI?=
 =?utf-8?B?WXZiUHQ2NmhIdHZubHRKWVp6ZzlwNUNhTEJmU3QxbGFMYzhDb0xXdHJwb2hR?=
 =?utf-8?B?OHFLWlJNZEpXTXYwRktkbUphMnExOEYwZjVXbmRrS3NzTU8yK3UwRXZXMGhL?=
 =?utf-8?B?WXdJQTA2dVBWT0RIdWpvQzBEN2NhQTh2cm9uREFHdjdSejRIQlVsend0bnFX?=
 =?utf-8?B?RGg4TXc0UHJoY3RZb1FUTXhCNG9tSDNqbDMxK29mcUowQTB0Rk5UelgyaVhm?=
 =?utf-8?B?dmZiSTFOSmJQTEtpamNKbmdJTnB6RW9qK3ZiWXdkeUorK294TVdMRjZwRzdp?=
 =?utf-8?B?ZU4yOHlSdUN0SHNkenZMMmwrSWpkZHBQdnN4dG5FbTE0a1pPQVVrVzlqTTUy?=
 =?utf-8?B?Z0pzZmNmcGREN1oycE5UWTZxTmxRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF5BFE10219E8D4491ECB5F5835F6779@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4920.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 456354c2-60aa-427a-94b7-08d9c454c8d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2021 07:37:47.4120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5/AufbA6wQwP7JZv+aWOHuCgYjN+Q9IFw2MkVFnY4zYyNZ9F2uG1tpdwwyiZJqHGsGbMiaS4S/zxy3OpuUqmI70mCm1aWpm14waGEy3hbm8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5189
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNi8yOS8yMSAxOjQ3IFBNLCBFdWdlbiBIcmlzdGV2IC0gTTE4MjgyIHdyb3RlOg0KPiBPbiA5
LzkvMjAgNzoxNiBQTSwgSHVndWVzIEZSVUNIRVQgd3JvdGU6DQo+PiBIaSBQcmFiaGFrYXIsDQo+
Pg0KPj4gQXMgZGlzY3Vzc2VkIHNlcGFyYXRlbHkgSSB3b3VsZCBwcmVmZXIgdG8gYmV0dGVyIHVu
ZGVyc3RhbmQgaXNzdWUgYmVmb3JlDQo+PiBnb2luZyB0byB0aGlzIHBhdGNoLg0KPj4gTmV2ZXJ0
aGVsZXNzIEkgaGF2ZSBzb21lIHJlbWFya3MgaW4gY29kZSBpbiBjYXNlIHdlJ2xsIG5lZWQgaXQg
YXQgdGhlIGVuZC4NCj4+DQo+PiBPbiA5LzQvMjAgMTA6MTggUE0sIExhZCBQcmFiaGFrYXIgd3Jv
dGU6DQo+Pj4gS2VlcCB0aGUgc2Vuc29yIGluIHNvZnR3YXJlIHBvd2VyIGRvd24gbW9kZSBhbmQg
d2FrZSB1cCBvbmx5IGluDQo+Pj4gb3Y1NjQwX3NldF9zdHJlYW1fZHZwKCkgY2FsbGJhY2suDQo+
Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBMYWQgUHJhYmhha2FyIDxwcmFiaGFrYXIubWFoYWRldi1s
YWQucmpAYnAucmVuZXNhcy5jb20+DQo+Pj4gUmV2aWV3ZWQtYnk6IEJpanUgRGFzIDxiaWp1LmRh
cy5qekBicC5yZW5lc2FzLmNvbT4NCj4+PiBUZXN0ZWQtYnk6IEphY29wbyBNb25kaSA8amFjb3Bv
QGptb25kaS5vcmc+DQo+Pj4gLS0tDQo+Pj4gICAgIGRyaXZlcnMvbWVkaWEvaTJjL292NTY0MC5j
IHwgMTkgKysrKysrKysrKysrKysrKy0tLQ0KPj4+ICAgICAxIGZpbGUgY2hhbmdlZCwgMTYgaW5z
ZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L21lZGlhL2kyYy9vdjU2NDAuYyBiL2RyaXZlcnMvbWVkaWEvaTJjL292NTY0MC5jDQo+Pj4gaW5k
ZXggMmZlNGE3YWMwNTkyLi44ODBmZGU3M2EwMzAgMTAwNjQ0DQo+Pj4gLS0tIGEvZHJpdmVycy9t
ZWRpYS9pMmMvb3Y1NjQwLmMNCj4+PiArKysgYi9kcml2ZXJzL21lZGlhL2kyYy9vdjU2NDAuYw0K
Pj4+IEBAIC0zNCw2ICszNCw4IEBADQo+Pj4gICAgICNkZWZpbmUgT1Y1NjQwX1JFR19TWVNfUkVT
RVQwMiAgICAgICAgICAgICAgMHgzMDAyDQo+Pj4gICAgICNkZWZpbmUgT1Y1NjQwX1JFR19TWVNf
Q0xPQ0tfRU5BQkxFMDIgICAgICAgMHgzMDA2DQo+Pj4gICAgICNkZWZpbmUgT1Y1NjQwX1JFR19T
WVNfQ1RSTDAgICAgICAgICAgICAgICAgMHgzMDA4DQo+Pj4gKyNkZWZpbmUgT1Y1NjQwX1JFR19T
WVNfQ1RSTDBfU1dfUFdETiAweDQyDQo+Pj4gKyNkZWZpbmUgT1Y1NjQwX1JFR19TWVNfQ1RSTDBf
U1dfUFdVUCAweDAyDQo+Pg0KPj4gRm9yIHRoZSB0aW1lIGJlaW5nIHRoaXMgc2VjdGlvbiB3YXMg
b25seSByZWZlcnJpbmcgdG8gcmVnaXN0ZXJzDQo+PiBhZGRyZXNzZXMgYW5kIGJpdCBkZXRhaWxz
IHdhcyBleHBsYWluZWQgaW50byBhIGNvbW1lbnQgcmlnaHQgYmVmb3JlDQo+PiBhZmZlY3RhdGlv
biwgc2VlIE9WNTY0MF9SRUdfSU9fTUlQSV9DVFJMMDAgZm9yIGV4YW1wbGUuDQo+Pg0KPj4+ICAg
ICAjZGVmaW5lIE9WNTY0MF9SRUdfQ0hJUF9JRCAgICAgICAgICAweDMwMGENCj4+PiAgICAgI2Rl
ZmluZSBPVjU2NDBfUkVHX0lPX01JUElfQ1RSTDAwICAgMHgzMDBlDQo+Pj4gICAgICNkZWZpbmUg
T1Y1NjQwX1JFR19QQURfT1VUUFVUX0VOQUJMRTAxICAgICAgMHgzMDE3DQo+Pj4gQEAgLTExMjAs
NiArMTEyMiwxMiBAQCBzdGF0aWMgaW50IG92NTY0MF9sb2FkX3JlZ3Moc3RydWN0IG92NTY0MF9k
ZXYgKnNlbnNvciwNCj4+PiAgICAgICAgICAgICAgICAgdmFsID0gcmVncy0+dmFsOw0KPj4+ICAg
ICAgICAgICAgICAgICBtYXNrID0gcmVncy0+bWFzazsNCj4+Pg0KPj4+ICsgICAgICAgICAgICAg
LyogcmVtYWluIGluIHBvd2VyIGRvd24gbW9kZSBmb3IgRFZQICovDQo+Pj4gKyAgICAgICAgICAg
ICBpZiAocmVncy0+cmVnX2FkZHIgPT0gT1Y1NjQwX1JFR19TWVNfQ1RSTDAgJiYNCj4+PiArICAg
ICAgICAgICAgICAgICB2YWwgPT0gT1Y1NjQwX1JFR19TWVNfQ1RSTDBfU1dfUFdVUCAmJg0KPj4+
ICsgICAgICAgICAgICAgICAgIHNlbnNvci0+ZXAuYnVzX3R5cGUgIT0gVjRMMl9NQlVTX0NTSTJf
RFBIWSkNCj4+PiArICAgICAgICAgICAgICAgICAgICAgY29udGludWU7DQo+Pj4gKw0KPj4NCj4+
IEkgdW5kZXJzdGFuZCB0aGF0IG1vcmUgb3IgbGVzcyByZWdpc3RlciBPVjU2NDBfUkVHX1NZU19D
VFJMMCAoMHgzMDA4KQ0KPj4gaGFzIGJlZW4gcGFydGlhbGx5IHJlbW92ZWQgZnJvbSBiaWcgaW5p
dCBzZXF1ZW5jZTogZm9yIHBvd2VyLXVwIHBhcnQsDQo+PiBidXQgcG93ZXItZHduIHJlbWFpbnMg
YXQgdmVyeSBiZWdpbm5pbmcgb2Ygc2VxdWVuY2UuDQo+PiBXZSBzaG91bGQgY29tcGxldGVseSBy
ZW1vdmUgMHgzMDA4IGZyb20gaW5pdCBzZXF1ZW5jZSwgaW5jbHVkaW5nDQo+PiBwb3dlci1kd24s
IGFuZCBpbnRyb2R1Y2UgYSBuZXcgZnVuY3Rpb24gb3Y1NjQwX3N3X3Bvd2VyZG93bihvbi9vZmYp
IHRoYXQNCj4+IHNob3VsZCBiZSBjYWxsZWQgYXQgdGhlIHJpZ2h0IHBsYWNlIGluc3RlYWQuDQo+
Pg0KPj4NCj4+PiAgICAgICAgICAgICAgICAgaWYgKG1hc2spDQo+Pj4gICAgICAgICAgICAgICAg
ICAgICAgICAgcmV0ID0gb3Y1NjQwX21vZF9yZWcoc2Vuc29yLCByZWdfYWRkciwgbWFzaywgdmFs
KTsNCj4+PiAgICAgICAgICAgICAgICAgZWxzZQ0KPj4+IEBAIC0xMjk3LDkgKzEzMDUsMTQgQEAg
c3RhdGljIGludCBvdjU2NDBfc2V0X3N0cmVhbV9kdnAoc3RydWN0IG92NTY0MF9kZXYgKnNlbnNv
ciwgYm9vbCBvbikNCj4+PiAgICAgICAgICAqIFBBRCBPVVRQVVQgRU5BQkxFIDAyDQo+Pj4gICAg
ICAgICAgKiAtIFs3OjJdOiAgICAgRFs1OjBdIG91dHB1dCBlbmFibGUNCj4+PiAgICAgICAgICAq
Lw0KPj4+IC0gICAgIHJldHVybiBvdjU2NDBfd3JpdGVfcmVnKHNlbnNvciwNCj4+PiAtICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBPVjU2NDBfUkVHX1BBRF9PVVRQVVRfRU5BQkxFMDIsDQo+
Pj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgb24gPyAweGZjIDogMCk7DQo+Pj4gKyAg
ICAgcmV0ID0gb3Y1NjQwX3dyaXRlX3JlZyhzZW5zb3IsIE9WNTY0MF9SRUdfUEFEX09VVFBVVF9F
TkFCTEUwMiwNCj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgIG9uID8gMHhmYyA6IDAp
Ow0KPj4+ICsgICAgIGlmIChyZXQpDQo+Pj4gKyAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPj4+
ICsNCj4+PiArICAgICByZXR1cm4gb3Y1NjQwX3dyaXRlX3JlZyhzZW5zb3IsIE9WNTY0MF9SRUdf
U1lTX0NUUkwwLCBvbiA/DQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgT1Y1NjQw
X1JFR19TWVNfQ1RSTDBfU1dfUFdVUCA6DQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgT1Y1NjQwX1JFR19TWVNfQ1RSTDBfU1dfUFdETik7DQo+Pj4gICAgIH0NCj4+Pg0KPj4+ICAg
ICBzdGF0aWMgaW50IG92NTY0MF9zZXRfc3RyZWFtX21pcGkoc3RydWN0IG92NTY0MF9kZXYgKnNl
bnNvciwgYm9vbCBvbikNCj4+Pg0KPj4NCj4+DQo+PiBCUiwNCj4+IEh1Z3Vlcy4NCj4+DQo+IA0K
PiANCj4gSGVsbG8gZXZlcnlvbmUsDQo+IA0KPiBXaGVuIEkgdXBkYXRlZCBkcml2ZXIgaW4gbXkg
dHJlZSB3aXRoIHRoaXMgcGF0Y2gsIEkgbm90aWNlZCB0aGF0IG15DQo+IHNldHVwIHVzaW5nIHRo
ZSBBVE1FTCBpc2MgcGxhdGZvcm0gKyBvdjU2NDAgaW4gcGFyYWxsZWwgYnVzIG1vZGUgc3RvcHBl
ZA0KPiB3b3JraW5nLg0KPiANCj4gSXQgbG9va3MgbGlrZSB0aGUgY3VscHJpdCBpcyB0aGlzIHBh
dGNoLg0KPiBJIGFtIG5vdCBzdXJlIHdoaWNoIGlzIHRoZSBiZXN0IHdheSB0byBmaXggaXQuDQo+
IEl0IGxvb2tzIGxpa2UgaW5pdGlhbGx5IHRoaW5ncyB3b3JrIGZpbmUgd2hlbiBwcm9iaW5nIHRo
ZSBkcml2ZXIsIGJ1dA0KPiB3aGVuIHdlIHdhbnQgdG8gc3RhcnQgc3RyZWFtaW5nIGF0IGEgbGF0
ZXIgcG9pbnQsIHRoZSByZWdpc3RlciBTWVNfQ1RSTDANCj4gY2Fubm90IGJlIHdyaXR0ZW4gYW55
bW9yZS4NCj4gSGVyZSBpcyBhbiBvdXRwdXQgb2YgdGhlIGxvZzoNCj4gDQo+ICAgIC0tLSBPcGVu
aW5nIC9kZXYvdmlkZW8wLi4uDQo+ICAgICAgIFRyeWluZyBzb3VyY2UgbW9kdWxlIHY0bDIuLi4N
Cj4gICAgICAgL2Rldi92aWRlbzAgb3BlbmVkLg0KPiAgICAgICBObyBpbnB1dCB3YXMgc3BlY2lm
aWVkLCB1c2luZyB0aGUgZmlyc3QuDQo+ICAgICAgIG92NTY0MCAxLTAwM2M6IG92NTY0MF93cml0
ZV9yZWc6IGVycm9yOiByZWc9MzAwOCwgdmFsPTINCj4gICAgICAgYXRtZWwtc2FtYTVkMi1pc2Mg
ZjAwMDgwMDAuaXNjOiBzdHJlYW0gb24gZmFpbGVkIGluIHN1YmRldiAtMTIxDQo+ICAgICAgIEVy
cm9yIHN0YXJ0aW5nIHN0cmVhbS4NCj4gICAgICAgVklESU9DX1NUUkVBTU9OOiBSZW1vdGUgSS9P
IGVycm9yDQo+ICAgICAgIFVuYWJsZSB0byB1c2UgbW1hcC4gVXNpbmcgcmVhZCBpbnN0ZWFkLg0K
PiAgICAgICBVbmFibGUgdG8gdXNlIHJlYWQuDQo+IA0KPiBJIGFtIHVzaW5nIGEgc2ltcGxlIGFw
cGxpY2F0aW9uIHRvIHJlYWQgZnJvbSAvZGV2L3ZpZGVvMCAod2hpY2ggaXMNCj4gcmVnaXN0ZXJl
ZCBieSB0aGUgYXRtZWwtaXNjIG9uY2UgdGhlIHNlbnNvciBwcm9iZWQpDQo+IA0KPiBJIGhhdmUg
YSBmZWVsaW5nIHRoYXQgc29tZXRoaW5nIGlzIHdyb25nIHJlbGF0ZWQgdG8gcG93ZXIsIGJ1dCBJ
IGNhbm5vdA0KPiB0ZWxsIGZvciBzdXJlLg0KPiANCj4gUmV2ZXJ0aW5nIHRoaXMgcGF0Y2ggbWFr
ZXMgaXQgd29yayBmaW5lIGFnYWluLg0KPiANCj4gSGVscCBpcyBhcHByZWNpYXRlZCwNCj4gVGhh
bmtzLA0KPiBFdWdlbg0KPiANCg0KDQpHZW50bGUgcGluZy4NCg0KSSB3b3VsZCBsaWtlIHRvIHNl
bmQgYSByZXZlcnQgcGF0Y2ggaWYgbm9ib2R5IGNhcmVzIGFib3V0IHRoaXMgDQpkcml2ZXIvcGF0
Y2ggZXhjZXB0IG1lLg0KDQpUaGFua3MsDQpFdWdlbg0K
