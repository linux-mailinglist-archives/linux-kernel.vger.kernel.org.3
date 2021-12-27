Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3646E47FBC9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 11:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235945AbhL0KPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 05:15:45 -0500
Received: from polaris.svanheule.net ([84.16.241.116]:50530 "EHLO
        polaris.svanheule.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235931AbhL0KPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 05:15:45 -0500
Received: from [10.0.28.181] (cust-13-241-108-94.dyn.as47377.net [94.108.241.13])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 43EAF2886BF;
        Mon, 27 Dec 2021 11:15:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1640600143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XQ++rAypcF3cqGDp+CkRP6VSaTvtTw7bDNf/Cjh12yQ=;
        b=M2Zz/YvhlPTKQhifSHslqT3njncTkVqBXJfMlyj8OJuIqEkdOR7KqzzsvZc7UZEjg4Hg+h
        GQk1b0xP6xA+3/+a/DzBVqg1TKlF+0Ezc3I0bSK/73aBsi5VHNYr989Xwdfr1HAMK1HC3A
        i4N+SdqVMCD9GP/jAKtpw9OAghAKLPmHpMoHCxoWvJu/Q1ANKUmLYXxZxvB48JhozlU0sQ
        nA9BhUF6uy3+DD4kmGIzXtJZUlwxuWLrqX5E/DsG4rQapNHEHJCNNqGx9pjAJAMVRXT/hF
        ZeqVVw1s0A1HLnYGtzShTl7JKr391m+TPmYiRCP85XD+F7rgc2Me+IlgE2KjwQ==
X-Priority: 3
To:     maz@kernel.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        mail@birger-koblitz.de, bert@biot.com, john@phrozen.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
From:   Sander Vanheule <sander@svanheule.net>
Subject: Re: [RFC PATCH v1 3/4] dt-bindings: interrupt-controller:
 realtek,rtl-intc: replace irq mapping
In-Reply-To: <87v8zaz7ml.wl-maz@kernel.org>
References: <cover.1640261161.git.sander@svanheule.net>
        <8a5931f18a6f1c92f8c8e4965dc65674d7e5a4c4.1640261161.git.sander@svanheule.net>  <87y24byzej.wl-maz@kernel.org>  <add13702d89fdad4ae7a479c0894aaa3be794087.camel@svanheule.net> <87v8zaz7ml.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Date:   Mon, 27 Dec 2021 10:15:41 +0000
Message-ID: <ofvekt.r4rr67.2rw3hx-qmf@polaris.svanheule.net>
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFyYywNCg0KT24gTW9uZGF5LCAyNyBEZWNlbWJlciAyMDIxLCBNYXJjIFp5bmdpZXIgd3Jv
dGU6DQo+IE9uIFRodSwgMjMgRGVjIDIwMjEgMTk6Mjk6MjMgKzAwMDAsDQo+IFNhbmRlciBWYW5o
ZXVsZSA8c2FuZGVyQHN2YW5oZXVsZS5uZXQ+IHdyb3RlOg0KPiA+IA0KPiA+IE9uIFRodSwgMjAy
MS0xMi0yMyBhdCAxODowMCArMDAwMCwgTWFyYyBaeW5naWVyIHdyb3RlOg0KPiA+ID4gT24gVGh1
LCAyMyBEZWMgMjAyMSAxMjowODozMyArMDAwMCwNCj4gPiA+IFNhbmRlciBWYW5oZXVsZSA8c2Fu
ZGVyQHN2YW5oZXVsZS5uZXQ+IHdyb3RlOg0KPiA+ID4gPiANCj4gPiA+ID4gVGhlIGJpbmRpbmcg
aW5jb3JyZWN0bHkgc3BlY2lmaWVkIHRoZSAiaW50ZXJydXB0LW1hcCIgcHJvcGVydHkgc2hvdWxk
IGJlDQo+ID4gPiA+IHVzZWQsIGFsdGhvdWdoIHRoZSB1c2UgaXMgbm9uLXN0YW5kYXJkLiBBIHF1
aXJrIGhhZCB0byBiZSBpbnRyb2R1Y2VkIGluDQo+ID4gPiA+IGNvbW1pdCBkZTRhZGRkY2JjYzIg
KCJvZi9pcnE6IEFkZCBhIHF1aXJrIGZvciBjb250cm9sbGVycyB3aXRoIHRoZWlyIG93bg0KPiA+
ID4gPiBkZWZpbml0aW9uIG9mIGludGVycnVwdC1tYXAiKSB0byBhbGxvdyB0aGUgZHJpdmVyIHRv
IGZ1bmN0aW9uIGFnYWluLg0KPiA+ID4gDQo+ID4gPiBUaGF0J3MgdG9vIGxhdGUuIFdlIGhhdmUg
cmVsZWFzZWQgYSBrZXJuZWwgd2l0aCB0aGlzIGJpbmRpbmcsIGFuZCBpdA0KPiA+ID4gd2lsbCBs
aXZlIG9uIGZvcmV2ZXIgdW50aWwgd2UgdG90YWxseSByZW1vdmUgdGhlIHBsYXRmb3JtIGZyb20g
dGhlDQo+ID4gPiB0cmVlLg0KPiA+ID4gDQo+ID4gPiBEVCBpcyBhbiBBQkksIGFuZCBvbmx5IHRp
bWUgdHJhdmVsIGNhbiBmaXggdGhpcyBibHVuZGVyLg0KPiA+IA0KPiA+IFRha2luZyBpbnRvIGFj
Y291bnQgeW91ciBjb21tZW50cyBvbiB0aGUgcHJldmlvdXMgcGF0Y2gsIHRoaXMgY2hhbmdlDQo+
ID4gd291bGRuJ3QgZXZlbiBiZSByZXF1aXJlZCBpZiBJIGNvcnJlY3QgdGhlIG1hcHBpbmdzIGZv
ciBteQ0KPiA+IGRldmljZXMuIEJ1dCB0aGF0IHdvdWxkbid0IGdldCByaWQgb2YgdGhlIGFzc3Vt
ZWQgbWFwcGluZyBiZXR3ZWVuDQo+ID4gb3V0cHV0IGxpbmVzIGFuZCBwYXJlbnQgaW50ZXJydXB0
cy4NCj4gDQo+IEEgZHJpdmVyIGNhbiBhbHdheXMgaWdub3JlIHNvbWUgaW5mb3JtYXRpb24gZnJv
bSB0aGUgRFQgYW5kIGRvIGl0cyBvd24NCj4gdGhpbmcuIE5vIHN1cmUgaWYgdGhhdCBhZGRyZXNz
ZXMgeW91ciBwcm9ibGVtIHRob3VnaC4NCj4gDQo+ID4gDQo+ID4gVG8gd2hhdCBleHRlbnQgY2Fu
IHRoZSBiaW5kaW5nIGJlIHVwZGF0ZWQgdG8gZ2V0IHJpZCBvZiB0aGlzDQo+ID4gYXNzdW1wdGlv
bj8gT3Igd291bGQgdGhhdCByZXF1aXJlIGEgY29tcGxldGVseSBuZXcgYmluZGluZz8NCj4gDQo+
IFlvdSBjYW4gb25seSBleHRlbmQgYSBiaW5kaW5nIGluIGEgdHdvLXdheSBmYXNoaW9uOiBvbGQg
a2VybmVsIHdvcmtzDQo+IHdpdGggbmV3IERULCBuZXcga2VybmVsIHdvcmtzIG9sZCBEVC4gV2hp
Y2ggbWVhbnMgdGhhdCBpbiBwcmFjdGljZSwNCj4geW91IGNhbiBvbmx5ICphZGQqIGluZm9ybWF0
aW9uIHRvIHRoZSBEVCwgYW5kIGhhdmUgcmVhc29uYWJsZSBkZWZhdWx0cw0KPiBpbiB0aGUgZHJp
dmVyIHdoZW4geW91IGRvbid0IGZpbmQgaXQuDQoNClRoYW5rcyBmb3IgY2xhcmlmeWluZy4gSW4g
dGhhdCBjYXNlIEkgZG9uJ3QgdGhpbmsgaXQgaXMgcG9zc2libGUgdG8gZ2V0IHJpZCBvZiB0aGUg
b3V0cHV0LXRvLXBhcmVudCBhc3N1bXB0aW9uIGVudGlyZWx5LCBzaW5jZSB0aGUgZHJpdmVyIHdv
dWxkIGFsd2F5cyBuZWVkIHRvIGFjY29tbW9kYXRlIGZvciB0aGUgb3JpZ2luYWwgYmluZGluZywg
d2hlcmUgdGhlcmUgaXMgbm8gb3V0cHV0IG1hcHBpbmcgc3BlY2lmaWVkIGluIHRoZSBiaW5kaW5n
LiBUaGVyZSBhcmUgbm8gU29DLXNwZWNpZmljIGNvbXBhdGlibGVzICh3aGVyZSBhIG1hcHBpbmcg
Y291bGQgYmUgYXNzdW1lZCksIGFuZCBJIGRvbid0IGtub3cgb24gaG93IG1hbnkgTUlQUyBwbGF0
Zm9ybXMgUmVhbHRlayBoYXMgdXNlZCB0aGlzIGludGVycnVwdCByb3V0ZXIvY29udHJvbGxlci4N
Cg0KSSBkb24ndCBoYXZlIG11Y2ggdGltZSBhbnltb3JlIHRvZGF5LCBidXQgSSdsbCBicmVhayBt
eSBoZWFkIG92ZXIgaXQgYWdhaW4gdG9tb3Jyb3cuDQoNCkJlc3QsDQpTYW5kZXI=
