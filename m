Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43387473EDE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 10:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbhLNI76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 03:59:58 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:43850 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbhLNI75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 03:59:57 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C6B9A21108;
        Tue, 14 Dec 2021 08:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639472396; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UFeDHd6qk8JF9LIDK/A9lw7Ura1H2sdGsscX/CasGK8=;
        b=YusjS/QgdgCMsIQDplVNnCPJHsr7E0ncNQoxqeBXHqemRBfT4fvd764Wc0BMw2VTfrGqIw
        Js7rIl6ABoNcUTWEHwj8vvSbY12UojrYdcLVVVv71LUyqzWBk9DnmmbiwVTqNsOD+xo40Z
        IVp/N8KszaPzpUAAXFtSJhrFEU6V1K8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639472396;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UFeDHd6qk8JF9LIDK/A9lw7Ura1H2sdGsscX/CasGK8=;
        b=oU9shgJ7LgDNLKclzFZi9o6zjsLHcWzpswtMiSJraEgqpqF5eyGdHK16urKLd3ciQUyFSi
        miHYTHbLKeXgEuAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A42A913C41;
        Tue, 14 Dec 2021 08:59:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pYsSJwxduGFQIwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Tue, 14 Dec 2021 08:59:56 +0000
Message-ID: <c969cfd4-194f-d347-3ed8-5bcbe1211fd5@suse.de>
Date:   Tue, 14 Dec 2021 09:59:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2] drm/ast: potential dereference of null pointer
Content-Language: en-US
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, airlied@redhat.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20211214014126.2211535-1-jiasheng@iscas.ac.cn>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <20211214014126.2211535-1-jiasheng@iscas.ac.cn>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------FSaiij6p1adHCvvQejO1KRSL"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------FSaiij6p1adHCvvQejO1KRSL
Content-Type: multipart/mixed; boundary="------------yXwzGw7zzhjVkoYN4Wgt7aeC";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Jiasheng Jiang <jiasheng@iscas.ac.cn>, airlied@redhat.com,
 airlied@linux.ie, daniel@ffwll.ch
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Message-ID: <c969cfd4-194f-d347-3ed8-5bcbe1211fd5@suse.de>
Subject: Re: [PATCH v2] drm/ast: potential dereference of null pointer
References: <20211214014126.2211535-1-jiasheng@iscas.ac.cn>
In-Reply-To: <20211214014126.2211535-1-jiasheng@iscas.ac.cn>

--------------yXwzGw7zzhjVkoYN4Wgt7aeC
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMTQuMTIuMjEgdW0gMDI6NDEgc2NocmllYiBKaWFzaGVuZyBKaWFuZzoNCj4g
VGhlIHJldHVybiB2YWx1ZSBvZiBremFsbG9jKCkgbmVlZHMgdG8gYmUgY2hlY2tlZC4NCj4g
VG8gYXZvaWQgdXNlIG9mIG51bGwgcG9pbnRlciAnJmFzdF9zdGF0ZS0+YmFzZScgaW4gY2Fz
ZSBvZiB0aGUNCj4gZmFpbHVyZSBvZiBhbGxvYy4NCj4gDQo+IEZpeGVzOiBmMGFkYmMzODJi
OGIgKCJkcm0vYXN0OiBBbGxvY2F0ZSBpbml0aWFsIENSVEMgc3RhdGUgb2YgdGhlIGNvcnJl
Y3Qgc2l6ZSIpDQo+IFNpZ25lZC1vZmYtYnk6IEppYXNoZW5nIEppYW5nIDxqaWFzaGVuZ0Bp
c2Nhcy5hYy5jbj4NCg0KVGhhbmtzIGEgbG90LiBJJ3ZlIGFkZGVkIHlvdSBwYXRjaCB0byBk
cm0tbWlzYy1maXhlcy4NCg0KQmVzdCByZWdhcmRzDQpUaG9tYXMNCg0KPiAtLS0NCj4gQ2hh
bmdlbG9nOg0KPiANCj4gdjEgLT4gdjINCj4gDQo+ICpDaGFuZ2UgMS4gQWRkIHRoZSBlbHNl
IHN0YXRlbWVudCB0aGF0IGNhbGxpbmcNCj4gX19kcm1fYXRvbWljX2hlbHBlcl9jcnRjX3Jl
c2V0KCkgd2l0aCBhIHN0YXRlIG9mIE5VTEwuDQo+IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1L2Ry
bS9hc3QvYXN0X21vZGUuYyB8IDUgKysrKy0NCj4gICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FzdC9hc3RfbW9kZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FzdC9hc3RfbW9kZS5j
DQo+IGluZGV4IDM2ZDk1NzVhYTI3Yi4uNjUwOTlmMDM1OWY5IDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYXN0L2FzdF9tb2RlLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FzdC9hc3RfbW9kZS5jDQo+IEBAIC0xMTIwLDcgKzExMjAsMTAgQEAgc3RhdGljIHZvaWQg
YXN0X2NydGNfcmVzZXQoc3RydWN0IGRybV9jcnRjICpjcnRjKQ0KPiAgIAlpZiAoY3J0Yy0+
c3RhdGUpDQo+ICAgCQljcnRjLT5mdW5jcy0+YXRvbWljX2Rlc3Ryb3lfc3RhdGUoY3J0Yywg
Y3J0Yy0+c3RhdGUpOw0KPiAgIA0KPiAtCV9fZHJtX2F0b21pY19oZWxwZXJfY3J0Y19yZXNl
dChjcnRjLCAmYXN0X3N0YXRlLT5iYXNlKTsNCj4gKwlpZiAoYXN0X3N0YXRlKQ0KPiArCQlf
X2RybV9hdG9taWNfaGVscGVyX2NydGNfcmVzZXQoY3J0YywgJmFzdF9zdGF0ZS0+YmFzZSk7
DQo+ICsJZWxzZQ0KPiArCQlfX2RybV9hdG9taWNfaGVscGVyX2NydGNfcmVzZXQoY3J0Yywg
TlVMTCk7DQo+ICAgfQ0KPiAgIA0KPiAgIHN0YXRpYyBzdHJ1Y3QgZHJtX2NydGNfc3RhdGUg
Kg0KPiANCg0KLS0gDQpUaG9tYXMgWmltbWVybWFubg0KR3JhcGhpY3MgRHJpdmVyIERldmVs
b3Blcg0KU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR2VybWFueSBHbWJIDQpNYXhmZWxkc3Ry
LiA1LCA5MDQwOSBOw7xybmJlcmcsIEdlcm1hbnkNCihIUkIgMzY4MDksIEFHIE7DvHJuYmVy
ZykNCkdlc2Now6RmdHNmw7xocmVyOiBJdm8gVG90ZXYNCg==

--------------yXwzGw7zzhjVkoYN4Wgt7aeC--

--------------FSaiij6p1adHCvvQejO1KRSL
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmG4XQwFAwAAAAAACgkQlh/E3EQov+AO
4g/+LFseO9NJXC7T8puGMkuVxIW1VoUzGwDpN37gIdJWzbWLwFnVAhd7nyw9lCrlCbpco5q6SaLZ
z6QZMib6HyQ/yvvQLBqjBjd91KY1GKGKX/gne0boSTPbtz2YP+z5m+CPPCL3NPCAn7LwQFiFfw4l
x4MmOAX0Z7+YlAweiAZQjBOFYtJz2At2JFNpGLtARy/Xwz0lscox67gEh0h9eItO57vWPNd7W6YY
xVs0wTqIx4szpvvlehvuTHA8kGGg3rD/ywQ2WyZv8vXF0RdpcxlRM/1LiLjhtb2JNqSURcFNxrkx
hn58mWKB8fLaKdihvSFzl52gs55vknwpmQKT6sKh0sPtZHUc5xMRlDqdeUqo/d2bhYFaIJnY3eeS
L440zhHeAk4sKXLUlRc9AS0xYw+Wm8bTBrzSNGda594aoxtE5MtNZsV2xDiQgZdyKo3SBDUgYUYG
bTkh0nkalSvS+EvSB5dIzyAB7w5OpptZ3VO0xncfuaOwOit1HAzuIFJY3xwFVU1AqiVq8tuS/jzd
3m2v8e5GeTDw1U8Z81H2w7vpVUwpFr5xw8FuJLgAC9FOxr7eB/VlDLOxVdbD05QKaTAbXIU1N3Zv
W7c+4ipWgEAoA/PaWc6tuazCW5EJyGATKXGhB9+N/dgWKv/UuYnLgKB8PuqKvjo1vaZQsNwgpEHe
+DI=
=nSHM
-----END PGP SIGNATURE-----

--------------FSaiij6p1adHCvvQejO1KRSL--
