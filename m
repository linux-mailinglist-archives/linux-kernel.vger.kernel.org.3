Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93C6E54D0BB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 20:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357890AbiFOSNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 14:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357826AbiFOSNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 14:13:36 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.109.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 06806387A8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 11:13:34 -0700 (PDT)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2049.outbound.protection.outlook.com [104.47.22.49]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-35-54RugKRtMUqBT0HR26PNGg-2; Wed, 15 Jun 2022 20:13:29 +0200
X-MC-Unique: 54RugKRtMUqBT0HR26PNGg-2
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 ZRAP278MB0349.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2f::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.13; Wed, 15 Jun 2022 18:13:26 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::c52f:2a3f:8cf5:6144]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::c52f:2a3f:8cf5:6144%4]) with mapi id 15.20.5353.014; Wed, 15 Jun 2022
 18:13:26 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "max.oss.09@gmail.com" <max.oss.09@gmail.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>
CC:     "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "biju.das.jz@bp.renesas.com" <biju.das.jz@bp.renesas.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "khilman@kernel.org" <khilman@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
        "will@kernel.org" <will@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Max Krummenacher <max.krummenacher@toradex.com>
Subject: Re: [PATCH v1 0/5] power: domain: Add driver for a PM domain provider
 which controls
Thread-Topic: [PATCH v1 0/5] power: domain: Add driver for a PM domain
 provider which controls
Thread-Index: AQHYfBLxjDqdjV5f9kmE6LEx7lVJ7a1Nu9WAgADK8ACAAiYIAIAAEgKAgAAEZgCAAAHjgIAACfYA
Date:   Wed, 15 Jun 2022 18:13:26 +0000
Message-ID: <8decc5b6d1f0bc028d60d444d939da4408e756d3.camel@toradex.com>
References: <20220609150851.23084-1-max.oss.09@gmail.com>
         <20220613191549.GA4092455-robh@kernel.org>
         <CAMuHMdU+aOw_D3SR6714U_i5WhE8S-FCLdPJaf_+Fncz4aH8VA@mail.gmail.com>
         <CAEHkU3VVM0zUsaKMUGeSzfbLmVJW6rqXGLv7TqaLTEQeXEVkUA@mail.gmail.com>
         <12e3bb72-af2d-653f-b342-c6b4d6a1f292@linaro.org>
         <ddbeba186bf662348e8594f322f750cf89326a66.camel@toradex.com>
         <df432e88-8688-c229-5ef0-8ba001b72908@linaro.org>
In-Reply-To: <df432e88-8688-c229-5ef0-8ba001b72908@linaro.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0fe4c51b-13b2-435f-64bb-08da4efabe5d
x-ms-traffictypediagnostic: ZRAP278MB0349:EE_
x-microsoft-antispam-prvs: <ZRAP278MB0349B6A4A154B8D37E3B2364FBAD9@ZRAP278MB0349.CHEP278.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: 3Qd2GqM2w5GAT8giPWcPCAg9ueudlvUjqLeW2EmGHbh/7Fk9xBHWrcMbsD+o9FX09nEPhIwQlabF0Yd5eG0OlpZaLvF4jZ/ZvhiPVIHOg1LC2tOF8YdJqb6DDdqDmxXlXZg5gqMHApH+ouo2uVFUUXYOe7bs/4743Lx9/n51K+fp1nWldKCmI3EB1KShnq3MZ8Ap0vSbl3SSNejjeuyzOUORCs3JcOSPiUfJBBU52n5wn6OlqR6vDozpJrEUTNmnS4E0enTZ1BOxhPoreetQVYDpHLAc/faT0WyW/smjr0gLCuKKoVUWnr9yQ+AfnX4vG/1QsPVSmcYrtqv4XTrSfLjK5B+iYtB5ACTHhnHhuMHNWAHlmhZ4WS42GzxEZgIrVeUhRYyTsAwgDE9eq4TTZxDFLUPzPrK5XxfkuvlzEkIdJvtb6ItIOIii7nvuwtzmxxnSF2w2G+LT6eqTqReyVQWNbA0igirzeiNZW+FLs4FBpFdiGJPvP5HuBhVbxzj7Sp8XrIa+qMLYjnIpnlJ6yVUdQgsWGSgNaya1JabY8L+fAZA4yMsChkmO0au3SyUp/XbwDTtCFPkVt1pO8i4kGLl6ZyWZ7PR2VJzmPoGyswApl8AAmLgR6T+SjfrhcauZVjAGOK6O1eZbTJu3G4Z1+kAUD61UiI0QhpcePrDPEhfXH5q84pvtukY3AgM2FzPAQQWel2ndVmmceYKx9qvL+iJY8+xkbShlYVSWcija3NbnLmEA2PCcZ9RwnnpD5G61hLXS2/HYzVYD4xhA2gPCvhzVmmjZunW3+QWnHE3MNuM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39850400004)(366004)(346002)(396003)(136003)(122000001)(508600001)(44832011)(7416002)(6486002)(8936002)(966005)(5660300002)(6512007)(2616005)(38100700002)(41300700001)(53546011)(6506007)(107886003)(186003)(86362001)(110136005)(66446008)(83380400001)(64756008)(76116006)(36756003)(38070700005)(26005)(2906002)(66476007)(66556008)(66946007)(8676002)(4326008)(71200400001)(54906003)(316002)(91956017);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bktEcFQweTFySlBIdzA5YzlzblZ2NnFKdzRibk10QzNkdzRxdUpkUHhCQUN6?=
 =?utf-8?B?NmRGM0JrZUdYd3M1a0dxcGNxY0FrblB3UjZqUzNFR3JtTzlLSmcwdXpLNW1x?=
 =?utf-8?B?WGdCUm1sSUhJRDN6RHoycGFoakd5dU5icnBwSnJIOEVORkUzRXQ5MGl6VFNq?=
 =?utf-8?B?NEZoVWkveGF6YmF3cjI3b08relA3QjZ6TXRhTlhTbFVHODVQVHJ1ZUs5R2Mv?=
 =?utf-8?B?bGVmREJwSEMwR0ErMkhZRzh2M0JkVW1VeDhncGVwVTNKMTRNVm1wTHlIaEsr?=
 =?utf-8?B?L2hZNXNLYWZxdEJhL0E2M2ZmMG5QdXNGQVJ5alhOcVVpUk9sT2Z3ZTNPNldO?=
 =?utf-8?B?UkQ3dStmS05uSzJvZzRIdEcxUW1EVW1RY2NYbXVNZVFYUFhHemlpK2VKV3Jp?=
 =?utf-8?B?NG5wWnlscTFXWTUvVldlZ1V4Z1RUZ0Q3QWlsbzM2Z1laZ05DVGFxRFZmYzNn?=
 =?utf-8?B?YmtzQ2tXMU5KcThpbURRcFpxcUFJN0RrNm9VamMwTWNFcGgwR3p2RnVLTHli?=
 =?utf-8?B?UHVtd1RVZjZXNmRRV1doTUZNZzVkQW5DdFlTdmdOQWszTmVsUXpSZkxOS3I3?=
 =?utf-8?B?N0NjdnVSMTg3REhmODd0YXdGcVNJaUNwN1p1SkwrN1lDSTAxSUxUWFNac3Qy?=
 =?utf-8?B?NnZpS3I5L2t2Q0RRakxxam1BeW16c0NIeHhqMW9NZi9XenBWZURPNEh0aklR?=
 =?utf-8?B?RTFkekJnTG9xc1YwbXgxSkhocVF2Uk5SVzd6RmtzUlBwbDdlaDM1UzNFbXV2?=
 =?utf-8?B?TXhwbFREWFBGWjI4RDRkSms4TG41bG9EaFZHeEhsYy9uWFlCQUJvUmpaT2ZE?=
 =?utf-8?B?dlJyQ0FZbEFQTkdCZHJxREVGRmFzbVVNNng2VmJLUHhHcHlDN3lmZS9mUkxu?=
 =?utf-8?B?MDhDa2RmSnpQekw0UTVPREh3d2gwM01XQ0pvd1lGeHcxcFJVc01BS2hQUzNB?=
 =?utf-8?B?VGU3QUpRMUpNSmI3enN1ZmlpYkxCNGdLQ1prNnhqMGVOaUI3QjNYK05TSy9T?=
 =?utf-8?B?YTZINmREa3FXaVFDTXhLeHo4OFF1cUJmZkwyODdNek82b0xWYnVGK0o2Mi8x?=
 =?utf-8?B?ZzBpV042elZKTnV5Z3EzN3dMdEd0eVlaUHFEM0hoWFZIT2cvc0dRODZFb3Vo?=
 =?utf-8?B?aklFaWhwNHhnUFMvNzIvdDI5NVBxNk9Rd01RbjdGS3MwWUllZitrVzZYTkNk?=
 =?utf-8?B?MVNOSUxwRmZUT3BNd04xWk5vSENPelczVjZhenZxYlc2L0EvVld0NHdSYStQ?=
 =?utf-8?B?SFVUT3lTTHdZN1FZYldRcE1nMGYycTdsUE04MXgrNmY4djRmN2Zqek1RT2RL?=
 =?utf-8?B?OWgwazA4Wlc1UDNGcFZWVzRzY2VoYmpUY0pZS3Q1aFZDekFQR0tzcnQ0dHBB?=
 =?utf-8?B?bGo1b1lsUVdTUkI3N2pEWEFOWU00Y3R1dHNKMjNYbmlHd2xYZ1ZZQjRHR1pa?=
 =?utf-8?B?UnhIbWtuajJWbkkxQThNRXRSUkxzRjdVZnYxME9sRWNwdEM0S3pWZ3h5MS9J?=
 =?utf-8?B?Ym5VMFRITys3aVlyZzJZUkNlTEROR1dOWjJJMjA2VzVUclY5ZnpNUFJnbU5X?=
 =?utf-8?B?RWRiTVp6TDFSMjQwSHNKaHVHa1prSlM1VGlSUjNlS2JkcG45ZmNmRmxMV0tR?=
 =?utf-8?B?cW80ZkMxd2F1cTJGRzRDWE05MStqWEUzMmI2em9DMWhYMnEwMnZZdGhIQnpL?=
 =?utf-8?B?U3VmelJFM2ZGN3oxUEd4ZmNRcVlVQktBSWVUNDdGVHpySHlyaE5sY3p3a2Iy?=
 =?utf-8?B?T2JIdDRPU0tucDhydUNCaTc1TlNmNXV1LyszSmg2a3NYYUNhY0x5Nm16ZkNw?=
 =?utf-8?B?bi8xRWxwMWlFV1AwbE5WY1k0T01ZMWNZc1E0K0s3VW5NWkNQbWw1K05TelRi?=
 =?utf-8?B?emRFN3pzMG5PL3FIaXJnMElZV3MyNzAva0JRVUlLMGtla3ZTSVJNeHpYaHBq?=
 =?utf-8?B?VHM0YkUzM281eEFtS2xML1Zpb1FGd1NOcTc1YTN4OWlqanhaUWFKYVpEN21s?=
 =?utf-8?B?U2h4amRsU0pxWVJCanNacklBS1MrOW5PRTlDSG5raVNzWVVWQ2dxOHpNQkYv?=
 =?utf-8?B?VUNvemdpeGoreXo5L0lCWlhFQ2V2UExrek1zeEJVdklTQW1ENnB2TjY4ZSsv?=
 =?utf-8?B?K00rS2Z2TzB2L3E2RVN3a3RmT1NmeXUxQzNobzZGUG9jUUszMTY3S3QxV2FR?=
 =?utf-8?B?b25kUUdnSjVmYzhqSFpmU0psWFplWDhhbU9UVDh1a2R0MEI0M0w1RnRhZUV4?=
 =?utf-8?B?eDQ2SUlCYnNNWDcrNGIwVzVTUXdkTWlWZENnWmMvK0ZOS24yTUptSHFyOUY1?=
 =?utf-8?B?ZmJIRDNlVVVyQk9Hc2JvdDl1V3JnNDRwbU5qb2M2WnlXbjNRUFZRL0o1VFR3?=
 =?utf-8?Q?hv5uyzwdZYw58R8cLPrm9IUyFTkYzF8Hi4E6L?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe4c51b-13b2-435f-64bb-08da4efabe5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2022 18:13:26.8616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RCAK07k/1Bu1UuKHWUTHhY1/0xsbLhjT3WZUeoAIkG7ll27doyPs7McUbI1HduSkMNptiU/DvfQRT4Z7ghMt29c9l3TrWHDyltSEHqgcJ8g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0349
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CDE13A77 smtp.mailfrom=marcel.ziswiler@toradex.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <11E9456D0D323C40B60708B0DA16A0D2@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIyLTA2LTE1IGF0IDEwOjM3IC0wNzAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBPbiAxNS8wNi8yMDIyIDEwOjMxLCBNYXJjZWwgWmlzd2lsZXIgd3JvdGU6DQo+ID4g
SGkNCj4gPiANCj4gPiBPbiBXZWQsIDIwMjItMDYtMTUgYXQgMTA6MTUgLTA3MDAsIEtyenlzenRv
ZiBLb3psb3dza2kgd3JvdGU6DQo+ID4gPiBPbiAxNS8wNi8yMDIyIDA5OjEwLCBNYXggS3J1bW1l
bmFjaGVyIHdyb3RlOg0KPiA+ID4gPiBIaQ0KPiA+ID4gPiANCj4gPiA+ID4gT24gVHVlLCBKdW4g
MTQsIDIwMjIgYXQgOToyMiBBTSBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0QGxpbnV4LW02OGsu
b3JnPiB3cm90ZToNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBIaSBSb2IsDQo+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gT24gTW9uLCBKdW4gMTMsIDIwMjIgYXQgOToxNSBQTSBSb2IgSGVycmluZyA8cm9i
aEBrZXJuZWwub3JnPiB3cm90ZToNCj4gPiA+ID4gPiA+IE9uIFRodSwgSnVuIDA5LCAyMDIyIGF0
IDA1OjA4OjQ2UE0gKzAyMDAsIE1heCBLcnVtbWVuYWNoZXIgd3JvdGU6DQo+ID4gPiA+ID4gPiA+
IEZyb206IE1heCBLcnVtbWVuYWNoZXIgPG1heC5rcnVtbWVuYWNoZXJAdG9yYWRleC5jb20+DQo+
ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBpdHMgcG93ZXIgZW5hYmxlIGJ5IHVzaW5nIGEg
cmVndWxhdG9yLg0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gVGhlIGN1cnJlbnRseSBp
bXBsZW1lbnRlZCBQTSBkb21haW4gcHJvdmlkZXJzIGFyZSBhbGwgc3BlY2lmaWMgdG8NCj4gPiA+
ID4gPiA+ID4gYSBwYXJ0aWN1bGFyIHN5c3RlbSBvbiBjaGlwLg0KPiA+ID4gPiA+ID4gDQo+ID4g
PiA+ID4gPiBZZXMsIHBvd2VyIGRvbWFpbnMgdGVuZCB0byBiZSBzcGVjaWZpYyB0byBhbiBTb0Mu
Li4gJ3Bvd2VyLWRvbWFpbnMnIGlzDQo+ID4gPiA+ID4gPiBzdXBwb3NlZCB0byBiZSBwb3dlciBp
c2xhbmRzIGluIGEgY2hpcC4gTGludXggJ1BNIGRvbWFpbnMnIGNhbiBiZQ0KPiA+ID4gPiA+ID4g
YW55dGhpbmcuLi4NCj4gPiA+ID4gDQo+ID4gPiA+IEkgZG9uJ3Qgc2VlIHdoeSBzdWNoIHBvd2Vy
IGlzbGFuZHMgc2hvdWxkIGJlIHJlc3RyaWN0ZWQgdG8gYSBTb0MuIFlvdSBjYW4NCj4gPiA+ID4g
YnVpbGQgdGhlIGV4YWN0IHNhbWUgaWRlYSBvbiBhIFBDQiBvciBldmVuIG1vcmUgbW9kdWxhciBk
ZXNpZ25zLg0KPiA+ID4gDQo+ID4gPiBJbiB0aGUgU29DIHRoZXNlIHBvd2VyIGlzbGFuZHMgYXJl
IG1vcmUtb3ItbGVzcyBkZWZpbmVkLiBUaGVzZSBhcmUgcmVhbA0KPiA+ID4gcmVnaW9ucyBnYXRl
ZCBieSBzb21lIGNvbnRyb2wga25vYi4NCj4gPiA+IA0KPiA+ID4gQ2FsbGluZyBmZXcgZGV2aWNl
cyBvbiBhIGJvYXJkICJwb3dlciBkb21haW4iIGRvZXMgbm90IG1ha2UgaXQgYSBwb3dlcg0KPiA+
ID4gZG9tYWluLiBUaGVyZSBpcyBubyBncm91cGluZywgdGhlcmUgaXMgbm8gY29udHJvbCBrbm9i
Lg0KPiA+ID4gDQo+ID4gPiBBcmVuJ3QgeW91IG5vdyByZS1pbXBsZW1lbnRpbmcgcmVndWxhdG9y
IHN1cHBsaWVzPyBIb3cgaXMgdGhpcyBkaWZmZXJlbnQNCj4gPiA+IHRoYW4gZXhpc3Rpbmcgc3Vw
cGxpZXM/DQo+ID4gDQo+ID4gSSBiZWxpZXZlIHRoZSBiaWdnZXN0IGRpZmZlcmVuY2UgYmV0d2Vl
biBwb3dlci1kb21haW5zIGFuZCByZWd1bGF0b3Itc3VwcGxpZXMgbGF5cyBpbiB0aGUgZm9ybWVy
IGJlaW5nDQo+ID4gZHJpdmVyDQo+ID4gYWdub3N0aWMgd2hpbGUgdGhlIGxhdGVyIGlzIGRyaXZl
ciBzcGVjaWZpYy4gDQo+IA0KPiBUaGF0J3Mgb25lIHdheSB0byBsb29rLCBidXQgdGhlIG90aGVy
IHdheSAobWF0Y2hpbmcgdGhlIGJpbmRpbmdzDQo+IHB1cnBvc2UpIGlzIHRvIGxvb2sgYXQgaGFy
ZHdhcmUuIFlvdSBoYXZlIHBoeXNpY2FsIHdpcmUgLyB2b2x0YWdlIHJhaWwNCj4gc3VwcGx5IC0g
dXNlIHJlZ3VsYXRvciBzdXBwbHkuIEluIHRoZSB0ZXJtcyBvZiB0aGUgaGFyZHdhcmUgLSB3aGF0
IGlzDQo+IHRoYXQgcG93ZXIgZG9tYWluPyBJdCdzIGEgY29uY2VwdCwgbm90IGEgcGh5c2ljYWwg
b2JqZWN0Lg0KDQpXZWxsLCBidXQgaG93IGNhbiB0aGF0IGNvbmNlcHQgdGhlbiBleGlzdCB3aXRo
aW4gdGhlIFNvQyBidXQgbm90IG91dHNpZGU/IEkgZG9uJ3QgZ2V0IGl0LiBJc24ndCBpdCBqdXN0
IHRoZQ0KZXhhY3Qgc2FtZSBwaHlzaWNhbCBwb3dlciBnYXRpbmcgdGhpbmd5IHdoZXRoZXIgaW5z
aWRlIHRoZSBTb0Mgb3Igb24gYSBQQ0I/DQoNCj4gPiBNZWFuaW5nIHdpdGggcG93ZXItZG9tYWlu
cyBvbmUgY2FuIGp1c3QgYWRkIHN1Y2ggYXJiaXRyYXJ5DQo+ID4gc3RydWN0dXJlIHRvIHRoZSBk
ZXZpY2UgdHJlZSB3aXRob3V0IGFueSBmdXJ0aGVyIGRyaXZlciBzcGVjaWZpYyBjaGFuZ2VzL2hh
bmRsaW5nIHJlcXVpcmVkLiBXaGlsZSB3aXRoDQo+ID4gcmVndWxhdG9yLXN1cHBsaWVzIGVhY2gg
YW5kIGV2ZXJ5IGRyaXZlciBhY3R1YWxseSBuZWVkcyB0byBoYXZlIGRyaXZlciBzcGVjaWZpYyBo
YW5kbGluZyB0aGVyZW9mIGFkZGVkLiBPcg0KPiA+IGRvIEkNCj4gPiBtaXNzIGFueXRoaW5nPw0K
PiANCj4gVGhhbmtzIGZvciBjbGFyaWZpY2F0aW9uIGJ1dCBJIGFtIG5vdCBzdXJlIGlmIGl0IG1h
dGNoZXMgdGhlIHB1cnBvc2Ugb2YNCj4gYmluZGluZ3MgYW5kIERUUy4gWW91IGNhbiBjaGFuZ2Ug
dGhlIGltcGxlbWVudGF0aW9uIGFzIHdlbGwgdG8gaGF2ZQ0KPiBpbXBsaWNpdCByZWd1bGF0b3Jz
LiBObyBuZWVkIGZvciBuZXcgYmluZGluZ3MgZm9yIHRoYXQuDQoNCk9rYXksIG1heWJlIHRoYXQg
d291bGQgYWxzbyB3b3JrLCBvZiBjb3Vyc2UuIFNvIGJhc2ljYWxseSBhZGQgYSBuZXcgYmluZGlu
ZyB3aGljaCBhbGxvd3MgYWRkaW5nIHJlZ3VsYXRvcnMgdG8NCmFyYml0cmFyeSBub2RlcyB3aGlj
aCB0aGVuIHdpbGwgYmUgZ2VuZXJpY2FsbHkgaGFuZGxlZCBieSBlLmcuIHJ1bnRpbWUgUE0uIEFs
bW9zdCBzb21ldGhpbmcgbGlrZSBhc3NpZ25lZC0NCmNsb2NrcyBbMV0geW91IG1lYW4/IEkgZ3Vl
c3MgdGhhdCBjb3VsZCB3b3JrLiBSZW1lbWJlciB0aGF0J3Mgd2h5IE1heCBwb3N0ZWQgaXQgYXMg
YW4gUkZDIHRvIGdldCBzdWNoIGZlZWRiYWNrLg0KVGhhbmtzIGZvciBmdXJ0aGVyIHJlZmluaW5n
IHRob3NlIGlkZWFzLg0KDQo+ID4gV2UgYXJlIHJlYWxseSB0cnlpbmcgdG8gbW9kZWwgc29tZXRo
aW5nIHdoZXJlIGEgc2luZ2xlIEdQSU8gcGluICh2aWEgYSBHUElPIHJlZ3VsYXRvciBvciB3aGF0
ZXZlcikgY2FuDQo+ID4gY29udHJvbA0KPiA+IHBvd2VyIHRvIGEgdmFyaWV0eSBvZiBvbi1ib2Fy
ZCBwZXJpcGhlcmFscy4gQW5kLCBvZiBjb3Vyc2UsIHdlIGVudmlzaW9uIHJ1bnRpbWUgUE0gYWN0
dWFsbHkgbWFraW5nIHVzZSBvZg0KPiA+IGl0DQo+ID4gZS5nLiB3aGVuIGRvaW5nIHN1c3BlbmQv
cmVzdW1lLg0KPiANCj4gQW5kIHRoaXMgR1BJTyBwaW4gY29udHJvbHMgd2hhdD8gU29tZSBwb3dl
ciBzd2l0Y2ggd2hpY2ggY3V0cyB0aGUgcG93ZXINCj4gb2Ygb25lIHJlZ3VsYXRvciBvciBtYW55
Pw0KDQpXZWxsLCB0aGF0IGRvZXNuJ3QgcmVhbGx5IG1hdHRlci4gUmVzcC4gdGhpcyBwYXJ0IG9u
ZSBzaG91bGQgYmUgYWJsZSB0byBzdWZmaWNpZW50bHkgbW9kZWwgdXNpbmcgd2hhdGV2ZXINCmF2
YWlsYWJsZSByZWd1bGF0b3IgbG9yZSB3ZSBhbHJlYWR5IGhhdmUgKGUuZy4gd2hhdGV2ZXIgZGVs
YXlzL3RpbWVzKS4NCg0KPiBJZiBtYW55IGRpZmZlcmVudCByZWd1bGF0b3JzLCBob3cgZG8geW91
DQo+IGhhbmRsZSBzbWFsbCBkaWZmZXJlbmNlcyBpbiByYW1wIHVwIHRpbWU/DQoNCldlbGwsIEkg
ZG9uJ3QgdGhpbmsgdGhpcyBpcyBhbnkgZGlmZmVyZW50IHRvIGFueSBvdGhlciByZWd1bGF0b3Io
cyksIG5vdD8gVGhlbSBIVyBmb2xrcyB3aWxsIGp1c3QgbmVlZCB0byB0ZWxsDQp1cyBzb21lIHJl
YXNvbmFibGUgbnVtYmVycyBmb3IgdGhvc2UgZGVsYXlzL3RpbWVzLg0KDQo+IEJlc3QgcmVnYXJk
cywNCj4gS3J6eXN6dG9mDQoNClsxXSBodHRwczovL2dpdGh1Yi5jb20vZGV2aWNldHJlZS1vcmcv
ZHQtc2NoZW1hL2Jsb2IvbWFpbi9kdHNjaGVtYS9zY2hlbWFzL2Nsb2NrL2Nsb2NrLnlhbWwjTDIy
DQoNCkNoZWVycw0KDQpNYXJjZWwNCg==

