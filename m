Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9A5B47FBDE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 11:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236115AbhL0KjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 05:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236006AbhL0KjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 05:39:13 -0500
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC8AC061401
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 02:39:13 -0800 (PST)
Received: from [10.0.28.181] (cust-13-241-108-94.dyn.as47377.net [94.108.241.13])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id AC74F2886DF;
        Mon, 27 Dec 2021 11:39:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1640601551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wq7sdb7qma6R/oPcxN9dHn9j7pVXZHtAxjglmPoi05w=;
        b=KfbgmS4qCWMsDONcQHMCCYRoQ0RMMgD64+vBFDLemimWJ9RzkTbQpUCZuCxqmpj4XnTLb6
        K6yit0Qq3nW3f5BUf8iniBDQsIhd9010oq6D00OyeQwqDqCl7NZkJ0doqkycgZQwK/ciHO
        YM/TVyfkKZq86+B/fHsQ5EY6DQ4W1+Ae8cA91tAfGaFIpNbTnuf18Zi5LIp4EnsbkHM7nx
        QKGBARJNw6MjOptocAxzIEE1wvUgSv7QCIZqKkfIwWEuo5pNC3sIWIe0x26SO8JDDTe+rl
        mEU+6jkB1iFhTVjiwePamR3ns8p14+Dr70R5IEH3A/ZyLpRwQbQc/e9Wsfukpw==
From:   Sander Vanheule <sander@svanheule.net>
X-Priority: 3
To:     tglx@linutronix.de, maz@kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, mail@birger-koblitz.de
Cc:     linux-kernel@vger.kernel.org, bert@biot.com, john@phrozen.org
Subject: Re: [RFC PATCH v2 0/5] Rework realtek-rtl IRQ driver
In-Reply-To: <90a3ce57-875f-d34a-0714-f815acae12d4@birger-koblitz.de>
References: <cover.1640548009.git.sander@svanheule.net>
 <90a3ce57-875f-d34a-0714-f815acae12d4@birger-koblitz.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Date:   Mon, 27 Dec 2021 10:39:10 +0000
Message-ID: <bvv98e.r4rs9b.2rw3hx-qmf@polaris.svanheule.net>
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQmlyZ2VyLA0KDQpPbiBNb25kYXksIDI3IERlY2VtYmVyIDIwMjEsIEJpcmdlciBLb2JsaXR6
IHdyb3RlOg0KPiBIaSwNCj4gDQo+IEkgZG9uJ3QgdGhpbmsgdGhlIElSUSByb3V0aW5nIGhhcyBh
biBvZmYtYnkgb25lIGVycm9yLiBUaGlzIHdhcyBjaG9zZW4NCj4gYnkgSm9obiB0byBjb3JyZXNw
b25kIHRvIFJlYWx0ZWsncyBvd24gImRvY3VtZW50YXRpb24iIGFuZCB0bw0KPiB0YWtlIGFjY291
bnQgb2YgdGhlIHNwZWNpYWwgbWVhbmluZyBvZiBJUlFzIDAsIDEgZm9yIFZTTVAgYW5kIDYgYW5k
IDcNCj4gZm9yIHRoZSBSZWFsdGVrIFNvQ3MuIEluIGFueSBjYXNlIGl0IHdvdWxkIGJyZWFrIHRo
ZSBBQkkgYXMgdGhlIG1lYW5pbmcNCj4gb2YgdGhlc2UgdmFsdWVzIGNoYW5nZXMgYW5kIEkgZG9u
J3QgdGhpbmsgdGhlIGNoYW5nZSBpbiByYW5nZSBhY3R1YWxseQ0KPiBnaXZlcyBhbnkgYWRkaXRp
b25hbCBmdW5jdGlvbmFsaXR5Lg0KDQpSZWFsdGVrJ3MgU0RLIHByb3ZpZGVzIHJvdXRpbmcgcmVn
aXN0ZXIgdmFsdWVzLiBJIHdvdWxkIGhhdmUgdG8gY2hlY2sgdG8gc2VlIHdoYXQgQ1BVIElSUXMg
aXQgdGhlbiBiaW5kcyB0bywgdG8gc2VydmljZSB0aG9zZSBpbnRlcnJ1cHRzLiBUaGUgYmluZGlu
ZyB3b3VsZG4ndCBoYXZlIHRvIGNoYW5nZSwgYnV0IHdlIGNvdWxkIGZpeCB0aGUgZHJpdmVyIGFu
ZCBkZXZpY2V0cmVlcy4NCg0KVGhlIGJpbmRpbmcgc3BlY2lmaWVzIHRoYXQgaW50ZXJydXB0LW1h
cCBwcm92aWRlcyBhIG1hcHBpbmcgb2YgaW50ZXJydXB0IGlucHV0cyB0byBwYXJlbnQgaW50ZXJy
dXB0LiBUaGUgZHJpdmVyIHRoZW4gdGFrZXMgdGhlc2UgdmFsdWVzLCBidXQgZG9lc24ndCBjaGVj
ayB3aGF0IHRoZSBwYXJlbnQgaW50ZXJydXB0IGNvbnRyb2xsZXIgYWN0dWFsbHkgaXMsIGFuZCBm
aW5hbGx5IGFzc2lnbnMgYSBjaGFpbmVkIGhhbmRsZXIgdG8gYSBoYXJkd2FyZSBJUlEgaW5kZXgg
KGluc3RlYWQgb2YgYSBWSVJRKS4NCg0KWW91IGNhbiB0cnkgbGltaXRpbmcgdGhlIGludGVycnVw
dC1tYXAgdG8gb25seSB0aGUgbWFwcGluZyBmb3IgVUFSVDAgd2l0aCB0aGUgY3VycmVudCBkcml2
ZXIsIGFuZCB5b3Ugd2lsbCBmaW5kIHRoYXQgeW91IGVuZCB1cCB3aXRoIGEgYnJva2VuIHN5c3Rl
bS4NCg0KQ1BVIElSUXMgMCBhbmQgMSBhcmUgaW5kZWVkIHNwZWNpYWwgKElQSSBmb3IgVlNNUCks
IHlldCB3ZSBoYXZlIGludGVycnVwdCBtYXBwaW5ncyB0aGF0IGNvbnRhaW4gPC4uLiAmY3B1aW50
YyAxPi4gRnVydGhlcm1vcmUsIGlmIHlvdSBzcGVjaWZ5IGEgbWFwcGluZyBvZiA8Li4uICZjcHVp
bnQgNj4gZm9yIGFuIGFjdGl2ZSBpbnRlcnJ1cHQgc291cmNlLCB5b3Ugd2lsbCBnZXQgc3B1cmlv
dXMgdGltZXIgKENQVSBJUlEgNykgaW50ZXJydXB0cy4gVGhpcyBjYW4ndCBiZSBjb3JyZWN0LiAN
CiANCj4gV2l0aCByZWdhcmRzIHRvIHRoZSBSVEw4MzkwLCB0aGF0IFNvQyBhY3R1YWxseSBoYXMg
dHdvIElSUSBjb250cm9sbGVycw0KPiB0byBhbGxvdyBWU01QLiBUaGUgY2hhbmdlcyBpbiBwYXJl
bnQgcm91dGluZyBoYXZlIGEgZ29vZCBjaGFuY2Ugb2YgYnJlYWtpbmcNCj4gVlNNUCBvbiB0aGUg
UlRMODM5MCB0YXJnZXRzLiBEaWQgeW91IHN0cmVzcyB0ZXN0IHRoaXMgbmV3IGxvZ2ljIHVuZGVy
IFZTTVA/DQoNCkkgaGF2ZW4ndCB0ZXN0ZWQgdGhpcyB3aXRoIFZTTVAsIGJlY2F1c2UgaXQgaXMg
b3V0IG9mIHNjb3BlIGZvciB0aGlzIHNlcmllcy4gRm9yIHRoZSBiaW5kaW5nLCBJIGV4cGVjdCB0
aGF0IHdvdWxkIG9ubHkgcmVxdWlyZSBOIHJlZ2lzdGVyIHJhbmdlcyBpbnN0ZWFkIG9mIG9uZTsg
b25lIHBlciBDUFUuIEkgdGhpbmsgdGhlIGRyaXZlciBzaG91bGQgdGhlbiBiZSBhYmxlIHRvIHBl
cmZvcm0gdGhlIElSUSBiYWxhbmNpbmcgYmFzZWQgb24gdGhhdCBpbmZvcm1hdGlvbiBhbG9uZSwg
Z2l2ZW4gdGhhdCB0aGUgcGFyZW50IElSUXMgYXJlIGF2YWlsYWJsZSBhdCBlYWNoIENQVS4NCg0K
QmVzdCwNClNhbmRlcg==
