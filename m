Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77A7551615
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 12:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239026AbiFTKlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 06:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232170AbiFTKls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 06:41:48 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19452140B1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 03:41:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B480E1FA76;
        Mon, 20 Jun 2022 10:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655721706; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7w41IQsGsxN+8vimErJxT8zUTzeKMC0ET7aZWma418Y=;
        b=NwE3qmXMlXJgI3tmRrz/2SgugzzEqUwikHHh5ypDI1Csjezmrc0Ru8upXPYIunvXBBKcor
        GT5GoXo5NYfsD/l7lfj/CJ9NOWHamfp78xYdZ1CxoS0vzBdTTxrYxMaTcLaSLMwOdSLISg
        ofTs3BoAYofv1aIpiQYZPlo+eUp2vV0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 611B813638;
        Mon, 20 Jun 2022 10:41:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DbBOFupOsGIxaQAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 20 Jun 2022 10:41:46 +0000
Message-ID: <1cfde4bf-241f-d94c-ffd7-2a11cf9aa1f2@suse.com>
Date:   Mon, 20 Jun 2022 12:41:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, jbeulich@suse.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20220503132207.17234-1-jgross@suse.com>
 <20220503132207.17234-2-jgross@suse.com> <YrBLU2C5cJoalnax@zn.tnic>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH 1/2] x86/pat: fix x86_has_pat_wp()
In-Reply-To: <YrBLU2C5cJoalnax@zn.tnic>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------d8k0hMH5UzQW082oVB8YUPtP"
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
--------------d8k0hMH5UzQW082oVB8YUPtP
Content-Type: multipart/mixed; boundary="------------BSsqO8n9CO6URm6ibKlIXMtW";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>
Cc: xen-devel@lists.xenproject.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, jbeulich@suse.com,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <1cfde4bf-241f-d94c-ffd7-2a11cf9aa1f2@suse.com>
Subject: Re: [PATCH 1/2] x86/pat: fix x86_has_pat_wp()
References: <20220503132207.17234-1-jgross@suse.com>
 <20220503132207.17234-2-jgross@suse.com> <YrBLU2C5cJoalnax@zn.tnic>
In-Reply-To: <YrBLU2C5cJoalnax@zn.tnic>

--------------BSsqO8n9CO6URm6ibKlIXMtW
Content-Type: multipart/mixed; boundary="------------00h0XzlSR6lx9AL9hG09U3QX"

--------------00h0XzlSR6lx9AL9hG09U3QX
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjAuMDYuMjIgMTI6MjYsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gVHVlLCBN
YXkgMDMsIDIwMjIgYXQgMDM6MjI6MDZQTSArMDIwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToN
Cj4+IHg4Nl9oYXNfcGF0X3dwKCkgaXMgdXNpbmcgYSB3cm9uZyB0ZXN0LCBhcyBpdCByZWxp
ZXMgb24gdGhlIG5vcm1hbA0KPj4gUEFUIGNvbmZpZ3VyYXRpb24gdXNlZCBieSB0aGUga2Vy
bmVsLiBJbiBjYXNlIHRoZSBQQVQgTVNSIGhhcyBiZWVuDQo+PiBzZXR1cCBieSBhbm90aGVy
IGVudGl0eSAoZS5nLiBCSU9TIG9yIFhlbiBoeXBlcnZpc29yKSBpdCBtaWdodCByZXR1cm4N
Cj4+IGZhbHNlIGV2ZW4gaWYgdGhlIFBBVCBjb25maWd1cmF0aW9uIGlzIGFsbG93aW5nIFdQ
IG1hcHBpbmdzLg0KPj4NCj4+IEZpeGVzOiAxZjZmNjU1ZTAxYWQgKCJ4ODYvbW06IEFkZCBh
IHg4Nl9oYXNfcGF0X3dwKCkgaGVscGVyIikNCj4+IFNpZ25lZC1vZmYtYnk6IEp1ZXJnZW4g
R3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4NCj4+IC0tLQ0KPj4gICBhcmNoL3g4Ni9tbS9pbml0
LmMgfCAzICsrLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L21tL2luaXQuYyBiL2Fy
Y2gveDg2L21tL2luaXQuYw0KPj4gaW5kZXggZDhjZmNlMjIxMjc1Li43MWUxODJlYmNlZDMg
MTAwNjQ0DQo+PiAtLS0gYS9hcmNoL3g4Ni9tbS9pbml0LmMNCj4+ICsrKyBiL2FyY2gveDg2
L21tL2luaXQuYw0KPj4gQEAgLTgwLDcgKzgwLDggQEAgc3RhdGljIHVpbnQ4X3QgX19wdGUy
Y2FjaGVtb2RlX3RibFs4XSA9IHsNCj4+ICAgLyogQ2hlY2sgdGhhdCB0aGUgd3JpdGUtcHJv
dGVjdCBQQVQgZW50cnkgaXMgc2V0IGZvciB3cml0ZS1wcm90ZWN0ICovDQo+PiAgIGJvb2wg
eDg2X2hhc19wYXRfd3Aodm9pZCkNCj4+ICAgew0KPj4gLQlyZXR1cm4gX19wdGUyY2FjaGVt
b2RlX3RibFtfUEFHRV9DQUNIRV9NT0RFX1dQXSA9PSBfUEFHRV9DQUNIRV9NT0RFX1dQOw0K
Pj4gKwlyZXR1cm4gX19wdGUyY2FjaGVtb2RlX3RibFtfX2NhY2hlbW9kZTJwdGVfdGJsW19Q
QUdFX0NBQ0hFX01PREVfV1BdXSA9PQ0KPj4gKwkgICAgICAgX1BBR0VfQ0FDSEVfTU9ERV9X
UDsNCj4gDQo+IFNvIHRoaXMgY29kZSBhbHdheXMgbWFrZXMgbXkgaGVhZCBzcGluLi4uIGVz
cGVjaWFsbHkgYWZ0ZXIgdmFjYXRpb24gYnV0DQo+IGxlbW1lIHRha2UgYSBzdGFiOg0KPiAN
Cj4gX19wdGUyY2FjaGVtb2RlX3RibCBpbmRpY2VzIGFyZSBvZiB0eXBlIGVudW0gcGFnZV9j
YWNoZV9tb2RlLg0KDQpZZXMuDQoNCj4gV2hhdCB5b3UndmUgZG9uZSBpcyBpbmRleCB3aXRo
DQo+IA0KPiBfX2NhY2hlbW9kZTJwdGVfdGJsW19QQUdFX0NBQ0hFX01PREVfV1BdDQo+IA0K
PiB3aGljaCBnaXZlcyB1aW50MTZfdC4NCj4gDQo+IFNvLCBpZiBhdCBhbGwsIHRoaXMgc2hv
dWxkIGRvIF9fcHRlMmNtX2lkeChfUEFHRV9DQUNIRV9NT0RFX1dQKSB0byBpbmRleA0KPiBp
bnRvIGl0Lg0KDQpPaCwgeW91IGFyZSBwYXJ0aWFsbHkgcmlnaHQuDQoNCkl0IHNob3VsZCBi
ZSBfX3B0ZTJjbV9pZHgoX19jYWNoZW1vZGUycHRlX3RibFtfUEFHRV9DQUNIRV9NT0RFX1dQ
XSkuDQoNCj4gQnV0IEknbSBzdGlsbCB1bmNsZWFyIG9uIHRoZSBiaWcgcGljdHVyZS4gTG9v
a2luZyBhdCBKYW4ncyBleHBsYW5hdGlvbiwNCj4gdGhlcmUncyBzb21ldGhpbmcgYWJvdXQg
UEFUIGluaXQgYmVpbmcgc2tpcHBlZCBkdWUgdG8gTVRSUnMgbm90IGJlaW5nDQo+IGVtdWxh
dGVkIGJ5IFhlbi4uLi4gb3Igc29tZXRoaW5nIHRvIHRoYXQgZWZmZWN0Lg0KDQpQQVQgaW5p
dCBpcyBiZWluZyBza2lwcGVkIGZvciBYZW4gUFYgZ3Vlc3RzLCBhcyB0aG9zZSBjYW4ndCB3
cml0ZSB0aGUNClBBVCBNU1IuIFRoZXkgbmVlZCB0byBjb3BlIHdpdGggdGhlIHNldHRpbmcg
dGhlIGh5cGVydmlzb3IgaGFzIGRvbmUNCih3aGljaCBjb250YWlucyBhbGwgY2FjaGluZyBt
b2RlcywgYnV0IGluIGEgZGlmZmVyZW50IGxheW91dCB0aGFuIHRoZQ0Ka2VybmVsIGlzIHVz
aW5nIG5vcm1hbGx5KS4NCg0KPiBTbyBpZiB0aGF0J3MgdGhlIGNhc2UsIHRoZSBYZW4gZ3Vl
c3QgY29kZSBzaG91bGQgaW5pdCBQQVQgaW4gaXRzIG93bg0KPiB3YXksIHNvIHRoYXQgdGhl
IGdlbmVyaWMgY29kZSB3b3JrcyB3aXRoIHRoaXMgd2l0aG91dCBkb2luZyBoYWNrcy4NCg0K
RGVwZW5kcyBvbiB3aGF0IHlvdSBtZWFuIHdpdGggImluaXQgUEFUIi4gSWYgeW91IG1lYW4g
dG8gd3JpdGUgdGhlDQpQQVQgTVNSLCB0aGVuIG5vLCB0aGlzIHdvbid0IHdvcmsuIElmIHlv
dSBtZWFuIHRvIHNldHVwIHRoZSB0cmFuc2xhdGlvbg0KYXJyYXlzIF9fY2FjaGVtb2RlMnB0
ZV90YmxbXSBhbmQgX19wdGUyY2FjaGVtb2RlX3RibFtdLCB0aGVuIHllcywgdGhpcw0KaXMg
YWxyZWFkeSBkb25lLg0KDQpNeSBwYXRjaCBpcyBvbmx5IGZpeGluZyB0aGUgd3Jvbmcgd2F5
IHF1ZXJ5aW5nIGZvciBXUCBiZWluZyBzdXBwb3J0ZWQuDQoNCj4gQnV0IEknbSBvbmx5IGd1
ZXNzaW5nIC0gdGhpcyBuZWVkcyBhICpsb3QqIG1vcmUgZWxhYm9yYXRpb24gYW5kDQo+IGV4
cGxhbmF0aW9uIHdoeSBleGFjdGx5IHRoaXMgaXMgbmVlZGVkLg0KDQpJIHdpbGwgY29ycmVj
dCB0aGUgY29kZSBhbmQgdXBkYXRlIHRoZSBjb21taXQgbWVzc2FnZS4NCg0KDQpKdWVyZ2Vu
DQo=
--------------00h0XzlSR6lx9AL9hG09U3QX
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------00h0XzlSR6lx9AL9hG09U3QX--

--------------BSsqO8n9CO6URm6ibKlIXMtW--

--------------d8k0hMH5UzQW082oVB8YUPtP
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmKwTukFAwAAAAAACgkQsN6d1ii/Ey/T
/Af+K1iQ7zdT/cqbRsGNY60+8Reyw+xEYCBvULc3labAa6S8CMirE4G0DBNY9Ddx8XEdLZCJBA7/
Yjo4F/NRcawlRxPHlwbSJbk5bxUoMhrHLyTFYuxSb6ERPXgWsVAfc0+rnptXAJvY+mtvK+eraNAv
S1LU3JtSZs1c/HbWemn/M0yMPez378+qBrxAL2LtJ10R1u5rZRYeRePyWG5ZM741guuGMa/hC31h
BiaKwJWlEkHWy2GHP9AiBg67QC9NxOQ6xivjWz4kVuLOXNG2+dKjdk0yMgMV1NzWcUZ5fKVp9lDa
7C93y0bgN3SoZz0loyHWEq5GPyvyav5DSDVDE5mHNQ==
=dJRd
-----END PGP SIGNATURE-----

--------------d8k0hMH5UzQW082oVB8YUPtP--
