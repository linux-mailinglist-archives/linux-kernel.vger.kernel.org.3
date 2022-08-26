Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0B35A218C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 09:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbiHZHPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 03:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245227AbiHZHPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 03:15:36 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB85421E0E;
        Fri, 26 Aug 2022 00:15:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2FF361F88B;
        Fri, 26 Aug 2022 07:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1661498134; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q+VtdprIdX5j7vYhY4afKBuH8G+2k+l9bdEFnhWupFo=;
        b=pRPIfu3wmz2tTo7Se6XGW4O2VOSjwptgAL+Xhz9x1PhxhsvOALUJFe0HirSXC6UtkIryaj
        JxybLbIeqdBOJzonIQWexbtEcJRGHFiZzsoemtIrP9vwr0ygrFVCKdQ2G8mWc56hlNAKay
        /5WdiQiJDIapB/fNhjLjB1wnAUknA9k=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D0F1713421;
        Fri, 26 Aug 2022 07:15:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id D+OmMBVzCGPFBwAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 26 Aug 2022 07:15:33 +0000
Message-ID: <6f65961a-c276-d04f-385e-4146a752cfe9@suse.com>
Date:   Fri, 26 Aug 2022 09:15:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/2] xen-blk{front,back}: Advertise feature-persistent as
 user requested
Content-Language: en-US
To:     SeongJae Park <sj@kernel.org>, roger.pau@citrix.com
Cc:     marmarek@invisiblethingslab.com, mheyne@amazon.de,
        xen-devel@lists.xenproject.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220825161511.94922-1-sj@kernel.org>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <20220825161511.94922-1-sj@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------fjBDY0LDDqqnuMH0vcGKV0Cn"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------fjBDY0LDDqqnuMH0vcGKV0Cn
Content-Type: multipart/mixed; boundary="------------0ZLY9A3bVywvYvgIb7De0oMJ";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: SeongJae Park <sj@kernel.org>, roger.pau@citrix.com
Cc: marmarek@invisiblethingslab.com, mheyne@amazon.de,
 xen-devel@lists.xenproject.org, axboe@kernel.dk,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <6f65961a-c276-d04f-385e-4146a752cfe9@suse.com>
Subject: Re: [PATCH 0/2] xen-blk{front,back}: Advertise feature-persistent as
 user requested
References: <20220825161511.94922-1-sj@kernel.org>
In-Reply-To: <20220825161511.94922-1-sj@kernel.org>

--------------0ZLY9A3bVywvYvgIb7De0oMJ
Content-Type: multipart/mixed; boundary="------------JqQwhu5J102EPuO9zkcBy5Z1"

--------------JqQwhu5J102EPuO9zkcBy5Z1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjUuMDguMjIgMTg6MTUsIFNlb25nSmFlIFBhcmsgd3JvdGU6DQo+IENvbW1pdCBlOTRj
NjEwMWUxNTEgKCJ4ZW4tYmxrYmFjazogQXBwbHkgJ2ZlYXR1cmVfcGVyc2lzdGVudCcgcGFy
YW1ldGVyDQo+IHdoZW4gY29ubmVjdCIpIG1hZGUgYmxrYmFjayB0byBhZHZlcnRpc2UgaXRz
IHN1cHBvcnQgb2YgdGhlIHBlcnNpc3RlbnQNCj4gZ3JhbnRzIGZlYXR1cmUgb25seSBpZiB0
aGUgdXNlciBzZXRzIHRoZSAnZmVhdHVyZV9wZXJzaXN0ZW50JyBwYXJhbWV0ZXINCj4gb2Yg
dGhlIGRyaXZlciBhbmQgdGhlIGZyb250ZW5kIGFkdmVydGlzZWQgaXRzIHN1cHBvcnQgb2Yg
dGhlIGZlYXR1cmUuDQo+IEhvd2V2ZXIsIGZvbGxvd2luZyBjb21taXQgNDAyYzQzZWE2YjM0
ICgieGVuLWJsa2Zyb250OiBBcHBseQ0KPiAnZmVhdHVyZV9wZXJzaXN0ZW50JyBwYXJhbWV0
ZXIgd2hlbiBjb25uZWN0IikgbWFkZSB0aGUgYmxrZnJvbnQgdG8gd29yaw0KPiBpbiB0aGUg
c2FtZSB3YXkuICBUaGF0IGlzLCBibGtmcm9udCBhbHNvIGFkdmVydGlzZXMgaXRzIHN1cHBv
cnQgb2YgdGhlDQo+IHBlcnNpc3RlbnQgZ3JhbnRzIGZlYXR1cmUgb25seSBpZiB0aGUgdXNl
ciBzZXRzIHRoZSAnZmVhdHVyZV9wZXJzaXN0ZW50Jw0KPiBwYXJhbWV0ZXIgb2YgdGhlIGRy
aXZlciBhbmQgdGhlIGJhY2tlbmQgYWR2ZXJ0aXNlZCBpdHMgc3VwcG9ydCBvZiB0aGUNCj4g
ZmVhdHVyZS4NCj4gDQo+IEhlbmNlIGJsa2JhY2sgYW5kIGJsa2Zyb250IHdpbGwgbmV2ZXIg
YWR2ZXJ0aXNlIHRoZWlyIHN1cHBvcnQgb2YgdGhlDQo+IGZlYXR1cmUgYnV0IHdhaXQgdW50
aWwgdGhlIG90aGVyIGFkdmVydGlzZXMgdGhlIHN1cHBvcnQsIGV2ZW4gdGhvdWdoDQo+IHVz
ZXJzIHNldCB0aGUgJ2ZlYXR1cmVfcGVyc2lzdGVudCcgcGFyYW1ldGVycyBvZiB0aGUgZHJp
dmVycy4gIEFzIGENCj4gcmVzdWx0LCB0aGUgcGVyc2lzdGVudCBncmFudHMgZmVhdHVyZSBp
cyBkaXNhYmxlZCBhbHdheXMgcmVnYXJkbGVzcyBvZg0KPiB0aGUgJ2ZlYXR1cmVfcGVyc2lz
dGVudCcgdmFsdWVzWzFdLg0KPiANCj4gVGhlIHByb2JsZW0gY29tZXMgZnJvbSB0aGUgbWlz
dXNlIG9mIHRoZSBzZW1hbnRpYyBvZiB0aGUgYWR2ZXJ0aXNlbWVudA0KPiBvZiB0aGUgZmVh
dHVyZS4gIFRoZSBhZHZlcnRpc2VtZW50IG9mIHRoZSBmZWF0dXJlIHNob3VsZCBtZWFucyBv
bmx5DQo+IGF2YWlsYWJpbGl0eSBvZiB0aGUgZmVhdHVyZSBub3QgdGhlIGRlY2lzaW9uIGZv
ciB1c2luZyB0aGUgZmVhdHVyZS4NCj4gSG93ZXZlciwgY3VycmVudCBiZWhhdmlvciBpcyB3
b3JraW5nIGluIHRoZSB3cm9uZyB3YXkuDQo+IA0KPiBUaGlzIHBhdGNoc2V0IGZpeGVzIHRo
ZSBpc3N1ZSBieSBtYWtpbmcgYm90aCBibGtiYWNrIGFuZCBibGtmcm9udA0KPiBhZHZlcnRp
c2UgdGhlaXIgc3VwcG9ydCBvZiB0aGUgZmVhdHVyZSBhcyB1c2VyIHJlcXVlc3RlZCB2aWEN
Cj4gJ2ZlYXR1cmVfcGVyc2lzdGVudCcgcGFyYW1ldGVyIHJlZ2FyZGxlc3Mgb2YgdGhlIG90
aGVyZW5kJ3Mgc3VwcG9ydCBvZg0KPiB0aGUgZmVhdHVyZS4NCj4gDQo+IFsxXSBodHRwczov
L2xvcmUua2VybmVsLm9yZy94ZW4tZGV2ZWwvYmQ4MThhYmEtNDg1Ny1iYzA3LWRjOGEtZTli
MmY4YzVmN2NkQHN1c2UuY29tLw0KPiANCj4gU2VvbmdKYWUgUGFyayAoMik6DQo+ICAgIHhl
bi1ibGtiYWNrOiBBZHZlcnRpc2UgZmVhdHVyZS1wZXJzaXN0ZW50IGFzIHVzZXIgcmVxdWVz
dGVkDQo+ICAgIHhlbi1ibGtmcm9udDogQWR2ZXJ0aXNlIGZlYXR1cmUtcGVyc2lzdGVudCBh
cyB1c2VyIHJlcXVlc3RlZA0KPiANCj4gICBkcml2ZXJzL2Jsb2NrL3hlbi1ibGtiYWNrL2Nv
bW1vbi5oIHwgMyArKysNCj4gICBkcml2ZXJzL2Jsb2NrL3hlbi1ibGtiYWNrL3hlbmJ1cy5j
IHwgNiArKysrLS0NCj4gICBkcml2ZXJzL2Jsb2NrL3hlbi1ibGtmcm9udC5jICAgICAgIHwg
OCArKysrKystLQ0KPiAgIDMgZmlsZXMgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgNCBk
ZWxldGlvbnMoLSkNCj4gDQoNCkZvciB0aGUgc2VyaWVzOg0KDQpSZXZpZXdlZC1ieTogSnVl
cmdlbiBHcm9zcyA8amdyb3NzQHN1c2UuY29tPg0KDQoNCkp1ZXJnZW4NCg==
--------------JqQwhu5J102EPuO9zkcBy5Z1
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------JqQwhu5J102EPuO9zkcBy5Z1--

--------------0ZLY9A3bVywvYvgIb7De0oMJ--

--------------fjBDY0LDDqqnuMH0vcGKV0Cn
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmMIcxUFAwAAAAAACgkQsN6d1ii/Ey/g
3wf+OJr/i0zfnUeR3mjAZDR9O8xj5QGwWPh59g9u9vwDTfHSHwpxU+VL9UN7Es523YSCZXi4bxiB
Tm6Wvj+xz3jtTXAZ0Mf6XvnicTdOWA1Ul9zOmw7taxW3y3EL+QWvFqEKi42H1zDD5DtfJcnOydoq
F/hh4Nofl7FRSrBGDrDgagxtZHKfjLur8x6F6wi1Eink7e49NYnCP2FZ/MgftutuThyggwYwx1Mk
f5iW0aVFFM9+QqyDO56+d/9WZIpEiDyOdLPiXzWUa3UwBZ6SewyIq5MYIrLRgWlnz8s1E6MCufOO
twJzR7pzZo7IOPbhqNVy0OD6pF2XdnytfMx97Ahu7g==
=fuFC
-----END PGP SIGNATURE-----

--------------fjBDY0LDDqqnuMH0vcGKV0Cn--
