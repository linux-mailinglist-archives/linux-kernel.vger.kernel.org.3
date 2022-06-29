Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB724560224
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 16:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233918AbiF2OKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 10:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233882AbiF2OKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 10:10:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250942CE13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 07:10:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B5BAA1F927;
        Wed, 29 Jun 2022 14:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1656511805; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SKb3qQs7axuf7v6bLmTJKcj9bTFBrGGLvM5cZkiAZxo=;
        b=TjC5VTtis4QEO4FRYj+PKvphz69NIKvetmKIm8BwgSWqI7OmA2ImJdGpQ9VJ2AaSijPpMq
        GKgaVygxvU0c5fh3xSMPAulF5LxFwrK74uMASC0CEK1ACiQUikdZ9R2ILogTrJVcBlJFM/
        +cWGlyQAaRN+Wrewd3EshkXTR5P1pfE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6BE89133D1;
        Wed, 29 Jun 2022 14:10:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6VbqGD1dvGKqAgAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 29 Jun 2022 14:10:05 +0000
Message-ID: <2592493b-4339-3e54-8acf-585dcf90be96@suse.com>
Date:   Wed, 29 Jun 2022 16:10:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        regressions@lists.linux.dev
References: <20220623094608.7294-1-jgross@suse.com>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v2 0/3] x86: fix brk area initialization
In-Reply-To: <20220623094608.7294-1-jgross@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------uGZghzY610stt0wl6fX7JZ6R"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------uGZghzY610stt0wl6fX7JZ6R
Content-Type: multipart/mixed; boundary="------------p9mC49YkD27kudZypFeCdkWn";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: xen-devel@lists.xenproject.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, regressions@lists.linux.dev
Message-ID: <2592493b-4339-3e54-8acf-585dcf90be96@suse.com>
Subject: Re: [PATCH v2 0/3] x86: fix brk area initialization
References: <20220623094608.7294-1-jgross@suse.com>
In-Reply-To: <20220623094608.7294-1-jgross@suse.com>

--------------p9mC49YkD27kudZypFeCdkWn
Content-Type: multipart/mixed; boundary="------------UzDDFnJxJu0cFBGkSu0hNa40"

--------------UzDDFnJxJu0cFBGkSu0hNa40
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjMuMDYuMjIgMTE6NDYsIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+IFRoZSBicmsgYXJl
YSBuZWVkcyB0byBiZSB6ZXJvZWQgaW5pdGlhbGx5LCBsaWtlIHRoZSAuYnNzIHNlY3Rpb24u
DQo+IEF0IHRoZSBzYW1lIHRpbWUgaXRzIG1lbW9yeSBzaG91bGQgYmUgY292ZXJlZCBieSB0
aGUgRUxGIHByb2dyYW0NCj4gaGVhZGVycy4NCj4gDQo+IEp1ZXJnZW4gR3Jvc3MgKDMpOg0K
PiAgICB4ODYveGVuOiB1c2UgY2xlYXJfYnNzKCkgZm9yIFhlbiBQViBndWVzdHMNCj4gICAg
eDg2OiBmaXggc2V0dXAgb2YgYnJrIGFyZWENCj4gICAgeDg2OiBmaXggLmJyayBhdHRyaWJ1
dGUgaW4gbGlua2VyIHNjcmlwdA0KPiANCj4gICBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9zZXR1
cC5oICB8ICAzICsrKw0KPiAgIGFyY2gveDg2L2tlcm5lbC9oZWFkNjQuYyAgICAgIHwgIDQg
KysrLQ0KPiAgIGFyY2gveDg2L2tlcm5lbC92bWxpbnV4Lmxkcy5TIHwgIDIgKy0NCj4gICBh
cmNoL3g4Ni94ZW4vZW5saWdodGVuX3B2LmMgICB8ICA4ICsrKysrKy0tDQo+ICAgYXJjaC94
ODYveGVuL3hlbi1oZWFkLlMgICAgICAgfCAxMCArLS0tLS0tLS0tDQo+ICAgNSBmaWxlcyBj
aGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCAxMyBkZWxldGlvbnMoLSkNCj4gDQoNCkNvdWxk
IEkgcGxlYXNlIGhhdmUgc29tZSBmZWVkYmFjaz8gVGhpcyBzZXJpZXMgaXMgZml4aW5nIGEg
bWFqb3INCnJlZ3Jlc3Npb24gcmVnYXJkaW5nIHJ1bm5pbmcgYXMgWGVuIFBWIGd1ZXN0IChk
ZXBlbmRpbmcgb24ga2VybmVsDQpjb25maWd1cmF0aW9uIHN5c3RlbSB3aWxsIGNyYXNoIHZl
cnkgZWFybHkpLg0KDQojcmVnemJvdCBeaW50cm9kdWNlZCBlMzI2ODNjNmY3ZDINCg0KDQpK
dWVyZ2VuDQo=
--------------UzDDFnJxJu0cFBGkSu0hNa40
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------UzDDFnJxJu0cFBGkSu0hNa40--

--------------p9mC49YkD27kudZypFeCdkWn--

--------------uGZghzY610stt0wl6fX7JZ6R
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmK8XTwFAwAAAAAACgkQsN6d1ii/Ey+a
ZAf/RRtfJG9S29Qozq/Vh4Ztvwb8yuAVX6zeDmhN69LCbbmcNf0veBd555vVoqgph8g2uAdar8RE
+jyKPr9ay4A5GXC5vLW99w0yCGhSP1A0D58w7KXr95qg5CUh7e4rx094nd8dTm5QN0z9YKShIUUN
B6LYAgHuWju3dW2goGSlA2Hxb+KSi6q6NpcLHA7V2/irXVwlVG3dT64qRShxXD9m3AC1hKC+IxXg
y2RNPgO0E2FvrDF3ClYXAOsscG2+psCT6GyDS5nzaWqcjvXwX/EJBxVQycN6B/ToVX9mB6FcPzYy
Eado7aKY7P9aQCGbnoJ4pqnieb/pty6EeFj/H/cYjw==
=E4vZ
-----END PGP SIGNATURE-----

--------------uGZghzY610stt0wl6fX7JZ6R--
