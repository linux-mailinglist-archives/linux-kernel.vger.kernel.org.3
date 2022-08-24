Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F4059FC85
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 16:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238937AbiHXOBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 10:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238834AbiHXOA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 10:00:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A51E85FE6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 07:00:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E7FE4343AF;
        Wed, 24 Aug 2022 14:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1661349654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EMwlVtQt2OIfrSiPHzl8Gk7eSfWyMsUviH2UaB+i6K0=;
        b=iT0PrH5W2FmGkokq5MNwvycNd872PXNFYC3I3HWHP8KBZArLOJg+OSy3hKwoygleg1tGys
        /9KQlrJB++eVotJqU1St2rH0jtPcyvxtv9Qy4sqyiwj1JgiIhMv2vYfJa8XTzEFyPCQHAe
        0T3EFSoNFXFEzMop/1VDYR3xtJjj+AY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9F15113780;
        Wed, 24 Aug 2022 14:00:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fh9KJRYvBmN0egAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 24 Aug 2022 14:00:54 +0000
Message-ID: <0fcf74d8-774f-1999-d508-b8349096d83e@suse.com>
Date:   Wed, 24 Aug 2022 16:00:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [POSSIBLE BUG] Dereferencing of NULL pointer
Content-Language: en-US
To:     Jan Beulich <jbeulich@suse.com>,
        Rustam Subkhankulov <subkhankulov@ispras.ru>
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        ldv-project@linuxtesting.org
References: <6228a437bb9d7f677f5e97973518bcd555bc2a07.camel@ispras.ru>
 <0f5f26d2-2b22-2a0d-8bb2-ee2e729ada3f@suse.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <0f5f26d2-2b22-2a0d-8bb2-ee2e729ada3f@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------vAC30YhXUtP7gZKpLqbO92pV"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------vAC30YhXUtP7gZKpLqbO92pV
Content-Type: multipart/mixed; boundary="------------q7angtWVae4m26mvtfP6b0Ey";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Jan Beulich <jbeulich@suse.com>,
 Rustam Subkhankulov <subkhankulov@ispras.ru>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 Alexey Khoroshilov <khoroshilov@ispras.ru>, ldv-project@linuxtesting.org
Message-ID: <0fcf74d8-774f-1999-d508-b8349096d83e@suse.com>
Subject: Re: [POSSIBLE BUG] Dereferencing of NULL pointer
References: <6228a437bb9d7f677f5e97973518bcd555bc2a07.camel@ispras.ru>
 <0f5f26d2-2b22-2a0d-8bb2-ee2e729ada3f@suse.com>
In-Reply-To: <0f5f26d2-2b22-2a0d-8bb2-ee2e729ada3f@suse.com>

--------------q7angtWVae4m26mvtfP6b0Ey
Content-Type: multipart/mixed; boundary="------------ASs8fx3CAUGuN4DNwsAWzQb6"

--------------ASs8fx3CAUGuN4DNwsAWzQb6
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjQuMDguMjIgMTU6NTksIEphbiBCZXVsaWNoIHdyb3RlOg0KPiBPbiAyMC4wOC4yMDIy
IDE5OjMwLCBSdXN0YW0gU3Via2hhbmt1bG92IHdyb3RlOg0KPj4gVmVyc2lvbjogNi4wLXJj
MQ0KPj4NCj4+IERlc2NyaXB0aW9uOg0KPj4NCj4+IEluIGZ1bmN0aW9uICdwcml2Y21kX2lv
Y3RsX2RtX29wJyAoZHJpdmVycy94ZW4vcHJpdmNtZC5jOiA2MTUpcmV0dXJuDQo+PiB2YWx1
ZSBvZiAna2NhbGxvYycgd2l0aCBHRlBfS0VSTkVMIGZsYWcgaXMgYXNzaWduZWQgdG8gInBh
Z2VzIg0KPj4gdmFyaWFibGUuIEdGUF9LRVJORUwgZmxhZyBkb2VzIG5vdCBndWFyYW50ZWUs
IHRoYXQgdGhlIHJldHVybiB2YWx1ZQ0KPj4gd2lsbCBub3QgYmUgTlVMTC4gSW4gdGhhdCBj
YXNlLCB0aGVyZSBpcyBhIGp1bXAgdG8gdGhlICJvdXQiIGxhYmVsLg0KPiANCj4gVGhlIHBy
b2JsZW0gaXMgd2lkZXIgdGhhbiB0aGF0LCBiZWNhdXNlIGVhcmxpZXIgZXJyb3JzIHdvdWxk
IGFsc28NCj4gbGVhZCB0byAib3V0IiAoZS5nLiBhZnRlciBjb3B5X2Zyb21fdXNlcigpIGZh
aWxlZCkuIFBsdXMgSSBndWVzcw0KPiB1bmxvY2tfcGFnZXMoKSBzaG91bGRuJ3QgYmUgY2Fs
bGVkIGF0IGFsbCAob3Igd2l0aCBpdHMgMm5kIGFyZyBzZXQNCj4gdG8gemVybykgYmVmb3Jl
IGxvY2tfcGFnZXMoKSB3YXMgYWN0dWFsbHkgY2FsbGVkLiBCdXQgSSBhZ3JlZSB3aXRoDQo+
IHRoZSBmdXJ0aGVyIGFuYWx5c2lzIGJlbG93LiBXb3VsZCB5b3UgbWluZCBzZW5kaW5nIGEg
cGF0Y2g/DQoNCkp1c3Qgc3RhcnRlZCB3cml0aW5nIGl0LiA6LSkNCg0KDQpKdWVyZ2VuDQo=

--------------ASs8fx3CAUGuN4DNwsAWzQb6
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------ASs8fx3CAUGuN4DNwsAWzQb6--

--------------q7angtWVae4m26mvtfP6b0Ey--

--------------vAC30YhXUtP7gZKpLqbO92pV
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmMGLxYFAwAAAAAACgkQsN6d1ii/Ey+T
sAf/Uy/hpnBgQFLaiHGSNN/9BbmPjRgoUL6VxejEEYHJa7Dk/fpezDK4E1Q2gz6b651PzoeXuGfX
Y86Y5Tc2qsbvtXmxZCDZ6se6Qw+Nmdj/AeDKYmx+E+o19FXzmqofyN0NsiPhHHSOlT17WaneYQ2D
z7MkTmKGRZx+xRs2CbwFV2DwYZ9neOhu95xTPGxE8/eL4RVUe5Dd/xLV8rdJBSTyWpBH3b1r/yJr
58ws8gv5VELkKm9VeXQOhwe72XOVQCHtScHqyOIUGLidu653hJ1zhl7qQ0LdyjCL34M2X2/3z/20
dRPAtCekld8FQ0HJiu1EW395YCubiyL0y0SzBSJtoA==
=Eily
-----END PGP SIGNATURE-----

--------------vAC30YhXUtP7gZKpLqbO92pV--
