Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00340472A1E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 11:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234108AbhLMKba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 05:31:30 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:44996 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239613AbhLMKaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 05:30:05 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4315421124;
        Mon, 13 Dec 2021 10:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639391404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kw8ZVY8rbgKJRmU5H9ZVeDnwGE48c++bpsgABfYTlhE=;
        b=mr2Sb0XqsjaS5j6KzjfcAm2EOXBS0XI3UO7RPNUCcMD9rLSayvhBB0bOSdgC32GfqtT2G0
        iJ+fuaLUryR+d37dT0WgRAJtwHjjlY/2w2wBUiH1jPknLk9H6mNagopK1uOgqT0CQiUOzE
        wIZWG9h2ChVz0DVT/dl7EGwmZQVf9KE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639391404;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kw8ZVY8rbgKJRmU5H9ZVeDnwGE48c++bpsgABfYTlhE=;
        b=Lwv3ApmoxC3i12tbzduLMTQG2piTSqfNelxlQpBBe6TKbGCecPZU8XNRbI3VRhHSOHXT4+
        IX4zK8EiEyDnWsCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1E5A813CE5;
        Mon, 13 Dec 2021 10:30:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Hw9FBqwgt2G4PwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 13 Dec 2021 10:30:04 +0000
Message-ID: <b4bf80bb-8b89-ae6e-9234-b19e334005f6@suse.de>
Date:   Mon, 13 Dec 2021 11:30:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] drm: simpledrm: fix wrong unit with pixel clock
Content-Language: en-US
To:     Alejandro Concepcion-Rodriguez <asconcepcion@acoro.eu>,
        airlied@linux.ie, daniel@ffwll.ch, maxime@cerno.tech,
        dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org
References: <6f8554ef-1305-0dda-821c-f7d2e5644a48@acoro.eu>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <6f8554ef-1305-0dda-821c-f7d2e5644a48@acoro.eu>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------qL0aFWhl18QKPkG70FsX37IX"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------qL0aFWhl18QKPkG70FsX37IX
Content-Type: multipart/mixed; boundary="------------nPevYJHk2xbf5cta0m1rBvIY";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Alejandro Concepcion-Rodriguez <asconcepcion@acoro.eu>, airlied@linux.ie,
 daniel@ffwll.ch, maxime@cerno.tech, dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Message-ID: <b4bf80bb-8b89-ae6e-9234-b19e334005f6@suse.de>
Subject: Re: [PATCH] drm: simpledrm: fix wrong unit with pixel clock
References: <6f8554ef-1305-0dda-821c-f7d2e5644a48@acoro.eu>
In-Reply-To: <6f8554ef-1305-0dda-821c-f7d2e5644a48@acoro.eu>

--------------nPevYJHk2xbf5cta0m1rBvIY
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMTIuMTIuMjEgdW0gMTc6MDYgc2NocmllYiBBbGVqYW5kcm8gQ29uY2VwY2lv
bi1Sb2RyaWd1ZXo6DQo+IFBpeGVsIGNsb2NrIGhhcyB0byBiZSBzZXQgaW4ga0h6Lg0KPiAN
Cj4gRml4ZXM6IDExZThmNWZkMjIzYiAoImRybTogQWRkIHNpbXBsZWRybSBkcml2ZXIiKQ0K
PiANCj4gU2lnbmVkLW9mZi1ieTogQWxlamFuZHJvIENvbmNlcGNpb24tUm9kcmlndWV6IDxh
c2NvbmNlcGNpb25AYWNvcm8uZXU+DQoNCkFwcGxpZWQgdG8gZHJtLW1pc2MtZml4ZXMuIFRo
YW5rcy4NCg0KQmVzdCByZWdhcmRzDQpUaG9tYXMNCg0KPiAtLS0NCj4gICBkcml2ZXJzL2dw
dS9kcm0vdGlueS9zaW1wbGVkcm0uYyB8IDIgKy0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vdGlueS9zaW1wbGVkcm0uYyBiL2RyaXZlcnMvZ3B1L2RybS90aW55L3NpbXBs
ZWRybS5jDQo+IGluZGV4IDJmOTk5OTE1YjlhYS4uNTYyYmYwOWY5MTQwIDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vdGlueS9zaW1wbGVkcm0uYw0KPiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vdGlueS9zaW1wbGVkcm0uYw0KPiBAQCAtNDU5LDcgKzQ1OSw3IEBAIHN0YXRp
YyBzdHJ1Y3QgZHJtX2Rpc3BsYXlfbW9kZSBzaW1wbGVkcm1fbW9kZSh1bnNpZ25lZCBpbnQg
d2lkdGgsDQo+ICAgew0KPiAgIAlzdHJ1Y3QgZHJtX2Rpc3BsYXlfbW9kZSBtb2RlID0geyBT
SU1QTEVEUk1fTU9ERSh3aWR0aCwgaGVpZ2h0KSB9Ow0KPiANCj4gLQltb2RlLmNsb2NrID0g
NjAgLyogSHogKi8gKiBtb2RlLmhkaXNwbGF5ICogbW9kZS52ZGlzcGxheTsNCj4gKwltb2Rl
LmNsb2NrID0gbW9kZS5oZGlzcGxheSAqIG1vZGUudmRpc3BsYXkgKiA2MCAvIDEwMDAgLyog
a0h6ICovOw0KPiAgIAlkcm1fbW9kZV9zZXRfbmFtZSgmbW9kZSk7DQo+IA0KPiAgIAlyZXR1
cm4gbW9kZTsNCj4gLS0NCj4gMi4yNS4xDQo+IA0KDQotLSANClRob21hcyBaaW1tZXJtYW5u
DQpHcmFwaGljcyBEcml2ZXIgRGV2ZWxvcGVyDQpTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBH
ZXJtYW55IEdtYkgNCk1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZywgR2VybWFueQ0K
KEhSQiAzNjgwOSwgQUcgTsO8cm5iZXJnKQ0KR2VzY2jDpGZ0c2bDvGhyZXI6IEl2byBUb3Rl
dg0K

--------------nPevYJHk2xbf5cta0m1rBvIY--

--------------qL0aFWhl18QKPkG70FsX37IX
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmG3IKsFAwAAAAAACgkQlh/E3EQov+CF
mw//S6xo6OmkEv9q7Bmbfxsbid4s5TwPNNH+++MEMU9x3UwiM3HyxqNfwlGl72jA77x6ejayKQUZ
R/f1l229BRdFWW1mmOCoy84ldTi9heGPobi49NOSfqt/Vokq+jOBn1WOX+VY6TvjNjXKqRIp6oh2
/8BZAVgWTVxPMO6qFVn1+gMOadqe/TtbUnPYnPc6sSVYMsxFCUZdPFndf8bBQhtF5uQsdmSlBhm4
adsp+mfeFtaOIziuqw3uvLg6ltYgU4ku1fuBGdiQwfKI5SF5RO5Ts9jLV6v4PNXVJxkPS6/3tXUr
55NkWeRBJqGbDNpkYud5vKgoBiS4JcfzkjhjHxN7A+zWE6Jgo5m9Pg+S2MQWX5VojwT9H42rScpU
jU1hyX+NhF/mQdvZwVgu68Zvm9gHuwd2dOXb+r2OUwLURIN5/xGBckNJvEiKETxWQky2NBRI+bGm
lf7hqLRsZlFLkkof83hY4eT72Q6IKRrdvn81WvBGtbN31Q3mKN2yxtOIKjPxIyjXm2pcxeilRp9l
JOMgWRIZiw5hoLFAELTeD3Kehq8KjYEGUeHUyw0+ZHNkxaQfQEOX/pyM3dJbcy3lytEH6W0aVvmZ
jTqA2roCig17xDgFe649P8QUPAzZq4kJoxZ5JXjDoC3I/Am0agxdP+8GO/kIgjYLow9L7nT1t23u
49k=
=sT4/
-----END PGP SIGNATURE-----

--------------qL0aFWhl18QKPkG70FsX37IX--
