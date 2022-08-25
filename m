Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9FF5A0E01
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 12:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241027AbiHYKiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 06:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240960AbiHYKiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 06:38:03 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7248DA261F
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 03:38:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 294845C01C;
        Thu, 25 Aug 2022 10:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1661423881; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zVooGo/u4Pk/Y4UICYKWqNxEcySE1V85AFIIpjlyVcg=;
        b=jpxtBHxjNJ/f0ScRlWpQzXtfRx3Efx4XKDLzPijfX6VmOq0jhsLHJ1bRktRxJha9xMwkbk
        hKtegVT1Ti6B8bG+D4N4UqMjyB+yEgOyF/UO4t/Uxcn52+e006IkkBK7ylPcYO2Pzb21Mi
        OmOaIpz+H3onYQgdAft5r0WPBi+C2Hs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D96EC13A8E;
        Thu, 25 Aug 2022 10:38:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XFwlMwhRB2PVZAAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 25 Aug 2022 10:38:00 +0000
Message-ID: <58570869-aab7-027b-36ff-0ad0a7b7c0b1@suse.com>
Date:   Thu, 25 Aug 2022 12:38:00 +0200
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
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <YwdPb4pWqppgzIpm@zn.tnic>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------5MI5OPek0PfQQs18g2pOrbCT"
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
--------------5MI5OPek0PfQQs18g2pOrbCT
Content-Type: multipart/mixed; boundary="------------jpd0SAsHH1ObS6hv80kdCW4f";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>
Cc: xen-devel@lists.xenproject.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <58570869-aab7-027b-36ff-0ad0a7b7c0b1@suse.com>
Subject: Re: [PATCH v2 02/10] x86/mtrr: remove unused cyrix_set_all() function
References: <20220820092533.29420-1-jgross@suse.com>
 <20220820092533.29420-3-jgross@suse.com> <YwdPb4pWqppgzIpm@zn.tnic>
In-Reply-To: <YwdPb4pWqppgzIpm@zn.tnic>

--------------jpd0SAsHH1ObS6hv80kdCW4f
Content-Type: multipart/mixed; boundary="------------PjCPhfSirSTLxUNCaJ2VWZRg"

--------------PjCPhfSirSTLxUNCaJ2VWZRg
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjUuMDguMjIgMTI6MzEsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gU2F0LCBB
dWcgMjAsIDIwMjIgYXQgMTE6MjU6MjVBTSArMDIwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToN
Cj4+IFRoZSBDeXJpeCBjcHUgc3BlY2lmaWMgTVRSUiBmdW5jdGlvbiBjeXJpeF9zZXRfYWxs
KCkgd2lsbCBuZXZlciBiZQ0KPj4gY2FsbGVkLCBhcyB0aGUgc3RydWN0IG10cnJfb3BzIHNl
dF9hbGwoKSBjYWxsYmFjayB3aWxsIG9ubHkgYmUgY2FsbGVkDQo+PiBpbiB0aGUgdXNlX2lu
dGVsKCkgY2FzZSwgd2hpY2ggd291bGQgcmVxdWlyZSB0aGUgdXNlX2ludGVsX2lmIG1lbWJl
cg0KPj4gb2Ygc3RydWN0IG10cnJfb3BzIHRvIGJlIHNldCwgd2hpY2ggaXNuJ3QgdGhlIGNh
c2UgZm9yIEN5cml4Lg0KPiANCj4gRG9pbmcgc29tZSBnaXQgYXJjaGVvbG9neToNCj4gDQo+
IFNvIHRoZSBjb21taXQgd2hpY2ggYWRkZWQgbXRycl9hcHNfZGVsYXllZF9pbml0IGlzDQo+
IA0KPiAgICBkMGFmOWVlZDVhYTkgKCJ4ODYsIHBhdC9tdHJyOiBSZW5kZXp2b3VzIGFsbCB0
aGUgY3B1cyBmb3IgTVRSUi9QQVQgaW5pdCIpDQo+IA0KPiBmcm9tIDIwMDkuDQo+IA0KPiBU
aGUgSVBJIGNhbGxiYWNrIGJlZm9yZSBpdCwgbG9va2VkIGxpa2UgdGhpczoNCj4gDQo+IHN0
YXRpYyB2b2lkIGlwaV9oYW5kbGVyKHZvaWQgKmluZm8pDQo+IHsNCj4gI2lmZGVmIENPTkZJ
R19TTVANCj4gCXN0cnVjdCBzZXRfbXRycl9kYXRhICpkYXRhID0gaW5mbzsNCj4gCXVuc2ln
bmVkIGxvbmcgZmxhZ3M7DQo+IA0KPiAJbG9jYWxfaXJxX3NhdmUoZmxhZ3MpOw0KPiANCj4g
CWF0b21pY19kZWMoJmRhdGEtPmNvdW50KTsNCj4gCXdoaWxlICghYXRvbWljX3JlYWQoJmRh
dGEtPmdhdGUpKQ0KPiAJCWNwdV9yZWxheCgpOw0KPiANCj4gCS8qICBUaGUgbWFzdGVyIGhh
cyBjbGVhcmVkIG1lIHRvIGV4ZWN1dGUgICovDQo+IAlpZiAoZGF0YS0+c21wX3JlZyAhPSB+
MFUpIHsNCj4gCQltdHJyX2lmLT5zZXQoZGF0YS0+c21wX3JlZywgZGF0YS0+c21wX2Jhc2Us
DQo+IAkJCSAgICAgZGF0YS0+c21wX3NpemUsIGRhdGEtPnNtcF90eXBlKTsNCj4gCX0gZWxz
ZSB7DQo+IAkJbXRycl9pZi0+c2V0X2FsbCgpOw0KPiAJCV5eXl5eXl5eXg0KPiANCj4gYW5k
IHRoYXQgZWxzZSBicmFuY2ggd291bGQgY2FsbCAtPnNldF9hbGwoKSBvbiBDeXJpeCB0b28u
DQo+IA0KPiBTdXJlc2gncyBwYXRjaCBjaGFuZ2VkIGl0IHRvIGRvOg0KPiANCj4gLQl9IGVs
c2Ugew0KPiArCX0gZWxzZSBpZiAobXRycl9hcHNfZGVsYXllZF9pbml0KSB7DQo+ICsJCS8q
DQo+ICsJCSAqIEluaXRpYWxpemUgdGhlIE1UUlJzIGluYWRkaXRpb24gdG8gdGhlIHN5bmNo
cm9uaXNhdGlvbi4NCj4gKwkJICovDQo+ICAgCQltdHJyX2lmLT5zZXRfYWxsKCk7DQo+IA0K
PiBCVVQgYmVsb3cgaW4gdGhlIHNldF9tdHJyKCkgY2FsbCwgaXQgZGlkOg0KPiANCj4gICAg
ICAgICAgLyoNCj4gICAgICAgICAgICogSEFDSyENCj4gICAgICAgICAgICogV2UgdXNlIHRo
aXMgc2FtZSBmdW5jdGlvbiB0byBpbml0aWFsaXplIHRoZSBtdHJycyBvbiBib290Lg0KPiAg
ICAgICAgICAgKiBUaGUgc3RhdGUgb2YgdGhlIGJvb3QgY3B1J3MgbXRycnMgaGFzIGJlZW4g
c2F2ZWQsIGFuZCB3ZSB3YW50DQo+ICAgICAgICAgICAqIHRvIHJlcGxpY2F0ZSBhY3Jvc3Mg
YWxsIHRoZSBBUHMuDQo+ICAgICAgICAgICAqIElmIHdlJ3JlIGRvaW5nIHRoYXQgQHJlZyBp
cyBzZXQgdG8gc29tZXRoaW5nIHNwZWNpYWwuLi4NCj4gICAgICAgICAgICovDQo+ICAgICAg
ICAgIGlmIChyZWcgIT0gfjBVKQ0KPiAgICAgICAgICAgICAgICAgIG10cnJfaWYtPnNldChy
ZWcsIGJhc2UsIHNpemUsIHR5cGUpOw0KPiAgICAgICAgICBlbHNlIGlmICghbXRycl9hcHNf
ZGVsYXllZF9pbml0KQ0KPiAgICAgICAgICAgICAgICAgIG10cnJfaWYtPnNldF9hbGwoKTsN
Cj4gCQleXl4NCj4gDQo+IGFuZCB0aGF0IHdvdWxkIGJlIHRoZSBDeXJpeCBjYXNlLg0KPiAN
Cj4gQnV0IHRoZW4NCj4gDQo+ICAgIDE5MmQ4ODU3NDI3ZCAoIng4NiwgbXRycjogdXNlIHN0
b3BfbWFjaGluZSBBUElzIGZvciBkb2luZyBNVFJSIHJlbmRlenZvdXMiKQ0KPiANCj4gY2Ft
ZSBhbmQgImNsZWFuZWQiIGFsbCB1cCBieSByZW1vdmluZyB0aGUgIkhBQ0siIGFuZCBkb2lu
ZyAtPnNldF9hbGwoKQ0KPiBvbmx5IGluIHRoZSByZW5kZXp2b3VzIGhhbmRsZXI6DQo+IA0K
PiArICAgICAgIH0gZWxzZSBpZiAobXRycl9hcHNfZGVsYXllZF9pbml0IHx8ICFjcHVfb25s
aW5lKHNtcF9wcm9jZXNzb3JfaWQoKSkpIHsNCj4gICAgICAgICAgICAgICAgICBtdHJyX2lm
LT5zZXRfYWxsKCk7DQo+ICAgICAgICAgIH0NCj4gDQo+IFdoaWNoIGJlZ3MgdGhlIHF1ZXN0
aW9uOiB3aHkgZG9lc24ndCB0aGUgc2Vjb25kIHBhcnQgb2YgdGhlIGVsc2UgdGVzdA0KPiBt
YXRjaCBvbiBDeXJpeD8gVGhlICJ8fCAhY3B1X29ubGluZShzbXBfcHJvY2Vzc29yX2lkKCkp
IiBjYXNlLg0KPiANCj4gSWYgb25seSB3ZSBoYWQgYSBDeXJpeCBtYWNoaW5lIHNvbWV3aGVy
ZS4uLg0KPiANCg0KWW91IGFyZSBtaXNzaW5nIG9uZSBhc3BlY3QgaGVyZTogdGhlcmUgaXMg
bm8gY2FsbCBwYXRoIGZvciBDeXJpeCBDUFVzIHVzaW5nDQpyZWcgPT0gfjBVLg0KDQpTbyB0
aGUgY29uZGl0aW9uIG9mIHRoZSAiZWxzZSBpZiIgd2lsbCBuZXZlciBiZSBldmFsdWF0ZWQg
d2l0aCBDeXJpeC4NCg0KDQpKdWVyZ2VuDQo=
--------------PjCPhfSirSTLxUNCaJ2VWZRg
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------PjCPhfSirSTLxUNCaJ2VWZRg--

--------------jpd0SAsHH1ObS6hv80kdCW4f--

--------------5MI5OPek0PfQQs18g2pOrbCT
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmMHUQgFAwAAAAAACgkQsN6d1ii/Ey9I
CQf/TSMOy3rnTUMTUnucyEp1W0Ac42eY6AnA3h7wcpen+iKn6lorIzwov3AOe9Tv9QB5vAXf04hw
sKreuZpITWn/iX6Fu3WIUKHyEVukqxj5ogfEEdngkiiq9k5nIrjuGYa8orxqItSV8G8F2rAruQ/z
AHMtqS46ZIqkj0TliRGs1sIuYEm+aydHlyv/JNUB7gT9Uhzs/GxscLalHGXFR2jo8X4xtAhzjAro
9G46pNMuL54N+ae/2zy6UfaJjLEvH7KLQ9k6t5nv7Onn6lblLWrVqJEdiw0lx/R49zuCkx3w41zq
N4DvoZdllQGUJ5yk7Z+UbNz39yKNgMBgHxqV3c1zrg==
=0xeN
-----END PGP SIGNATURE-----

--------------5MI5OPek0PfQQs18g2pOrbCT--
