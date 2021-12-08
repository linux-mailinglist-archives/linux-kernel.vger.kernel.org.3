Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9401546CAB1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 03:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236936AbhLHCEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 21:04:36 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:35466 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232311AbhLHCEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 21:04:35 -0500
X-UUID: f05e892a241e430e88faada1e0e9d722-20211208
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=DZaORBOtJY/yncuKK0ASrYmOnUqpv3wP5VjwQJkPl2o=;
        b=b+UDQlVg4XGmaR/qFBZQ2UnrcsS4U9u3hEOst0+evmQLKEDBQc5+YTeybF9YdI2le6UgfGcwjLYs7HK33Fld6u8aYRUCOFNIFgZSmhdtnE7TPNSKvz15SVskae9YpUMy4K36oR8VctY7reduWByuNECn+GyfqSdZtz1YUxpIpus=;
X-UUID: f05e892a241e430e88faada1e0e9d722-20211208
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 89225687; Wed, 08 Dec 2021 10:01:00 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 8 Dec 2021 10:00:59 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 8 Dec 2021 10:00:58 +0800
Message-ID: <00e62ae7e7764296023b34395e4d109139c10325.camel@mediatek.com>
Subject: Re: [PATCH v7 2/7] mtk-mdp: add driver to probe mdp components
From:   Yong Wu <yong.wu@mediatek.com>
To:     houlong wei <houlong.wei@mediatek.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Eizan Miyamoto <eizan@chromium.org>,
        "Hans Verkuil" <hverkuil@xs4all.nl>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        CK Hu =?UTF-8?Q?=28=E8=83=A1=E4=BF=8A=E5=85=89=29?= 
        <ck.hu@mediatek.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Yongqiang Niu =?UTF-8?Q?=28=E7=89=9B=E6=B0=B8=E5=BC=BA=29?= 
        <yongqiang.niu@mediatek.com>,
        Andrew-CT Chen =?UTF-8?Q?=28=E9=99=B3=E6=99=BA=E8=BF=AA=29?= 
        <Andrew-CT.Chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Minghsiu Tsai =?UTF-8?Q?=28=E8=94=A1=E6=98=8E=E4=BF=AE=29?= 
        <Minghsiu.Tsai@mediatek.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-media <linux-media@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Date:   Wed, 8 Dec 2021 10:00:54 +0800
In-Reply-To: <fc309940c9e59f80397b90c8b11424fea344e1b5.camel@mediatek.com>
References: <20210825063323.3607738-1-eizan@chromium.org>
         <20210825163247.v7.2.Ie6d1e6e39cf9b5d6b2108ae1096af34c3d55880b@changeid>
         <CAAEAJfDNDXdJFfB-bHhFcqnnKZ0TY--d_wLGddKRymQOLQY4TQ@mail.gmail.com>
         <fc309940c9e59f80397b90c8b11424fea344e1b5.camel@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIxLTA5LTA2IGF0IDAwOjIzICswODAwLCBob3Vsb25nIHdlaSB3cm90ZToNCj4g
SGkgRXplcXVpZWwsDQo+IA0KPiBUaGFuayB5b3UgZm9yIHlvdXIgYXR0ZW50aW9uIHRvIHRoaXMg
c2VyaWVzIG9mIHBhdGNoZXMuIEkgYW5zd2VyDQo+IHBhcnRpYWwgb2YgeW91ciBxdWVzdGlvbnMg
YmVsb3cuDQo+IFJlZ2FyZHMsDQo+IEhvdWxvbmcNCj4gDQo+IE9uIFNhdCwgMjAyMS0wOS0wNCBh
dCAyMDozNCArMDgwMCwgRXplcXVpZWwgR2FyY2lhIHdyb3RlOg0KPiA+IEhpIEVpemFuLA0KPiA+
IA0KPiA+IFNvcnJ5IGZvciBzZWVpbmcgdGhpcyBzZXJpZXMgc28gbGF0ZS4NCj4gPiANCj4gPiBP
biBXZWQsIDI1IEF1ZyAyMDIxIGF0IDAzOjM1LCBFaXphbiBNaXlhbW90byA8ZWl6YW5AY2hyb21p
dW0ub3JnPg0KPiA+IHdyb3RlOg0KPiA+ID4gDQo+ID4gPiBCcm9hZGx5LCB0aGlzIHBhdGNoICgx
KSBhZGRzIGEgZHJpdmVyIGZvciB2YXJpb3VzIE1USyBNRFANCj4gPiA+IGNvbXBvbmVudHMgdG8N
Cj4gPiA+IGdvIGFsb25nc2lkZSB0aGUgbWFpbiBNVEsgTURQIGRyaXZlciwgYW5kICgyKSBob29r
cyB0aGVtIGFsbA0KPiA+ID4gdG9nZXRoZXINCj4gPiA+IHVzaW5nIHRoZSBjb21wb25lbnQgZnJh
bWV3b3JrLg0KPiA+ID4gDQo+ID4gPiAoMSkgVXAgdW50aWwgbm93LCB0aGUgTVRLIE1EUCBkcml2
ZXIgY29udHJvbHMgOCBkZXZpY2VzIGluIHRoZQ0KPiA+ID4gZGV2aWNlDQo+ID4gPiB0cmVlIG9u
IGl0cyBvd24uIFdoZW4gcnVubmluZyB0ZXN0cyBmb3IgdGhlIGhhcmR3YXJlIHZpZGVvDQo+ID4g
PiBkZWNvZGVyLA0KPiA+ID4gd2UNCj4gPiA+IGZvdW5kIHRoYXQgdGhlIGlvbW11cyBhbmQgTEFS
QnMgd2VyZSBub3QgYmVpbmcgcHJvcGVybHkNCj4gPiA+IGNvbmZpZ3VyZWQuDQo+ID4gDQo+ID4g
V2h5IHdlcmUgbm90IGJlaW5nIHByb3Blcmx5IGNvbmZpZ3VyZWQ/IFdoYXQgd2FzIHRoZSBwcm9i
bGVtPw0KPiA+IFdoeSBub3QgZml4aW5nIHRoYXQgaW5zdGVhZD8NCj4gPiANCj4gPiBEb2VzIHRo
aXMgbWVhbiB0aGUgZHJpdmVyIGlzIGN1cnJlbnRseSBicm9rZW4gYW5kIHVudXNhYmxlPw0KPiAN
Cj4gVGhpcyBzZXJpZXMgb2YgcGF0Y2hlcyBhcmUgc3VwcGxlbWVudHMgdG8gYW5vdGhlciBzZXJp
ZXMsIHBsZWFzZQ0KPiByZWZlcg0KPiB0byAgDQo+IA0KaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVs
Lm9yZy9wcm9qZWN0L2xpbnV4LW1lZGlhdGVrL2xpc3QvP3Nlcmllcz01MTUxMjljDQo+ICwgd2hp
Y2ggYWRkIGRldmljZSBsaW5rIGJldHdlZW4gdGhlIG10ay1pb21tdSBjb25zdW1lciBhbmQgdGhl
IG10ay0NCj4gbGFyYiANCj4gZGV2aWNlcy4gV2l0aG91dCB0aGF0IHNlcmllcyBvZiBwYXRjaGVz
LCB0aGUgbXRrLW1kcCBkcml2ZXIgY2FuIHdvcmsNCj4gd2VsbCBzbyBmYXIuDQo+IEJ1dCB3aXRo
IHRoYXQgc2VyaWVzLCBpdCBzZWVtcyB0aGUgZGV2aWNlIGxpbmsgb25seSBjYW4gYmUNCj4gZXN0
YWJsaXNoZWQNCj4gZm9yIHRoZSBkZXZpY2Ugd2hpY2ggaXMgcmVnaXN0ZXJlZCBhcyBhIHBsYXRm
b3JtIGRyaXZlci4gVGhhdCdzIHdoeQ0KPiBFaXphbiBhZGRzIHRoaXMgc2VyaWVzIG9mIHBhdGNo
ZXMgdG8gbWFrZSBhbGwgbWRwIGNvbXBvbmVudHMgdG8gYmUNCj4gcmVnaXN0ZXJlZCBhcyBwbGF0
Zm9ybSBkcml2ZXJzLg0KDQpUaGUgbXQ4MTczIG1kcCBoYXMgc2V2ZXJhbCBkZXZpY2VzOg0KICAg
bWVkaWF0ZWssbXQ4MTczLW1kcC1yZG1hLCBtZWRpYXRlayxtdDgxNzMtbWRwICANCiAgIG1lZGlh
dGVrLG10ODE3My1tZHAtcnN6DQogICBtZWRpYXRlayxtdDgxNzMtbWRwLXdkbWENCiAgIG1lZGlh
dGVrLG10ODE3My1tZHAtd3JvdA0KDQpFeGNlcHQgdGhlIGZpcnN0IG9uZSwgdGhlIGxhc3QgdGhy
ZWUgZGV2aWNlcyBhcmUgbm90IHRoZSBzdGFuZGFyZA0KcGxhdGZvcm0gZGV2aWNlcy4gVGh1cywg
dGhleSBzaG91bGQgbm90IGJlIHRoZSBpb21tdSBjb25zdW1lciBkZXZpY2VzLg0KDQpRdWVzdGlv
biAxOiBUaGUgbGFzdCB0aHJlZSBkZXZpY2UgZG9uJ3Qgd29yayBhY3R1YWxseSBpbiBtdDgxNzMg
Y2hyb21lLA0KcmlnaHQ/IG9yIHRoZXkgYWNjZXNzIGNvbnRpbnVvdXMgYnVmZmVycz8NCg0KUXVl
c3Rpb24gMjogVGhlIElPTU1VIGRldmljZS1saW5rIHBhdGNoc2V0IGp1c3QgcmVwbGFjZXMgdGhl
IHBtIHJ1bnRpbWUNCmludGVyZmFjZXMuIEl0IGRvbid0IGltcHJvdmUgdGhlIG1kcCBmbG93LCBh
bHNvIHNob3VsZCBub3QgaW50cm9kdWNlDQpyZWdyZXNzaW9uLiB0aHVzLCBteSB2OCBkb24ndCBy
ZWJhc2UgdGhpcyBtZHAgcGF0Y2hlcy4gRG9lcyB0aGUgaW9tbXUNCnBhdGNoc2V0IGludHJvZHVj
ZSByZWdyZXNzaW9uIGZvciBtZHA/DQoNCkBFaXphbiwgQGhvdWxvbmcsIENvdWxkIHlvdSBoZWxw
IGNvbmZpcm0gdGhpcz8NClRoYW5rcy4NCg0KPiANCj4gPiANCj4gPiA+IFRvDQo+ID4gPiBjb25m
aWd1cmUgdGhlbSwgYSBkcml2ZXIgZm9yIGVhY2ggYmUgYWRkZWQgdG8gbXRrX21kcF9jb21wIHNv
DQo+ID4gPiB0aGF0DQo+ID4gPiBtdGtfaW9tbXVfYWRkX2RldmljZSgpIGNhbiAoZXZlbnR1YWxs
eSkgYmUgY2FsbGVkIGZyb20NCj4gPiA+IGRtYV9jb25maWd1cmUoKQ0KPiA+ID4gaW5zaWRlIHJl
YWxseV9wcm9iZSgpLg0KPiA+ID4gDQo+ID4gPiAoMikgVGhlIGludGVncmF0aW9uIGludG8gdGhl
IGNvbXBvbmVudCBmcmFtZXdvcmsgYWxsb3dzIHVzIHRvDQo+ID4gPiBkZWZlcg0KPiA+ID4gdGhl
DQo+ID4gPiByZWdpc3RyYXRpb24gd2l0aCB0aGUgdjRsMiBzdWJzeXN0ZW0gdW50aWwgYWxsIHRo
ZSBNRFAtcmVsYXRlZA0KPiA+ID4gZGV2aWNlcw0KPiA+ID4gaGF2ZSBiZWVuIHByb2JlZCwgc28g
dGhhdCB0aGUgcmVsZXZhbnQgZGV2aWNlIG5vZGUgZG9lcyBub3QNCj4gPiA+IGJlY29tZQ0KPiA+
ID4gYXZhaWxhYmxlIHVudGlsIGluaXRpYWxpemF0aW9uIG9mIGFsbCB0aGUgY29tcG9uZW50cyBp
cyBjb21wbGV0ZS4NCj4gPiA+IA0KPiA+ID4gU29tZSBub3RlcyBhYm91dCBob3cgdGhlIGNvbXBv
bmVudCBmcmFtZXdvcmsgaGFzIGJlZW4gaW50ZWdyYXRlZDoNCj4gPiA+IA0KPiA+ID4gLSBUaGUg
ZHJpdmVyIGZvciB0aGUgcmRtYTAgY29tcG9uZW50IHNlcnZlcyBkb3VibGUgZHV0eSBhcyB0aGUN
Cj4gPiA+ICJtYXN0ZXIiDQo+ID4gPiAgIChhZ2dyZWdhdGUpIGRyaXZlciBhcyB3ZWxsIGFzIGEg
Y29tcG9uZW50IGRyaXZlci4gVGhpcyBpcyBhDQo+ID4gPiBub24tDQo+ID4gPiBpZGVhbA0KPiA+
ID4gICBjb21wcm9taXNlIHVudGlsIGEgYmV0dGVyIHNvbHV0aW9uIGlzIGRldmVsb3BlZC4gVGhp
cyBkZXZpY2UgaXMNCj4gPiA+ICAgZGlmZmVyZW50aWF0ZWQgZnJvbSB0aGUgcmVzdCBieSBjaGVj
a2luZyBmb3IgYSAibWVkaWF0ZWssdnB1Ig0KPiA+ID4gcHJvcGVydHkNCj4gPiA+ICAgaW4gdGhl
IGRldmljZSBub2RlLg0KPiA+ID4gDQo+ID4gDQo+ID4gQXMgSSBoYXZlIHN0YXRlZCBpbiBZdW5m
ZWksIEkgYW0gbm90IGNvbnZpbmNlZCB5b3UgbmVlZCBhbiBhc3luYw0KPiA+IGZyYW1ld29yaw0K
PiA+IGF0IGFsbC4gSXQgc2VlbXMgYWxsIHRoZXNlIGRldmljZXMgY291bGQgaGF2ZSBiZWVuIGxp
bmtlZCB0b2dldGhlcg0KPiA+IGluIHRoZSBkZXZpY2UgdHJlZSwgYW5kIHRoZW4gaGF2ZSBhIG1h
c3RlciBkZXZpY2UgdG8gdGllIHRoZW0uDQo+ID4gDQo+ID4gSS5lLiBzb21ldGhpbmcgbGlrZQ0K
PiA+IA0KPiA+IG1kcCB7DQo+ID4gICBtZHBfcmRtYTAgew0KPiA+ICAgfQ0KPiA+ICAgbWRwX3Jz
ejAgew0KPiA+ICAgfQ0KPiA+ICAgbWRwX3JzejEgew0KPiA+ICAgfQ0KPiA+IH0NCj4gPiANCj4g
DQo+IFRoZSBjb21taXQgbWVzc2FnZSBvZiB0aGUgcGF0Y2ggYmVsb3cgZXhwbGFpbnMgdGhhdCAi
IElmIHRoZSBtZHBfKg0KPiBub2RlcyBhcmUgdW5kZXIgYW4gbWRwIHN1Yi1ub2RlLCB0aGVpciBj
b3JyZXNwb25kaW5nIHBsYXRmb3JtIGRldmljZQ0KPiBkb2VzIG5vdCBhdXRvbWF0aWNhbGx5IGdl
dCBpdHMgaW9tbXUgYXNzaWduZWQgcHJvcGVybHkuIg0KPiBQbGVhc2UgcmVmZXIgdG8gDQo+IA0K
aHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvc3RhYmxlL2xp
bnV4LmdpdC9jb21taXQvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxNzMuZHRzaT9o
PXY1LjE0LjEmaWQ9ODEyNzg4MWY3NDFkYmJmOWExZGE5ZTliYzU5MTMzODIwMTYwYjIxNw0KPiAN
CltzbmlwXQ0K

