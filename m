Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B559B54CFFA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 19:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357340AbiFORcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 13:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357724AbiFORcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 13:32:15 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Jun 2022 10:32:11 PDT
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.111.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1C7E24F455
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:32:10 -0700 (PDT)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2049.outbound.protection.outlook.com [104.47.22.49]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-34-Q9-7JXeJNvGGUxgK2OMg-A-2; Wed, 15 Jun 2022 19:31:04 +0200
X-MC-Unique: Q9-7JXeJNvGGUxgK2OMg-A-2
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 ZRAP278MB0303.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2c::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.14; Wed, 15 Jun 2022 17:31:02 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::c52f:2a3f:8cf5:6144]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::c52f:2a3f:8cf5:6144%4]) with mapi id 15.20.5353.014; Wed, 15 Jun 2022
 17:31:02 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "max.oss.09@gmail.com" <max.oss.09@gmail.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>
CC:     "linux-imx@nxp.com" <linux-imx@nxp.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
        "biju.das.jz@bp.renesas.com" <biju.das.jz@bp.renesas.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "khilman@kernel.org" <khilman@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
        "will@kernel.org" <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        "broonie@kernel.org" <broonie@kernel.org>
Subject: Re: [PATCH v1 0/5] power: domain: Add driver for a PM domain provider
 which controls
Thread-Topic: [PATCH v1 0/5] power: domain: Add driver for a PM domain
 provider which controls
Thread-Index: AQHYfBLxjDqdjV5f9kmE6LEx7lVJ7a1Nu9WAgADK8ACAAiYIAIAAEgKAgAAEZgA=
Date:   Wed, 15 Jun 2022 17:31:01 +0000
Message-ID: <ddbeba186bf662348e8594f322f750cf89326a66.camel@toradex.com>
References: <20220609150851.23084-1-max.oss.09@gmail.com>
         <20220613191549.GA4092455-robh@kernel.org>
         <CAMuHMdU+aOw_D3SR6714U_i5WhE8S-FCLdPJaf_+Fncz4aH8VA@mail.gmail.com>
         <CAEHkU3VVM0zUsaKMUGeSzfbLmVJW6rqXGLv7TqaLTEQeXEVkUA@mail.gmail.com>
         <12e3bb72-af2d-653f-b342-c6b4d6a1f292@linaro.org>
In-Reply-To: <12e3bb72-af2d-653f-b342-c6b4d6a1f292@linaro.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f53f238-f9dd-4895-142e-08da4ef4d17b
x-ms-traffictypediagnostic: ZRAP278MB0303:EE_
x-microsoft-antispam-prvs: <ZRAP278MB03036257D1B225AF8FA850A8FBAD9@ZRAP278MB0303.CHEP278.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: CSHSg1YmKLVel/moaEGTPduQCazYos12OdNyDmT+vBJ23jZ7wB7ELYCbh+u4cayt26hnrU/4dDhO9m6U5gl0+jjiwUDIcpJfP1c6UhKNPWdxZuD0Fl6Gc9xea6yZ96wn8tLRZinn38NXutJz9xKtJwhpqxQBhpgOEhXb/kubrR9jLVurH+M+7JdxiReLk7um6TnfwzNC3mhW5lAjcnFJiJmNRPh/ODSTOSapvTek0/Ydwo8WsTXD6vYtaItrN1Dcvv/grUimUMvcMseToc4STVzkNxbYIkwTAfetBb5hNFFdmzvknpF6rymebtJHz3+XKykJCdH/fMvQ4EA/sdCbiEGyqIg/s6yzO8mPSpF80N9M4GlXlNEss4KsSBHGsGDGZu5A9f+sb3x1RClcGvnH1RVRzYsIwl+pFgKuwvyogToApfkZv0ScdZe7xY97u8jAOoJaH/IuC/XwtkTCkaZMjl7MYxrrJl79JreQXxxKU5u6p/tnIqMToO6E7L4SeOaz+0hJ+zhPimHCJM4BmX1ur+cmoQ99BEpd8xtiPHgW0iD6ahWutMZALm2gMkmhoabdTLfXxrxDqkwOrNclgBdvq1ADqWFwy3NpqAeBoV2EAkmyGW7nlBl7SqVslwRjLokamWk2Dx6asdAI5tTasXKDWJp1edpvNtMByPnxLPCTcQk7Gjai625mFqf4zDVzaYnzqOPYIHpTloKB27brKmuQ6Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39850400004)(396003)(366004)(136003)(346002)(26005)(53546011)(4326008)(66946007)(66556008)(66476007)(66446008)(64756008)(6506007)(6512007)(2906002)(2616005)(86362001)(8676002)(38070700005)(91956017)(41300700001)(38100700002)(316002)(110136005)(76116006)(36756003)(54906003)(5660300002)(44832011)(508600001)(83380400001)(186003)(71200400001)(8936002)(7416002)(122000001)(6486002);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YWwwMnNXSkZud0lneUxPeFB0M1VQMXc1MmhhYVFGNlh6aVhtaENWcVg4NnhU?=
 =?utf-8?B?Wm5nTWZFcHd6ZnFNYmUwWXgwQTFBcE1CVlRqQTdWeHJnZjQwZ0pGM2dPdlVp?=
 =?utf-8?B?eDdQWlRkcC9FU0VrY094TllwdkJ2R0xxQlR3RVBJdmhPZnlrNjNQSG55M2Ns?=
 =?utf-8?B?STl0cCs4V1RJS2cwUFFxSzJmTU1tdnZOVEZJZDNHM0gwKzRaTXRvVndMMldv?=
 =?utf-8?B?bjljcFFqM0lRT01aZkx5aUZ4aTVKeHc4VGVGVEU5L1p3bjRLZnhrSTR0eFlT?=
 =?utf-8?B?MVBrRE1ZSHJEWFNGLzJVWlpqNHZKZjd5NUI3SGF6SW1xdzF6c0ZRaEw1d2hP?=
 =?utf-8?B?WmxQRGk4TU5MbUJoMjdiSlo0RDJwUlNka2lCL2p6SFRwdVYrSHhBa3U2T1NG?=
 =?utf-8?B?MHlUa3VMZGtQZW9UYmdiRC9NeWNQbENCd1pZQjY1NHB6RWJMOE9ZalJIeEZT?=
 =?utf-8?B?SmEva2doUVZqc0NDZFRHbEp1eFJ2MnJySlZiS04wRzBUUnBlMlduT2Y0bTN4?=
 =?utf-8?B?ekNDM0U2Vzdpak1wQnBNQ29jZm5yK0paN1YzSEtOOUcyWlJ4OUZxRTJnNEpF?=
 =?utf-8?B?c1JpS2N5cS9HT3hJSHFKY3VSaGIzWWRpZGUxNnFlaUlGS1dQUW1OQ1hPYUJs?=
 =?utf-8?B?QnBtTHdxRjRzRmFiMTBwbU9WdmtIeDRWUm9FZ1JzZ29zbkMyOEN6ZHp3RzJC?=
 =?utf-8?B?cS91bGVLdU9IaDNFSUlmRVJRY0xKVzQwYzNOOUpCWjZFR0hNbE9KMTBtSDI3?=
 =?utf-8?B?ZmFmMldGRG5Sb2RCZkpHUEVhZmNZQ2VtaFE3bkVlaFRrMC9zclpEc2twUU52?=
 =?utf-8?B?ZEhEYXcxVXU1RmVoSjdaNjlkUlJVVzNIamFWSzFnVVF0aHg1Y2hDWndRUVNE?=
 =?utf-8?B?WHNpNHpCNlYzcjkvSThTWTJ2NERpYW42Zkt6TlU1Ryt6T2dTZzcyVGpIUDNT?=
 =?utf-8?B?a3N5RUY0cFo1cG1wRElaZ3FRMjJwRGJVYmVhTC93SEZZOXQ0aXNLR3BzeFlG?=
 =?utf-8?B?eUFCdGRTdU9SVzI5VVdNM3RlU3ROekpDMlc3bS90eXN2emtHNHdocG1MSENs?=
 =?utf-8?B?RTJiOEorNjZ5Q09mTm5oZGppS1NtVUNHdUZQcEZOSGU0Z0RSenhCVC9YVVk2?=
 =?utf-8?B?amphNXJpWU45aCsxUmduYkkrVm1JSGwzb1dNaE1UbUpOc1VpeG9nSTY2NmNl?=
 =?utf-8?B?SFROYnBrWUpjdXErYVVSTi82cGQvazZXMEJzUzdZUFJlRDgzN2tZSm01TzJn?=
 =?utf-8?B?Z1Zndy9jenJzODZMeWVyNGc0TnRwalVhZmpaemR1bWt0T3VoTm5RWG9pai83?=
 =?utf-8?B?ZHdYckRBSUtjNWU5ZDBRcG51VzQva3kwa0I1YU95YUJxR3l5YmNHa25vUkd1?=
 =?utf-8?B?WGQ3c0VMczQ4eTJhUEY4emJ3T1pGUitTNjhCYURhWkZiM2R5Zjc0dk9oUElq?=
 =?utf-8?B?RFZTVklEZXVxb1BUUzlrZk0rSU9aUVlxZTlENEREQktDNWdKa294WW1HdzRz?=
 =?utf-8?B?WlRqNEM2djNZVDVwUlMrWDFHdEFYQnZHSkRuWWIxT3d3eWpKZVdqNXlpK0tL?=
 =?utf-8?B?dStBRENrNVZ0WUJ5SVNCRjhIMEY3b1JxekladExKR2l0THJUbVZqMEF3YnNn?=
 =?utf-8?B?Vk92cVZSLzdXM3dBckNScmN1TjNzTHFpVHVqYzcrZjA4aU5YMUVQYXpGbXZT?=
 =?utf-8?B?ek92VE9YWTZDNVpJZnA4RGF6NDZ4TmtDeWJjTE5ZVFBkMkJBcDZvS0QwMG9u?=
 =?utf-8?B?TzBqaDdYQkRrV2kxL1FTYzY3eUMwci9IdEhsZmt2MEx1WnhXZldiMzB2N2Qx?=
 =?utf-8?B?K2l6MmVQcXNzWkV6bkFLdjNlVStGT1dSWCt0SUVNOUlGdW9GeWpvYU9VdEpJ?=
 =?utf-8?B?eHB0MXpaMmpJaVlvT0ZkQURHN3RuNklTemhnMVZvd29OR3ZWdUNoTkNRVGpz?=
 =?utf-8?B?NEJnL05RRkV2Yng2anliaEs4MkVjN0V3Y2JDZnRxLzV5QWRYOU8xbEM4SFNo?=
 =?utf-8?B?YTIxRnIyNzdzbTl1RUpyWWdqaW84NTVXellVZC9vV1gxT1NWYWJzK0tMRGVL?=
 =?utf-8?B?MTNhTm55cW1mTGpWSWtOUGhZQXBpcElOYmdHL1I5ekpYbkQwYVpab080L1VM?=
 =?utf-8?B?cWZHNFlaUlVmYVI4K3pvOHJtNkw1MHVGcVA4NTdWQnlBSG1KSW5Bc0o2eTRp?=
 =?utf-8?B?RVdqeGFNdC8ycXhWampYQW9KMWxNcGlSRnptcFNWY2tWMkgxL2JQMWduNUdk?=
 =?utf-8?B?SGhkMm81MG1xaFBxK0trQ051MVNOdGFuZi9UeVVkVjBON0Z2bFVIVGlpL0Ex?=
 =?utf-8?B?ZWRoMHFKV0p0QXByaVJoNk1LeDZZL2d5RzdNc1lTanRFb2QxN2xtWVpyVG9Q?=
 =?utf-8?Q?s5lD8EeXVTBClMD7lHoYaq/i9Sw/4yPnVnj5Y?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f53f238-f9dd-4895-142e-08da4ef4d17b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2022 17:31:01.9837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gr2ZZDyRFljqugyi885McS9XOhtHA1k4LjIEw2btbLPu1koP4qDkY8r3+9GezSiFjxtNkqrMd7CuE09VfwWi09ETLNbZBOk3pUK016vqaSo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0303
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CDE13A77 smtp.mailfrom=marcel.ziswiler@toradex.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <FFA0C073F802F548AC368D436243384E@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkNCg0KT24gV2VkLCAyMDIyLTA2LTE1IGF0IDEwOjE1IC0wNzAwLCBLcnp5c3p0b2YgS296bG93
c2tpIHdyb3RlOg0KPiBPbiAxNS8wNi8yMDIyIDA5OjEwLCBNYXggS3J1bW1lbmFjaGVyIHdyb3Rl
Og0KPiA+IEhpDQo+ID4gDQo+ID4gT24gVHVlLCBKdW4gMTQsIDIwMjIgYXQgOToyMiBBTSBHZWVy
dCBVeXR0ZXJob2V2ZW4gPGdlZXJ0QGxpbnV4LW02OGsub3JnPiB3cm90ZToNCj4gPiA+IA0KPiA+
ID4gSGkgUm9iLA0KPiA+ID4gDQo+ID4gPiBPbiBNb24sIEp1biAxMywgMjAyMiBhdCA5OjE1IFBN
IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiA+ID4gPiBPbiBUaHUsIEp1
biAwOSwgMjAyMiBhdCAwNTowODo0NlBNICswMjAwLCBNYXggS3J1bW1lbmFjaGVyIHdyb3RlOg0K
PiA+ID4gPiA+IEZyb206IE1heCBLcnVtbWVuYWNoZXIgPG1heC5rcnVtbWVuYWNoZXJAdG9yYWRl
eC5jb20+DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gaXRzIHBvd2VyIGVuYWJsZSBieSB1c2luZyBh
IHJlZ3VsYXRvci4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBUaGUgY3VycmVudGx5IGltcGxlbWVu
dGVkIFBNIGRvbWFpbiBwcm92aWRlcnMgYXJlIGFsbCBzcGVjaWZpYyB0bw0KPiA+ID4gPiA+IGEg
cGFydGljdWxhciBzeXN0ZW0gb24gY2hpcC4NCj4gPiA+ID4gDQo+ID4gPiA+IFllcywgcG93ZXIg
ZG9tYWlucyB0ZW5kIHRvIGJlIHNwZWNpZmljIHRvIGFuIFNvQy4uLiAncG93ZXItZG9tYWlucycg
aXMNCj4gPiA+ID4gc3VwcG9zZWQgdG8gYmUgcG93ZXIgaXNsYW5kcyBpbiBhIGNoaXAuIExpbnV4
ICdQTSBkb21haW5zJyBjYW4gYmUNCj4gPiA+ID4gYW55dGhpbmcuLi4NCj4gPiANCj4gPiBJIGRv
bid0IHNlZSB3aHkgc3VjaCBwb3dlciBpc2xhbmRzIHNob3VsZCBiZSByZXN0cmljdGVkIHRvIGEg
U29DLiBZb3UgY2FuDQo+ID4gYnVpbGQgdGhlIGV4YWN0IHNhbWUgaWRlYSBvbiBhIFBDQiBvciBl
dmVuIG1vcmUgbW9kdWxhciBkZXNpZ25zLg0KPiANCj4gSW4gdGhlIFNvQyB0aGVzZSBwb3dlciBp
c2xhbmRzIGFyZSBtb3JlLW9yLWxlc3MgZGVmaW5lZC4gVGhlc2UgYXJlIHJlYWwNCj4gcmVnaW9u
cyBnYXRlZCBieSBzb21lIGNvbnRyb2wga25vYi4NCj4gDQo+IENhbGxpbmcgZmV3IGRldmljZXMg
b24gYSBib2FyZCAicG93ZXIgZG9tYWluIiBkb2VzIG5vdCBtYWtlIGl0IGEgcG93ZXINCj4gZG9t
YWluLiBUaGVyZSBpcyBubyBncm91cGluZywgdGhlcmUgaXMgbm8gY29udHJvbCBrbm9iLg0KPiAN
Cj4gQXJlbid0IHlvdSBub3cgcmUtaW1wbGVtZW50aW5nIHJlZ3VsYXRvciBzdXBwbGllcz8gSG93
IGlzIHRoaXMgZGlmZmVyZW50DQo+IHRoYW4gZXhpc3Rpbmcgc3VwcGxpZXM/DQoNCkkgYmVsaWV2
ZSB0aGUgYmlnZ2VzdCBkaWZmZXJlbmNlIGJldHdlZW4gcG93ZXItZG9tYWlucyBhbmQgcmVndWxh
dG9yLXN1cHBsaWVzIGxheXMgaW4gdGhlIGZvcm1lciBiZWluZyBkcml2ZXINCmFnbm9zdGljIHdo
aWxlIHRoZSBsYXRlciBpcyBkcml2ZXIgc3BlY2lmaWMuIE1lYW5pbmcgd2l0aCBwb3dlci1kb21h
aW5zIG9uZSBjYW4ganVzdCBhZGQgc3VjaCBhcmJpdHJhcnkNCnN0cnVjdHVyZSB0byB0aGUgZGV2
aWNlIHRyZWUgd2l0aG91dCBhbnkgZnVydGhlciBkcml2ZXIgc3BlY2lmaWMgY2hhbmdlcy9oYW5k
bGluZyByZXF1aXJlZC4gV2hpbGUgd2l0aA0KcmVndWxhdG9yLXN1cHBsaWVzIGVhY2ggYW5kIGV2
ZXJ5IGRyaXZlciBhY3R1YWxseSBuZWVkcyB0byBoYXZlIGRyaXZlciBzcGVjaWZpYyBoYW5kbGlu
ZyB0aGVyZW9mIGFkZGVkLiBPciBkbyBJDQptaXNzIGFueXRoaW5nPw0KDQpXZSBhcmUgcmVhbGx5
IHRyeWluZyB0byBtb2RlbCBzb21ldGhpbmcgd2hlcmUgYSBzaW5nbGUgR1BJTyBwaW4gKHZpYSBh
IEdQSU8gcmVndWxhdG9yIG9yIHdoYXRldmVyKSBjYW4gY29udHJvbA0KcG93ZXIgdG8gYSB2YXJp
ZXR5IG9mIG9uLWJvYXJkIHBlcmlwaGVyYWxzLiBBbmQsIG9mIGNvdXJzZSwgd2UgZW52aXNpb24g
cnVudGltZSBQTSBhY3R1YWxseSBtYWtpbmcgdXNlIG9mIGl0DQplLmcuIHdoZW4gZG9pbmcgc3Vz
cGVuZC9yZXN1bWUuDQoNCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0KQ2hlZXJzDQoN
Ck1hcmNlbA0K

