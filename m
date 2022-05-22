Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC08053028E
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 13:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244746AbiEVLIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 07:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbiEVLID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 07:08:03 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237213BBE8
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 04:08:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AF34D1F388;
        Sun, 22 May 2022 11:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1653217681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7jhhjX59gp3INCmTVN5+tXAZn7wIvtS1GymA5skwI10=;
        b=MiUd93T0uon1p0IVPOalJHOEW93egU72//t2wjtdwQbSSw+6mFRVU02/IwihOhcz/7nlcJ
        FOqzCDhGjG+2uneC2iuYk1OT9yWmegF7zOZxcbscbKF9GlOoojE17bZSL0XjU248q0qaq2
        +cZAJc0efSNmT1jzybDvrXSjf6ha9uE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3684613ADF;
        Sun, 22 May 2022 11:08:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nuSQC5EZimL7bgAAMHmgww
        (envelope-from <jgross@suse.com>); Sun, 22 May 2022 11:08:01 +0000
Message-ID: <2f70c3fc-fdb6-450c-d570-f39280798872@suse.com>
Date:   Sun, 22 May 2022 13:08:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] x86: xen: remove STACK_FRAME_NON_STANDARD from xen_cpuid
Content-Language: en-US
To:     Maximilian Heyne <mheyne@amazon.de>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org
References: <20220517162425.100567-1-mheyne@amazon.de>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <20220517162425.100567-1-mheyne@amazon.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------UjP09znP3YBjHC9yreCDjkQ0"
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------UjP09znP3YBjHC9yreCDjkQ0
Content-Type: multipart/mixed; boundary="------------7a22TXAifxypLWqiFjNtqLoM";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Maximilian Heyne <mheyne@amazon.de>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Message-ID: <2f70c3fc-fdb6-450c-d570-f39280798872@suse.com>
Subject: Re: [PATCH] x86: xen: remove STACK_FRAME_NON_STANDARD from xen_cpuid
References: <20220517162425.100567-1-mheyne@amazon.de>
In-Reply-To: <20220517162425.100567-1-mheyne@amazon.de>

--------------7a22TXAifxypLWqiFjNtqLoM
Content-Type: multipart/mixed; boundary="------------dPizdxr0IEHdFSKZq8XyRjCl"

--------------dPizdxr0IEHdFSKZq8XyRjCl
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTcuMDUuMjIgMTg6MjQsIE1heGltaWxpYW4gSGV5bmUgd3JvdGU6DQo+IFNpbmNlIGNv
bW1pdCA0ZDY1YWRmY2QxMTkgKCJ4ODY6IHhlbjogaW5zbjogRGVjb2RlIFhlbiBhbmQgS1ZN
DQo+IGVtdWxhdGUtcHJlZml4IHNpZ25hdHVyZSIpLCBvYmp0b29sIGlzIGFibGUgdG8gY29y
cmVjdGx5IHBhcnNlIHRoZQ0KPiBwcmVmaXhlZCBpbnN0cnVjdGlvbiBpbiB4ZW5fY3B1aWQg
YW5kIGVtaXQgY29ycmVjdCBvcmMgdW53aW5kDQo+IGluZm9ybWF0aW9uLiBIZW5jZSwgbWFy
a2luZyB0aGUgZnVuY3Rpb24gYXMgU1RBQ0tGUkFNRV9OT05fU1RBTkRBUkQgaXMNCj4gbm8g
bG9uZ2VyIG5lZWRlZC4NCj4gDQo+IFRoaXMgY29tbWl0IGlzIGJhc2ljYWxseSBhIHJldmVy
dCBvZiBjb21taXQgOTgzYmI2ZDI1NGM3ICgieDg2L3hlbjogTWFyaw0KPiB4ZW5fY3B1aWQo
KSBzdGFjayBmcmFtZSBhcyBub24tc3RhbmRhcmQiKS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IE1heGltaWxpYW4gSGV5bmUgPG1oZXluZUBhbWF6b24uZGU+DQo+IENDOiBKb3NoIFBvaW1i
b2V1ZiA8anBvaW1ib2VAa2VybmVsLm9yZz4NCg0KUHVzaGVkIHRvIHhlbi90aXAuZ2l0IGZv
ci1saW51cy01LjE5DQoNCg0KSnVlcmdlbg0K
--------------dPizdxr0IEHdFSKZq8XyRjCl
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------dPizdxr0IEHdFSKZq8XyRjCl--

--------------7a22TXAifxypLWqiFjNtqLoM--

--------------UjP09znP3YBjHC9yreCDjkQ0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmKKGZAFAwAAAAAACgkQsN6d1ii/Ey9t
Ygf/RyJdnElkqpjOx/hFvASnaqEo7bBY8I6oLiz+H1XOZCxW+x8y71NU3WJA+8ykTLg2jDk9rpKB
cJSXWWfK7MjVs3Ku05PnvzawCYdYPJybbrvfEYMEdAQfF5SPTxKXlLFCUr1guf6JtlnvaxuC08yo
kHFgxaCc2ewm6w+XBlih3TJQ1wEN3fbNhbhLdHgTKZLJv6H1WYj+JACGG8j6e/YDvx8ZpMOlDiLD
8AL8HRmhf66IZTLxwOMcV4XPi6Ukz+asrWE2FDRa/lmGdAJei/UqDkZyMZR8FHPLAkyH6o7c6Ous
mjzb5QG70tHNJLW3Cx3t2ViPXsjJefvxSKKW+uJhpQ==
=tVnq
-----END PGP SIGNATURE-----

--------------UjP09znP3YBjHC9yreCDjkQ0--
