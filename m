Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAFA4C4583
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241017AbiBYNLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:11:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241007AbiBYNLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:11:30 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B771EDA20
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:10:51 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E0CEF1F383;
        Fri, 25 Feb 2022 13:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645794649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eUojYv+oX7BFamXdVFlRIzLk+XRgrlr6JqewWUQNEIE=;
        b=nEP45D6KFLEd+HysBxr9Xy5B5mCJurI/lwqkrTjggPy/ji64xOL//vVjwjJSRHgalctj7n
        h5a8K1zOsjCZP3PXh0fvQIT0G1HmLkG73pIot6wTBSezWUQTRj5EJuGkKmab6qXgKinZQc
        Xt979J4DnxUvCZUgSGCXGiApSxAZY7w=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1C9F513519;
        Fri, 25 Feb 2022 13:10:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Z9ihOljVGGK+QgAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 25 Feb 2022 13:10:48 +0000
Message-ID: <375952e2-87af-79cc-c067-4364252ab22f@suse.com>
Date:   Fri, 25 Feb 2022 14:10:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5 1/3] MAINTAINERS: Update maintainers for paravirt ops
 and VMware hypervisor interface
Content-Language: en-US
To:     "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>, x86@kernel.org,
        pv-drivers@vmware.com, tglx@linutronix.de, bp@alien8.de
Cc:     Alexey Makhalov <amakhalov@vmware.com>,
        Deep Shah <sdeep@vmware.com>, vithampi@vmware.com,
        keerthanak@vmware.com, srivatsab@vmware.com, anishs@vmware.com,
        linux-kernel@vger.kernel.org, namit@vmware.com, joe@perches.com,
        kuba@kernel.org, rostedt@goodmis.org
References: <164574138686.654750.10250173565414769119.stgit@csail.mit.edu>
 <164574143710.654750.17342470717937593195.stgit@csail.mit.edu>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <164574143710.654750.17342470717937593195.stgit@csail.mit.edu>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------29t2LMCCQC8QOiYo5iq7cuuQ"
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
--------------29t2LMCCQC8QOiYo5iq7cuuQ
Content-Type: multipart/mixed; boundary="------------AeeXwk2O6jRaKrbpuBln0voK";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>, x86@kernel.org,
 pv-drivers@vmware.com, tglx@linutronix.de, bp@alien8.de
Cc: Alexey Makhalov <amakhalov@vmware.com>, Deep Shah <sdeep@vmware.com>,
 vithampi@vmware.com, keerthanak@vmware.com, srivatsab@vmware.com,
 anishs@vmware.com, linux-kernel@vger.kernel.org, namit@vmware.com,
 joe@perches.com, kuba@kernel.org, rostedt@goodmis.org
Message-ID: <375952e2-87af-79cc-c067-4364252ab22f@suse.com>
Subject: Re: [PATCH v5 1/3] MAINTAINERS: Update maintainers for paravirt ops
 and VMware hypervisor interface
References: <164574138686.654750.10250173565414769119.stgit@csail.mit.edu>
 <164574143710.654750.17342470717937593195.stgit@csail.mit.edu>
In-Reply-To: <164574143710.654750.17342470717937593195.stgit@csail.mit.edu>

--------------AeeXwk2O6jRaKrbpuBln0voK
Content-Type: multipart/mixed; boundary="------------Wn4y4i3amsZqtrpQHhcygLzB"

--------------Wn4y4i3amsZqtrpQHhcygLzB
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjQuMDIuMjIgMjM6MjQsIFNyaXZhdHNhIFMuIEJoYXQgd3JvdGU6DQo+IEZyb206IFNy
aXZhdHNhIFMuIEJoYXQgKFZNd2FyZSkgPHNyaXZhdHNhQGNzYWlsLm1pdC5lZHU+DQo+IA0K
PiBEZWVwIGhhcyBkZWNpZGVkIHRvIHRyYW5zZmVyIHRoZSBqb2ludC1tYWludGFpbmVyc2hp
cCBvZiBwYXJhdmlydCBvcHMNCj4gdG8gU3JpdmF0c2EsIGFuZCB0aGUgbWFpbnRhaW5lcnNo
aXAgb2YgdGhlIFZNd2FyZSBoeXBlcnZpc29yIGludGVyZmFjZQ0KPiB0byBTcml2YXRzYSBh
bmQgQWxleGV5LiBVcGRhdGUgdGhlIE1BSU5UQUlORVJTIGZpbGUgdG8gcmVmbGVjdCB0aGlz
DQo+IGNoYW5nZSwgYW5kIGFsc28gYWRkIEFsZXhleSBhcyBhIHJldmlld2VyIGZvciBwYXJh
dmlydCBvcHMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBTcml2YXRzYSBTLiBCaGF0IChWTXdh
cmUpIDxzcml2YXRzYUBjc2FpbC5taXQuZWR1Pg0KPiBBY2tlZC1ieTogQWxleGV5IE1ha2hh
bG92IDxhbWFraGFsb3ZAdm13YXJlLmNvbT4NCj4gQWNrZWQtYnk6IERlZXAgU2hhaCA8c2Rl
ZXBAdm13YXJlLmNvbT4NCj4gQ2M6IEp1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4N
Cg0KQWNrZWQtYnk6IEp1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4NCg0KDQpKdWVy
Z2VuDQo=
--------------Wn4y4i3amsZqtrpQHhcygLzB
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------Wn4y4i3amsZqtrpQHhcygLzB--

--------------AeeXwk2O6jRaKrbpuBln0voK--

--------------29t2LMCCQC8QOiYo5iq7cuuQ
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmIY1VgFAwAAAAAACgkQsN6d1ii/Ey8a
lwgAg3CewYQxWcD0zp/zRFRvs391kC+/R247t8nwd2NPG3BudJzoH2itXHQk/nOpANxG09gGkGTD
sW0mqnI5vIhea3tv746ocAOjB7goxpODQuY4crjv5JC2Daja2KjpBz2peF/uWlGxfUtzcJxb2K6r
yRAbaooy17+vw2xbsB2v7pWT5ZLRaCuTC876/tqvBhzhA7GUbXzCc/qUFq2JdXRSWwV5j+56br1e
vhFLUnZemd8pRTjUw/psL3kmqj99G9uvUjsxGSt767ygTb/Hwv5qhYf6Dd3tHLGzsQDfYdGXK92+
yuypvfQO8H4VXAIEAlMMXw2oZxnK8PzkSy2E+Fk+NA==
=xeNw
-----END PGP SIGNATURE-----

--------------29t2LMCCQC8QOiYo5iq7cuuQ--
