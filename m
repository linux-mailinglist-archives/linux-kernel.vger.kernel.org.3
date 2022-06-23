Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25EE555752B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 10:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbiFWIOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 04:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbiFWIOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 04:14:40 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B61248314
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 01:14:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B03DA21CBA;
        Thu, 23 Jun 2022 08:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655972074; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=afwLM4d4rLkUgAhD+sY30a7nqnnN9dXH8QSVTUckGeo=;
        b=nW3hGcBTNax3sy1XU5yV4vaq8C9RumrT231gEt0vxuYG2Txds/YvyV0Nau2Ij3b2sOWbIX
        m5cTsjLh+4b40XOjOJ1wu6r+PLkWZ2Kjg/lJTGf/GqnHOxRn+Hg3rkoN4eVe02so5+6kcq
        sH5Uu6SW518BauOK0pk72sQyTF2cIbE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 67C69133A6;
        Thu, 23 Jun 2022 08:14:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vfnuF+ogtGIRfQAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 23 Jun 2022 08:14:34 +0000
Message-ID: <594866df-ef56-055f-c13c-64fac5797164@suse.com>
Date:   Thu, 23 Jun 2022 10:14:33 +0200
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
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <b210d5c7-26cc-df6f-fa37-56fe04c8d0dc@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------tyKWPK4tg4qidWiOv9WpCwsK"
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
--------------tyKWPK4tg4qidWiOv9WpCwsK
Content-Type: multipart/mixed; boundary="------------ZqePaME2t2Xr00pBN6b1ShkQ";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Jan Beulich <jbeulich@suse.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
Message-ID: <594866df-ef56-055f-c13c-64fac5797164@suse.com>
Subject: Re: [PATCH 2/2] x86: fix setup of brk area
References: <20220622161048.4483-1-jgross@suse.com>
 <20220622161048.4483-3-jgross@suse.com>
 <b210d5c7-26cc-df6f-fa37-56fe04c8d0dc@suse.com>
In-Reply-To: <b210d5c7-26cc-df6f-fa37-56fe04c8d0dc@suse.com>

--------------ZqePaME2t2Xr00pBN6b1ShkQ
Content-Type: multipart/mixed; boundary="------------Q7WiS17ExvyNKOn2eZ3hqg4i"

--------------Q7WiS17ExvyNKOn2eZ3hqg4i
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjMuMDYuMjIgMTA6MDksIEphbiBCZXVsaWNoIHdyb3RlOg0KPiBPbiAyMi4wNi4yMDIy
IDE4OjEwLCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KPj4gQ29tbWl0IGUzMjY4M2M2ZjdkMiAo
Ing4Ni9tbTogRml4IFJFU0VSVkVfQlJLKCkgZm9yIG9sZGVyIGJpbnV0aWxzIikNCj4+IHB1
dCB0aGUgYnJrIGFyZWEgaW50byB0aGUgLmJzcyBzZWdtZW50LCBjYXVzaW5nIGl0IG5vdCB0
byBiZSBjbGVhcmVkDQo+PiBpbml0aWFsbHkuDQo+IA0KPiBUaGlzIHJlYWRzIGNvbnRyYWRp
Y3RpdmVseTogSWYgdGhlIGFyZWEgd2FzIHB1dCBpbiAuYnNzLCBpdCB3b3VsZCBiZQ0KPiBj
bGVhcmVkLiBUaGluZyBpcyBpdCBpcyBwdXQgaW4gLmJzcy4uYnJrIGluIHRoZSBvYmplY3Qg
ZmlsZXMsIHdoaWxlDQo+IHRoZSBsaW5rZXIgc2NyaXB0IHB1dHMgaXQgaW4gLmJyayAoaS5l
LiBvdXRzaWRlIG9mIC5ic3MpLg0KDQpIbW0sIHllcywgdGhpcyBzaG91bGQgYmUgcmV3b3Jk
ZWQuDQoNCj4gDQo+PiBBcyB0aGUgYnJrIGFyZWEgaXMgdXNlZCB0byBhbGxvY2F0ZSBlYXJs
eSBwYWdlIHRhYmxlcywgdGhlc2UNCj4+IG1pZ2h0IGNvbnRhaW4gZ2FyYmFnZSBpbiBub3Qg
ZXhwbGljaXRseSB3cml0dGVuIGVudHJpZXMuDQo+IA0KPiBJJ20gc3VycHJpc2VkIHRoaXMg
bGFjayBvZiB6ZXJvLWluaXRpYWxpemF0aW9uIGRpZG4ndCBjYXVzZSBhbnkgaXNzdWUNCj4g
b3V0c2lkZSBvZiBQViBYZW4uIFVubGVzcyBvZiBjb3Vyc2UgdGhlcmUgbmV2ZXIgd2FzIHRo
ZSBpbnRlbnRpb24gZm9yDQo+IHVzZXJzIG9mIHRoZSBmYWNpbGl0eSB0byBhc3N1bWUgYmxh
bmsgcGFnZXMgY29taW5nIGZyb20gdGhlcmUsIGluDQo+IHdoaWNoIGNhc2UgWGVuJ3MgdXNl
IGZvciBlYXJseSBwYWdlIHRhYmxlcyB3b3VsZCBoYXZlIGJlZW4gd3JvbmcgKGluDQo+IG5v
dCBleHBsaWNpdGx5IHplcm9pbmcgdGhlIHNwYWNlIGZpcnN0KS4NCg0KRnVuIGZhY3Q6IEl0
cyBub3QgWGVuJ3MgdXNlIGZvciBlYXJseSBwYWdlIHRhYmxlcywgYnV0IHRoZSBrZXJuZWwn
cw0KaW5pdCBjb2RlLiBJdCBpcyB1c2VkIGZvciBiYXJlIG1ldGFsLCB0b28uDQoNClRoZSB1
c2UgY2FzZSBmb3IgaW5pdGlhbCBwYWdlIHRhYmxlcyBpcyB0aGUgcHJvYmxlbWF0aWMgb25l
LiBPbmx5IHRoZQ0KbmVlZGVkIHBhZ2UgdGFibGUgZW50cmllcyBhcmUgd3JpdHRlbiBieSB0
aGUga2VybmVsLCBzbyB0aGUgb3RoZXIgb25lcw0Ka2VlcCB0aGVpciBpbml0aWFsIGdhcmJh
Z2UgdmFsdWVzLiBBcyBub3JtYWxseSBubyB1bmluaXRpYWxpemVkIGVudHJpZXMNCmFyZSBl
dmVyIHJlZmVyZW5jZWQsIHRoaXMgd2lsbCBoYXZlIG5vIHJlYWwgaW1wYWN0Lg0KDQpXaXRo
IFhlbiwgaG93ZXZlciwgQUxMIGVudHJpZXMgYXJlIGJlaW5nIHZhbGlkYXRlZCwgd2hpY2gg
bGVkIHRvIHRoZQ0KZWFybHkgY3Jhc2ggb2YgZG9tMC4NCg0KDQpKdWVyZ2VuDQo=
--------------Q7WiS17ExvyNKOn2eZ3hqg4i
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------Q7WiS17ExvyNKOn2eZ3hqg4i--

--------------ZqePaME2t2Xr00pBN6b1ShkQ--

--------------tyKWPK4tg4qidWiOv9WpCwsK
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmK0IOoFAwAAAAAACgkQsN6d1ii/Ey9A
awf/UbFKzpxwA/vQQZx1sPtORlECc5baaQN5NYZJ7TMX450cnX99+a/RTXSvHL3o3K0xGGnDG7xr
o1AmHdBMnWKXrpnukvQ9+UrY1fsCtnYzxSwOlg7yroVMdG69qVihKMJAY7ixfibcwRZERM9bxP9+
2e5kgMhwRagAc0YTnQNtE5tQ2GzIi3aAnQa1MYDn2wgCROJDlMIn6PjEevw0oWF+07VM/yyZtV7m
ZCw6JANjOHN/HmDRhMX9ChuOoElGn4LKlYO+m2N4X/l3U0rIew6BzUL4a8/ZNZtSVFd6ZyN9YyBx
e858wV+nkkPMPt60DezRgzzF2LSDh5I9HGvEqSmp/g==
=z5F0
-----END PGP SIGNATURE-----

--------------tyKWPK4tg4qidWiOv9WpCwsK--
