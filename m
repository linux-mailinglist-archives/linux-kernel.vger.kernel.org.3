Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D544249CE90
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 16:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239133AbiAZPeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 10:34:18 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:41612 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiAZPeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 10:34:16 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 43A4A21135;
        Wed, 26 Jan 2022 15:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643211255; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1jZs20RGCJa9pVS6y6Z0Y/xifC1MB/foIDCxFxd9Cjw=;
        b=BGxiJyDM+TzAMOHfH12pNQm/5xJahg5YpswEs3SWZiUauRMdVfe61gNSK/10uH1ar8an2a
        1c7msSknt8oRfU6LFigcICq3EboYfHRnfH3Wu/npb4BX9vRf7WF9vn2eSNlDTmCoxAqMEj
        R4iOoQKvWU0XFF+O72tGsiAF8eaXb0Q=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 195CF13DFC;
        Wed, 26 Jan 2022 15:34:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Ixi2A/dp8WGBJAAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 26 Jan 2022 15:34:15 +0000
Message-ID: <4ada030a-55bc-31fc-bda0-8d1c4dc8546b@suse.com>
Date:   Wed, 26 Jan 2022 16:34:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: Possible reproduction of CSD locking issue
Content-Language: en-US
To:     minyard@acm.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220125182737.GO34919@minyard.net>
 <4609fe56-7d88-8176-a378-0f465670b37d@suse.com>
 <20220126135639.GS34919@minyard.net>
 <70245998-b99e-ebe7-e932-f8a1b46f6ac7@suse.com>
 <20220126153117.GU34919@minyard.net>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <20220126153117.GU34919@minyard.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------0lvEI0TcZDUc406Sn004uNqP"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------0lvEI0TcZDUc406Sn004uNqP
Content-Type: multipart/mixed; boundary="------------hVKBS4b7N0g2X96dNG8Wik1y";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: minyard@acm.org
Cc: Ingo Molnar <mingo@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Message-ID: <4ada030a-55bc-31fc-bda0-8d1c4dc8546b@suse.com>
Subject: Re: Possible reproduction of CSD locking issue
References: <20220125182737.GO34919@minyard.net>
 <4609fe56-7d88-8176-a378-0f465670b37d@suse.com>
 <20220126135639.GS34919@minyard.net>
 <70245998-b99e-ebe7-e932-f8a1b46f6ac7@suse.com>
 <20220126153117.GU34919@minyard.net>
In-Reply-To: <20220126153117.GU34919@minyard.net>

--------------hVKBS4b7N0g2X96dNG8Wik1y
Content-Type: multipart/mixed; boundary="------------Bq6P7ADTMO6oUm2LMFZJbBVF"

--------------Bq6P7ADTMO6oUm2LMFZJbBVF
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjYuMDEuMjIgMTY6MzEsIENvcmV5IE1pbnlhcmQgd3JvdGU6DQo+IE9uIFdlZCwgSmFu
IDI2LCAyMDIyIGF0IDAzOjUxOjM2UE0gKzAxMDAsIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+
PiBPbiAyNi4wMS4yMiAxNDo1NiwgQ29yZXkgTWlueWFyZCB3cm90ZToNCj4+PiBPbiBXZWQs
IEphbiAyNiwgMjAyMiBhdCAwNzowODoyMkFNICswMTAwLCBKdWVyZ2VuIEdyb3NzIHdyb3Rl
Og0KPiANCj4gc25pcC4uDQo+IA0KPj4+DQo+Pj4gICAgY3NkOiBjbnQoNjNkOGUxZik6IDAw
MDMtPjAwMzcgcXVldWUNCj4+PiAgICBjc2Q6IGNudCg2M2Q4ZTIwKTogMDAwMy0+MDAzNyBp
cGkNCj4+PiAgICBjc2Q6IGNudCg2M2Q4ZTIxKTogMDAwMy0+MDAzNyBwaW5nDQo+Pj4NCj4+
PiBJbiBfX3NtcF9jYWxsX3NpbmdsZV9xdWV1ZV9kZWJ1ZyBDUFUgMyBzZW5kcyBhbm90aGVy
IG1lc3NhZ2UgdG8NCj4+PiBDUFUgNTUgYW5kIHNlbmRzIGFuIElQSS4gIEJ1dCB0aGVyZSBz
aG91bGQgYmUgYSBwaW5nZWQgZW50cnkNCj4+PiBhZnRlciB0aGlzLg0KPj4+DQo+Pj4gICAg
Y3NkOiBjbnQoNjNkOGUyMik6IDAwMDMtPjAwMzcgcXVldWUNCj4+PiAgICBjc2Q6IGNudCg2
M2Q4ZTIzKTogMDAwMy0+MDAzNyBub2lwaQ0KPj4NCj4+IFRoaXMgaXMgaW50ZXJlc3Rpbmcu
IFRob3NlIGFyZSA1IGNvbnNlY3V0aXZlIGVudHJpZXMgd2l0aG91dCBhbnkNCj4+IG1pc3Np
bmcgaW4gYmV0d2VlbiAoc2VlIHRoZSBjb3VudGVyIHZhbHVlcykuIENvdWxkIGl0IGJlIHRo
YXQgYWZ0ZXINCj4+IHRoZSBwaW5nIHRoZXJlIHdhcyBhbiBpbnRlcnJ1cHQgYW5kIHRoZSBj
b2RlIHdhcyByZS1lbnRlcmVkIGZvcg0KPj4gc2VuZGluZyBhbm90aGVyIElQST8gVGhpcyB3
b3VsZCBjbGVhcmx5IHJlc3VsdCBpbiBhIGhhbmcgYXMgc2Vlbi4NCj4gDQo+IFNpbmNlIHBy
ZWVtcHQgaXMgZW5hYmxlZCwgd291bGRuJ3QgaXQgZXZlbnR1YWxseSBjb21lIGJhY2sgdG8g
dGhlIGZpcnN0DQo+IHRocmVhZCBhbmQgc2VuZCB0aGUgSVBJPyAgVW5sZXNzIENQVSAzIGlz
IHN0dWNrIGluIGFuIGludGVycnVwdCBvcg0KPiBpbnRlcnJ1cHQgc3Rvcm0uDQoNCldpdGgg
cHJlZW1wdCBkaXNhYmxlZCAoeW91IHByb2JhYmx5IG1lYW50IHRoYXQpIG9ubHkgYW4gSVBJ
IGZyb20NCmludGVycnVwdCBjb250ZXh0IHdvdWxkIGJlIHBvc3NpYmxlLiBBbmQgaXQgd291
bGQgYmUgc3R1Y2ssIG9mIGNvdXJzZSwNCmFzIGl0IHdvdWxkIG5lZWQgdG8gd2FpdCBmb3Ig
dGhlIENTRCBsb2NrLg0KDQoNCkp1ZXJnZW4NCg==
--------------Bq6P7ADTMO6oUm2LMFZJbBVF
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------Bq6P7ADTMO6oUm2LMFZJbBVF--

--------------hVKBS4b7N0g2X96dNG8Wik1y--

--------------0lvEI0TcZDUc406Sn004uNqP
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmHxafYFAwAAAAAACgkQsN6d1ii/Ey+R
mQf+JvXQzHj9zYa0TxSNr34eJDjTpoen8TJz9SF9vWm56gsTttT4HDrA0TzpCizVOHq6TxluEIau
CelknYZaZ7yMdO0UxsqyvMs155tvvWzHXVXppPU582SK2WrRmdKNlqHs3X7yOTZbsMHZ2IlFv0TL
EwEY579tDj6cXvLpPhm+iKn+g8qLPNO+TgTKk9WwyL55nhTx/dc1fPqFgYA8Ju0HAkxjliidfNHf
t7hleM9ntJqeq7uK3cfrZ0o9/RoF1DUwmrNRguEvty1Ph7pC1HoULAilBGDzaLnopubH/QmzE1ur
7By2mTT/niSWJ44Owm6+Uxidd0qF+QC5hOtiMDvGkw==
=ItjI
-----END PGP SIGNATURE-----

--------------0lvEI0TcZDUc406Sn004uNqP--
