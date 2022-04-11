Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107904FB72B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 11:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344299AbiDKJS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 05:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344297AbiDKJRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 05:17:31 -0400
X-Greylist: delayed 408 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 11 Apr 2022 02:15:15 PDT
Received: from mx2.securetransport.de (mx2.securetransport.de [IPv6:2a03:4000:13:6c7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC111901D;
        Mon, 11 Apr 2022 02:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1649668020;
        bh=ZkjVgkAd7BPlW65AFkPh62JC4/Ltq0wEMyPc85IKACI=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=SL6bK6G+HmR/00NefWd1XD9Pl03YFODwgM0d+CYvOYcv6LM9GvBERBQa3ehx9V93X
         b02Y6EFV7w/Lu1QSNBIXrpV0xM1u0DsU78FZLvvopN9jxX9smxdU1mpKfHLD388pUj
         Dh2Dh4HZo+HyRFKGly6rTcEkUFEkNYX2PHWT7ngSYgpMsZIxUVMRys2bSBwdEdIn8j
         VEXtJ6LudDcwgUJoETqTFYrZeAfgCKXjByKRE0cPHiKJIAIjC3uoguktNcXbuqhXdK
         AfEqw59xeyaBmJhDXVyyZi7dRYhFRDF3iuaXfrJwvmNZFnjdtKxeS+Ur20rH5yloQU
         x9BDWa1gRCtOw==
X-secureTransport-forwarded: yes
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To:     Guenter Roeck <linux@roeck-us.net>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
CC:     "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Andrej Picej <andrej.picej@norik.com>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: RE: [PATCH v5 1/5] mfd: da9062: make register CONFIG_I writable
Thread-Topic: [PATCH v5 1/5] mfd: da9062: make register CONFIG_I writable
Thread-Index: AQHX6m0sEuT02omnTU6Bw4Z3mrvD4awlnAGAgAAHA4CAxYtwoA==
Date:   Mon, 11 Apr 2022 09:06:46 +0000
Message-ID: <3e49d99036cf4b5793d52891683b867f@dh-electronics.com>
References: <20211206064732.280375-1-andrej.picej@norik.com>
 <DB9PR10MB4652F10355222D5DD1A65E50806D9@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
 <83fad886-541c-987c-1f38-7029aca41892@roeck-us.net>
In-Reply-To: <83fad886-541c-987c-1f38-7029aca41892@roeck-us.net>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogR3VlbnRlciBSb2VjayBbbWFpbHRvOmdyb2VjazdAZ21haWwuY29tXSBPbiBCZWhhbGYg
T2YgR3VlbnRlciBSb2Vjaw0KU2VudDogTW9uZGF5LCBEZWNlbWJlciA2LCAyMDIxIDY6MTIgUE0N
Cj4gT24gMTIvNi8yMSA4OjQ2IEFNLCBBZGFtIFRob21zb24gd3JvdGU6DQo+PiBPbiAwNiBEZWNl
bWJlciAyMDIxIDA2OjQ3LCBBbmRyZWogUGljZWogd3JvdGU6DQo+Pg0KPj4+IEZyb206IFN0ZWZh
biBDaHJpc3QgPHMuY2hyaXN0QHBoeXRlYy5kZT4NCj4+Pg0KPj4+IE1ha2UgdGhlIGNvbmZpZyBy
ZWdpc3RlciBDT05GSUdfSSB3cml0YWJsZSB0byBjaGFuZ2UgdGhlIHdhdGNoZG9nIG1vZGUuDQo+
Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gQ2hyaXN0IDxzLmNocmlzdEBwaHl0ZWMuZGU+
DQo+Pj4gU2lnbmVkLW9mZi1ieTogQW5kcmVqIFBpY2VqIDxhbmRyZWoucGljZWpAbm9yaWsuY29t
Pg0KPj4NCj4+IEkndmUgYWxyZWFkeSBwcm92aWRlZCAnUmV2aWV3ZWQtYnknIHRhZ3MgZm9yIHRo
ZSBvdGhlciBwYXRjaGVzIGluIHRoaXMgc2V0LiBJbg0KPj4gdGhlIGZ1dHVyZSB5b3UgY2FuIGFk
ZCBhbnkgcmVjZWl2ZWQgdGFncyBvbiB0byBwYXRjaCByZS1zdWJtaXNzaW9ucyB3aGVyZQ0KPj4g
bm90aGluZyBoYXMgY2hhbmdlZCBzaW5jZSBsYXN0IHJldmlldy4NCj4+DQo+PiBBbnl3YXksIHRo
YW5rcyBmb3IgdGhlIHdvcmsgb24gdGhpcywgYW5kIGZvciB0aGUgcGF0Y2ggc2V0Og0KPj4NCj4+
IFJldmlld2VkLWJ5OiBBZGFtIFRob21zb24gPEFkYW0uVGhvbXNvbi5PcGVuc291cmNlQGRpYXNl
bWkuY29tPg0KPj4NCj4gDQo+IEluIHRoaXMgY29udGV4dDoNCj4gDQo+IEkgZXhwZWN0IHRoYXQg
dGFncyBhcmUgcHJlc2VudCBpbiBwYXRjaHdvcmsuIElmIGEgc3VibWl0dGVyIGRyb3BzIHRhZ3MN
Cj4gaW4gYSBuZXcgcmV2aXNpb24gb2YgYSBwYXRjaCBzZXJpZXMsIHRob3NlIHdpbGwgZ2V0IGxv
c3QuIFRoZSB1bmRlcmx5aW5nDQo+IGFzc3VtcHRpb24gaXMgdGhhdCB0aGUgc3VibWl0dGVyIGhh
ZCBhIHJlYXNvbiB0byBkcm9wIHRhZ3MsIHN1Y2ggYXMNCj4gc3Vic3RhbnRpYWwgY2hhbmdlcyBp
biBhbiBhZmZlY3RlZCBwYXRjaC4gSSBjYW4gbm90IGFzc3VtZSB0aGF0IHRoZQ0KPiBzdWJtaXR0
ZXIgZHJvcHBlZCBhIHRhZyBhY2NpZGVudGFsbHkgYW5kIHJlLWFwcGx5IGl0LCB1bmxlc3MgdGhl
IHJlYXNvbg0KPiB3YXMgZXhwbGljaXRseSBwcm92aWRlZCAob2J2aW91c2x5IHRoYXQgaXMgdHlw
aWNhbGx5IG5vdCB0aGUgY2FzZSBzaW5jZQ0KPiBwZW9wbGUgZG9uJ3QgdXN1YWxseSBhZGQgImFj
Y2lkZW50YWxseSBkcm9wcGVkIFJldmlld2VkLWJ5OiB0YWdzIiB0bw0KPiBjaGFuZ2UgbG9ncyku
DQo+IA0KPiBBbHNvLCBJIGRvIG5vdCBsb29rIGludG8gb25lIHBhdGNoIG9mIGEgc2VyaWVzIGFu
ZCBhcHBseSB0YWdzIHRvIG90aGVyDQo+IHBhdGNoZXMgb2YgdGhhdCBzZXJpZXMuIFNpbWlsYXIg
cmVhc29uLCBvbmx5IGhlcmUgaXQgaXMgd29yc2UgYmVjYXVzZSBXaW0NCj4gbWF5IHB1bGwgYSBw
YXRjaCBmcm9tIHBhdGNod29yaywgZnJvbSBhbiBlLW1haWwsIG9yIGZyb20gbXkgd2F0Y2hkb2ct
bmV4dA0KPiBicmFuY2guIFdlIGNhbid0IGhhdmUgYWxsIG9mIHRoZW0gaGF2ZSBkaWZmZXJlbnQg
dGFncywgc28gSSB0YWtlIHdoYXQgaXMNCj4gaW4gcGF0Y2h3b3JrIGFuZCBub3RoaW5nIGVsc2Ug
KGFuZCB5b3VyIHVwZGF0ZWQgUmV2aWV3ZWQtYnk6IHRhZyB3aWxsDQo+IG5vdCBhcHBseSB0byBv
dGhlciBwYXRjaGVzIG9mIHRoZSBzZXJpZXMgYmVjYXVzZSBpdCBpc24ndCBpbiBwYXRjaHdvcmsN
Cj4gZm9yIHRob3NlKS4NCj4gDQo+IEkgYWxzbyBzZWUgdGhhdCBteSBvd24gUmV2aWV3ZWQtYnk6
IHRhZyAob3IgdGFncywgSSBkaWRuJ3QgY2hlY2sgYWxsDQo+IG9mIHRoZW0pIHdhcy93ZXJlIGRy
b3BwZWQgaW4gdjUgb2YgdGhpcyBzZXJpZXMuIFRoYXQgbWVhbnMgSSdsbCBoYXZlIHRvDQo+IHJl
LXJldmlldyB0aGUgc2VyaWVzIHRvIHNlZSB3aGF0IGNoYW5nZWQsIHdoaWNoIHdpbGwgdGFrZSB0
aW1lIGFuZCBtZWFucw0KPiB0aGF0IHRoZSBzZXJpZXMgd2lsbCBlbmQgdXAgYXQgdGhlIGJvdHRv
bSBvZiBteSByZXZpZXcgcXVldWUuDQo+IFBsZWFzZSBrZWVwIHRoYXQgaW4gbWluZCB3aGVuIGRy
b3BwaW5nIHRhZ3MuDQoNCg0KSGkgR3VlbnRlciwNCg0KSXMgdGhlcmUgYW55dGhpbmcgYWdhaW5z
dCBhcHBseWluZyB0aGUgZmlyc3QgNCBwYXRjaGVzIG9mIHRoaXMgc2VyaWVzPw0KDQpUaGFua3Mg
YW5kIHJlZ2FyZHMNCkNocmlzdG9waA0K
