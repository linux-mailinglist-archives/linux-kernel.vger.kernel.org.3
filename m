Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBA451D98E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 15:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441870AbiEFNsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 09:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiEFNsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 09:48:04 -0400
Received: from de-smtp-delivery-213.mimecast.com (de-smtp-delivery-213.mimecast.com [194.104.111.213])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC1FB33A32
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 06:44:20 -0700 (PDT)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2105.outbound.protection.outlook.com [104.47.22.105]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-22-d5woUW79NIOIJ2hVHnz6ew-1; Fri, 06 May 2022 15:44:14 +0200
X-MC-Unique: d5woUW79NIOIJ2hVHnz6ew-1
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 ZR0P278MB0619.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3a::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.24; Fri, 6 May 2022 13:44:12 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::c52f:2a3f:8cf5:6144]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::c52f:2a3f:8cf5:6144%4]) with mapi id 15.20.5206.027; Fri, 6 May 2022
 13:44:12 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "soc@kernel.org" <soc@kernel.org>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Denys Drozdov <denys.drozdov@toradex.com>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "matthias.schiffer@tq-group.com" <matthias.schiffer@tq-group.com>,
        "marex@denx.de" <marex@denx.de>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        "leoyang.li@nxp.com" <leoyang.li@nxp.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Max Krummenacher <max.krummenacher@toradex.com>
Subject: Re: [PATCH v2 00/14] ARM: dts: imx6ull-colibri: device tree
 improvements
Thread-Topic: [PATCH v2 00/14] ARM: dts: imx6ull-colibri: device tree
 improvements
Thread-Index: AQHYWMDrkguBdVFYI0mLpdSkg5mHma0Po20AgAJJzQA=
Date:   Fri, 6 May 2022 13:44:12 +0000
Message-ID: <6a5a4a58092135ce70c404edfaf2570c926878dd.camel@toradex.com>
References: <20220425162356.176665-1-marcel@ziswiler.com>
         <20220505024732.GO14615@dragon>
In-Reply-To: <20220505024732.GO14615@dragon>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6605d3ad-a2fb-4505-91cc-08da2f66813b
x-ms-traffictypediagnostic: ZR0P278MB0619:EE_
x-microsoft-antispam-prvs: <ZR0P278MB06197D1711E5B4C28504397BFBC59@ZR0P278MB0619.CHEP278.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: 9/WcQAug6PMcU1ID0Bw85huSba4Kh7qB2+fu9ufOUJdcG5gyPpDesnkrvq9mqO3Oj/uVN/sMg4ku60dGRgtYkd7jXO3wQzqWIzLnBz4hPJalwvcLj3fcVtzf0uqvJMndbT49NppX83TFf1q/gqzJF3t0f8DVIENDK1X7/ohdmspzXReO8f0x5E34gqvt0xVbuJYJP0c3Ki2rhT/r9YSxHD4zMsx/XOvV2ZlWMdW7Ljd3jB8tfFRW8Hw6LKqsC2v2NSHaZDVxqLadfUY6hhry4AKEvuLxIRAj8Oc6iBEWiOBWGhdFlxkt/OspUohSos7X8qpcovp9cdqpoWfrMze0Mi7bjl8UzqucLCXhRSXLrQg+OFEHLDTVRMI8ziwEUiXT0FD9xrInCFJysb1dPwp7Wpgzy4SakrW1j3OUXbuVYennwkONNa6YLD6CF5xyHiRLvy+HmEPBWcc7rqej8ipYAT9JIgijCIfbM4w7bNWFwgiMDjYuf8PhxaAP9G4AhEjJ5GHQp8CuS0E5MzbPASZreS2jRuMw93fF+ZXv3KV/q5FlNnPurFJl357pDznnaFLtiG0UZBLr2sjkEXL1jwlA4AHaJBe/1+P2FhtwQft/FOB73Lk9iejR+44MBeQxfbnmnVDLwOI3oJxB4uGbVJJeg3pL792Ox7MiFPYSYkA81diEgCkBHxWZEztT9I7Iv453WIKHEZ40p4qPV4kpoYOE2Pf9YSIynDMTZjNfEXPuORE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(346002)(66476007)(8676002)(4326008)(64756008)(2616005)(316002)(6512007)(26005)(6506007)(66446008)(76116006)(66946007)(66556008)(6916009)(86362001)(508600001)(71200400001)(6486002)(186003)(107886003)(38100700002)(122000001)(38070700005)(83380400001)(36756003)(44832011)(7416002)(2906002)(8936002)(5660300002)(54906003)(32563001);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2hieW0rRm81ckc0c3VKS2VXdy9BU0k2K2dzeGdRYlJvMnJSVnlRbHUxT0dt?=
 =?utf-8?B?aGRqdFFUSzlDSVc2TFcrQjJoUHdSZ0hrbndnYVA5SnRQR1RPSmRGekIzODdD?=
 =?utf-8?B?WVFPZlRwRHZGRkR0R0ZMTTV3bFRxblJYUW5qK1VnMnZxSVNSQ01ZZkIyVUw4?=
 =?utf-8?B?bG5oNlRSdUtSaDdxMHJHaW53UDFVM3VhbU5PN09PeHpMdUNNejIyb0tNaEVi?=
 =?utf-8?B?UldjK3hhaktJL0NPTkgzMGNhM2hjczlLQ0xsYjYzd0JPaklJUXFsRkFHNXAx?=
 =?utf-8?B?eDUvQmRYTHYvOGhmV3h6QzUycFVQdjlZaHZuclZXM0ZaQUJMcXNDTVF1c2Rj?=
 =?utf-8?B?dGZvVEx1MkdFdEYrSTV0TzlIZWFqZklrbVpQb3FNVm1sS085YnBRLzRzWDll?=
 =?utf-8?B?MWsvd3JRY2x6Tml6ZG5FQ3JFSSs3ZWdCSmRqNTBXRTkvTlFXbWozTnJnM0V4?=
 =?utf-8?B?YmJkVXJHajdIaEtpSFRONVFaam8xV2dPVzZEWWhhV0tYRW1DRC9RUFd2Ynoy?=
 =?utf-8?B?YTFGc2xRdThoczhEQisyVkMxZ3RPQWtjU0dFdlJYQllyVVh1RjEvYVowTTcr?=
 =?utf-8?B?NTBITjZENmFRTGlhR0JvbXVsMFZLb29oS25HVklxeXh5SUtDUXpCQTZmcFQr?=
 =?utf-8?B?NDFCaFdlYzM4UzZsQy9yQnZTR2F1NFg0S0RaeHgydTVTcis0TllmM0tENHRG?=
 =?utf-8?B?YjU0S2NmWmhRbGJXVFhVTVBNZXcwRnlscVRaTU4rT1hVWStDeklhdEZkWXZB?=
 =?utf-8?B?ZnJPYUhIZDZNVGVkaGJnT1RTNkdUcVJsZ3ZWSWl2K1pVNW1USlB4bU1ENHJa?=
 =?utf-8?B?Y2dXK3FsWkloOU1VVG1zTEM4bHo0RE5wVitad0ZGSUdXa0kzNTdpay9Nb0hR?=
 =?utf-8?B?VWlQN1F6QldOMzZGWVF0K3JzdktsMHZZTC9tVXdJY3NsT0R6UkNlRCtCdVBU?=
 =?utf-8?B?dlgybFY4OGJXc25WMW9UL1pvbWM4N002eTkvekExcVFFSnp4MmlzQnZkQWow?=
 =?utf-8?B?U1VWS3MwdzBuQ3FUSExXVFVVNUh4RFRES1hhOUlKa3JkSmIyVUtIWUxJM2dR?=
 =?utf-8?B?RnhkRUtPL3hQODJBYnBSL0ZWaGVMVmZkUk5RYStCNHlXMTFUZGRub09zajFG?=
 =?utf-8?B?NjVBaklwU0JqRXRSYlIraS9NYU11NzN4UEFkSFV5SmZwd1g1SHlFRUFNT3hG?=
 =?utf-8?B?VDJncitkY2tkbmxlVW9kMWVIcDNSS09hbDlzb1c2UnpoUGl4RzZ4ZHplcjR1?=
 =?utf-8?B?UnU2TFN3bzVibk1LOUhDMEF5cC9CNU5iSVFmZmdhZFlJTE5ZTDR0SUcyM0NR?=
 =?utf-8?B?VHlkaGY3MW9FQ1UwNFRwNEFqVWxpRVI4TFgzNW1XMk5xbDVFUENpSnhGdjJp?=
 =?utf-8?B?dmw5Wjk0ZUY5SkZyZjF2ZHRjWHBZaTBaNDFhRUx3QzBzOVB5ZFdtOUQzcWdD?=
 =?utf-8?B?S09rajJRcEFDcWRwUHNDZ3lGL0RTK1lwTVhjdHFlUHVJWEl0MjJabEhVMkh5?=
 =?utf-8?B?bEEwMGlTZDJ6cDJ3Qkp1a2JNZTFoOXdncHUyZXpWRzJkVnN5dUIwcW1yT2xr?=
 =?utf-8?B?VVVQc2s3VStlaWtzUEVCNm9LZWtlRjhiVlE5NXBXUCt5OWdaNXljckxyT3Fv?=
 =?utf-8?B?M1psYlRMdEk4NmdhZS8rV09hTUFqREo2bnJWTWk4N1NtdUR4anFrcTZWTVIx?=
 =?utf-8?B?bXFHRTNJZDMwODJ0UXk0bVZiV1ZsZWU1M0pjb3NjY044UFR5V3RRU09ET3g1?=
 =?utf-8?B?eGFYQVRMeEgxb3FhL082aXVBTVhUNENqVWptemMxUmhXQWJqdGlSUDRjMFlV?=
 =?utf-8?B?L1NTaUNkVHUrMWN6d1RUMHg0bG5jWE5hYXBmZzRhRlhPUHVGdWhZamFEOU1k?=
 =?utf-8?B?U3dVdGU0SXVQREg3SGhINjNOaGxSVTJjU0k5ZjFSS0t4T254OWQrVjVuL2Jx?=
 =?utf-8?B?YzBBV1QxSzNQbTlIaG9uZm0xZ0JCbnJoM3kxTWc3aXVhL0UzYm1RQURVMW5B?=
 =?utf-8?B?a3hXM01mMlhZbjBtdDluVHhrM3NUOFRXM1lteCtIVkFIcDE2bHp4TzdWaGh6?=
 =?utf-8?B?Vyt2OUxxdXhJMnpJWnJPRGVZcHg3eXdYVXNlaVJFRDZtS1NKcG9iQkZsVG1S?=
 =?utf-8?B?dTlrd1U4c2tHc1BrZUhOOWgzdWFodjUxK1ZDSzl4dVZmbUJ4QzZCSzYyRnRz?=
 =?utf-8?B?OUozMUlsL1UxUGdBb250UVZscXhHY3ErNjF0OG0wZ0hpb3Zrc2htRGs2NEho?=
 =?utf-8?B?cUFxNDVqRk4xQXYyTDJmalhEcXMvQkFBT1pNckw4L3l1Tytpd3luMllCTHNT?=
 =?utf-8?B?RGdZWGZnYWtRaHVZVm5ya0gyRFBFQkZkaXZsc2I3djNNR2E5MUFoQmdDRXhO?=
 =?utf-8?Q?q8P/ewEJGe1hC7gO8nGfCcNhIbppQbTSLIysb?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6605d3ad-a2fb-4505-91cc-08da2f66813b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2022 13:44:12.7056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VCtl9t4wY3/nqxyZAF2+wYXBYcnTu0pNFyRnHN3mfbmgvg9b7Oc3IDCKle6XdZYfX9b7jwT4AE0/x2XuHCDJ3Wl3r1hxO6nlkM3eclxl5Hc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0619
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CDE13A77 smtp.mailfrom=marcel.ziswiler@toradex.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <470FF257C31BC947B2E533D7BE7F1BDB@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU2hhd24NCg0KT24gVGh1LCAyMDIyLTA1LTA1IGF0IDEwOjQ3ICswODAwLCBTaGF3biBHdW8g
d3JvdGU6DQoNCltzbmlwXQ0KDQo+IFRoZSBkdHMgc2VyaWVzIGRvZXNuJ3QgYXBwbHkgdG8gbXkg
YnJhbmNoLg0KPiANCj4gQXBwbHlpbmc6IEFSTTogZHRzOiBpbXg2dWxsLWNvbGlicmk6IHVzZSBw
dWxsLWRvd24gZm9yIGFkYyBwaW5zDQo+IEFwcGx5aW5nOiBBUk06IGR0czogaW14NnVsbC1jb2xp
YnJpOiBjaGFuZ2UgdG91Y2ggaTJjIHBhcmFtZXRlcnMNCj4gQXBwbHlpbmc6IEFSTTogZHRzOiBp
bXg2dWxsLWNvbGlicmk6IGFkZCBwaHktc3VwcGx5IHRvIGZlYw0KPiBBcHBseWluZzogQVJNOiBk
dHM6IGlteDZ1bGwtY29saWJyaTogYWRkIHRvdWNoc2NyZWVuIGRldmljZSBub2Rlcw0KPiBBcHBs
eWluZzogQVJNOiBkdHM6IGlteDZ1bGwtY29saWJyaTogdXBkYXRlIHVzZGhjMSBwaXhtdXggYW5k
IHNpZ25hbGluZw0KPiBlcnJvcjogcGF0Y2ggZmFpbGVkOiBhcmNoL2FybS9ib290L2R0cy9pbXg2
dWxsLWNvbGlicmkuZHRzaTozNQ0KPiBlcnJvcjogYXJjaC9hcm0vYm9vdC9kdHMvaW14NnVsbC1j
b2xpYnJpLmR0c2k6IHBhdGNoIGRvZXMgbm90IGFwcGx5DQo+IFBhdGNoIGZhaWxlZCBhdCAwMDA1
IEFSTTogZHRzOiBpbXg2dWxsLWNvbGlicmk6IHVwZGF0ZSB1c2RoYzEgcGl4bXV4IGFuZCBzaWdu
YWxpbmcNCj4gaGludDogVXNlICdnaXQgYW0gLS1zaG93LWN1cnJlbnQtcGF0Y2gnIHRvIHNlZSB0
aGUgZmFpbGVkIHBhdGNoDQo+IFdoZW4geW91IGhhdmUgcmVzb2x2ZWQgdGhpcyBwcm9ibGVtLCBy
dW4gImdpdCBhbSAtLWNvbnRpbnVlIi4NCj4gSWYgeW91IHByZWZlciB0byBza2lwIHRoaXMgcGF0
Y2gsIHJ1biAiZ2l0IGFtIC0tc2tpcCIgaW5zdGVhZC4NCj4gVG8gcmVzdG9yZSB0aGUgb3JpZ2lu
YWwgYnJhbmNoIGFuZCBzdG9wIHBhdGNoaW5nLCBydW4gImdpdCBhbSAtLWFib3J0Ii4NCj4gDQo+
IEFwcGx5aW5nOiBBUk06IGR0czogaW14NnVsbC1jb2xpYnJpOiB1cGRhdGUgZGV2aWNlIHRyZWVz
IHRvIHN1cHBvcnQgb3ZlcmxheXMNCj4gQXBwbHlpbmc6IEFSTTogZHRzOiBpbXg2dWxsLWNvbGli
cmk6IGFkZCBncGlvLWxpbmUtbmFtZXMNCj4gQXBwbHlpbmc6IEFSTTogZHRzOiBpbXg2dWxsLWNv
bGlicmk6IGFkZCBzdXBwb3J0IGZvciB0b3JhZGV4IGlyaXMgY2FycmllciBib2FyZHMNCj4gQXBw
bHlpbmc6IEFSTTogZHRzOiBpbXg2dWxsLWNvbGlicmk6IGFkZCBzdXBwb3J0IGZvciB0b3JhZGV4
IGFzdGVyIGNhcnJpZXIgYm9hcmRzDQo+IEFwcGx5aW5nOiBBUk06IGR0czogaW14NnVsbC1jb2xp
YnJpOiBmaXggbmFuZCBiY2ggZ2VvbWV0cnkNCj4gQXBwbHlpbmc6IEFSTTogZHRzOiBpbXg2dWxs
LWNvbGlicmk6IGFkZC91cGRhdGUgc29tZSBjb21tZW50cw0KPiBlcnJvcjogcGF0Y2ggZmFpbGVk
OiBhcmNoL2FybS9ib290L2R0cy9pbXg2dWxsLWNvbGlicmkuZHRzaToyNTENCj4gZXJyb3I6IGFy
Y2gvYXJtL2Jvb3QvZHRzL2lteDZ1bGwtY29saWJyaS5kdHNpOiBwYXRjaCBkb2VzIG5vdCBhcHBs
eQ0KPiBQYXRjaCBmYWlsZWQgYXQgMDAxMSBBUk06IGR0czogaW14NnVsbC1jb2xpYnJpOiBhZGQv
dXBkYXRlIHNvbWUgY29tbWVudHMNCj4gaGludDogVXNlICdnaXQgYW0gLS1zaG93LWN1cnJlbnQt
cGF0Y2gnIHRvIHNlZSB0aGUgZmFpbGVkIHBhdGNoDQo+IFdoZW4geW91IGhhdmUgcmVzb2x2ZWQg
dGhpcyBwcm9ibGVtLCBydW4gImdpdCBhbSAtLWNvbnRpbnVlIi4NCj4gSWYgeW91IHByZWZlciB0
byBza2lwIHRoaXMgcGF0Y2gsIHJ1biAiZ2l0IGFtIC0tc2tpcCIgaW5zdGVhZC4NCj4gVG8gcmVz
dG9yZSB0aGUgb3JpZ2luYWwgYnJhbmNoIGFuZCBzdG9wIHBhdGNoaW5nLCBydW4gImdpdCBhbSAt
LWFib3J0Ii4NCj4gDQo+IEFwcGx5aW5nOiBBUk06IGR0czogaW14NnVsbC1jb2xpYnJpOiBtb3Zl
IGdwaW8ta2V5cyBub2RlIHRvIHNvbSBkdHNpDQo+IEFwcGx5aW5nOiBBUk06IGR0czogaW14NnVs
bC1jb2xpYnJpOiBpbXByb3ZlIHBpbmN0cmwgbm9kZSBuYW1lcw0KPiBlcnJvcjogcGF0Y2ggZmFp
bGVkOiBhcmNoL2FybS9ib290L2R0cy9pbXg2dWxsLWNvbGlicmkuZHRzaToyOTINCj4gZXJyb3I6
IGFyY2gvYXJtL2Jvb3QvZHRzL2lteDZ1bGwtY29saWJyaS5kdHNpOiBwYXRjaCBkb2VzIG5vdCBh
cHBseQ0KPiBQYXRjaCBmYWlsZWQgYXQgMDAxMyBBUk06IGR0czogaW14NnVsbC1jb2xpYnJpOiBp
bXByb3ZlIHBpbmN0cmwgbm9kZSBuYW1lcw0KPiBoaW50OiBVc2UgJ2dpdCBhbSAtLXNob3ctY3Vy
cmVudC1wYXRjaCcgdG8gc2VlIHRoZSBmYWlsZWQgcGF0Y2gNCj4gV2hlbiB5b3UgaGF2ZSByZXNv
bHZlZCB0aGlzIHByb2JsZW0sIHJ1biAiZ2l0IGFtIC0tY29udGludWUiLg0KPiBJZiB5b3UgcHJl
ZmVyIHRvIHNraXAgdGhpcyBwYXRjaCwgcnVuICJnaXQgYW0gLS1za2lwIiBpbnN0ZWFkLg0KPiAN
Cj4gU2hhd24NCg0KSSBqdXN0IG5vdyBzZW50IGEgdjMgcmUtYmFzZWQgb24geW91ciBpbXgvZHQu
IEkgaG9wZSB0aGF0IGFwcGxpZXMgbm93LiBUaGFua3MhDQoNCkNoZWVycw0KDQpNYXJjZWwNCg==

