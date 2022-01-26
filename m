Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F27549CCB4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 15:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242357AbiAZOvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 09:51:41 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:34224 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235611AbiAZOvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 09:51:38 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B8E1D1F3B3;
        Wed, 26 Jan 2022 14:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643208696; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CvZQ8ZBuvPur20kE+KlEBcczgw/C67h6xQ0fSxjlVqQ=;
        b=aIQI8E2KmmPrqyI90nc5P8bnNxIB8VfGQaacH7D5ySrB59r3RsvoLPbOSjJdidku2NJEht
        a8tMrOIB7TZh5rQ5J7g3+7EF9Nn3thydR81Atn/AVGm0t9uUevtr6uqpBWYX78zGpL4SG5
        ZK9U0cVvJLSAALnTl1ZHmm1qtHbaTZY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 93C6F13A67;
        Wed, 26 Jan 2022 14:51:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BVKaIvhf8WGyCwAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 26 Jan 2022 14:51:36 +0000
Message-ID: <70245998-b99e-ebe7-e932-f8a1b46f6ac7@suse.com>
Date:   Wed, 26 Jan 2022 15:51:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Content-Language: en-US
To:     minyard@acm.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220125182737.GO34919@minyard.net>
 <4609fe56-7d88-8176-a378-0f465670b37d@suse.com>
 <20220126135639.GS34919@minyard.net>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: Possible reproduction of CSD locking issue
In-Reply-To: <20220126135639.GS34919@minyard.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------ysBIyo7RHfsioKjgd0ok4qJ1"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------ysBIyo7RHfsioKjgd0ok4qJ1
Content-Type: multipart/mixed; boundary="------------9UOFRG9zt3gAJLCOIPLXTMAq";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: minyard@acm.org
Cc: Ingo Molnar <mingo@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Message-ID: <70245998-b99e-ebe7-e932-f8a1b46f6ac7@suse.com>
Subject: Re: Possible reproduction of CSD locking issue
References: <20220125182737.GO34919@minyard.net>
 <4609fe56-7d88-8176-a378-0f465670b37d@suse.com>
 <20220126135639.GS34919@minyard.net>
In-Reply-To: <20220126135639.GS34919@minyard.net>

--------------9UOFRG9zt3gAJLCOIPLXTMAq
Content-Type: multipart/mixed; boundary="------------iwrbvJz4BUb38090BFGzVGaJ"

--------------iwrbvJz4BUb38090BFGzVGaJ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjYuMDEuMjIgMTQ6NTYsIENvcmV5IE1pbnlhcmQgd3JvdGU6DQo+IE9uIFdlZCwgSmFu
IDI2LCAyMDIyIGF0IDA3OjA4OjIyQU0gKzAxMDAsIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+
PiBPbiAyNS4wMS4yMiAxOToyNywgQ29yZXkgTWlueWFyZCB3cm90ZToNCj4+PiBXZSBoYXZl
IGEgY3VzdG9tZXIgdGhhdCBoYWQgYmVlbiBzZWVpbmcgQ1NEIGxvY2sgaXNzdWVzIG9uIGEg
Q2VudG9zIDcNCj4+PiBrZXJuZWwgKHVuZm9ydHVuYXRlbHkpLiAgSSBjb3VsZG4ndCBmaW5k
IGFueXRoaW5nIG9yIGFueSBrZXJuZWwgY2hhbmdlcw0KPj4+IHRoYXQgbWlnaHQgZml4IGl0
LCBzbyBJIHdhcyBjb25zZGVyaW5nIGl0IHdhcyB0aGUgQ1NEIGxvY2tpbmcgaXNzdWUgeW91
DQo+Pj4gaGF2ZSBiZWVuIGNoYXNpbmcgZm9yIGEgd2hpbGUuDQo+Pg0KPj4gSXMgdGhpcyBv
biBiYXJlIG1ldGFsIG9yIGluIGEgdmlydHVhbGl6ZWQgZW52aXJvbm1lbnQ/DQo+IA0KPiBU
aGlzIGlzIGJhcmUgbWV0YWwuDQo+IA0KPiBJIGRvIHRoaW5rIEkga25vdyB3aGF0IGhhcHBl
bmVkLiAgSGVyZSdzIG15IGFuYWx5c2lzLi4uDQo+IA0KPiBjc2Q6IERldGVjdGVkIG5vbi1y
ZXNwb25zaXZlIENTRCBsb2NrICgjMSkgb24gQ1BVIzMsIHdhaXRpbmcgNTAwMDAwMDA0MiBu
cyBmb3IgQ1BVIzU1IGZsdXNoX3RsYl9mdW5jKzB4MC8weGIwKDB4ZmZmZjhlMGIzZTJhZmJl
OCkuDQo+ICAgY3NkOiBDU0QgbG9jayAoIzEpIHVucmVzcG9uc2l2ZS4NCj4gICBjc2Q6IGNu
dCgwMDAwMDAwKTogMDAwMC0+MDAwMCBxdWV1ZQ0KPiAgIGNzZDogY250KDAwMDAwMDEpOiBm
ZmZmLT4wMDM3IGlkbGUNCj4gDQo+IFRoZSBhYm92ZSBtZWFucyB0aGF0IHRoZXNlIGV2ZW50
cyB3ZXJlbid0IHNlZW4sIEkgdGhpbmsuICBXZSBjYW4NCj4gaWdub3JlIHRoZW0gaW4gYW55
IGNhc2UuDQo+IA0KPiAgIGNzZDogY250KDYzZDhkZDgpOiAwMDAzLT4wMDM3IGlwaQ0KPiAg
IGNzZDogY250KDYzZDhkZDkpOiAwMDAzLT4wMDM3IHBpbmcNCj4gICBjc2Q6IGNudCg2M2Q4
ZGRhKTogMDAwMy0+ZmZmZiBwaW5nZWQNCj4gDQo+IFRoaXMgaXMgYSBsaXR0bGUgY29uZnVz
aW5nLiAgVGhlIGZpcnN0IHR3byBsaW5lcyBoYXZlIHRvIGJlIGZyb20NCj4gX19zbXBfY2Fs
bF9zaW5nbGVfcXVldWVfZGVidWcuICBUaGUgbGFzdCBsaW5lIGhhcyB0byBiZSBmcm9tDQo+
IHNtcF9jYWxsX2Z1bmN0aW9uX21hbnkuICBCdXQgeW91IG5ldmVyIHNlZSB0aGUgcGluZ2Vk
IGZyb20NCj4gX19zbXBfY2FsbF9zaW5nbGVfcXVldWVfZGVidWcuDQoNCkJlIGNhcmVmdWwg
aGVyZS4gRm9yIGVhY2ggZXZlbnQtdHlwZS9jcHUgY29tYmluYXRpb24gdGhlcmUgaXMgb25s
eSBvbmUNCmVudHJ5IHNhdmVkLiBJdCBpcyBzdGlsbCBwb3NzaWJsZSB0byBzZWUgc29tZSBl
dmVudHMgbW9yZSB0aGFuIG9uY2UsDQphcyBlYWNoIGVudHJ5IGhvbGRzIGluZm9ybWF0aW9u
IG9mIHR3byBldmVudHMgKHRoZSBsb2NhdGlvbiBfd2hlcmVfDQp0aGUgZW50cnkgaXMgc3Rv
cmVkIGlzIGRldGVybWluaW5nIHdoYXQganVzdCBoYXBwZW5lZCwgYW5kIHRoZSBfZGF0YV8N
CnN0b3JlZCBhdCB0aGlzIHBvc2l0aW9uIHRlbGxzIHVzIHdoYXQgaGFwcGVuZWQgb25lIGV2
ZW50IGJlZm9yZSB0aGF0KS4NCg0KU28gYW55ICJtaXNzaW5nIiBlbnRyeSB3aGljaCB0eXBl
L2NwdSBjb21iaW5hdGlvbiBpcyBzZWVuIGZ1cnRoZXIgZG93bg0KaW4gdGhlIHRyYWNlIF9t
aWdodF8gYmUganVzdCBvdmVyd3JpdHRlbiBieSB0aGUgbGF0ZXIgZW50cnkuDQoNCkkndmUg
dXNlZCB0aGlzIHNjaGVtZSBpbnN0ZWFkIG9mIHNpbXBsZSB0cmFjZSBidWZmZXJzIGFzIG9u
IGEgbGFyZ2UNCnN5c3RlbSBhbnkgYnVmZmVyIHdvdWxkIGJlIG92ZXJ3cml0dGVuIG11bHRp
cGxlIHRpbWVzIGJlZm9yZSB0aGUgQ1NEDQp0aW1lb3V0IGlzIG92ZXIuIFRoaXMgd2F5IGF0
IGxlYXN0IHRoZSB0cmFjZSBlbnRyaWVzIG9mIHRoZSBjcHVzDQpoYXZpbmcgcHJvYmxlbXMg
KHRoZSBzZW5kZXIgYW5kL29yIHRoZSByZWNlaXZlcikgYXJlIHN0aWxsIGF2YWlsYWJsZS4N
Cg0KQWZ0ZXIgaGF2aW5nIGZvdW5kIGEgbG9jYWwgcmVwcm9kdWNlciBmb3IgbXkgcHJvYmxl
bSBJIGNvdWxkIGVuaGFuY2UNCnRoZSBwYXRjaGVzIGJ5IHVzaW5nIHNtYWxsIGFycmF5cyBp
bnN0ZWFkIG9mIHNpbmdsZSBlbnRyaWVzIGZvciBlYWNoDQp0cmFjZSBlbnRyeSBsb2NhdGlv
biwgcHJvZHVjaW5nIGJldHRlciB0cmFjZXMgd2l0aCBsZXNzICJtaXNzaW5nIg0KZW50cmll
cy4gSSBkaWRuJ3QgcG9zdCB0aG9zZSBwYXRjaGVzLCBhcyB0aGV5IHdlcmUgaGVhdmlseQ0K
aW50ZXJ0d2luZWQgd2l0aCBoeXBlcnZpc29yIHBhdGNoZXMgZm9yIHByb2R1Y2luZyB0cmFj
ZXMgY292ZXJpbmcNCmJvdGgsIGtlcm5lbCBhbmQgaHlwZXJ2aXNvciBldmVudHMuDQoNCj4g
DQo+ICAgY3NkOiBjbnQoNjNkOGRlYSk6IDAwMzUtPjAwMzcgcGluZ2VkDQo+IA0KPiBUaGUg
dGFpbCBvZiBDUFUgNTMgc2VuZGluZyBhbiBJUEkgdG8gQ1BVIDU1IGluDQo+IF9fc21wX2Nh
bGxfc2luZ2xlX3F1ZXVlX2RlYnVnLg0KPiANCj4gICBjc2Q6IGNudCg2M2Q4ZGViKTogZmZm
Zi0+MDAzNyBnb3RpcGkNCj4gICBjc2Q6IGNudCg2M2Q4ZGVjKTogZmZmZi0+MDAzNyBoYW5k
bGUNCj4gICBjc2Q6IGNudCg2M2Q4ZGVkKTogZmZmZi0+MDAzNyBkZXF1ZXVlIChzcmMgQ1BV
IDAgPT0gZW1wdHkpDQo+ICAgY3NkOiBjbnQoNjNkOGRlZSk6IGZmZmYtPjAwMzcgaGRsZW5k
IChzcmMgQ1BVIDAgPT0gZWFybHkpDQo+IA0KPiBDUFUgNTUgaXMgaGFuZGxpbmcgdGhlIElQ
SShzKSBpdCB3YXMgc2VudCBlYXJsaWVyLg0KDQpSaWdodC4gRXZlcnl0aGluZyB1cCB0byBo
ZXJlIGlzIGNvbXBsZXRlbHkgZmluZSBhbmQgY2FuIGJlIGlnbm9yZWQuDQoNCj4gDQo+ICAg
Y3NkOiBjbnQoNjNkOGUxZik6IDAwMDMtPjAwMzcgcXVldWUNCj4gICBjc2Q6IGNudCg2M2Q4
ZTIwKTogMDAwMy0+MDAzNyBpcGkNCj4gICBjc2Q6IGNudCg2M2Q4ZTIxKTogMDAwMy0+MDAz
NyBwaW5nDQo+IA0KPiBJbiBfX3NtcF9jYWxsX3NpbmdsZV9xdWV1ZV9kZWJ1ZyBDUFUgMyBz
ZW5kcyBhbm90aGVyIG1lc3NhZ2UgdG8NCj4gQ1BVIDU1IGFuZCBzZW5kcyBhbiBJUEkuICBC
dXQgdGhlcmUgc2hvdWxkIGJlIGEgcGluZ2VkIGVudHJ5DQo+IGFmdGVyIHRoaXMuDQo+IA0K
PiAgIGNzZDogY250KDYzZDhlMjIpOiAwMDAzLT4wMDM3IHF1ZXVlDQo+ICAgY3NkOiBjbnQo
NjNkOGUyMyk6IDAwMDMtPjAwMzcgbm9pcGkNCg0KVGhpcyBpcyBpbnRlcmVzdGluZy4gVGhv
c2UgYXJlIDUgY29uc2VjdXRpdmUgZW50cmllcyB3aXRob3V0IGFueQ0KbWlzc2luZyBpbiBi
ZXR3ZWVuIChzZWUgdGhlIGNvdW50ZXIgdmFsdWVzKS4gQ291bGQgaXQgYmUgdGhhdCBhZnRl
cg0KdGhlIHBpbmcgdGhlcmUgd2FzIGFuIGludGVycnVwdCBhbmQgdGhlIGNvZGUgd2FzIHJl
LWVudGVyZWQgZm9yDQpzZW5kaW5nIGFub3RoZXIgSVBJPyBUaGlzIHdvdWxkIGNsZWFybHkg
cmVzdWx0IGluIGEgaGFuZyBhcyBzZWVuLg0KDQoNCkp1ZXJnZW4NCg==
--------------iwrbvJz4BUb38090BFGzVGaJ
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------iwrbvJz4BUb38090BFGzVGaJ--

--------------9UOFRG9zt3gAJLCOIPLXTMAq--

--------------ysBIyo7RHfsioKjgd0ok4qJ1
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmHxX/gFAwAAAAAACgkQsN6d1ii/Ey8Z
Iwf9Ef5NmN/r7jcArTfLwHKQAbVjqiSLFNl4v8w2i87W522pM2HblYUVGboHwz/RLrat6diOYKuj
7tfQbSRNxraYXbqL70l2nqTE2KBZOa4in8HtiQ/AEkIfBTkpg6nMUTVpjB5W3RpE2ZSqOYgmbbTB
VsN1TFTIfC6Gbbk5Uzm41E4bKirZXZcN1l/wR1mQCATPbmgKiRl88lsXMj1WYJiwE6WiZXzyMe0S
bsNrmRJy4tyQrEi0+szgZErxEttLcuUIh+aRzEF7V9bOpKjWMKsRLqSATMkseyPSev7mw4d5DHv3
mWVSQy1K4Asz8vdf+WUxd/ZTHDmSBkbOEuULrit//A==
=ZGLv
-----END PGP SIGNATURE-----

--------------ysBIyo7RHfsioKjgd0ok4qJ1--
