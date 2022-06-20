Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51777550FB5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 07:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238286AbiFTFaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 01:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiFTFaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 01:30:16 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851C295A3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 22:30:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AD3641F9A0;
        Mon, 20 Jun 2022 05:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655703013; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lTKBeEnkA13UMoSCaO9KZJ/EHnwH3pAZboyVMGM77rU=;
        b=QjLziJ7rqxGaGGZCI/l6SBWrV3yWGMzHEqUYWyHzS4tzmyl792yQtcV4wJylgPv01vLTF/
        /fo/C8+r32/Hx5Ni6vdtumj1dCcxONe4Mv8xLthn1o/nuXovfzBh1NANPk9hQsijuroy2q
        OhYKvZHkOE1C00c+bCpc6I5RK2umpNs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 55C7513427;
        Mon, 20 Jun 2022 05:30:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ahGRE+UFsGKiVwAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 20 Jun 2022 05:30:13 +0000
Message-ID: <c5515533-29a9-9e91-5a36-45f00f25b37b@suse.com>
Date:   Mon, 20 Jun 2022 07:30:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     Thorsten Leemhuis <regressions@leemhuis.info>,
        xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     jbeulich@suse.com, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20220503132207.17234-1-jgross@suse.com>
 <20220503132207.17234-2-jgross@suse.com>
 <fb0eadee-1d45-f414-eda4-a87f01eeb57a@suse.com>
 <effc0c6a-9e4d-b503-e4ba-6c8d2da72699@leemhuis.info>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH 1/2] x86/pat: fix x86_has_pat_wp()
In-Reply-To: <effc0c6a-9e4d-b503-e4ba-6c8d2da72699@leemhuis.info>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------TrYTNr10W5n70OBgv21LKjlS"
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
--------------TrYTNr10W5n70OBgv21LKjlS
Content-Type: multipart/mixed; boundary="------------pw6YLSc6mvGCJfu2mpvQIea8";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Thorsten Leemhuis <regressions@leemhuis.info>,
 xen-devel@lists.xenproject.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Borislav Petkov <bp@alien8.de>
Cc: jbeulich@suse.com, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <c5515533-29a9-9e91-5a36-45f00f25b37b@suse.com>
Subject: Re: [PATCH 1/2] x86/pat: fix x86_has_pat_wp()
References: <20220503132207.17234-1-jgross@suse.com>
 <20220503132207.17234-2-jgross@suse.com>
 <fb0eadee-1d45-f414-eda4-a87f01eeb57a@suse.com>
 <effc0c6a-9e4d-b503-e4ba-6c8d2da72699@leemhuis.info>
In-Reply-To: <effc0c6a-9e4d-b503-e4ba-6c8d2da72699@leemhuis.info>

--------------pw6YLSc6mvGCJfu2mpvQIea8
Content-Type: multipart/mixed; boundary="------------h099hHche060m0xNSeZh399g"

--------------h099hHche060m0xNSeZh399g
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjAuMDYuMjIgMDc6MjIsIFRob3JzdGVuIExlZW1odWlzIHdyb3RlOg0KPiBPbiAxNC4w
Ni4yMiAxNzowOSwgSnVlcmdlbiBHcm9zcyB3cm90ZToNCj4+IE9uIDAzLjA1LjIyIDE1OjIy
LCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KPj4+IHg4Nl9oYXNfcGF0X3dwKCkgaXMgdXNpbmcg
YSB3cm9uZyB0ZXN0LCBhcyBpdCByZWxpZXMgb24gdGhlIG5vcm1hbA0KPj4+IFBBVCBjb25m
aWd1cmF0aW9uIHVzZWQgYnkgdGhlIGtlcm5lbC4gSW4gY2FzZSB0aGUgUEFUIE1TUiBoYXMg
YmVlbg0KPj4+IHNldHVwIGJ5IGFub3RoZXIgZW50aXR5IChlLmcuIEJJT1Mgb3IgWGVuIGh5
cGVydmlzb3IpIGl0IG1pZ2h0IHJldHVybg0KPj4+IGZhbHNlIGV2ZW4gaWYgdGhlIFBBVCBj
b25maWd1cmF0aW9uIGlzIGFsbG93aW5nIFdQIG1hcHBpbmdzLg0KPj4+DQo+Pj4gRml4ZXM6
IDFmNmY2NTVlMDFhZCAoIng4Ni9tbTogQWRkIGEgeDg2X2hhc19wYXRfd3AoKSBoZWxwZXIi
KQ0KPj4+IFNpZ25lZC1vZmYtYnk6IEp1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4N
Cj4+PiAtLS0NCj4+PiAgwqAgYXJjaC94ODYvbW0vaW5pdC5jIHwgMyArKy0NCj4+PiAgwqAg
MSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4+DQo+
Pj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L21tL2luaXQuYyBiL2FyY2gveDg2L21tL2luaXQu
Yw0KPj4+IGluZGV4IGQ4Y2ZjZTIyMTI3NS4uNzFlMTgyZWJjZWQzIDEwMDY0NA0KPj4+IC0t
LSBhL2FyY2gveDg2L21tL2luaXQuYw0KPj4+ICsrKyBiL2FyY2gveDg2L21tL2luaXQuYw0K
Pj4+IEBAIC04MCw3ICs4MCw4IEBAIHN0YXRpYyB1aW50OF90IF9fcHRlMmNhY2hlbW9kZV90
YmxbOF0gPSB7DQo+Pj4gIMKgIC8qIENoZWNrIHRoYXQgdGhlIHdyaXRlLXByb3RlY3QgUEFU
IGVudHJ5IGlzIHNldCBmb3Igd3JpdGUtcHJvdGVjdCAqLw0KPj4+ICDCoCBib29sIHg4Nl9o
YXNfcGF0X3dwKHZvaWQpDQo+Pj4gIMKgIHsNCj4+PiAtwqDCoMKgIHJldHVybiBfX3B0ZTJj
YWNoZW1vZGVfdGJsW19QQUdFX0NBQ0hFX01PREVfV1BdID09DQo+Pj4gX1BBR0VfQ0FDSEVf
TU9ERV9XUDsNCj4+PiArwqDCoMKgIHJldHVybg0KPj4+IF9fcHRlMmNhY2hlbW9kZV90Ymxb
X19jYWNoZW1vZGUycHRlX3RibFtfUEFHRV9DQUNIRV9NT0RFX1dQXV0gPT0NCj4+PiArwqDC
oMKgwqDCoMKgwqDCoMKgwqAgX1BBR0VfQ0FDSEVfTU9ERV9XUDsNCj4+PiAgwqAgfQ0KPj4+
ICDCoCDCoCBlbnVtIHBhZ2VfY2FjaGVfbW9kZSBwZ3Byb3QyY2FjaGVtb2RlKHBncHJvdF90
IHBncHJvdCkNCj4+DQo+PiB4ODYgbWFpbnRhaW5lcnMsIHBsZWFzZSBjb25zaWRlciB0YWtp
bmcgdGhpcyBwYXRjaCwgYXMgaXQgaXMgZml4aW5nDQo+PiBhIHJlYWwgYnVnLiBQYXRjaCAy
IG9mIHRoaXMgc2VyaWVzIGNhbiBiZSBkcm9wcGVkIElNTy4NCj4gDQo+IEp1ZXJnZW4sIGNh
biB5b3UgaGVscCBtZSBvdXQgaGVyZSBwbGVhc2UuIFBhdGNoIDIgYWZhaWNzIHdhcyBzdXBw
b3NlZCB0bw0KPiBmaXggdGhpcyByZWdyZXNzaW9uIEknbSB0cmFja2luZzoNCj4gaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvcmVncmVzc2lvbnMvWW5ISzFaM285OWVNWHNWS0BtYWlsLWl0
bC8NCg0KTm8sIHBhdGNoIDIgd2Fzbid0IGNvdmVyaW5nIGFsbCBuZWVkZWQgY2FzZXMuDQoN
Cj4gSXMgUGF0Y2ggMSBhbG9uZSBlbm91Z2ggdG8gZml4IGl0PyBPciBpcyB0aGVyZSBhIGRp
ZmZlcmVudCBmaXggZm9yIGl0Pw0KDQpQYXRjaCAxIGlzIGZpeGluZyBhIGRpZmZlcmVudCBp
c3N1ZSAoaXQgaXMgbGFja2luZyBhbnkgbWFpbnRhaW5lcg0KZmVlZGJhY2ssIHRob3VnaCku
DQoNClRoaXMgcGF0Y2ggb2YgSmFuIHNob3VsZCBkbyB0aGUgam9iLCBidXQgaXQgc2VlbXMg
dG8gYmUgc3R1Y2ssIHRvbzoNCg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC85Mzg1
ZmE2MC1mYTVkLWY1NTktYTEzNy02NjA4NDA4Zjg4YjBAc3VzZS5jb20vDQoNCj4gT3IgaXMg
dGhlcmUgc29tZSBvdGhlciBzb2x1dGlvbiB0byBmaW5hbGx5IGZpeCB0aGF0IHJlZ3Jlc3Np
b25zIHRoYXQNCj4gaWRlYWxseSBzaG91bGQgaGF2ZSBiZWVuIGZpeGVkIHdlZWtzIGFnbyBh
bHJlYWR5Pw0KDQpJIGFncmVlIGl0IHNob3VsZCBoYXZlIGJlZW4gZml4ZWQgcXVpdGUgc29t
ZSB0aW1lIG5vdywgYnV0IHRoZSB4ODYNCm1haW50YWluZXJzIGRvbid0IHNlZW0gdG8gYmUg
aW50ZXJlc3RlZCBpbiB0aG9zZSBzdHVjayBwYXRjaGVzLiA6LSgNCg0KTWF5YmUgSSBzaG91
bGQgdGFrZSBhIGRpZmZlcmVudCBhcHByb2FjaDoNCg0KeDg2IG1haW50YWluZXJzLCBwbGVh
c2Ugc3BlYWsgdXAgaWYgeW91IE5BSyAob3IgQWNrKSBhbnkgb2YgYWJvdmUgdHdvIHBhdGNo
ZXMuDQpJbiBjYXNlIHlvdSBkb24ndCBOQUsgb3IgdGFrZSB0aGUgcGF0Y2hlcywgSSdtIGlu
Y2xpbmVkIHRvIGNhcnJ5IHRoZW0gdmlhDQp0aGUgWGVuIHRyZWUgdG8gZ2V0IHRoZSBpc3N1
ZXMgZml4ZWQuDQoNCg0KSnVlcmdlbg0K
--------------h099hHche060m0xNSeZh399g
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------h099hHche060m0xNSeZh399g--

--------------pw6YLSc6mvGCJfu2mpvQIea8--

--------------TrYTNr10W5n70OBgv21LKjlS
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmKwBeQFAwAAAAAACgkQsN6d1ii/Ey9r
cgf/SuURpcc5UxmfxrN1FBmBlECRuboQgwTqaMkIKajWwphVD3yONz4d7X607XzJjciy7JnnNX4l
2mldvK9BRvUVfFrjSZsBnRVfJWnMXtjkolupeC95e5uUcskfqEBjKVokofRQgHPLIcd8o3Uf6+0/
7yqCgUvAWUN/lY1pQ/vniERrzDs64v+z4/YSoclZ1U4sVDSH/U97GQ/XlZhhCyO3G4hdChEqYgaU
sMkffF7zaididwAIJFWm/sjO9hOTe16D+MbLa46ifKR/hHB8jTLobeoDmFVpg+op0RilDuaZeeK1
lUftqBV49BvxysD8YW6JXfgEv0xJO0cUJFnfWhmZcQ==
=A6TZ
-----END PGP SIGNATURE-----

--------------TrYTNr10W5n70OBgv21LKjlS--
