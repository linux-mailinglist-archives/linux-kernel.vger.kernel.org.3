Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F280E4A9815
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 11:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344732AbiBDK7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 05:59:39 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:48650 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiBDK7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 05:59:38 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CBAAE210FD;
        Fri,  4 Feb 2022 10:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643972377; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2P4VB8OlIs+RzUn2xrWmyDzZ6eet0vBzg4h8IXY4oVE=;
        b=eC5vuQra40HT6uiIRK+Eegyc/w0cwPFCqu9/JEqxNwbxs+08juxATl2AFxT3OamZKeT2/W
        Bfj+S6sAUDEGBQ4J4ims+roRMn18CyhjhJXxLKq5Jq3NL+ITVT7sAJuTsMLm1K9viWP0JQ
        voR3JrxAIalW4MTdRHDVgyHMSpAHZog=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9304113A82;
        Fri,  4 Feb 2022 10:59:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sRSVIhkH/WElKQAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 04 Feb 2022 10:59:37 +0000
Message-ID: <a8877192-2389-8974-270a-5cb95c6da134@suse.com>
Date:   Fri, 4 Feb 2022 11:59:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Content-Language: en-US
To:     Nikita Popov <npv1310@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org,
        the arch/x86 maintainers <x86@kernel.org>
References: <CA+cA0PB92khCo7dNAyw-zUmhKJHg-D2aQyT=HmLHhyVvd_Cd5g@mail.gmail.com>
 <feffc13d-5ee5-7326-1f5d-d803d0ab44b2@intel.com>
 <CA+cA0PCbY2qSsgTLsK8=N3WNEWN_JSgOoefn2wNhKFPrJbJCSA@mail.gmail.com>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: A logical error in arch/x86/mm/init.c
In-Reply-To: <CA+cA0PCbY2qSsgTLsK8=N3WNEWN_JSgOoefn2wNhKFPrJbJCSA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------irqrfNfFkF6ofuzTcgZ0IqgB"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------irqrfNfFkF6ofuzTcgZ0IqgB
Content-Type: multipart/mixed; boundary="------------0Copjh6EgJqlK6kqyQCrEvYv";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Nikita Popov <npv1310@gmail.com>, Dave Hansen <dave.hansen@intel.com>
Cc: dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
 linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>
Message-ID: <a8877192-2389-8974-270a-5cb95c6da134@suse.com>
Subject: Re: A logical error in arch/x86/mm/init.c
References: <CA+cA0PB92khCo7dNAyw-zUmhKJHg-D2aQyT=HmLHhyVvd_Cd5g@mail.gmail.com>
 <feffc13d-5ee5-7326-1f5d-d803d0ab44b2@intel.com>
 <CA+cA0PCbY2qSsgTLsK8=N3WNEWN_JSgOoefn2wNhKFPrJbJCSA@mail.gmail.com>
In-Reply-To: <CA+cA0PCbY2qSsgTLsK8=N3WNEWN_JSgOoefn2wNhKFPrJbJCSA@mail.gmail.com>

--------------0Copjh6EgJqlK6kqyQCrEvYv
Content-Type: multipart/mixed; boundary="------------F0fn3x0XCsSqJO4lIPgpIPsM"

--------------F0fn3x0XCsSqJO4lIPgpIPsM
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDQuMDIuMjIgMDY6MzUsIE5pa2l0YSBQb3BvdiB3cm90ZToNCj4gVGhhbmsgeW91IGZv
ciB5b3VyIGF0dGVudGlvbi4NCj4+IElmIHlvdSByZWFsbHkgZmVlbCB0aGF0IHRoaXMgaXMg
c29tZXRoaW5nIHRoYXQgbmVlZHMgdG8gYmUgZml4ZWQsIEknZA0KPj4gYXBwcmVjaWF0ZSBp
ZiB5b3UgY291bGQgZmluZCBzb21lIHdheSB0byByZXByb2R1Y2UgaXQgYW5kIHRoZW4gc2Vu
ZCBhDQo+PiBwcm9wZXIgcGF0Y2guDQo+IEkgYmVsaWV2ZSB0aGlzIHdvdWxkIGJlIGhhcmQg
dG8gcmVwcm9kdWNlLg0KPiBJIGp1c3Qgbm90aWNlZCB0aGlzIGRpc2NyZXBhbmN5IGR1cmlu
ZyBtYW51YWwgY29kZSByZXZpZXcuDQo+IEknbSBjb25zaWRlcmluZyB0aGUgZm9sbG93aW5n
IGZhY3RzOg0KPiAxKSBUaGUgYXJlYSAncGd0X2J1ZicgaXMgcGFydCBvZiB0aGUgJ2Jyaycg
YXJlYSBkZWZpbmVkIGluIHRoZSBsaW5rZXINCj4gc2NyaXB0LiBJdCBpcyBhbGxvY2F0ZWQg
aW4gdGhlIGZ1bmN0aW9uICdlYXJseV9hbGxvY19wZ3RfYnVmJyB1c2luZw0KPiB0aGUgdmVy
eSBzYW1lICdleHRlbmRfYnJrJy4gVGhlIGxhdHRlciBpcyBlc3NlbnRpYWxseSBhIHN0YWNr
LWJhc2VkDQo+IGFsbG9jYXRvciBwaWNraW5nIGl0cyBtZW1vcnkgc2xpY2VzIGZyb20gdGhl
IGxpbmtlciBkZWZpbmVkIGFyZWEuDQo+IDIpIFRoZSBhbGxvY2F0aW9ucyBmcm9tICdwZ3Rf
YnVmJyBhcmUgaW4gdGhlIHN0YWNrIG1hbm5lciB0b28uDQo+IE9uZSBjYW4gZXhwZWN0IHRo
YXQgdGhlc2UgdHdvIGFyZWFzIChvbmUgb2Ygd2hpY2ggaXMgY29tcGxldGVseQ0KPiBjb250
YWluZWQgaW4gdGhlIG90aGVyKSBoYXZlIHRoZSBzYW1lIHByb3BlcnRpZXMgaW4gdmlldyBv
ZiB0aGUgZGlyZWN0DQo+IG1lbW9yeSBtYXBwaW5nLg0KPiANCj4gVGhlbiB0aGVyZSBpcyB0
aGUgZmxhZyAnY2FuX3VzZV9icmtfcGd0JyB3aGljaCBhbGxvd3MgdXNhZ2Ugb2YgdGhlDQo+
IHBndF9idWYgYXJlYSBpZiBhIG1hcHBlZCByYW5nZSBkb2Vzbid0IG92ZXJsYXAgd2l0aCB0
aGUgZnJlZSBzcGFjZSBvZg0KPiB0aGUgcGd0X2J1ZiBhcmVhLiBJbiB0aGUgJ2luaXRfcmFu
Z2VfbWVtb3J5X21hcHBpbmcnIGZ1bmN0aW9uIHdlIGNhbg0KPiBvYnNlcnZlIHRoYXQgdGhp
cyBmbGFnIGRvZXNuJ3QgcmVmbGVjdCB0aGUgcmVsYXRpdmUgcG9zaXRpb24gYmV0d2VlbiBh
DQo+IG1hcHBlZCByYW5nZSBhbmQgdGhlIGZyZWUgc3BhY2Ugb2YgdGhlIGJyayBhcmVhIGFz
IGEgd2hvbGU6DQo+ICAgICAgICAgICAgICAgICAgLyoNCj4gICAgICAgICAgICAgICAgICAg
KiBpZiBpdCBpcyBvdmVybGFwcGluZyB3aXRoIGJyayBwZ3QsIHdlIG5lZWQgdG8NCj4gICAg
ICAgICAgICAgICAgICAgKiBhbGxvYyBwZ3QgYnVmIGZyb20gbWVtYmxvY2sgaW5zdGVhZC4N
Cj4gICAgICAgICAgICAgICAgICAgKi8NCj4gICAgICAgICAgICAgICAgICBjYW5fdXNlX2Jy
a19wZ3QgPSBtYXgoc3RhcnQsICh1NjQpcGd0X2J1Zl9lbmQ8PFBBR0VfU0hJRlQpID49DQo+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBtaW4oZW5kLCAodTY0KXBn
dF9idWZfdG9wPDxQQUdFX1NISUZUKTsNCj4gVGhpcyBjaGVjayBpcyBzaW1wbHkgdG9vIG5h
cnJvdy4NCj4gDQo+IFNvIGZvciB3aGF0ZXZlciByZWFzb24gdGhpcyBmbGFnIHByb2hpYml0
cyB1c2FnZSBvZiB0aGUgcGd0X2J1ZiBhcmVhLA0KPiBJIGJlbGlldmUgZm9yIHRoZSBleGFj
dCBzYW1lIHJlYXNvbiB3ZSBoYXZlIHRvIGF2b2lkIHVzaW5nIGJyayBhcmVhIGlmDQo+IHRo
ZSBzaW1pbGFyIGNvbmRpdGlvbiBvbiB0aGUgZnJlZSBzcGFjZSBvZiB0aGUgYnJrIGFyZWEg
aG9sZHMuDQo+PiBUaGlzIF9taWdodF8gYmUgcmlnaHQuICBCdXQsIG15IGNvbmZpZGVuY2Ug
dGhhdCBpdCB3b24ndCBicmVhayBhbnl0aGluZw0KPj4gZWxzZSBpcyBwcmV0dHkgbG93LiAg
SXQncyBhbHNvIG9idmlvdXNseSBub3QgYmVlbiB0ZXN0ZWQuDQo+IFllcywgSSBhZ3JlZSBo
ZXJlLiBJIHNhdyBpdCBhcyBteSBkdXR5IHRvIHJlcG9ydCB0aGUgcG9zc2libGUgaXNzdWUu
DQo+PiBXaGF0IGFyZSB0aGVzZSAiTU1VIGlzc3VlcyI/DQo+IEkgdHJpZWQgdG8gZGVkdWNl
IHRoZSB1bmRlcmx5aW5nIHJlYXNvbiBiZXlvbmQgdGhlIGNvZGUgZnJhZ21lbnRzIGluDQo+
IHF1ZXN0aW9uLiBJIHByZXN1bWVkIHRoYXQgY2hlY2tpbmcgZm9yIG92ZXJsYXAgaXMgcHJv
dGVjdGluZyBhZ2FpbnN0DQo+IHNvbWUgTU1VIGlzc3VlcyB0aGF0IGNvdWxkIGFmZmVjdCBz
dGFiaWxpdHkgb2YgdGhlIGtlcm5lbC4NCg0KSSd2ZSBkb25lIGEgbG9jYWwgdGVzdCB3aXRo
IHRoZSBjYW5fdXNlX2Jya19wZ3QgdGVzdHMgaW4NCmFsbG9jX2xvd19wYWdlcygpIHJlbW92
ZWQgYW5kIGNvdWxkbid0IHRyaWdnZXIgYW55IGJ1ZyB3aGVuIHJ1bm5pbmcgYXMNClhlbiBQ
ViBndWVzdC4NCg0KVGhpcyBjb3VsZCBiZSBkdWUgdG8gY29tbWl0IDAxNjdkN2Q4YjBiZWI0
Y2YxLCBvciBzb21lIHBhcnRzIG9mIGVhcmx5DQptZW1vcnkgbWFuYWdlbWVudCBpbml0aWFs
aXphdGlvbiAobWF5YmUgZm9yIFhlbiBQViBvbmx5KSBoYXZlIGNoYW5nZWQNCnNpbmNlIHRo
ZSBwYXRjaCBpbnRyb2R1Y2luZyBjYW5fdXNlX2Jya19wZ3Qgd2FzIGFwcGxpZWQuDQoNCg0K
SnVlcmdlbg0K
--------------F0fn3x0XCsSqJO4lIPgpIPsM
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------F0fn3x0XCsSqJO4lIPgpIPsM--

--------------0Copjh6EgJqlK6kqyQCrEvYv--

--------------irqrfNfFkF6ofuzTcgZ0IqgB
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmH9BxgFAwAAAAAACgkQsN6d1ii/Ey/e
4Af/Vhv/nsdl9H3DagPRLJXNIZ1GcaqMejNuDbaNigHXAQ+h3B/TYnq7VQ00wVaOZTytE/bwBVpU
oYiSzSReoJvzXLktDs6LxexgkD38rO/e97jGrQCOBeEonFr4cDicnLQKouX2WqPX99c2SB2lt57r
grWw9gI8rIqRTew2nLMhjp0AuzzUMytyv4wP276hj2/7Rl4+FArLNvCCkp7KkG4a9z/vNiYC6Si/
AXdZNxCFt5cP+bu/Be3yoOpVGi6ewiGzJkp774XaPWAHCIcKFWCa5NzwBySS4IdHWDIsisNsuA6M
/qyuo95P+mMSqGZeNiegtWEZf9vy0fuy8MFL+CyM9g==
=PwT0
-----END PGP SIGNATURE-----

--------------irqrfNfFkF6ofuzTcgZ0IqgB--
