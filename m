Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86D27476E9B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 11:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235808AbhLPKOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 05:14:00 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:36210 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbhLPKN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 05:13:59 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E2F16212B6;
        Thu, 16 Dec 2021 10:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639649637; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C9zkuW4vj62cZydLruN2DlMZ0uP/pbPyOAEvv0x7Vto=;
        b=XgDdaZaRgPQe0myadPEBt03inLUaM4d6UkSmYbqefe0d6NDTRj4H/RFJKYf2X/wwa1RrAK
        g46jV7m36MN/a36jvw28h4h0AWsn9dn5I7lpIoB8cLzT1ot+XlXdedTcgj6IwTKWjEZswP
        xx18SsWCjjwQ/1LX7UpOtK2bxGtvPw0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639649637;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C9zkuW4vj62cZydLruN2DlMZ0uP/pbPyOAEvv0x7Vto=;
        b=IVC3mUjMjeQ2HsojqMFI0rqOxH35Qu2UsG+XbTzPRWkLGi/CGqjYD9qkhwYFn/mGfL168e
        +zzritYMgg/rUKBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A535C13DF8;
        Thu, 16 Dec 2021 10:13:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zvhCJ2URu2FjGgAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Thu, 16 Dec 2021 10:13:57 +0000
Message-ID: <1c7fc6c4-7941-682d-9675-425b04605f7f@suse.de>
Date:   Thu, 16 Dec 2021 11:13:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v3 0/3] drm/simpledrm: Apple M1 / DT platform support
 fixes
Content-Language: en-US
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     Hector Martin <marcan@marcan.st>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
References: <20211212062407.138309-1-marcan@marcan.st>
 <4d16ff4b-4060-49df-805f-66d293ffa186@suse.de>
In-Reply-To: <4d16ff4b-4060-49df-805f-66d293ffa186@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------eYF1iziI7aQX0irnmnJKm7vw"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------eYF1iziI7aQX0irnmnJKm7vw
Content-Type: multipart/mixed; boundary="------------Z62ztZl0jHcNjlkYd7K00At9";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Hector Martin <marcan@marcan.st>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh+dt@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org,
 Javier Martinez Canillas <javier@dowhile0.org>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>
Message-ID: <1c7fc6c4-7941-682d-9675-425b04605f7f@suse.de>
Subject: Re: [PATCH v3 0/3] drm/simpledrm: Apple M1 / DT platform support
 fixes
References: <20211212062407.138309-1-marcan@marcan.st>
 <4d16ff4b-4060-49df-805f-66d293ffa186@suse.de>
In-Reply-To: <4d16ff4b-4060-49df-805f-66d293ffa186@suse.de>

--------------Z62ztZl0jHcNjlkYd7K00At9
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMTUuMTIuMjEgdW0gMTQ6Mjkgc2NocmllYiBUaG9tYXMgWmltbWVybWFubjoN
Cj4gSGkNCj4gDQo+IEFtIDEyLjEyLjIxIHVtIDA3OjI0IHNjaHJpZWIgSGVjdG9yIE1hcnRp
bjoNCj4+IEhpIERSTSBmb2xrcywNCj4+DQo+PiBUaGlzIHNob3J0IHNlcmllcyBtYWtlcyBz
aW1wbGVkcm0gd29yayBvbiBBcHBsZSBNMSAoaW5jbHVkaW5nIFByby9NYXgpDQo+PiBwbGF0
Zm9ybXMgdGhlIHdheSBzaW1wbGVmYiBhbHJlYWR5IGRvZXMsIGJ5IGFkZGluZyBYUkdCMjEw
MTAxMCBzdXBwb3J0DQo+PiBhbmQgbWFraW5nIGl0IGJpbmQgdG8gZnJhbWVidWZmZXJzIGlu
IC9jaG9zZW4gdGhlIHNhbWUgd2F5IHNpbXBsZWZiDQo+PiBkb2VzLg0KPj4NCj4+IFRoaXMg
YXZvaWRzIGJyZWFraW5nIHRoZSBib290bG9hZGVyLXByb3ZpZGVkIGZyYW1lYnVmZmVyIGNv
bnNvbGUgd2hlbg0KPj4gc2ltcGxlZHJtIGlzIHNlbGVjdGVkIHRvIHJlcGxhY2Ugc2ltcGxl
ZmIsIGFzIHRoZXNlIEZCcyBhbHdheXMgc2VlbSB0bw0KPj4gYmUgMTAtYml0IChhdCBsZWFz
dCB3aGVuIGEgcmVhbCBzY3JlZW4gaXMgYXR0YWNoZWQpLg0KPiANCj4gSWYgdGhlcmUgYXJl
IG5vIGZ1cnRoZXIgY29tbWVudHMsIEknbSBnb2luZyB0byBhcHBseSB0aGUgc2VyaWVzIHRv
IA0KPiBkcm0tbWlzYy1uZXh0Lg0KDQpJJ3ZlIGFkZGVkIHRoZSBzZXJpZXMuDQoNCkJlc3Qg
cmVnYXJkcw0KVGhvbWFzDQoNCj4gDQo+IEJlc3QgcmVnYXJkcw0KPiBUaG9tYXMNCj4gDQo+
Pg0KPj4gQ2hhbmdlcyBzaW5jZSB2MjoNCj4+IC0gTWFkZSAxMC1iaXQgY29udmVyc2lvbiBj
b2RlIGZpbGwgdGhlIExTQnMNCj4+IC0gQWRkZWQgQVJHQjIxMDEwMTAgdG8gc3VwcG9ydGVk
IGZvcm1hdHMgbGlzdA0KPj4gLSBTaW1wbGlmaWVkIE9GIGNvcmUgY29kZSBwZXIgcmV2aWV3
IGZlZWRiYWNrDQo+PiBIZWN0b3IgTWFydGluICgzKToNCj4+IMKgwqAgb2Y6IE1vdmUgc2lt
cGxlLWZyYW1lYnVmZmVyIGRldmljZSBoYW5kbGluZyBmcm9tIHNpbXBsZWZiIHRvIG9mDQo+
PiDCoMKgIGRybS9mb3JtYXQtaGVscGVyOiBBZGQgZHJtX2ZiX3hyZ2I4ODg4X3RvX3hyZ2Iy
MTAxMDEwX3RvaW8oKQ0KPj4gwqDCoCBkcm0vc2ltcGxlZHJtOiBBZGQgW0FYXVJHQjIxMDEw
MTAgZm9ybWF0cw0KPj4NCj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9kcm1fZm9ybWF0X2hlbHBl
ci5jIHwgNjQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+IMKgIGRyaXZlcnMv
Z3B1L2RybS90aW55L3NpbXBsZWRybS5jwqDCoMKgIHzCoCA0ICstDQo+PiDCoCBkcml2ZXJz
L29mL3BsYXRmb3JtLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCA0ICsrDQo+
PiDCoCBkcml2ZXJzL3ZpZGVvL2ZiZGV2L3NpbXBsZWZiLmPCoMKgwqDCoMKgIHwgMjEgKy0t
LS0tLS0tLQ0KPj4gwqAgaW5jbHVkZS9kcm0vZHJtX2Zvcm1hdF9oZWxwZXIuaMKgwqDCoMKg
IHzCoCAzICsrDQo+PiDCoCA1IGZpbGVzIGNoYW5nZWQsIDc0IGluc2VydGlvbnMoKyksIDIy
IGRlbGV0aW9ucygtKQ0KPj4NCj4gDQoNCi0tIA0KVGhvbWFzIFppbW1lcm1hbm4NCkdyYXBo
aWNzIERyaXZlciBEZXZlbG9wZXINClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdlcm1hbnkg
R21iSA0KTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnLCBHZXJtYW55DQooSFJCIDM2
ODA5LCBBRyBOw7xybmJlcmcpDQpHZXNjaMOkZnRzZsO8aHJlcjogSXZvIFRvdGV2DQo=

--------------Z62ztZl0jHcNjlkYd7K00At9--

--------------eYF1iziI7aQX0irnmnJKm7vw
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmG7EWUFAwAAAAAACgkQlh/E3EQov+DD
iQ//XUN/4mfxi9I+9sLedCoShvZeOFabZFjAcpa8LR9fKKetE5ZED9Obch0FBQUxuF/JwLY7sp8m
VZ+7cmN35w7JbsOjM3p0Vr4fm1E+1WfQo34XKknt+PMjZLonVtF53MAkFjkU4Oo/OKNmXCXVkTB/
4vMsonxEo3/xaY7NBjWFimoTDHg3RPBFadyyxp2rUvFeC/hMCJxaFaLijQk+NBHMq3PMv4ez6qIa
cSwYui652L8sQzFXYdD+FTZasrD0hGOz0CcuWf4DPpDtkwC+3s5RyYFw4ox+ol+r+d5ie+WV4Ga+
A4Zk3cIZn7ZogkLVFp8It+um/LeCtRfoIESYQETQCFFdvWTExLaQnCh2+4WOVTj4TI6sUzKOd37d
A6yLSIm0xm7rxBtoq90GrjvLu5CdmxeSZknYPtLi+Spibf0e1CqDEpTe+dUApbFFxjTqDOUsAQXw
up5dPd8mVIivygm5ttjWoT3aGSlQFrqX5qVf4uFgo3yKBe8Kh9P+cuJ+UZ3nFrF3HhxsBfzWp9iN
wcos4uMnwmKTmOOoEnct3ffOZMUGlEM3y2w0lM1hNWmXD1sZyLzOh6S+1fC2EXNoEZ1rgS721FUt
cdbWqXdlZ2CEUwHD7nLG2xb8MlcGczEd1ty3fKBii6JvpKgQf+tBSw4b/0NJjDC2Z1J2ZR6IdfdF
BRg=
=5jtR
-----END PGP SIGNATURE-----

--------------eYF1iziI7aQX0irnmnJKm7vw--
