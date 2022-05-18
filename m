Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D794352B2EC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 09:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbiERGwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 02:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbiERGv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 02:51:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061BC255
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 23:51:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1EBC821B95;
        Wed, 18 May 2022 06:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652856684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QZ3xSzAbpENpHAyFUOE8ygTqPn5djDgy0iBJKdjMqII=;
        b=NilKRIim5KBXGg2kwSJPHd8hVvDi2Nb6kBJh4CjXVJLsfc9J7IhMJn8zL4mO6FMrDI1cgY
        ZoBSbTNT9Ii9EIaJ/lovkIln3jcpF1Sa4GyCJE77e/mF0P4ATgmGat5hh0P8F/s12U4oST
        aKfH6aaL++D8pEtZS9UqDJpa4XLJ9o0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AC30513A6D;
        Wed, 18 May 2022 06:51:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Iq0AKGuXhGKTPgAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 18 May 2022 06:51:23 +0000
Message-ID: <bdfca03d-66e7-44b4-0c79-d0558437e432@suse.com>
Date:   Wed, 18 May 2022 08:51:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] x86: xen: remove STACK_FRAME_NON_STANDARD from xen_cpuid
Content-Language: en-US
To:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Maximilian Heyne <mheyne@amazon.de>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org
References: <20220517162425.100567-1-mheyne@amazon.de>
 <20220517164229.ixz7fqxwrxwmiizn@treble>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <20220517164229.ixz7fqxwrxwmiizn@treble>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------74x0OnXh0yd7AIWTKDFPGdV2"
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------74x0OnXh0yd7AIWTKDFPGdV2
Content-Type: multipart/mixed; boundary="------------CCXoDBa40f5JJDFmJ1SLT0DL";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>, Maximilian Heyne <mheyne@amazon.de>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Message-ID: <bdfca03d-66e7-44b4-0c79-d0558437e432@suse.com>
Subject: Re: [PATCH] x86: xen: remove STACK_FRAME_NON_STANDARD from xen_cpuid
References: <20220517162425.100567-1-mheyne@amazon.de>
 <20220517164229.ixz7fqxwrxwmiizn@treble>
In-Reply-To: <20220517164229.ixz7fqxwrxwmiizn@treble>

--------------CCXoDBa40f5JJDFmJ1SLT0DL
Content-Type: multipart/mixed; boundary="------------JZLfEJinIuvVgpen3Kze5FMZ"

--------------JZLfEJinIuvVgpen3Kze5FMZ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTcuMDUuMjIgMTg6NDIsIEpvc2ggUG9pbWJvZXVmIHdyb3RlOg0KPiBPbiBUdWUsIE1h
eSAxNywgMjAyMiBhdCAwNDoyNDoyNVBNICswMDAwLCBNYXhpbWlsaWFuIEhleW5lIHdyb3Rl
Og0KPj4gU2luY2UgY29tbWl0IDRkNjVhZGZjZDExOSAoIng4NjogeGVuOiBpbnNuOiBEZWNv
ZGUgWGVuIGFuZCBLVk0NCj4+IGVtdWxhdGUtcHJlZml4IHNpZ25hdHVyZSIpLCBvYmp0b29s
IGlzIGFibGUgdG8gY29ycmVjdGx5IHBhcnNlIHRoZQ0KPj4gcHJlZml4ZWQgaW5zdHJ1Y3Rp
b24gaW4geGVuX2NwdWlkIGFuZCBlbWl0IGNvcnJlY3Qgb3JjIHVud2luZA0KPj4gaW5mb3Jt
YXRpb24uIEhlbmNlLCBtYXJraW5nIHRoZSBmdW5jdGlvbiBhcyBTVEFDS0ZSQU1FX05PTl9T
VEFOREFSRCBpcw0KPj4gbm8gbG9uZ2VyIG5lZWRlZC4NCj4+DQo+PiBUaGlzIGNvbW1pdCBp
cyBiYXNpY2FsbHkgYSByZXZlcnQgb2YgY29tbWl0IDk4M2JiNmQyNTRjNyAoIng4Ni94ZW46
IE1hcmsNCj4+IHhlbl9jcHVpZCgpIHN0YWNrIGZyYW1lIGFzIG5vbi1zdGFuZGFyZCIpLg0K
Pj4NCj4+IFNpZ25lZC1vZmYtYnk6IE1heGltaWxpYW4gSGV5bmUgPG1oZXluZUBhbWF6b24u
ZGU+DQo+PiBDQzogSm9zaCBQb2ltYm9ldWYgPGpwb2ltYm9lQGtlcm5lbC5vcmc+DQo+Pg0K
Pj4gY3I6IGh0dHBzOi8vY29kZS5hbWF6b24uY29tL3Jldmlld3MvQ1ItNjk2NDUwODANCj4g
ICAgICAgIF5eXl5eDQo+IA0KPiBUaGlzIGxvb2tzIGxpa2UgYW4gaW50ZXJuYWwgYW1hem9u
IGxpbmsgYW5kIHNob3VsZCBiZSByZW1vdmVkLg0KPiBPdGhlcndpc2UsIGxvb2tzIGdvb2Qg
dG8gbWUuDQoNCkNhbiBiZSBkb25lIHdoaWxlIGNvbW1pdHRpbmcuDQoNClJldmlld2VkLWJ5
OiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+DQoNCg0KSnVlcmdlbg0K
--------------JZLfEJinIuvVgpen3Kze5FMZ
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------JZLfEJinIuvVgpen3Kze5FMZ--

--------------CCXoDBa40f5JJDFmJ1SLT0DL--

--------------74x0OnXh0yd7AIWTKDFPGdV2
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB4BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmKEl2sFAwAAAAAACgkQsN6d1ii/Ey/A
7wf2KDlTnSiyyI8o5vega9yByUIpmzyC52POyc67sYCwjK5eGs3q8izbF2JgTZotA2STLQniX9R/
KxHE8Jhfo4tTLiUnDpljoPzEn6VVuJkgeGAYDWJqOhYlr7OteqJZIOhD/Z07jI9MatbKjRqe+aRj
TD9BOJg6W/r0uAWdGBc9B0HFPTKxi7+P6LMgCvbPzeRlDl/H9bjX1kCHvnXlIjvrd59UQ76S1eRg
rrsxUapIDsQ0Kcj+Ei/TB5qcGeZuAoGUr1Lq3/y+BdocxdMMYD+pJ2dPKfj6t2VpIvSztgyrQ0gl
+3EUwPWeeNis6ODa+H4GU/IvXYeX6yq23FjGfyMS
=mleQ
-----END PGP SIGNATURE-----

--------------74x0OnXh0yd7AIWTKDFPGdV2--
