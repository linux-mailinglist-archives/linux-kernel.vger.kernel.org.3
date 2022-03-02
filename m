Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D4F4C9B61
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 03:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239087AbiCBCst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 21:48:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbiCBCss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 21:48:48 -0500
Received: from mg.sunplus.com (unknown [113.196.136.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7B57B506D5;
        Tue,  1 Mar 2022 18:48:05 -0800 (PST)
X-MailGates: (flag:3,DYNAMIC,RELAY,NOHOST:PASS)(compute_score:DELIVER,40
        ,3)
Received: from 172.17.9.202
        by mg01.sunplus.com with MailGates ESMTP Server V5.0(10053:0:AUTH_RELAY)
        (envelope-from <tony.huang@sunplus.com>); Wed, 02 Mar 2022 10:48:15 +0800 (CST)
Received: from sphcmbx02.sunplus.com.tw (172.17.9.112) by
 sphcmbx01.sunplus.com.tw (172.17.9.202) with Microsoft SMTP Server (TLS) id
 15.0.1497.26; Wed, 2 Mar 2022 10:48:15 +0800
Received: from sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd]) by
 sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd%14]) with mapi id
 15.00.1497.026; Wed, 2 Mar 2022 10:48:15 +0800
From:   =?utf-8?B?VG9ueSBIdWFuZyDpu4Pmh7fljpo=?= <tony.huang@sunplus.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Tony Huang <tonyhuang.sunplus@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        gregkh <gregkh@linuxfoundation.org>,
        =?utf-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>
Subject: RE: [PATCH v9 2/2] misc: Add iop driver for Sunplus SP7021
Thread-Topic: [PATCH v9 2/2] misc: Add iop driver for Sunplus SP7021
Thread-Index: AQHYJsjgtEqSV/WirUaNKgOQ/NhSWaydE0+AgA5UZIA=
Date:   Wed, 2 Mar 2022 02:48:14 +0000
Message-ID: <5c7e4c014858485a8b0eb120f85e98de@sphcmbx02.sunplus.com.tw>
References: <cover.1645407997.git.tonyhuang.sunplus@gmail.com>
 <20f858dfe999816cb05dfde5f89db48f3416358e.1645407997.git.tonyhuang.sunplus@gmail.com>
 <CAK8P3a1FZQ2LQco8D263+YXjcSQvzU6RHAL8SKcKy8hiLnHY8g@mail.gmail.com>
In-Reply-To: <CAK8P3a1FZQ2LQco8D263+YXjcSQvzU6RHAL8SKcKy8hiLnHY8g@mail.gmail.com>
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

RGVhciBBcm5kLCBHcmVna2g6DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJv
bTogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4NCj4gU2VudDogTW9uZGF5LCBGZWJydWFy
eSAyMSwgMjAyMiAzOjIwIFBNDQo+IFRvOiBUb255IEh1YW5nIDx0b255aHVhbmcuc3VucGx1c0Bn
bWFpbC5jb20+DQo+IENjOiBSb2IgSGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3JnPjsgRFRNTCA8
ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc+Ow0KPiBMaW51eCBLZXJuZWwgTWFpbGluZyBMaXN0
IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgRGVyZWsgS2llcm5hbg0KPiA8ZGVyZWsu
a2llcm5hbkB4aWxpbnguY29tPjsgRHJhZ2FuIEN2ZXRpYyA8ZHJhZ2FuLmN2ZXRpY0B4aWxpbngu
Y29tPjsgQXJuZA0KPiBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT47IGdyZWdraCA8Z3JlZ2toQGxp
bnV4Zm91bmRhdGlvbi5vcmc+OyBXZWxscyBMdQ0KPiDlkYLoirPpqLAgPHdlbGxzLmx1QHN1bnBs
dXMuY29tPjsgVG9ueSBIdWFuZyDpu4Pmh7fljpoNCj4gPHRvbnkuaHVhbmdAc3VucGx1cy5jb20+
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjkgMi8yXSBtaXNjOiBBZGQgaW9wIGRyaXZlciBmb3Ig
U3VucGx1cyBTUDcwMjENCj4gDQo+IE9uIE1vbiwgRmViIDIxLCAyMDIyIGF0IDM6MTQgQU0gVG9u
eSBIdWFuZw0KPiA8dG9ueWh1YW5nLnN1bnBsdXNAZ21haWwuY29tPiB3cm90ZToNCj4gPg0KPiA+
IElPUCg4MDUxKSBlbWJlZGRlZCBpbnNpZGUgU1A3MDIxIHdoaWNoIGlzIHVzZWQgYXMgUHJvY2Vz
c29yIGZvciBJL08NCj4gPiBjb250cm9sLCBtb25pdG9yIFJUQyBpbnRlcnJ1cHQgYW5kIGNvb3Bl
cmF0aW9uIHdpdGggQ1BVICYgUE1DIGluIHBvd2VyDQo+ID4gbWFuYWdlbWVudCBwdXJwb3NlLg0K
PiA+IFRoZSBJT1AgY29yZSBpcyBEUTgwNTEsIHNvIGFsc28gbmFtZWQgSU9QODA1MSwgaXQgc3Vw
cG9ydHMgZGVkaWNhdGVkDQo+ID4gSlRBRyBkZWJ1ZyBwaW5zIHdoaWNoIHNoYXJlIHdpdGggU1A3
MDIxLg0KPiA+IEluIHN0YW5kYnkgbW9kZSBvcGVyYXRpb24sIHRoZSBwb3dlciBzcGVjIHJlYWNo
IDQwMHVBLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogVG9ueSBIdWFuZyA8dG9ueWh1YW5nLnN1
bnBsdXNAZ21haWwuY29tPg0KPiA+IC0tLQ0KPiA+IENoYW5nZXMgaW4gdjk6DQo+ID4gIC0gUmVt
b3ZlIGN1c3RvbSBhdHRyaWJ1dGVzIHN5c2ZzLg0KPiANCj4gWW91IGFyZSBub3cgYmFjayB0byBh
IGRyaXZlciB0aGF0IGRvZXMgbm90aGluZyBhdCBhbGwsIHBsZWFzZSBtYWtlIGl0IHVzZSBhdA0K
PiBsZWFzdCBvbmUga2VybmVsIHN1YnN5c3RlbSB0aGF0IGl0IGNhbiBob29rIHVwIHRvIGJlZm9y
ZSB5b3Ugc2VuZCBpdCBhZ2Fpbi4NCj4gDQptb25pdG9yIFJUQyBpbnRlcnJ1cHQ6DQpTUDcwMjEg
c3lzdGVtIGhhcyBpdHMgb3duIFJUQyBkZXZpY2UgZHJpdmVyIChydGMtc3VucGx1cy5jKS4JCQkJ
CQkJCQkNClRoZSB1c2VyIGNhbiBzZXQgdGhlIFJUQyB3YWtlLXVwIHRpbWUgdGhyb3VnaCBydGMt
c3VucGx1cy5jLgkJCQkJCQkJCQ0KVGhlIElPUCBjb2RlIGRvZXMgbm90IG5lZWQgdG8gaW5jcmVh
c2UgdGhlIFJUQyBzdWJzeXN0ZW0gZnVuY3Rpb24sIHNldCB0aGUgUlRDIHJlZ2lzdGVyLgkJCQkJ
CQkJCQ0KV2hlbiB0aGUgbGludXgga2VybmVsIHN5c3RlbS4gT25seSB0aGUgODA1MSBDUFUgaGFz
IHBvd2VyIGFuZCBjYW4gbW9uaXRvciB0aGUgUlRDIHdha2UtdXAgaW50ZXJydXB0LgkJCQkJCQkJ
CQ0KDQo+IEFsc28sIHdoZW4gbGlzdGluZyB0aGUgZnVuY3Rpb25hbGl0eSBhYm92ZSwgZGVzY3Jp
YmUgd2hpY2ggc3Vic3lzdGVtcyB5b3Ugd2FudA0KPiB0byB1c2UgZm9yIHRob3NlIGluIHRoZSBs
b25nIHJ1biwgdGhpcyB3b3VsZCBtYWtlIGl0IGNsZWFyZXIgdG8gc2VlIHdoaWNoDQo+IGRpcmVj
dGlvbiB5b3Ugd2FudCB0byB0YWtlIHRoaXMgZHJpdmVyIHdoZW4geW91IGFkZCBiYWNrIHRoZSBm
ZWF0dXJlcy4NCj4gDQo+ICAgICAgICAgIEFybmQNCg==
