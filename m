Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A3455E027
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345359AbiF1MDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 08:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344929AbiF1MDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:03:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD4226F1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 05:03:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0C2DD21EDC;
        Tue, 28 Jun 2022 12:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1656417796; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yVWg7wp4h+Cfn2qEfC6WV/K5Vv+RBe+YiFsHKlpkmZQ=;
        b=hn0c66rsHaEfSrsSHHC75IHTya+X9eM25nyDtKYbte2CMyE/UkS5l2Qk+r7uMe2XaB4x9P
        FyitlS0G+yD3KL+iWvvwRwSZHj4mp6FJMYNS74SzKWDKnaIsRvJJS0jRmErIdE30Vr6sL4
        WYPCi5jahpUkFo1HGGlnS4TmaMnHVBM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A35D5139E9;
        Tue, 28 Jun 2022 12:03:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HhcWJgPuumJVFAAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 28 Jun 2022 12:03:15 +0000
Message-ID: <8e7faa1d-9e72-5b2e-2a70-426d822d05b3@suse.com>
Date:   Tue, 28 Jun 2022 14:03:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     Jan Beulich <jbeulich@suse.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20220623094608.7294-1-jgross@suse.com>
 <20220623094608.7294-2-jgross@suse.com>
 <117fd526-a241-2f01-47b5-e40e1803124b@suse.com>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v2 1/3] x86/xen: use clear_bss() for Xen PV guests
In-Reply-To: <117fd526-a241-2f01-47b5-e40e1803124b@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------PKRvAy4qT3iQa0ns18QQvZQy"
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
--------------PKRvAy4qT3iQa0ns18QQvZQy
Content-Type: multipart/mixed; boundary="------------80o8n7krF6sw0zfxyPWo7gx5";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Jan Beulich <jbeulich@suse.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 xen-devel@lists.xenproject.org, x86@kernel.org, linux-kernel@vger.kernel.org
Message-ID: <8e7faa1d-9e72-5b2e-2a70-426d822d05b3@suse.com>
Subject: Re: [PATCH v2 1/3] x86/xen: use clear_bss() for Xen PV guests
References: <20220623094608.7294-1-jgross@suse.com>
 <20220623094608.7294-2-jgross@suse.com>
 <117fd526-a241-2f01-47b5-e40e1803124b@suse.com>
In-Reply-To: <117fd526-a241-2f01-47b5-e40e1803124b@suse.com>

--------------80o8n7krF6sw0zfxyPWo7gx5
Content-Type: multipart/mixed; boundary="------------sDLlMP0x9f6jm3WTSHG4Qbmi"

--------------sDLlMP0x9f6jm3WTSHG4Qbmi
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjMuMDYuMjIgMTE6NTEsIEphbiBCZXVsaWNoIHdyb3RlOg0KPiBPbiAyMy4wNi4yMDIy
IDExOjQ2LCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KPj4gLS0tIGEvYXJjaC94ODYveGVuL2Vu
bGlnaHRlbl9wdi5jDQo+PiArKysgYi9hcmNoL3g4Ni94ZW4vZW5saWdodGVuX3B2LmMNCj4+
IEBAIC0xMTgzLDE1ICsxMTgzLDE5IEBAIHN0YXRpYyB2b2lkIF9faW5pdCB4ZW5fZG9tdV9z
ZXRfbGVnYWN5X2ZlYXR1cmVzKHZvaWQpDQo+PiAgIGV4dGVybiB2b2lkIGVhcmx5X3hlbl9p
cmV0X3BhdGNoKHZvaWQpOw0KPj4gICANCj4+ICAgLyogRmlyc3QgQyBmdW5jdGlvbiB0byBi
ZSBjYWxsZWQgb24gWGVuIGJvb3QgKi8NCj4+IC1hc21saW5rYWdlIF9fdmlzaWJsZSB2b2lk
IF9faW5pdCB4ZW5fc3RhcnRfa2VybmVsKHZvaWQpDQo+PiArYXNtbGlua2FnZSBfX3Zpc2li
bGUgdm9pZCBfX2luaXQgeGVuX3N0YXJ0X2tlcm5lbChzdHJ1Y3Qgc3RhcnRfaW5mbyAqc2kp
DQo+PiAgIHsNCj4+ICAgCXN0cnVjdCBwaHlzZGV2X3NldF9pb3BsIHNldF9pb3BsOw0KPj4g
ICAJdW5zaWduZWQgbG9uZyBpbml0cmRfc3RhcnQgPSAwOw0KPj4gICAJaW50IHJjOw0KPj4g
ICANCj4+IC0JaWYgKCF4ZW5fc3RhcnRfaW5mbykNCj4+ICsJaWYgKCFzaSkNCj4+ICAgCQly
ZXR1cm47DQo+PiAgIA0KPj4gKwljbGVhcl9ic3MoKTsNCj4gDQo+IEFzIHBlciBzdWJzZXF1
ZW50IG9ic2VydmF0aW9uLCB0aGlzIHNob3VsZG4ndCByZWFsbHkgYmUgbmVlZGVkOiBUaGUN
Cj4gaHlwZXJ2aXNvciAob3IgdG9vbCBzdGFjayBmb3IgRG9tVS1zKSBhbHJlYWR5IGRvZXMg
c28uIFdoaWxlIEkgZ3Vlc3MNCj4gd2Ugd2FudCB0byBrZWVwIGl0IHRvIGJlIG9uIHRoZSBz
YWZlIHNpZGUsIG1heWJlIHdvcnRoIGEgY29tbWVudD8NCg0KQXJlIHlvdSBzdXJlIGFsbCBw
b3NzaWJsZSBib290IGxvYWRlcnMgYXJlIGNsZWFyaW5nIGFsbG9jLW9ubHkgc2VjdGlvbnM/
DQoNCkknZCByYXRoZXIgbm90IGNvdW50IG9uIGUuZy4gZ3J1YiBkb2luZyB0aGlzIGluIGFs
bCBjYXNlcy4NCg0KDQpKdWVyZ2VuDQo=
--------------sDLlMP0x9f6jm3WTSHG4Qbmi
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------sDLlMP0x9f6jm3WTSHG4Qbmi--

--------------80o8n7krF6sw0zfxyPWo7gx5--

--------------PKRvAy4qT3iQa0ns18QQvZQy
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmK67gMFAwAAAAAACgkQsN6d1ii/Ey8H
Ugf+OD0yOcSu9qozk0L8XeQDqTSi3n0Bqexn+BBDt0XHm6r4L2T2nvJU+bm4aH5cJDM8yrn6ZBze
cv9u3M/ecd16V2FT4ISCgC769pZX+9BEUD+GGwKsEhCaTiVw67M+Te/HqgqrnMClvQD4WBOBU4a5
AFaJRyBb1kymiMPPW16OlNeGH8a1+5/m6G3Kxz4bvfbhuAJDeusORVKsHEwts77+8wHd7ZRQG6O+
d9OmaoT9tpFr1QSOCfYLx5X4wGnr+G6LFX8955T1JzKkVJ9g275FTBnStHGtnGcXsxFpkMv7ejK9
EQMtmeyo0A+EVQt3QXGr9aRZL5jZR8uw7De/F9rXCA==
=5oig
-----END PGP SIGNATURE-----

--------------PKRvAy4qT3iQa0ns18QQvZQy--
