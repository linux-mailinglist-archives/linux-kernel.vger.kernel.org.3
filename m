Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8DC46B71B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 10:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233934AbhLGJfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 04:35:31 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:40272 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233017AbhLGJfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 04:35:30 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0C54B21B3E;
        Tue,  7 Dec 2021 09:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638869520; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=agBgv4TJQZLemzxsCodLp31B4S7vDF/Lputw3SH3//A=;
        b=G9379qMp4bcVSiBKySWAHkR9HnYy4H7moy2tY+8cvYzsEhuzR4m+qa7AaudRxpdvy5I5fe
        sIj+QgctGdvw8KSoVpMu5Wp9h6i7ZRuLCHo8kpGU+9yfYTi2yZ9lYGazqlFxxNkxN9/CGp
        5ECmNZeZBL9Zucr2j46VixkTKBVP77E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638869520;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=agBgv4TJQZLemzxsCodLp31B4S7vDF/Lputw3SH3//A=;
        b=ZHCcukbuWkdKxCeMu7Es9NRzQsyWiDXYjQYxl3tnIk1gGy3P77tQjFUNusek9k95iuIM2H
        Evutnagjtz7jQmBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C0254139F0;
        Tue,  7 Dec 2021 09:31:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0yjFLQ8qr2H3VAAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Tue, 07 Dec 2021 09:31:59 +0000
Message-ID: <fbc244d0-8ea5-bb1a-0c71-178f390ea748@suse.de>
Date:   Tue, 7 Dec 2021 10:31:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2 3/3] drm/simpledrm: Add XRGB2101010 format
Content-Language: en-US
To:     Hector Martin <marcan@marcan.st>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20211207072943.121961-1-marcan@marcan.st>
 <20211207072943.121961-4-marcan@marcan.st>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <20211207072943.121961-4-marcan@marcan.st>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------U0IBPje5qHUul0W9vaArGJ0e"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------U0IBPje5qHUul0W9vaArGJ0e
Content-Type: multipart/mixed; boundary="------------25Pg8mlFy6MbCoIJRHja10yZ";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Hector Martin <marcan@marcan.st>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh+dt@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Javier Martinez Canillas <javier@dowhile0.org>,
 Pekka Paalanen <ppaalanen@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Message-ID: <fbc244d0-8ea5-bb1a-0c71-178f390ea748@suse.de>
Subject: Re: [PATCH v2 3/3] drm/simpledrm: Add XRGB2101010 format
References: <20211207072943.121961-1-marcan@marcan.st>
 <20211207072943.121961-4-marcan@marcan.st>
In-Reply-To: <20211207072943.121961-4-marcan@marcan.st>

--------------25Pg8mlFy6MbCoIJRHja10yZ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMDcuMTIuMjEgdW0gMDg6Mjkgc2NocmllYiBIZWN0b3IgTWFydGluOg0KPiBU
aGlzIGlzIHRoZSBmb3JtYXQgdXNlZCBieSB0aGUgYm9vdGxvYWRlciBmcmFtZWJ1ZmZlciBv
biBBcHBsZSBBUk02NA0KPiBwbGF0Zm9ybXMuDQo+IA0KPiBSZXZpZXdlZC1ieTogVGhvbWFz
IFppbW1lcm1hbm4gPHR6aW1tZXJtYW5uQHN1c2UuZGU+DQo+IFNpZ25lZC1vZmYtYnk6IEhl
Y3RvciBNYXJ0aW4gPG1hcmNhbkBtYXJjYW4uc3Q+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1
L2RybS90aW55L3NpbXBsZWRybS5jIHwgMiArLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS90aW55L3NpbXBsZWRybS5jIGIvZHJpdmVycy9ncHUvZHJtL3Rpbnkvc2ltcGxl
ZHJtLmMNCj4gaW5kZXggMmY5OTk5MTViOWFhLi5lZGFkZmQ5ZWU4ODIgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS90aW55L3NpbXBsZWRybS5jDQo+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS90aW55L3NpbXBsZWRybS5jDQo+IEBAIC01NzEsNyArNTcxLDcgQEAgc3RhdGlj
IGNvbnN0IHVpbnQzMl90IHNpbXBsZWRybV9kZWZhdWx0X2Zvcm1hdHNbXSA9IHsNCj4gICAJ
Ly9EUk1fRk9STUFUX1hSR0IxNTU1LA0KPiAgIAkvL0RSTV9GT1JNQVRfQVJHQjE1NTUsDQo+
ICAgCURSTV9GT1JNQVRfUkdCODg4LA0KPiAtCS8vRFJNX0ZPUk1BVF9YUkdCMjEwMTAxMCwN
Cj4gKwlEUk1fRk9STUFUX1hSR0IyMTAxMDEwLA0KPiAgIAkvL0RSTV9GT1JNQVRfQVJHQjIx
MDEwMTAsDQoNCllvdSBzaG91bGQgYWxzbyBlbmFibGUgRFJNX0ZPUk1BVF9BUkdCMjEwMTAx
MCBoZXJlLiBZb3UgYWRkZWQgdGhlIA0KY29udmVyc2lvbiBmdW5jdGlvbiwgc28gRFJNIGNh
biBkZWFsIHdpdGggaXQuIEhhdmluZyBhbiBhbHBoYSBjaGFubmVsIA0KaXNuJ3QgdHlwaWNh
bGx5IHN1cHBvcnRlZCBmb3IgcHJpbWFyeSBwbGFuZXMsIGJ1dCB0aGUgZm9ybWF0IGlzIGxp
c3RlZCANCmluIFNJTVBMRUZCX0ZPUk1BVFMuIFsxXQ0KDQpXaXRoIHRoaXMgY2hhbmdlOg0K
DQpSZXZpZXdlZC1ieTogVGhvbWFzIFppbW1lcm1hbm4gPHR6aW1tZXJtYW5uQHN1c2UuZGU+
DQoNCkJlc3QgcmVnYXJkcw0KDQpbMV0gDQpodHRwczovL2VsaXhpci5ib290bGluLmNvbS9s
aW51eC9sYXRlc3Qvc291cmNlL2luY2x1ZGUvbGludXgvcGxhdGZvcm1fZGF0YS9zaW1wbGVm
Yi5oI0wxNg0KDQo+ICAgfTsNCj4gICANCj4gDQoNCi0tIA0KVGhvbWFzIFppbW1lcm1hbm4N
CkdyYXBoaWNzIERyaXZlciBEZXZlbG9wZXINClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdl
cm1hbnkgR21iSA0KTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnLCBHZXJtYW55DQoo
SFJCIDM2ODA5LCBBRyBOw7xybmJlcmcpDQpHZXNjaMOkZnRzZsO8aHJlcjogSXZvIFRvdGV2
DQo=

--------------25Pg8mlFy6MbCoIJRHja10yZ--

--------------U0IBPje5qHUul0W9vaArGJ0e
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmGvKg8FAwAAAAAACgkQlh/E3EQov+Dm
Xw/9HMfJoLrAhOEMqKU5Hp1PxOooNfgT0nXmV8epWTwiykGbII2L9CObQUKSPXvjnQiCMyGzU7UC
tmfPEe9FgQk2NikKK91F+laiC1fQ616JygNeS0rxqgFEFOwpXhPnRm62O3oTXjAO+f5oytmJCb4l
+JK5XVMLaSXL+CnSs02x8q0SoGvEPqRom+6bKTz7fjgTbuwpBkYyX1QrSwHmG3RFhtz9eYvXQp0L
kjBiKe5Qtr7WvYBGHHjJZDHr0oj0EvIK2Sq+cbHDYeXgJzg1kPeiyRlAG+xCgFh2b1ZUESOHP9BC
KCg7UIh4Yn1jF9aFcgpFvweapFvo22b7ZGmCoduVaToR2xs7VMc42XBVC7k/eb4nRkT8DFvpM8dt
mq+KuF/DjjMkViYkZpdChBFKUReowKQRHmp/t5VMNeYQtYysoJieBN+UCgTjJ3+HOBv2rKMH0Lv5
UlovJOWohVSirzOsplbrXWAJVQcSKXbkQQDIid0h5oIY3/eCOif/87Uk0CQWdymIHAE82u6VOawI
YBTU+cD/PDLfzA8RJkM+WkUmGLCFANK+Rs8GlVcJgbCw3NHlh+6pHnPTz4j0fEyLrEVN3bLidYNP
qggP+jqSUwevG9URiBrqunlA0niatGc4igALObfRjoOlr1obShs8cJvTk+0nihAVSS1oSvcwRAvA
Gi0=
=1NJk
-----END PGP SIGNATURE-----

--------------U0IBPje5qHUul0W9vaArGJ0e--
