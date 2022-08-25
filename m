Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D785A1016
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 14:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235306AbiHYMNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 08:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241394AbiHYMNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 08:13:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD865AB058
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 05:13:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4EFF21FDF5;
        Thu, 25 Aug 2022 12:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1661429584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JdJxAPoA2WJkOjRSESc7wPCa+hS4lUCOlOuMq9PfJn4=;
        b=rUTt9cOAcD8YLMR46rQRGFYzWzHk6PcLKJPbFL6ID/tcwuSOSb/TmVWzhOIep1BGxdqKvO
        RMk/rl99LYAtTXiE9tiUpWe8qzvn727HAjW7GjSg52ci5bp5a9mNee+Nl3DbIz0Z1EyoQw
        8+QcfsdS4u4e/iVH2IADgtyRKJK1Ckg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EA28A13A8E;
        Thu, 25 Aug 2022 12:13:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wobRNk9nB2PyDgAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 25 Aug 2022 12:13:03 +0000
Message-ID: <6b830ad8-1406-b740-27ba-f1161df99b0f@suse.com>
Date:   Thu, 25 Aug 2022 14:13:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 02/10] x86/mtrr: remove unused cyrix_set_all() function
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20220820092533.29420-1-jgross@suse.com>
 <20220820092533.29420-3-jgross@suse.com> <YwdPb4pWqppgzIpm@zn.tnic>
 <aff049cb-ebdd-68ad-5597-d22f87026297@suse.com> <YwdgGFJWTV1YF3n2@zn.tnic>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <YwdgGFJWTV1YF3n2@zn.tnic>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------w8yUqS6oV0V6m9JR6coCENwL"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------w8yUqS6oV0V6m9JR6coCENwL
Content-Type: multipart/mixed; boundary="------------601I3US8zQXjktOjXHqfW5oJ";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>
Cc: xen-devel@lists.xenproject.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <6b830ad8-1406-b740-27ba-f1161df99b0f@suse.com>
Subject: Re: [PATCH v2 02/10] x86/mtrr: remove unused cyrix_set_all() function
References: <20220820092533.29420-1-jgross@suse.com>
 <20220820092533.29420-3-jgross@suse.com> <YwdPb4pWqppgzIpm@zn.tnic>
 <aff049cb-ebdd-68ad-5597-d22f87026297@suse.com> <YwdgGFJWTV1YF3n2@zn.tnic>
In-Reply-To: <YwdgGFJWTV1YF3n2@zn.tnic>

--------------601I3US8zQXjktOjXHqfW5oJ
Content-Type: multipart/mixed; boundary="------------8Abn2UA0vYr3cGM5R7ZnpIVF"

--------------8Abn2UA0vYr3cGM5R7ZnpIVF
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjUuMDguMjIgMTM6NDIsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gVGh1LCBB
dWcgMjUsIDIwMjIgYXQgMTI6NDE6MDVQTSArMDIwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToN
Cj4+IE1heWJlIHRoZSBhbHRlcm5hdGl2ZSByZWFzb25pbmcgaXMgbXVjaCBmYXN0ZXIgdG8g
dW5kZXJzdGFuZDogaWYgdGhlDQo+PiBDeXJpeCBzZXRfYWxsKCkgY291bGQgYmUgY2FsbGVk
LCB0aGUgQU1EIGFuZCBDZW50YXVyIG9uZXMgd291bGQgYmUgY2FsbGFibGUsDQo+PiB0b28u
DQo+IA0KPiBSaWdodC4NCj4gDQo+PiBUaG9zZSBiZWluZyBjYWxsZWQgd291bGQgcmVzdWx0
IGluIGEgTlVMTCBkZXJlZiwgc28gd2h5IHNob3VsZCB3ZSBrZWVwDQo+PiB0aGUgQ3lyaXgg
b25lPw0KPiANCj4gSSBrbm93IHlvdSdyZSBlYWdlciB0byByZW1vdmUgZGVhZCBjb2RlIC0g
SSdkIGxvdmUgdGhhdCB0b28uIEJ1dCBiZWZvcmUNCj4gd2UgZG8gdGhhdCwgd2UgbmVlZCB0
byBmaW5kIG91dCB3aGV0aGVyIHNvbWUgQ3lyaXggaHcgb3V0IHRoZXJlIHdvdWxkDQo+IG5v
dCBuZWVkIHRoaXMuDQoNCkJhY2sgdG8gcmVhc29uaW5nICMxLiBPbmx5IHRoZSB1c2VfaW50
ZWwoKSBjYXNlIGNhbGxzIHRoZSBjb2RlIGluIHF1ZXN0aW9uDQp3aXRoIHJlZyA9PSB+MC4g
QW5kIHVzZV9pbnRlbCgpIGlzIGNsZWFybHkgbm90IEN5cml4Lg0KDQoNCkp1ZXJnZW4NCg==

--------------8Abn2UA0vYr3cGM5R7ZnpIVF
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------8Abn2UA0vYr3cGM5R7ZnpIVF--

--------------601I3US8zQXjktOjXHqfW5oJ--

--------------w8yUqS6oV0V6m9JR6coCENwL
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmMHZ08FAwAAAAAACgkQsN6d1ii/Ey8h
oQf+NdIM3QfdjUwtclr315py/S0njAMRYAei4Faif5dIXVBhpTTF920lnZrhWewTBtXW82mbQY6q
OljsoBGY9jyMIxRBZERqqeX1sWC36MxmMyAE7cXnKzGXZC16x17JMiSZMgPX6Thf6XpcAYT38OuZ
Cormn1SpaYzYQIzeU55M8G3L8hhN8TW0tJGYJTPbVKWN7oIHhZdPtA3D9/JVZ0HSzNO7PXz3zAzr
jBStRutX5nYhXhPBKYRThust4AFH/ka+bhC9ZuOtQFseT8Tz6sXxJuMOcYw2tNlnrBOCCYm8xLxm
Bc+952fe+jOppzdOVmgtbOe38H+rnslT1x8yr3Fvgw==
=/0ma
-----END PGP SIGNATURE-----

--------------w8yUqS6oV0V6m9JR6coCENwL--
