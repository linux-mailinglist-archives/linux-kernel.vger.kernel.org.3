Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1BB57058A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 16:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbiGKO1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 10:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiGKO1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 10:27:11 -0400
X-Greylist: delayed 4606 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 11 Jul 2022 07:27:09 PDT
Received: from us-smtp-delivery-162.mimecast.com (us-smtp-delivery-162.mimecast.com [170.10.133.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003BB3E777
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 07:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hp.com; s=mimecast20180716;
        t=1657549629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l00WYzrxueOSn80ezFgetvbsSJDtBH7pSt+m1Dv/c1E=;
        b=RxoYFkpCM/aInMJO2TGJbMglSn45oS0+e4lEyfv1rooHM/q+UwM02JhwBwZnbscASCv1Pn
        /0e7daIfyUBop4WgB169ukMyzRqiNX9LscxmtDafueAz/F2TJTaPaGLNz7M5UhzpspE+u9
        Sxmkh2WqXd9W9HjvmciiA7RLRt+SbZM=
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-444-jj_uhwd8NOu8DeUJoKaUgg-1; Mon, 11 Jul 2022 10:27:02 -0400
X-MC-Unique: jj_uhwd8NOu8DeUJoKaUgg-1
Received: from PH0PR84MB1953.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:160::10)
 by PH0PR84MB1670.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:172::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Mon, 11 Jul
 2022 14:26:59 +0000
Received: from PH0PR84MB1953.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::880d:1bb8:7f9e:19cc]) by PH0PR84MB1953.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::880d:1bb8:7f9e:19cc%7]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 14:26:59 +0000
From:   "Lopez, Jorge A (Security)" <jorge.lopez2@hp.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Alex Dewar <alex.dewar@gmx.co.uk>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "tiwai@suse.de" <tiwai@suse.de>,
        "markgross@kernel.org" <markgross@kernel.org>
CC:     "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Subject: RE: input/i8042: Malfunctioning brightness keys on HP Elite Dragonfly
 G2
Thread-Topic: input/i8042: Malfunctioning brightness keys on HP Elite
 Dragonfly G2
Thread-Index: AQHYlR8s56cSTJIX+UqJ5MPQFYzlza15IwvQgAAVZnA=
Date:   Mon, 11 Jul 2022 14:26:59 +0000
Message-ID: <PH0PR84MB19536D04A5625D4DC8B76AF1A8879@PH0PR84MB1953.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220629094314.b7xmfb3xccj7vs6v@ic-alex-elitebook>
 <3fedf676645bfa638c9a6c656121083abc2c98ea.camel@gmx.co.uk>
 <8b893c42-e514-bcef-0513-070b3723cdcc@redhat.com>
 <df7313597d2ac3212f10c05aa3d369728f030c86.camel@gmx.co.uk>
 <c89d39eb-17b9-8800-c8ff-8d236b80de2f@redhat.com>
 <PH0PR84MB195309F5BA5B96858024E61FA8879@PH0PR84MB1953.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <PH0PR84MB195309F5BA5B96858024E61FA8879@PH0PR84MB1953.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-bromium-msgid: 0d33843c-16e8-4684-99db-70c22d04cfab
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af508544-f1b8-4e24-4cad-08da63496a85
x-ms-traffictypediagnostic: PH0PR84MB1670:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: V093BXAj5EmCwps71HliXwux/HYgaQl1r/4x8e89ms4ko1dJuJ5169/PO1naE+eLBxLAKIRAsxXvWUKESuc9eF4fpJ64E0E+c6RHxtrqrpItoAmOSKlUnvNoxf+sAHSrgiL0YN6gPT4hKYNhPFVxPtwOx4DjqjcjQPjR7Y7e2MNO8xkOrMBn4QG33cSsq4bgnjX3X9e9Oe/b2CSR2XNYzYvdk/OjjRdXYAcB7i/9SgPE8akjUtnHQIl+s8JoD1dAmtKlovbqylRUbT/C+WH4yDgD3y4n2aRtoyV86Q8TIEV+AFQvA3cK9fO4oF83yKK9bqo+PSUm7AjDmpn155uzodO6u4SI6mZ8ONFNBmCtoOjKbz2Wtr0ePRYmAWwwilrXgVI5WJEXr9gqjFRzM6ON/OOqfKqBZEgJxe4RoVtMk1CXgwY0kQX7apYMrjaCc8SskSyEeSbIpAFpcS1OYziT5HTycCbiqydOVOlkh2ULwfU38LUxjkq+ib4Xzgx1wBN66ajRm7hpJJmpRGnrEh1ye16c4SMN5mdP/z1uHlljNIhMGjB65Q0riGkqHn66w3fz4ZBriIb/F3GRJEdH8BHuU72ej4BSgsj8mgzMlDSPTpy5S9Hc9Z0eDs5UkfxMQAWAFJhzB64p2HX4ZO7w9sBu+Cz5aZGfYkuansS1dnFyJhLNo8686xTlKsVy1IpIjj/EC/57cwG89UmugewGmqyjdRmoXJ9omgiEvKWmxrWvLeH5jR9mkUhbpzXBLBM0z5R/vGehGr9tZUcWRvhvlIVrzkCO5fB5m8eKFTwisZuefbTTBl6gywzR6PIQyB1CXKe6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR84MB1953.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(39860400002)(396003)(376002)(366004)(84040400005)(2906002)(7696005)(6506007)(52536014)(53546011)(316002)(55016003)(5660300002)(54906003)(38070700005)(478600001)(2940100002)(41300700001)(26005)(110136005)(33656002)(9686003)(71200400001)(64756008)(76116006)(66556008)(4326008)(83380400001)(66946007)(66446008)(8676002)(66476007)(86362001)(82960400001)(8936002)(38100700002)(186003)(122000001);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bklmZ09sbk9zQ2RxZlJYVkdDaEgxR2tLR0JJMC9GUXBaV1JDVld6ZEs3WENP?=
 =?utf-8?B?L1U5c0xtTWNjNEdQOTN3bnZtb3psV3hJR1dVanFQaFJBdlFEWnFTWTFRWHpw?=
 =?utf-8?B?Mk12RGdmNFBtUmZzUkVpRmN1SVlZR2RiQWdsWHFYSHRhbktjankrZkZiSHlE?=
 =?utf-8?B?NXZmazZ6dUJqWmFURisyUTBGTi9xcTdPWU5VeU1mRmJqeXZ0RXA0UHNtVXg4?=
 =?utf-8?B?RGtBQi8rMEhEY2xNMU1GVDFXVzBrZHk3V3N1S0JOYVNmanV4aUQ3aE5Icy9O?=
 =?utf-8?B?bVNoZFc2UVVYQktzZWZkTm1YWDJ1a1I5QW93RmhaRS8zL3BFWmorT3NBa3lU?=
 =?utf-8?B?N2w2UjZ3RFA2WFg5dWZVcXJYcEt2UCt4R2gvMDhvTG5GQXRYNisySVQxMCtj?=
 =?utf-8?B?WWFIZjZGTXB3SFArdHdyRWJqMHV1TTIrRVZXSzBSbFVtUXhwQU1UcFR1cXBy?=
 =?utf-8?B?R0J1TFcyaVZZZzdtZVl2M05SMzFraXgxMU5uWTdoeHhrdTM1WG5RTmFpM1hV?=
 =?utf-8?B?MUNKaUJ3aUI5d3BQSERGNmlUTk13Y3g2M3hqQ1c1TStjbVVCTGcxRW5zMU90?=
 =?utf-8?B?VFI2UWhrazRPZEZkV210RWY3OXdJb3lndWpySUpXcUJwRktQeEZIMXh3Wnlr?=
 =?utf-8?B?T2pPSVNiOGdUbGlWN3I3bFpXTzlCOCtadjhHTUJWVGlpbXQ3dmt5Y01xZERx?=
 =?utf-8?B?bm5PaVF0VW16Y00wdzFoRTYyTTM4aytwNTBqYzluYUhRaWN1ZUhwUnVISkRl?=
 =?utf-8?B?bHBHTm5pemtrYjltR2N0ZGRGeis3KzdMdEFvSkM2NGg1VFR2MGx0a0VHT0xF?=
 =?utf-8?B?aTdBL0o4RnZaeUd6WFBMazVtQVlhdGczbmdzeFJIb1dzYjl0SE4wWHg3SVdX?=
 =?utf-8?B?d2pmRWlkaHp0L2J3YzRjOXlheENkMERaRTVuME0xMTRvVnY5RXNmblJ3QTdE?=
 =?utf-8?B?Y2xaKzdSazFnZ2RDMEVJenZvMXFWMGtZZWFUQU9OL3dzMldFNFIxR0pwNE55?=
 =?utf-8?B?aVgremlsM0NPdEpNaUhFMU5GK29ua2c1NzRZMEgxbHhxZzRQdjR2Ri9WdjlG?=
 =?utf-8?B?d3ZVOWxXR1NrNWpuSmh6SkFlVm1sdThZcGVTK2p6YkltWVJFOHNBMHB3ajZH?=
 =?utf-8?B?MTBBVkNZV3ZBbjZWNGRSQW9ySDk2WkhkSkkwYnU3bS91TkRNYktZaFRZdW90?=
 =?utf-8?B?Mkh2dnFLTEpiU2wvMm9tOHBId3FMeS91S2xsam1paHJWZlVVTkdJa2xkTWoz?=
 =?utf-8?B?NzFzdTI2T0Z6Yko5OHpLdnJCQXpuTG9BUmlBVi9iWmlSTGVQbFdvM2ErcFNF?=
 =?utf-8?B?aVZEaGtuM09Rc1U1dFJZa2duLzRJVVZ0dlp4UUZtemtNS0p5Y1gveGNsMHEv?=
 =?utf-8?B?dS9KSHNQRXd2Z0ZaVEJReWxIQmM3TGQ0WVF4djF0amMwYmQ4U25QSHA1L2ww?=
 =?utf-8?B?bHc2OEdBUDNkMzQwTzZzK3p5WUZ1cUZFaU0wTXFELzJuUWFNbHQwWWU0MTZk?=
 =?utf-8?B?WHBFdlZKRmR5a2kwT1NlalFqQ0QvRyt6L2QxVWoybXJMUUhuLzRFc21LejY0?=
 =?utf-8?B?RXhxS1RTWDBrRUp0cGlMUWlSVndOait3VkJaTEdnTEUrYzVPcHppRHhsTCt3?=
 =?utf-8?B?V1YzVFZnbm1jWTZjSGtXM0tDVlFsTUIvYmxtUTlLQmZyQzRjTnRHUUdKaExL?=
 =?utf-8?B?a0loNnJUT0p4bTh5K0hvNnRieFhtRlZnVUo5RWduYjVJRDNhcGlpYXhaVy81?=
 =?utf-8?B?UzhHWUdYQlhwSjJROEovMjZkc21RUWxyN3V2Vldta3B5bzdWQ2svRERySkpN?=
 =?utf-8?B?M0ZMT0YrNzNxL3hTMlVXcHMwVU9XMi9IR3ZZZjFVKzBzdVR5RER6T3VDSTdT?=
 =?utf-8?B?R25hTXgrZVgzemVqWVZ6bVlVcUx3bFEvbVpISmZPQXMrYnRwaXZZVDdQOTlq?=
 =?utf-8?B?Nk1xR0doUm9lSWpOVlkvdVdldmh4OUcrZmxXNEQwc3g0MEVCdDg3d2lKWnpN?=
 =?utf-8?B?emdaWk9pN0xlTTZDQm12STQzR3ljMVV3U2RYNDgvZVpFNWorUG1qNlhLYk9C?=
 =?utf-8?B?QXVGbjk4Q2FsVVhvbHJuaXo3MWFGUm1HdDhsUUd6RWNtVWZ2cE9ObUFkVGdV?=
 =?utf-8?Q?RgTK8es4JZmgIBFjL7ydRzpZv?=
MIME-Version: 1.0
X-OriginatorOrg: hp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR84MB1953.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: af508544-f1b8-4e24-4cad-08da63496a85
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2022 14:26:59.6760
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ca7981a2-785a-463d-b82a-3db87dfc3ce6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: imXKq3zL+3W35GXEkeEoPs3dxxyOELkSRMfpSes3h7CLkFDv4Rwlqk/pCIGsjla1Etnt8+f2+zFejw1DihxMpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR84MB1670
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA62A171 smtp.mailfrom=jorge.lopez2@hp.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: hp.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWxleCwNCg0KSSBjb25maXJtZWQgYnJpZ2h0bmVzcyB1cC9kb3duIGFuZCBtdXRlIGFyZSBB
VCB0cmFuc2xhdGVkIHNldCBvZiBrZXlzIGFuZCBub3QgaGFuZGxlZCBieSBIUC1XTUkgZHJpdmVy
Lg0KQklPUyBzaG91bGQgYmUgc2VuZGluZyBhbiAweDQgZXZlbnQgd2hpY2gga2V5Y29kZSAyMjQg
KGJyaWdodG5lc3MgdXApLCAyMjUgKGJyaWdodG5lc3MgZG93biksIGFuZCAxOTAgKG1pY3JvcGhv
bmUpLg0KSW5zdGVhZCwgQklPUyBpcyBzZW5kaW5nIGtleWNvZGUgMTkwIGZvciBhbGwgdGhyZWUg
a2V5cy4NCg0KSSB3aWxsIHNlYXJjaCBmb3IgYW4gRWxpdGUgRHJhZ29uZmx5IEcyIHVuaXQgYW5k
IHRyeSB0byBkdXBsaWNhdGUgdGhlIHByb2JsZW0uICBQbGVhc2Ugc2VuZCB0aGUgQklPUyB2ZXJz
aW9uIHlvdXIgc3lzdGVtIGlzIHJ1bm5pbmcgb24uDQpUaGlzIHByb2JsZW0gY291bGQgaGF2ZSBi
ZWVuIHJlcG9ydGVkIGFuZCBmaXhlZCBpbiB0aGUgbGF0ZXN0IEJJT1MgdmVyc2lvbi4NCg0KTG9v
ayBmb3J3YXJkIHRvIGhlYXJpbmcgYmFjayBmcm9tIHlvdS4NCg0KDQpSZWdhcmRzLA0KDQpKb3Jn
ZSBMb3Bleg0KSGV3bGV0dC1QYWNrYXJkIA0KDQrigJxPbmNlIHlvdSBzdG9wIGxlYXJuaW5nLCB5
b3Ugc3RhcnQgZHlpbmfigJ0NCkFsYmVydCBFaW5zdGVpbg0KDQotLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KRnJvbTogTG9wZXosIEpvcmdlIEEgKFNlY3VyaXR5KSANClNlbnQ6IE1vbmRheSwg
SnVseSAxMSwgMjAyMiA4OjEwIEFNDQpUbzogJ0hhbnMgZGUgR29lZGUnIDxoZGVnb2VkZUByZWRo
YXQuY29tPjsgQWxleCBEZXdhciA8YWxleC5kZXdhckBnbXguY28udWs+OyBkbWl0cnkudG9yb2to
b3ZAZ21haWwuY29tOyB0aXdhaUBzdXNlLmRlOyBtYXJrZ3Jvc3NAa2VybmVsLm9yZw0KQ2M6IGxp
bnV4LWlucHV0QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsg
cGxhdGZvcm0tZHJpdmVyLXg4NkB2Z2VyLmtlcm5lbC5vcmcNClN1YmplY3Q6IFJFOiBpbnB1dC9p
ODA0MjogTWFsZnVuY3Rpb25pbmcgYnJpZ2h0bmVzcyBrZXlzIG9uIEhQIEVsaXRlIERyYWdvbmZs
eSBHMg0KDQpIaSBBbGV4LA0KDQpMZXQgbWUgaW52ZXN0aWdhdGUgdGhpcyBpc3N1ZS4gIFRoZSBk
cml2ZXIgbWFwcyBzb21lIGtleXMsIHNvIGl0IGlzIHBvc3NpYmxlIHRoZSBsaXN0IGlzIGluY29t
cGxldGUuICANCkl0IGlzIGV4cGVjdGVkIGhwX3dtaSBkcml2ZXIgdG8gYmUgbG9hZGVkLCBDb3Jy
ZWN0Pw0KQ2FuIHlvdSBwcm92aWRlIHRoZSBCSU9TIHZlcnNpb24gY3VycmVudCBpbiB5b3VyIHN5
c3RlbT8NCg0KDQpSZWdhcmRzLA0KDQpKb3JnZSBMb3Bleg0KSGV3bGV0dC1QYWNrYXJkIA0KDQri
gJxPbmNlIHlvdSBzdG9wIGxlYXJuaW5nLCB5b3Ugc3RhcnQgZHlpbmfigJ0NCkFsYmVydCBFaW5z
dGVpbg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogSGFucyBkZSBHb2VkZSA8
aGRlZ29lZGVAcmVkaGF0LmNvbT4NClNlbnQ6IE1vbmRheSwgSnVseSAxMSwgMjAyMiA3OjEwIEFN
DQpUbzogQWxleCBEZXdhciA8YWxleC5kZXdhckBnbXguY28udWs+OyBkbWl0cnkudG9yb2tob3ZA
Z21haWwuY29tOyB0aXdhaUBzdXNlLmRlOyBtYXJrZ3Jvc3NAa2VybmVsLm9yZzsgTG9wZXosIEpv
cmdlIEEgKFNlY3VyaXR5KSA8am9yZ2UubG9wZXoyQGhwLmNvbT4NCkNjOiBsaW51eC1pbnB1dEB2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IHBsYXRmb3JtLWRy
aXZlci14ODZAdmdlci5rZXJuZWwub3JnDQpTdWJqZWN0OiBSZTogaW5wdXQvaTgwNDI6IE1hbGZ1
bmN0aW9uaW5nIGJyaWdodG5lc3Mga2V5cyBvbiBIUCBFbGl0ZSBEcmFnb25mbHkgRzINCg0KSGkg
QWxleCwNCg0KT24gNy8xMS8yMiAwOTo0OSwgQWxleCBEZXdhciB3cm90ZToNCj4gSGkgSGFucywN
Cj4gDQo+IE9uIFNhdCwgMjAyMi0wNy0wOSBhdCAxNjo1NiArMDIwMCwgSGFucyBkZSBHb2VkZSB3
cm90ZToNCj4+IEhpLA0KPj4NCj4+IE9uIDcvNS8yMiAxOToyNSwgQWxleCBEZXdhciB3cm90ZToN
Cj4+PiBGcmllbmRseSBwaW5nPyDwn5mCDQo+Pj4NCj4+PiBJJ20gYWxzbyBDQydpbmcgdGhlIHg4
NiBwbGF0Zm9ybSBwZW9wbGUgaW50byB0aGlzLCBhcyBJJ20gbm90IHN1cmUgDQo+Pj4gd2hldGhl
ciB0aGlzIHByb2JsZW0gaXMgc29tZXRoaW5nIG1vcmUgd2l0aGluIHRoZWlyIHJlbWl0Lg0KPj4N
Cj4+IFBsZWFzZSB0ZXN0IHRoZSBhdGJrZCBkZXZpY2Ugd2l0aCAic3VkbyBldmVtdS1yZWNvcmQi
IG9yICJzdWRvIA0KPj4gZXZ0ZXN0Ig0KPj4gYW5kIGlmIHRoZSBicmlnaHRuZXNzIGtleXMgZ2Vu
ZXJhdGUgZXZlbnRzIHRoZXJlLCB3cml0ZSBkb3duIHRoZSByYXcgDQo+PiBldmVudCBjb2RlcyAo
TVNDIGV2ZW50cykuDQo+IA0KPiBJIHRyaWVkIHRoaXMgYnV0IHVuZm9ydHVuYXRlbHkgdGhpcyBk
b2Vzbid0IHNlZW0gdG8gYmUgdGhlIHdob2xlIHN0b3J5Lg0KPiBJZiBJIHByZXNzICJkZWNyZWFz
ZSBicmlnaHRuZXNzIiBJIGdldDoNCj4gRXZlbnQ6IHRpbWUgMTY1NzUyNTM5My45MjI3MjcsIC0t
LS0tLS0tLS0tLS0tIFNZTl9SRVBPUlQgLS0tLS0tLS0tLS0tDQo+IEV2ZW50OiB0aW1lIDE2NTc1
MjUzOTcuMDQzMzQ4LCB0eXBlIDQgKEVWX01TQyksIGNvZGUgNCAoTVNDX1NDQU4pLCANCj4gdmFs
dWUgODENCj4gRXZlbnQ6IHRpbWUgMTY1NzUyNTM5Ny4wNDMzNDgsIHR5cGUgMSAoRVZfS0VZKSwg
Y29kZSAxOTAgKEtFWV9GMjApLCANCj4gdmFsdWUgMQ0KPiBFdmVudDogdGltZSAxNjU3NTI1Mzk3
LjA0MzM0OCwgLS0tLS0tLS0tLS0tLS0gU1lOX1JFUE9SVCAtLS0tLS0tLS0tLS0NCj4gRXZlbnQ6
IHRpbWUgMTY1NzUyNTM5Ny4wNTAzODQsIHR5cGUgNCAoRVZfTVNDKSwgY29kZSA0IChNU0NfU0NB
TiksIA0KPiB2YWx1ZSA4MQ0KPiBFdmVudDogdGltZSAxNjU3NTI1Mzk3LjA1MDM4NCwgdHlwZSAx
IChFVl9LRVkpLCBjb2RlIDE5MCAoS0VZX0YyMCksIA0KPiB2YWx1ZSAwDQo+IA0KPiBBbmQgaWYg
SSBwcmVzcyAiaW5jcmVhc2UgYnJpZ2h0bmVzcyIgSSBnZXQ6DQo+IEV2ZW50OiB0aW1lIDE2NTc1
MjUzOTcuMDUwMzg0LCAtLS0tLS0tLS0tLS0tLSBTWU5fUkVQT1JUIC0tLS0tLS0tLS0tLQ0KPiBF
dmVudDogdGltZSAxNjU3NTI1Mzk4LjYwNzE4NCwgdHlwZSA0IChFVl9NU0MpLCBjb2RlIDQgKE1T
Q19TQ0FOKSwgDQo+IHZhbHVlIDgxDQo+IEV2ZW50OiB0aW1lIDE2NTc1MjUzOTguNjA3MTg0LCB0
eXBlIDEgKEVWX0tFWSksIGNvZGUgMTkwIChLRVlfRjIwKSwgDQo+IHZhbHVlIDENCj4gRXZlbnQ6
IHRpbWUgMTY1NzUyNTM5OC42MDcxODQsIC0tLS0tLS0tLS0tLS0tIFNZTl9SRVBPUlQgLS0tLS0t
LS0tLS0tDQo+IEV2ZW50OiB0aW1lIDE2NTc1MjUzOTguNjE0MTkwLCB0eXBlIDQgKEVWX01TQyks
IGNvZGUgNCAoTVNDX1NDQU4pLCANCj4gdmFsdWUgODENCj4gRXZlbnQ6IHRpbWUgMTY1NzUyNTM5
OC42MTQxOTAsIHR5cGUgMSAoRVZfS0VZKSwgY29kZSAxOTAgKEtFWV9GMjApLCANCj4gdmFsdWUg
MA0KPiANCj4gVGhlcmUncyBubyBkaWZmZXJlbmNlISBBbmQgSSBhbHNvIGdldCB0aGUgc2FtZSB0
aGluZyBpZiBJIHByZXNzIHRoZQ0KPiAqYWN0dWFsKiBtdXRlIG1pYyBidXR0b24g8J+Yni4NCj4g
DQo+IEFueSBpZGVhcz8NCg0KRnJvbSB0aGlzIGl0IGxvb2tzIGxpa2Ugd2UgbmVlZCB0byB1c2Ug
c29tZSBvdGhlciBpbnRlcmZhY2UgdG8gZ2V0IHRoZXNlIGV2ZW50cyAoKyBpZ25vcmUgdGhlIGFi
b3ZlIGV2ZW50cykuDQoNCkRvIHlvdSBoYXZlIGEgIkhQIFdNSSBob3RrZXlzIiBkZXZpY2UgaW4g
eW91ciBsaXN0IG9mIGlucHV0IGRldmljZXM/ICBBbmQgYXJlIHlvdSBnZXR0aW5nIGFueSBldmVu
dHMgb24gdGhhdCA/DQoNCkxpa2V3aXNlIGRvIHlvdSBoYXZlIGEgIlZpZGVvIEJ1cyIgZGV2aWNl
IGFuZCBhbnkgZXZlbnRzIG9uIHRoYXQgPw0KDQpJJ3ZlIGFsc28gYWRkZWQgSm9yZ2UgZnJvbSBI
UCB0byB0aGUgQ2MuIEpvcmdlLCBjYW4geW91IGhlbHAgd2l0aCB0aGlzID8NCg0KUmVnYXJkcywN
Cg0KSGFucw0KDQo=

