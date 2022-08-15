Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A85592BB5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242204AbiHOJ4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 05:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242321AbiHOJz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 05:55:56 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E8D7613F7D
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 02:55:54 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-101-4cQNWSDENwOhApAiFPs4uQ-1; Mon, 15 Aug 2022 10:55:51 +0100
X-MC-Unique: 4cQNWSDENwOhApAiFPs4uQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.38; Mon, 15 Aug 2022 10:55:50 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.040; Mon, 15 Aug 2022 10:55:50 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Nick Desaulniers' <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>
CC:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Tom Rix <trix@redhat.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: RE: [PATCH] ASoC: mchp-spdiftx: Fix clang
 -Wbitfield-constant-conversion
Thread-Topic: [PATCH] ASoC: mchp-spdiftx: Fix clang
 -Wbitfield-constant-conversion
Thread-Index: AQHYrP4xySyJ4QyXg0+0Vu0cOV8HAa2vv+Uw
Date:   Mon, 15 Aug 2022 09:55:50 +0000
Message-ID: <24087aa311e84df3a3df3c0e15151580@AcuMS.aculab.com>
References: <20220810010809.2024482-1-nathan@kernel.org>
 <CAKwvOdmZvB_=JTeLg08uMFhEMpWga4FJey50QHjzCv_jMVpwkg@mail.gmail.com>
In-Reply-To: <CAKwvOdmZvB_=JTeLg08uMFhEMpWga4FJey50QHjzCv_jMVpwkg@mail.gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTmljayBEZXNhdWxuaWVycw0KPiBTZW50OiAxMCBBdWd1c3QgMjAyMiAyMjoxNA0KPiAN
Cj4gT24gVHVlLCBBdWcgOSwgMjAyMiBhdCA2OjA4IFBNIE5hdGhhbiBDaGFuY2VsbG9yIDxuYXRo
YW5Aa2VybmVsLm9yZz4gd3JvdGU6DQo+ID4NCj4gPiBBIHJlY2VudCBjaGFuZ2UgaW4gY2xhbmcg
c3RyZW5ndGhlbmVkIGl0cyAtV2JpdGZpZWxkLWNvbnN0YW50LWNvbnZlcnNpb24NCj4gPiB0byB3
YXJuIHdoZW4gMSBpcyBhc3NpZ25lZCB0byBhIDEtYml0IHNpZ25lZCBpbnRlZ2VyIGJpdGZpZWxk
LCBhcyBpdCBjYW4NCj4gPiBvbmx5IGJlIDAgb3IgLTEsIG5vdCAxOg0KDQpJcyB0aGVyZSBhIC1X
c2lnbmVkLWJpdGZpZWxkID8NCllvdSBwcm9iYWJseSBkb24ndCBldmVyIHdhbnQgdGhlIGNvbXBp
bGVyIHRvIGJlIGdlbmVyYXRpbmcNCnRoZSBjb2RlIHRvIHNpZ24tcHJvcGFnYXRlIGEgYml0Zmll
bGQuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkg
Um9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlv
biBObzogMTM5NzM4NiAoV2FsZXMpDQo=

