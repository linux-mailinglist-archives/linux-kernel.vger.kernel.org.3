Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483DE508C36
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 17:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380267AbiDTPgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 11:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380251AbiDTPgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 11:36:15 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F4D3EBB4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 08:33:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1CC781F385;
        Wed, 20 Apr 2022 15:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650468808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kUyien+X+aKrfWNmxu1J2DMHSzIs0wi8yTDzXFvfr6A=;
        b=PQwL7DUDNvQu+aJEVFd0jprGoTBj6Jgi4S+pvkM/n0Szgln9UNjx2j51uohrkhoBEKLHwe
        2Hv+zVe0kJqjJ3Fmg4ScxLCyQ38HBHsLmi/fWQw3QGOfe0ZLyQ9cZgoOvo5Hj0Hy1jD5t9
        RnWe5o6V2QNzSKBnAJLIGdHT0BRZMaw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DDAD513AD5;
        Wed, 20 Apr 2022 15:33:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mE/bNMcnYGJpNwAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 20 Apr 2022 15:33:27 +0000
Message-ID: <67088937-576d-cafa-ad21-13eea497683a@suse.com>
Date:   Wed, 20 Apr 2022 17:33:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 18/18] xen/xenbus: eliminate xenbus_grant_ring()
Content-Language: en-US
To:     Andrew Cooper <Andrew.Cooper3@citrix.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
References: <20220420150942.31235-1-jgross@suse.com>
 <20220420150942.31235-19-jgross@suse.com>
 <fdc5675e-7766-2144-8f56-a49faab9631a@citrix.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <fdc5675e-7766-2144-8f56-a49faab9631a@citrix.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------pbiZjsksvj6Z21gBiaYfufUn"
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------pbiZjsksvj6Z21gBiaYfufUn
Content-Type: multipart/mixed; boundary="------------Zynua7uXBy7MiNzM6Om5Hml7";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Andrew Cooper <Andrew.Cooper3@citrix.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Stefano Stabellini <sstabellini@kernel.org>
Message-ID: <67088937-576d-cafa-ad21-13eea497683a@suse.com>
Subject: Re: [PATCH 18/18] xen/xenbus: eliminate xenbus_grant_ring()
References: <20220420150942.31235-1-jgross@suse.com>
 <20220420150942.31235-19-jgross@suse.com>
 <fdc5675e-7766-2144-8f56-a49faab9631a@citrix.com>
In-Reply-To: <fdc5675e-7766-2144-8f56-a49faab9631a@citrix.com>

--------------Zynua7uXBy7MiNzM6Om5Hml7
Content-Type: multipart/mixed; boundary="------------OzQRlIwmin5E8UoUJHiWu0RY"

--------------OzQRlIwmin5E8UoUJHiWu0RY
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjAuMDQuMjIgMTc6MjIsIEFuZHJldyBDb29wZXIgd3JvdGU6DQo+IE9uIDIwLzA0LzIw
MjIgMTY6MDksIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy94ZW4veGVuYnVzL3hlbmJ1c19jbGllbnQuYyBiL2RyaXZlcnMveGVuL3hlbmJ1cy94ZW5i
dXNfY2xpZW50LmMNCj4+IGluZGV4IDFhMmUwZDk0Y2NkMS4uN2IxZjdmODZiNmU1IDEwMDY0
NA0KPj4gLS0tIGEvZHJpdmVycy94ZW4veGVuYnVzL3hlbmJ1c19jbGllbnQuYw0KPj4gKysr
IGIvZHJpdmVycy94ZW4veGVuYnVzL3hlbmJ1c19jbGllbnQuYw0KPj4gQEAgLTQzMyw5ICsz
OTAsMjQgQEAgaW50IHhlbmJ1c19zZXR1cF9yaW5nKHN0cnVjdCB4ZW5idXNfZGV2aWNlICpk
ZXYsIGdmcF90IGdmcCwgdm9pZCAqKnZhZGRyLA0KPj4gICAJCWdvdG8gZXJyOw0KPj4gICAJ
fQ0KPj4gICANCj4+IC0JcmV0ID0geGVuYnVzX2dyYW50X3JpbmcoZGV2LCAqdmFkZHIsIG5y
X3BhZ2VzLCBncmVmcyk7DQo+PiAtCWlmIChyZXQpDQo+PiArCXJldCA9IGdudHRhYl9hbGxv
Y19ncmFudF9yZWZlcmVuY2VzKG5yX3BhZ2VzLCAmZ3JlZl9oZWFkKTsNCj4+ICsJaWYgKHJl
dCkgew0KPj4gKwkJeGVuYnVzX2Rldl9mYXRhbChkZXYsIHJldCwgImdyYW50aW5nIGFjY2Vz
cyB0byByaW5nIHBhZ2UiKTsNCj4gDQo+IENhbiB3ZSB0YWtlIHRoZSBvcHBvcnR1bml0eSB0
byB1bmJyZWFrIHRoaXMgZXJyb3IgbWVzc2FnZT/CoCAiJXUgcmluZyBwYWdlcyIuDQoNCkZp
bmUgd2l0aCBtZS4NCg0KDQpKdWVyZ2VuDQo=
--------------OzQRlIwmin5E8UoUJHiWu0RY
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------OzQRlIwmin5E8UoUJHiWu0RY--

--------------Zynua7uXBy7MiNzM6Om5Hml7--

--------------pbiZjsksvj6Z21gBiaYfufUn
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmJgJ8cFAwAAAAAACgkQsN6d1ii/Ey8z
VwgAh1MZdNvdCxCgf5LxO0qIPGvZHJWiJwP/cImXnvin9CGB4VUSgWMQWzPs9Iw7zYJVPEN6VYx2
vlKCqu75kY11q3RfjYcsmFyiNU6BL/VDkbelbFiLDYPVqrkjXiJ0gnGdAsRtFy/09Dihyu21jlLP
fNuRyikPXexmuD5iKsVyAusaKwJG4Uzxd3wr9ChSsoUSZ9/K5VIM+JAbM/Qkm8VfBDldxtbXxXfY
iBSWGHHEFj0E2JdEto7OkMnbQoHeOADXC4wCyOoHd0ZTZV4jbGfRLSzc0LuDvmJFJ2y8l4jRT7R+
vnBNUe4/vdJDqE3LD04IfBoRwu3IbwCDlu9lpcRxAw==
=kcqN
-----END PGP SIGNATURE-----

--------------pbiZjsksvj6Z21gBiaYfufUn--
