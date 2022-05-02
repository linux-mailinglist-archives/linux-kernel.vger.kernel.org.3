Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32ADF516F7A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 14:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384990AbiEBMWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 08:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiEBMWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 08:22:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FFE15FC5
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 05:18:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CB94221877;
        Mon,  2 May 2022 12:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651493916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vxL8VGu3fWjcp+srwnIwSZeuC3yLWivdZkYkS5iW/EE=;
        b=PvwSQV4NxumUh95cE/oyVr9KQz+F/Lhctg3ybJErI33CdzegDT1wtaTnnkePXGFQgVVAj7
        Dg2+/cIF8xM89xMkmHesJvfvBMaOXFzag+KeaHZEJbP6vC+zxv2sMbeYwkvHSpSANQXnp7
        Ji8indUPsppC+TIP1G3B0BOgyvguk4I=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6735D13491;
        Mon,  2 May 2022 12:18:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sA9vFxzMb2L4cwAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 02 May 2022 12:18:36 +0000
Message-ID: <3db51f9f-317a-352a-4214-0f159b6cd34c@suse.com>
Date:   Mon, 2 May 2022 14:18:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH V6 6/8] x86/entry: Convert SWAPGS to swapgs and remove the
 definition of SWAPGS
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
References: <20220421141055.316239-1-jiangshanlai@gmail.com>
 <20220421141055.316239-7-jiangshanlai@gmail.com> <Ymu2XC7k8Xj/vMjG@zn.tnic>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <Ymu2XC7k8Xj/vMjG@zn.tnic>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------096pY9loLJhLLoe3NQ7nt6xE"
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------096pY9loLJhLLoe3NQ7nt6xE
Content-Type: multipart/mixed; boundary="------------8fWnUdb74ellbAfE7pxh7CFl";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>, Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 Lai Jiangshan <jiangshan.ljs@antgroup.com>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 "Kirill A. Shutemov" <kirill@shutemov.name>
Message-ID: <3db51f9f-317a-352a-4214-0f159b6cd34c@suse.com>
Subject: Re: [PATCH V6 6/8] x86/entry: Convert SWAPGS to swapgs and remove the
 definition of SWAPGS
References: <20220421141055.316239-1-jiangshanlai@gmail.com>
 <20220421141055.316239-7-jiangshanlai@gmail.com> <Ymu2XC7k8Xj/vMjG@zn.tnic>
In-Reply-To: <Ymu2XC7k8Xj/vMjG@zn.tnic>

--------------8fWnUdb74ellbAfE7pxh7CFl
Content-Type: multipart/mixed; boundary="------------bTp2Z3wG1OClvf7LAruBGv0W"

--------------bTp2Z3wG1OClvf7LAruBGv0W
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjkuMDQuMjIgMTE6NTYsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gVGh1LCBB
cHIgMjEsIDIwMjIgYXQgMTA6MTA6NTNQTSArMDgwMCwgTGFpIEppYW5nc2hhbiB3cm90ZToN
Cj4+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9lbnRyeS9lbnRyeV82NF9jb21wYXQuUyBiL2Fy
Y2gveDg2L2VudHJ5L2VudHJ5XzY0X2NvbXBhdC5TDQo+PiBpbmRleCA0ZmRiMDA3Y2RkYmQu
LmM1YWViMDgxOTcwNyAxMDA2NDQNCj4+IC0tLSBhL2FyY2gveDg2L2VudHJ5L2VudHJ5XzY0
X2NvbXBhdC5TDQo+PiArKysgYi9hcmNoL3g4Ni9lbnRyeS9lbnRyeV82NF9jb21wYXQuUw0K
Pj4gQEAgLTUwLDcgKzUwLDcgQEAgU1lNX0NPREVfU1RBUlQoZW50cnlfU1lTRU5URVJfY29t
cGF0KQ0KPj4gICAJVU5XSU5EX0hJTlRfRU1QVFkNCj4+ICAgCUVOREJSDQo+PiAgIAkvKiBJ
bnRlcnJ1cHRzIGFyZSBvZmYgb24gZW50cnkuICovDQo+PiAtCVNXQVBHUw0KPj4gKwlzd2Fw
Z3MNCj4+ICAgDQo+PiAgIAlwdXNocQklcmF4DQo+PiAgIAlTV0lUQ0hfVE9fS0VSTkVMX0NS
MyBzY3JhdGNoX3JlZz0lcmF4DQo+IA0KPiBJJ20gbm90IHN1cmUgYWJvdXQgdGhpczogd2h5
IGNhbid0IFhFTlBWIGRvIGEgMzItYml0IHN5c2NhbGwgdGhyb3VnaCB0aGUgdmRzbz8NCg0K
VGhlIHN5c2NhbGwgd2lsbCBsYW5kIGluIHRoZSBoeXBlcnZpc29yLCB3aGljaCB0aGVuIHdp
bGwgYWN0aXZhdGUNCnRoZSByZWxhdGVkIHJlZ2lzdGVyZWQgY2FsbGJhY2sgKHhlbl9zeXNl
bnRlcl90YXJnZXQpLg0KDQo+IEFsc28sIGxvb2tpbmcgYXQgdGhpcywgSsO8cmdlbiwgaXQg
bG9va3Mga2luZGEgc3BhZ2hldHRpIHRvIG1lOg0KPiANCj4gZW50cnlfU1lTRU5URVJfY29t
cGF0DQo+IA0KPiAuLi4NCj4gDQo+ICAgICAgICAgIC8qIFhFTiBQViBndWVzdHMgYWx3YXlz
IHVzZSBJUkVUIHBhdGggKi8NCj4gICAgICAgICAgQUxURVJOQVRJVkUgInRlc3RsICVlYXgs
ICVlYXg7IGp6IHN3YXBnc19yZXN0b3JlX3JlZ3NfYW5kX3JldHVybl90b191c2VybW9kZSIs
IFwNCj4gICAgICAgICAgICAgICAgICAgICAgImptcCBzd2FwZ3NfcmVzdG9yZV9yZWdzX2Fu
ZF9yZXR1cm5fdG9fdXNlcm1vZGUiLCBYODZfRkVBVFVSRV9YRU5QVg0KPiANCj4gDQo+IHRo
ZW4gYXQgdGhhdCBzd2FwZ3NfcmVzdG9yZV9yZWdzX2FuZF9yZXR1cm5fdG9fdXNlcm1vZGUg
bGFiZWw6DQo+IA0KPiAjaWZkZWYgQ09ORklHX1hFTl9QVg0KPiAgICAgICAgICBBTFRFUk5B
VElWRSAiIiwgImptcCB4ZW5wdl9yZXN0b3JlX3JlZ3NfYW5kX3JldHVybl90b191c2VybW9k
ZSIsIFg4Nl9GRUFUVVJFX1hFTlBWDQo+ICNlbmRpZg0KPiANCj4gDQo+IENhbiB3ZSBzaW1w
bHkganVtcCBkaXJlY3RseSB0byB4ZW5wdl9yZXN0b3JlX3JlZ3NfYW5kX3JldHVybl90b191
c2VybW9kZQ0KPiBmcm9tIGVudHJ5X1NZU0VOVEVSX2NvbXBhdCBvciBpcyB0aGF0IENPTkZJ
R19ERUJVR19FTlRSWSBjaHVuayB0aGVyZQ0KPiBuZWVkZWQ/DQoNCkkgd291bGRuJ3QgaW5z
aXN0IG9uIHRoZSBDT05GSUdfREVCVUdfRU5UUlkgY2h1bmsuDQoNCg0KSnVlcmdlbg0K
--------------bTp2Z3wG1OClvf7LAruBGv0W
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------bTp2Z3wG1OClvf7LAruBGv0W--

--------------8fWnUdb74ellbAfE7pxh7CFl--

--------------096pY9loLJhLLoe3NQ7nt6xE
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmJvzBsFAwAAAAAACgkQsN6d1ii/Ey8k
/wf+M5mKUqG+FIis7hiNPsb1sjobg1UOLxZ2L23S9FN0beGd3FfyeW5ElXe69wwV7MP/VMIho6ck
SG9KWM8vJ7kYTOimQVO8EuKKHofy0kSg1DcjLp0etefbqP2bugLCabSf3A566jHNatl6DDWKP3Jf
Mxp6FZYklqFSExQNn//nujqncJASTrAZPa6lzcVW3HNy9i0NqGA9Smb+A2rq6OxssCQaSeBM7C7c
oKHWU2KjH7Lf+vzvVuMI+Ykpiu0V0xOLhl0w2Mic1CRkAA1GFII7Ta/fEINGwfiy5PHsVeyELFFn
wPCQnG4/ad7faQUzvaGCT1KyVnHBQ0pQ0uMcE7UK2g==
=0M6c
-----END PGP SIGNATURE-----

--------------096pY9loLJhLLoe3NQ7nt6xE--
