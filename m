Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B64751669C
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 19:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352873AbiEAR0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 13:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbiEAR0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 13:26:49 -0400
X-Greylist: delayed 580 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 01 May 2022 10:23:21 PDT
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5CC4614F
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 10:23:20 -0700 (PDT)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 8BE5D23E8;
        Sun,  1 May 2022 17:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1651425213;
        bh=+7dSocgdKOwnHjit7kSTGbHZMbMHppkIre6dLkmO8Cw=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=F2IdnanVZjeIFlluSGTpSZv3RvVD0PAiRPxCCpjcpFGQPpfB4a8BAwhDZkWINbnPx
         DdBqQZSrzVhk53Xs2alY8n0w6HiI+SXLxjYRBnma+pLr80Z9y62s46SQxTPK6SYPbE
         YcC7Ud3m6SlaKqkjYdqU2syu2WE6HBJSiek3jrsQ=
Received: from vdlg-exch-02.paragon-software.com (172.30.1.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Sun, 1 May 2022 20:13:39 +0300
Received: from vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b])
 by vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b%12]) with
 mapi id 15.01.2375.007; Sun, 1 May 2022 20:13:39 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kari Argillander <kari.argillander@stargateuniverse.net>
CC:     "ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>,
        Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Eric Biggers <ebiggers@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Al Viro" <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: NTFS3 driver is orphan already. What we do?
Thread-Topic: NTFS3 driver is orphan already. What we do?
Thread-Index: AQHYWU8d5UQareA1dE+mIW4HKVrLlK0D2MOAgAZo1WA=
Date:   Sun, 1 May 2022 17:13:39 +0000
Message-ID: <0f48e2eb2b0740b1b85e3b8d910c4bd8@paragon-software.com>
References: <da20d32b-5185-f40b-48b8-2986922d8b25@stargateuniverse.net>
 <CAHk-=wihuvzVTozzNLZT=uFzJH6uM7ZNKN7fYVpm0v2KkY6Jxg@mail.gmail.com>
In-Reply-To: <CAHk-=wihuvzVTozzNLZT=uFzJH6uM7ZNKN7fYVpm0v2KkY6Jxg@mail.gmail.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.30.0.26]
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

PiBGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRhdGlvbi5vcmc+DQo+
IFNlbnQ6IFdlZG5lc2RheSwgQXByaWwgMjcsIDIwMjIgNzo0NyBQTQ0KPiBUbzogS2FyaSBBcmdp
bGxhbmRlciA8a2FyaS5hcmdpbGxhbmRlckBzdGFyZ2F0ZXVuaXZlcnNlLm5ldD4NCj4gQ2M6IEtv
bnN0YW50aW4gS29tYXJvdiA8YWxtYXouYWxleGFuZHJvdmljaEBwYXJhZ29uLXNvZnR3YXJlLmNv
bT47IG50ZnMzQGxpc3RzLmxpbnV4LmRldjsgVGhlb2RvcmUgVHMnbyA8dHl0c29AbWl0LmVkdT47
DQo+IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPjsgTWF0dGhldyBXaWxjb3ggPHdpbGx5
QGluZnJhZGVhZC5vcmc+OyBFcmljIEJpZ2dlcnMgPGViaWdnZXJzQGtlcm5lbC5vcmc+OyBEYXJy
aWNrIEouIFdvbmcNCj4gPGRqd29uZ0BrZXJuZWwub3JnPjsgQ2hyaXN0aWFuIEJyYXVuZXIgPGNo
cmlzdGlhbi5icmF1bmVyQHVidW50dS5jb20+OyBBbCBWaXJvIDx2aXJvQHplbml2LmxpbnV4Lm9y
Zy51az47IExpbnV4IEtlcm5lbCBNYWlsaW5nDQo+IExpc3QgPGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc+DQo+IFN1YmplY3Q6IFJlOiBOVEZTMyBkcml2ZXIgaXMgb3JwaGFuIGFscmVhZHku
IFdoYXQgd2UgZG8/DQo+IA0KPiBbIFNhZCBzdGF0ZSBvZiBhZmZhaXJzIG1vc3RseSBlZGl0ZWQg
b3V0IF0NCj4gDQo+IE9uIFR1ZSwgQXByIDI2LCAyMDIyIGF0IDI6MjIgQU0gS2FyaSBBcmdpbGxh
bmRlcg0KPiA8a2FyaS5hcmdpbGxhbmRlckBzdGFyZ2F0ZXVuaXZlcnNlLm5ldD4gd3JvdGU6DQo+
ID4NCj4gPiBJIGFsc28gZGlkIHN1Z2dlc3QgdGhhdCBJIGNvdWxkIGNvIG1haW50YWluIHRoaXMg
ZHJpdmVyIHRvIHRha2UgYnVyZGVuIGZyb20NCj4gPiBLb25zdGFudGluLCBidXQgaGF2ZW4ndCBn
b3QgYW55IHJlcGxheS4NCj4gDQo+IElmIHlvdSBhcmUgd2lsbGluZyB0byBtYWludGFpbiBpdCAo
YW5kIG1heWJlIGZpbmQgb3RoZXIgbGlrZS1taW5kZWQNCj4gcGVvcGxlIHRvIGhlbHAgeW91KSwg
SSB0aGluayB0aGF0IHdvdWxkIGNlcnRhaW5seSBiZSBhIHRoaW5nIHRvIHRyeS4NCj4gDQo+IEFu
ZCBpZiB3ZSBjYW4gZmluZCAqbm9ib2R5KiB0aGF0IGVuZHMgdXAgY2FyaW5nIGFuZCBtYWludGFp
bmluZywgdGhlbg0KPiBJIGd1ZXNzIHdlIHNob3VsZCByZW1vdmUgaXQsIHJhdGhlciB0aGFuIGVu
ZCB1cCB3aXRoICp0d28qIGVmZmVjdGl2ZWx5DQo+IHVubWFpbnRhaW5lZCBjb3BpZXMgb2YgTlRG
UyBkcml2ZXJzLg0KPiANCj4gTm90IHRoYXQgdHdvIHVubWFpbnRhaW5lZCBmaWxlc3lzdGVtcyBh
cmUgbXVjaCB3b3JzZSB0aGFuIG9uZSA6LXANCj4gDQo+ICAgICAgICAgICAgTGludXMNCg0KSGVs
bG8gTGludXMsIEthcmkgYW5kIGFsbC4NCg0KRmlyc3QgYW5kIGZvcmVtb3N0IEkgbmVlZCB0byBz
dGF0ZSB0aGF0IGFjdGl2ZSB3b3JrIG9uIE5URlMzIGRyaXZlciBoYXMgbmV2ZXIgc3RvcHBlZCwN
CmFuZCBpdCB3YXMgbmV2ZXIgZGVjaWRlZCB0byAib3JwaGFuIiBOVEZTMy4gIEN1cnJlbnRseSB3
ZSBhcmUgc3RpbGwgaW4gdGhlIG1pZGRsZSBvZiB0aGUgcHJvY2Vzcw0Kb2YgZ2V0dGluZyB0aGUg
S2VybmVsLm9yZyBhY2NvdW50LiBXZSBuZWVkIHRvIHNpZ24gb3VyIFBHUCBrZXkgdG8gbW92ZSBm
b3J3YXJkLCBidXQNCnRoZSBwcm9jZXNzIGlzIG5vdCBzbyBjbGVhciAod2lsbCBiZSBncmF0ZWZ1
bCB0byBnZXQgc29tZSBwcm9jZXNzIGRlc2NpcHRpb24pLCBzbyBpdCBpcyBnb2luZyBxdWl0ZSBz
bG93DQp0cnlpbmcgdG8gdW5yYXZlbCB0aGUgdG9waWMuDQoNCkFzIGZvciBub3csIHdlIGNhbiBw
cmVwYXJlIHBhdGNoZXMvcHVsbCByZXF1ZXN0cyB0aHJvdWdoIHRoZSBnaXRodWIsIA0KYW5kIHN1
Ym1pdCB0aGVtIHJpZ2h0IG5vdyAod2UgaGF2ZSBxdWl0ZSBhIGJ1bmNoIG9mIGZpeGVzDQpmb3Ig
bmV3IEtlcm5lbHMgc3VwcG9ydCwgYnVnZml4ZXMgYW5kIGZzdGVzdHMgZml4ZXMpIC0tIGlmIExp
bnVzIGFwcHJvdmVzIHRoaXMgYXBwcm9hY2gNCnVudGlsIHdlIHNldCB1cCB0aGUgcHJvcGVyIGdp
dC5rZXJuZWwub3JnIHJlcG8uDQoNCkFsc28sIHRvIGNsYXJpZnkgdGhpcyBleHBsaWNpdGx5OiBp
biBhZGRpdGlvbiB0byB0aGUgZHJpdmVyLCB3ZSdyZSB3b3JraW5nIG9mIG50ZnMzIHV0aWxpdGll
cyBhcyB3ZWxsLg0KDQpPdmVyYWxsLCBuZXZlcnRoZWxlc3MgdGhlIE5URlMzIGRldmVsb3BtZW50
IHBhY2UgaGFzIGJlZW4gc2xvd2VkIGRvd24gYSBiaXQgZm9yIHByZXZpb3VzIGNvdXBsZQ0Kb2Yg
bW9udGhzLCBpdHMgc3RhdGUgaXMgc3RpbGwgdGhlIHNhbWUgYXMgYmVmb3JlOiBpdCBpcyBmdWxs
eSBtYWludGFpbmVkIGFuZCBiZWluZyBkZXZlbG9wZWQuDQoNCkFuZCBmaW5hbGx5LCB3ZSBhcG9s
b2dpemUgZm9yIGxhdGUgcmVwbHk7IEkgYWxsb3dlZCBtZSBzaG9ydCB2YWNhdGlvbiBhZnRlciBt
b3N0IHJlc3RyaWN0aW9ucyBiZWNhdXNlDQpvZiBjb3ZpZCBlbmRlZCB1cCB0aGlzIG1vbnRoIGlu
IEdlcm1hbnkuDQoNClRoYW5rcy4NCg==
