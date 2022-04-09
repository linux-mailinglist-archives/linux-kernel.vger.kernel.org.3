Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4484FA70E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 13:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241525AbiDILOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 07:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241507AbiDILON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 07:14:13 -0400
Received: from mg.sunplus.com (unknown [113.196.136.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5DC6B3BA7D;
        Sat,  9 Apr 2022 04:11:59 -0700 (PDT)
X-MailGates: (flag:3,DYNAMIC,RELAY,NOHOST:PASS)(compute_score:DELIVER,40
        ,3)
Received: from 172.17.9.112
        by mg01.sunplus.com with MailGates ESMTP Server V5.0(8696:0:AUTH_RELAY)
        (envelope-from <tony.huang@sunplus.com>); Sat, 09 Apr 2022 19:11:46 +0800 (CST)
Received: from sphcmbx02.sunplus.com.tw (172.17.9.112) by
 sphcmbx02.sunplus.com.tw (172.17.9.112) with Microsoft SMTP Server (TLS) id
 15.0.1497.26; Sat, 9 Apr 2022 19:11:41 +0800
Received: from sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd]) by
 sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd%14]) with mapi id
 15.00.1497.026; Sat, 9 Apr 2022 19:11:41 +0800
From:   =?utf-8?B?VG9ueSBIdWFuZyDpu4Pmh7fljpo=?= <tony.huang@sunplus.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     =?utf-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>,
        =?utf-8?B?TGggS3VvIOmDreWKm+ixqg==?= <lh.Kuo@sunplus.com>
Subject: RE: [PATCH v6 2/2] mmc: Add mmc driver for Sunplus SP7021
Thread-Topic: [PATCH v6 2/2] mmc: Add mmc driver for Sunplus SP7021
Thread-Index: AQHYSZCPbSy48/804Uq8neyvz9tcSKznbUOWgAACnWA=
Date:   Sat, 9 Apr 2022 11:11:41 +0000
Message-ID: <607c96516048441db549f716656ea62f@sphcmbx02.sunplus.com.tw>
References: <e99f3027590b5ab3938c2e2d8713bf6284a810b2.1649229258.git.tonyhuang.sunplus@gmail.com>
 <202204070029.JvyEor8F-lkp@intel.com>
 <CAHpW4oQc0=SinXTVW=ph8BgKQ4bN1mXOtWDv46MCNgXED+9TGQ@mail.gmail.com>
In-Reply-To: <CAHpW4oQc0=SinXTVW=ph8BgKQ4bN1mXOtWDv46MCNgXED+9TGQ@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.25.108.54]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVhciBBcm5kOg0KDQo+IA0KPiBIaSBUb255LA0KPiANCj4gSSBsb3ZlIHlvdXIgcGF0Y2ghIFll
dCBzb21ldGhpbmcgdG8gaW1wcm92ZToNCj4gDQo+IFthdXRvIGJ1aWxkIHRlc3QgRVJST1Igb24g
dWxmLWhhbnNzb24tbW1jLW1pcnJvci9uZXh0XSBbY2Fubm90IGFwcGx5IHRvDQo+IHJvYmgvZm9y
LW5leHQgbGludXMvbWFzdGVyIHY1LjE4LXJjMSBuZXh0LTIwMjIwNDA2XSBbSWYgeW91ciBwYXRj
aCBpcyBhcHBsaWVkDQo+IHRvIHRoZSB3cm9uZyBnaXQgdHJlZSwga2luZGx5IGRyb3AgdXMgYSBu
b3RlLg0KPiBBbmQgd2hlbiBzdWJtaXR0aW5nIHBhdGNoLCB3ZSBzdWdnZXN0IHRvIHVzZSAnLS1i
YXNlJyBhcyBkb2N1bWVudGVkIGluDQo+IGh0dHBzOi8vZ2l0LXNjbS5jb20vZG9jcy9naXQtZm9y
bWF0LXBhdGNoXQ0KPiANCj4gdXJsOg0KPiBodHRwczovL2dpdGh1Yi5jb20vaW50ZWwtbGFiLWxr
cC9saW51eC9jb21taXRzL1RvbnktSHVhbmcvQWRkLW1tYy1kcml2ZXItZg0KPiBvci1TdW5wbHVz
LVNQNzAyMS1TT0MvMjAyMjA0MDYtMTk0MTA2DQo+IGJhc2U6ICAgaHR0cHM6Ly9naXQubGluYXJv
Lm9yZy9wZW9wbGUvdWxmLmhhbnNzb24vbW1jLW1pcnJvci5naXQgbmV4dA0KPiBjb25maWc6IG5k
czMyLWJ1aWxkb25seS1yYW5kY29uZmlnLXIwMDMtMjAyMjA0MDYNCj4gKGh0dHBzOi8vZG93bmxv
YWQuMDEub3JnLzBkYXktY2kvYXJjaGl2ZS8yMDIyMDQwNy8yMDIyMDQwNzAwMjkuSnZ5RW9yOEYt
bA0KPiBrcEBpbnRlbC5jb20vY29uZmlnKQ0KPiBjb21waWxlcjogbmRzMzJsZS1saW51eC1nY2Mg
KEdDQykgMTEuMi4wIHJlcHJvZHVjZSAodGhpcyBpcyBhIFc9MSBidWlsZCk6DQo+ICAgICAgICAg
d2dldA0KPiBodHRwczovL3Jhdy5naXRodWJ1c2VyY29udGVudC5jb20vaW50ZWwvbGtwLXRlc3Rz
L21hc3Rlci9zYmluL21ha2UuY3Jvc3MNCj4gLU8gfi9iaW4vbWFrZS5jcm9zcw0KPiAgICAgICAg
IGNobW9kICt4IH4vYmluL21ha2UuY3Jvc3MNCj4gICAgICAgICAjDQo+IGh0dHBzOi8vZ2l0aHVi
LmNvbS9pbnRlbC1sYWItbGtwL2xpbnV4L2NvbW1pdC8zMjVhMGQ5Y2E5ZDY1ZjU2MTZmNzk0ZTBk
YmINCj4gMDQyNTYzMTJmNzM5ZA0KPiAgICAgICAgIGdpdCByZW1vdGUgYWRkIGxpbnV4LXJldmll
dyBodHRwczovL2dpdGh1Yi5jb20vaW50ZWwtbGFiLWxrcC9saW51eA0KPiAgICAgICAgIGdpdCBm
ZXRjaCAtLW5vLXRhZ3MgbGludXgtcmV2aWV3DQo+IFRvbnktSHVhbmcvQWRkLW1tYy1kcml2ZXIt
Zm9yLVN1bnBsdXMtU1A3MDIxLVNPQy8yMDIyMDQwNi0xOTQxMDYNCj4gICAgICAgICBnaXQgY2hl
Y2tvdXQgMzI1YTBkOWNhOWQ2NWY1NjE2Zjc5NGUwZGJiMDQyNTYzMTJmNzM5ZA0KPiAgICAgICAg
ICMgc2F2ZSB0aGUgY29uZmlnIGZpbGUgdG8gbGludXggYnVpbGQgdHJlZQ0KPiAgICAgICAgIG1r
ZGlyIGJ1aWxkX2Rpcg0KPiAgICAgICAgIENPTVBJTEVSX0lOU1RBTExfUEFUSD0kSE9NRS8wZGF5
IENPTVBJTEVSPWdjYy0xMS4yLjANCj4gbWFrZS5jcm9zcyBPPWJ1aWxkX2RpciBBUkNIPW5kczMy
IFNIRUxMPS9iaW4vYmFzaCBkcml2ZXJzL21tYy9ob3N0Lw0KPiANCj4gSWYgeW91IGZpeCB0aGUg
aXNzdWUsIGtpbmRseSBhZGQgZm9sbG93aW5nIHRhZyBhcyBhcHByb3ByaWF0ZQ0KPiBSZXBvcnRl
ZC1ieToga2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+DQo+IA0KPiBBbGwgZXJyb3Iv
d2FybmluZ3MgKG5ldyBvbmVzIHByZWZpeGVkIGJ5ID4+KToNCj4gDQo+ICAgIGRyaXZlcnMvbW1j
L2hvc3Qvc3VucGx1cy1tbWMuYzogSW4gZnVuY3Rpb24gJ3NwbW1jX3NldF9idXNfdGltaW5nJzoN
Cj4gPj4gZHJpdmVycy9tbWMvaG9zdC9zdW5wbHVzLW1tYy5jOjMxMToxNTogd2FybmluZzogdmFy
aWFibGUNCj4gPj4gJ3RpbWluZ19uYW1lJyBzZXQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1idXQt
c2V0LXZhcmlhYmxlXQ0KPiAgICAgIDMxMSB8ICAgICAgICAgY2hhciAqdGltaW5nX25hbWU7DQo+
ICAgICAgICAgIHwgICAgICAgICAgICAgICBefn5+fn5+fn5+fg0KPiAgICBkcml2ZXJzL21tYy9o
b3N0L3N1bnBsdXMtbW1jLmM6IEF0IHRvcCBsZXZlbDoNCj4gPj4gZHJpdmVycy9tbWMvaG9zdC9z
dW5wbHVzLW1tYy5jOjc5ODoxMzogd2FybmluZzogbm8gcHJldmlvdXMgcHJvdG90eXBlDQo+ID4+
IGZvciAnc3BtbWNfaXJxJyBbLVdtaXNzaW5nLXByb3RvdHlwZXNdDQo+ICAgICAgNzk4IHwgaXJx
cmV0dXJuX3Qgc3BtbWNfaXJxKGludCBpcnEsIHZvaWQgKmRldl9pZCkNCj4gICAgICAgICAgfCAg
ICAgICAgICAgICBefn5+fn5+fn4NCj4gPj4gZHJpdmVycy9tbWMvaG9zdC9zdW5wbHVzLW1tYy5j
Ojg5NDo1OiB3YXJuaW5nOiBubyBwcmV2aW91cyBwcm90b3R5cGUNCj4gPj4gZm9yICdzcG1tY19n
ZXRfY2QnIFstV21pc3NpbmctcHJvdG90eXBlc10NCj4gICAgICA4OTQgfCBpbnQgc3BtbWNfZ2V0
X2NkKHN0cnVjdCBtbWNfaG9zdCAqbW1jKQ0KPiAgICAgICAgICB8ICAgICBefn5+fn5+fn5+fn4N
Cj4gICAgZHJpdmVycy9tbWMvaG9zdC9zdW5wbHVzLW1tYy5jOiBJbiBmdW5jdGlvbiAnc3BtbWNf
ZHJ2X3Byb2JlJzoNCj4gPj4gZHJpdmVycy9tbWMvaG9zdC9zdW5wbHVzLW1tYy5jOjEwMjE6MjI6
IHdhcm5pbmc6IHZhcmlhYmxlICdtb2RlJyBzZXQNCj4gPj4gYnV0IG5vdCB1c2VkIFstV3VudXNl
ZC1idXQtc2V0LXZhcmlhYmxlXQ0KPiAgICAgMTAyMSB8ICAgICAgICAgdW5zaWduZWQgaW50IG1v
ZGU7DQo+ICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgXn5+fg0KPiAgICBkcml2ZXJz
L21tYy9ob3N0L3N1bnBsdXMtbW1jLmM6IEF0IHRvcCBsZXZlbDoNCj4gPj4gZHJpdmVycy9tbWMv
aG9zdC9zdW5wbHVzLW1tYy5jOjExNzA6OTogZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9m
DQo+ID4+IGZ1bmN0aW9uICdTWVNURU1fU0xFRVBfUE1fT1BTJzsgZGlkIHlvdSBtZWFuDQo+ID4+
ICdTRVRfU1lTVEVNX1NMRUVQX1BNX09QUyc/IFstV2Vycm9yPWltcGxpY2l0LWZ1bmN0aW9uLWRl
Y2xhcmF0aW9uXQ0KPiAgICAgMTE3MCB8ICAgICAgICAgU1lTVEVNX1NMRUVQX1BNX09QUyhzcG1t
Y19wbV9zdXNwZW5kLA0KPiBzcG1tY19wbV9yZXN1bWUpDQo+ICAgICAgICAgIHwgICAgICAgICBe
fn5+fn5+fn5+fn5+fn5+fn5+DQo+ICAgICAgICAgIHwgICAgICAgICBTRVRfU1lTVEVNX1NMRUVQ
X1BNX09QUw0KDQpJIGZvbGxvdyB5b3VyIHN1Z2d1ZXN0IGluIHY1LiAJCQkJCQkNCiJJdCdzIGJl
dHRlciB0byB1c2UgU1lTVEVNX1NMRUVQX1BNX09QUy9SVU5USU1FX1BNX09QUyBpbnN0ZWFkIG9m
IHRoZSBTRVRfIHZlcnNpb24iCQkJCQkJDQpCdXQga2VybmVsIHRlc3Qgcm9ib3Qgc2hvd3MgZXJy
b3IuCQkJCQkJDQo=
