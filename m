Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829A9557631
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 11:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiFWJDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 05:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiFWJDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 05:03:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB3219FAF
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 02:03:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8611E1FD69;
        Thu, 23 Jun 2022 09:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655974991; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bAKw0xzUEKMoT1Yy+1wdM0M3tDw+GQYafQLrIJQL42w=;
        b=tTNhpU9e6FGUnJ/VrF1WQ8rm0cfR/TwSCKUyU0AG6mAvQUI3kEZJR7TkdTC58AdXSuQbWv
        EKqfrhJUMtbdZUKFHz6jtHbioVfhEOGvkDyNEnLOs6+S53cKuE9SZegThgQiSGOFUunDRJ
        fwChRPACmGdDpT88un9aQVDYpls/MIA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3619A13461;
        Thu, 23 Jun 2022 09:03:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id o4YOC08stGJEGQAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 23 Jun 2022 09:03:11 +0000
Message-ID: <41a4a440-36fc-513a-232f-18b781b41926@suse.com>
Date:   Thu, 23 Jun 2022 11:03:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/2] x86: fix setup of brk area
Content-Language: en-US
To:     Jan Beulich <jbeulich@suse.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <20220622161048.4483-1-jgross@suse.com>
 <20220622161048.4483-3-jgross@suse.com>
 <b210d5c7-26cc-df6f-fa37-56fe04c8d0dc@suse.com>
 <594866df-ef56-055f-c13c-64fac5797164@suse.com>
 <bba2828b-0649-3a93-16a4-eb3b35214af0@suse.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <bba2828b-0649-3a93-16a4-eb3b35214af0@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------0Kgae878YS1jYcAQMbnGeBB5"
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
--------------0Kgae878YS1jYcAQMbnGeBB5
Content-Type: multipart/mixed; boundary="------------kd5r3yTajMvuOOQvM9ZBotxm";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Jan Beulich <jbeulich@suse.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
Message-ID: <41a4a440-36fc-513a-232f-18b781b41926@suse.com>
Subject: Re: [PATCH 2/2] x86: fix setup of brk area
References: <20220622161048.4483-1-jgross@suse.com>
 <20220622161048.4483-3-jgross@suse.com>
 <b210d5c7-26cc-df6f-fa37-56fe04c8d0dc@suse.com>
 <594866df-ef56-055f-c13c-64fac5797164@suse.com>
 <bba2828b-0649-3a93-16a4-eb3b35214af0@suse.com>
In-Reply-To: <bba2828b-0649-3a93-16a4-eb3b35214af0@suse.com>

--------------kd5r3yTajMvuOOQvM9ZBotxm
Content-Type: multipart/mixed; boundary="------------zvMaJq6FxuLUBrOMsqi6oh8u"

--------------zvMaJq6FxuLUBrOMsqi6oh8u
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjMuMDYuMjIgMTA6NTAsIEphbiBCZXVsaWNoIHdyb3RlOg0KPiBPbiAyMy4wNi4yMDIy
IDEwOjE0LCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KPj4gT24gMjMuMDYuMjIgMTA6MDksIEph
biBCZXVsaWNoIHdyb3RlOg0KPj4+IE9uIDIyLjA2LjIwMjIgMTg6MTAsIEp1ZXJnZW4gR3Jv
c3Mgd3JvdGU6DQo+Pj4+IENvbW1pdCBlMzI2ODNjNmY3ZDIgKCJ4ODYvbW06IEZpeCBSRVNF
UlZFX0JSSygpIGZvciBvbGRlciBiaW51dGlscyIpDQo+Pj4+IHB1dCB0aGUgYnJrIGFyZWEg
aW50byB0aGUgLmJzcyBzZWdtZW50LCBjYXVzaW5nIGl0IG5vdCB0byBiZSBjbGVhcmVkDQo+
Pj4+IGluaXRpYWxseS4NCj4+Pg0KPj4+IFRoaXMgcmVhZHMgY29udHJhZGljdGl2ZWx5OiBJ
ZiB0aGUgYXJlYSB3YXMgcHV0IGluIC5ic3MsIGl0IHdvdWxkIGJlDQo+Pj4gY2xlYXJlZC4g
VGhpbmcgaXMgaXQgaXMgcHV0IGluIC5ic3MuLmJyayBpbiB0aGUgb2JqZWN0IGZpbGVzLCB3
aGlsZQ0KPj4+IHRoZSBsaW5rZXIgc2NyaXB0IHB1dHMgaXQgaW4gLmJyayAoaS5lLiBvdXRz
aWRlIG9mIC5ic3MpLg0KPj4NCj4+IEhtbSwgeWVzLCB0aGlzIHNob3VsZCBiZSByZXdvcmRl
ZC4NCj4+DQo+Pj4NCj4+Pj4gQXMgdGhlIGJyayBhcmVhIGlzIHVzZWQgdG8gYWxsb2NhdGUg
ZWFybHkgcGFnZSB0YWJsZXMsIHRoZXNlDQo+Pj4+IG1pZ2h0IGNvbnRhaW4gZ2FyYmFnZSBp
biBub3QgZXhwbGljaXRseSB3cml0dGVuIGVudHJpZXMuDQo+Pj4NCj4+PiBJJ20gc3VycHJp
c2VkIHRoaXMgbGFjayBvZiB6ZXJvLWluaXRpYWxpemF0aW9uIGRpZG4ndCBjYXVzZSBhbnkg
aXNzdWUNCj4+PiBvdXRzaWRlIG9mIFBWIFhlbi4gVW5sZXNzIG9mIGNvdXJzZSB0aGVyZSBu
ZXZlciB3YXMgdGhlIGludGVudGlvbiBmb3INCj4+PiB1c2VycyBvZiB0aGUgZmFjaWxpdHkg
dG8gYXNzdW1lIGJsYW5rIHBhZ2VzIGNvbWluZyBmcm9tIHRoZXJlLCBpbg0KPj4+IHdoaWNo
IGNhc2UgWGVuJ3MgdXNlIGZvciBlYXJseSBwYWdlIHRhYmxlcyB3b3VsZCBoYXZlIGJlZW4g
d3JvbmcgKGluDQo+Pj4gbm90IGV4cGxpY2l0bHkgemVyb2luZyB0aGUgc3BhY2UgZmlyc3Qp
Lg0KPj4NCj4+IEZ1biBmYWN0OiBJdHMgbm90IFhlbidzIHVzZSBmb3IgZWFybHkgcGFnZSB0
YWJsZXMsIGJ1dCB0aGUga2VybmVsJ3MNCj4+IGluaXQgY29kZS4gSXQgaXMgdXNlZCBmb3Ig
YmFyZSBtZXRhbCwgdG9vLg0KPj4NCj4+IFRoZSB1c2UgY2FzZSBmb3IgaW5pdGlhbCBwYWdl
IHRhYmxlcyBpcyB0aGUgcHJvYmxlbWF0aWMgb25lLiBPbmx5IHRoZQ0KPj4gbmVlZGVkIHBh
Z2UgdGFibGUgZW50cmllcyBhcmUgd3JpdHRlbiBieSB0aGUga2VybmVsLCBzbyB0aGUgb3Ro
ZXIgb25lcw0KPj4ga2VlcCB0aGVpciBpbml0aWFsIGdhcmJhZ2UgdmFsdWVzLiBBcyBub3Jt
YWxseSBubyB1bmluaXRpYWxpemVkIGVudHJpZXMNCj4+IGFyZSBldmVyIHJlZmVyZW5jZWQs
IHRoaXMgd2lsbCBoYXZlIG5vIHJlYWwgaW1wYWN0Lg0KPiANCj4gQXJlIHlvdSBzdXJlIHRo
ZXJlIGNvdWxkbid0IHN1cmZhY2UgdXNlci1tb2RlIGFjY2Vzc2libGUgcGFnZSB0YWJsZQ0K
PiBlbnRyaWVzIHBvaW50aW5nIGF0IHJhbmRvbSBwYWdlcz8NCg0KTm8sIEknbSBub3Qgc3Vy
ZSB0aGlzIGNhbid0IGhhcHBlbi4NCg0KDQpKdWVyZ2VuDQoNCg==
--------------zvMaJq6FxuLUBrOMsqi6oh8u
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------zvMaJq6FxuLUBrOMsqi6oh8u--

--------------kd5r3yTajMvuOOQvM9ZBotxm--

--------------0Kgae878YS1jYcAQMbnGeBB5
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmK0LE4FAwAAAAAACgkQsN6d1ii/Ey/j
Qgf+NW0ofa9R6lUtDLFDh4bkvNB842OI9FDH6ntwEmPPNkpeRZDlm+6ERG/pH31mtmz8UQr6MLh8
335F4v4eKtYG7+fvUuzKkMjfvT5HOskrYMwCavpMEDsJ6Ds9bjtaMHSaxoKzA0LRkvqilEpLBXBq
L0q0c37Pxe8+E4nXfRB5uV9/ArA48150fMLIRx0Poc411tlAypyN6kqyeofoUDu4As4dYu/SsRne
SCMUkzrgtIw4ybsINZxHN6YrdsKo3yUaKyMtcEE2ThqpDGkU4oIKpgyhsvNvmDVkzZQ5vojWaEMJ
rzsUOngMtdtpLolRKVSBaQz75wmNdglAChV/cRgHmQ==
=+bXg
-----END PGP SIGNATURE-----

--------------0Kgae878YS1jYcAQMbnGeBB5--
