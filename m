Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6F15070FA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 16:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351272AbiDSOuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351305AbiDSOus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:50:48 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F232CE30
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 07:48:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 021461F752;
        Tue, 19 Apr 2022 14:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650379684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2qHyop+1P6vNk74wS/Hu4HCEXxTm5BKFFllbFWg7vQs=;
        b=ldJbhLGrdUr4FGbted2k9hgkyX14dIjflBU0YZMpDDe0g+fQ7Vwl/GL4Qy7fz+Pc8TSRh/
        ejm+RKhWb1BJwCy86Z6SxUl2bpStCl8zq0R4A2bGdgwBiWrbToiHC6w3TFICmT9QwTi9uO
        h8Ypz3bYxN3+k91Qd2wuJlZcIXJhdTU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A9532132E7;
        Tue, 19 Apr 2022 14:48:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nGoQKKPLXmKPKQAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 19 Apr 2022 14:48:03 +0000
Message-ID: <b68163be-ad43-7773-22ff-e83191886626@suse.com>
Date:   Tue, 19 Apr 2022 16:48:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     Oleksandr <olekstysh@gmail.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Julien Grall <julien@xen.org>,
        "Michael S. Tsirkin" <mst@redhat.com>
References: <1649963973-22879-1-git-send-email-olekstysh@gmail.com>
 <1649963973-22879-7-git-send-email-olekstysh@gmail.com>
 <alpine.DEB.2.22.394.2204151305050.915916@ubuntu-linux-20-04-desktop>
 <YlpdBHKT1bYzZe2e@infradead.org>
 <f879622e-5656-deb1-1930-f0cd180a4ab1@gmail.com>
 <alpine.DEB.2.22.394.2204181202080.915916@ubuntu-linux-20-04-desktop>
 <6a04cc34-fbb3-44d8-c1a4-03bda5b3deb1@gmail.com>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [RFC PATCH 6/6] arm/xen: Assign xen-virtio DMA ops for virtio
 devices in Xen guests
In-Reply-To: <6a04cc34-fbb3-44d8-c1a4-03bda5b3deb1@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------oIIxPuFY5WvnE0tBaUGfzFWJ"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------oIIxPuFY5WvnE0tBaUGfzFWJ
Content-Type: multipart/mixed; boundary="------------tYbLJuhukeFgUoH3LwEWStTL";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Oleksandr <olekstysh@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, xen-devel@lists.xenproject.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Julien Grall <julien@xen.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <b68163be-ad43-7773-22ff-e83191886626@suse.com>
Subject: Re: [RFC PATCH 6/6] arm/xen: Assign xen-virtio DMA ops for virtio
 devices in Xen guests
References: <1649963973-22879-1-git-send-email-olekstysh@gmail.com>
 <1649963973-22879-7-git-send-email-olekstysh@gmail.com>
 <alpine.DEB.2.22.394.2204151305050.915916@ubuntu-linux-20-04-desktop>
 <YlpdBHKT1bYzZe2e@infradead.org>
 <f879622e-5656-deb1-1930-f0cd180a4ab1@gmail.com>
 <alpine.DEB.2.22.394.2204181202080.915916@ubuntu-linux-20-04-desktop>
 <6a04cc34-fbb3-44d8-c1a4-03bda5b3deb1@gmail.com>
In-Reply-To: <6a04cc34-fbb3-44d8-c1a4-03bda5b3deb1@gmail.com>

--------------tYbLJuhukeFgUoH3LwEWStTL
Content-Type: multipart/mixed; boundary="------------IytZh70LUF3jeF0x0ClKbXOS"

--------------IytZh70LUF3jeF0x0ClKbXOS
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTkuMDQuMjIgMTQ6MTcsIE9sZWtzYW5kciB3cm90ZToNCj4gDQo+IEhlbGxvIFN0ZWZh
bm8sIEp1ZXJnZW4NCj4gDQo+IA0KPiBPbiAxOC4wNC4yMiAyMjoxMSwgU3RlZmFubyBTdGFi
ZWxsaW5pIHdyb3RlOg0KPj4gT24gTW9uLCAxOCBBcHIgMjAyMiwgT2xla3NhbmRyIHdyb3Rl
Og0KPj4+IE9uIDE2LjA0LjIyIDA5OjA3LCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4+
Pg0KPj4+IEhlbGxvIENocmlzdG9waA0KPj4+DQo+Pj4+IE9uIEZyaSwgQXByIDE1LCAyMDIy
IGF0IDAzOjAyOjQ1UE0gLTA3MDAsIFN0ZWZhbm8gU3RhYmVsbGluaSB3cm90ZToNCj4+Pj4+
IFRoaXMgbWFrZXMgc2Vuc2Ugb3ZlcmFsbC4gQ29uc2lkZXJpbmcgdGhhdCB0aGUgc3dpb3Rs
Yi14ZW4gY2FzZSBhbmQgdGhlDQo+Pj4+PiB2aXJ0aW8gY2FzZSBhcmUgbXV0dWFsbHkgZXhj
bHVzaXZlLCBJIHdvdWxkIHdyaXRlIGl0IGxpa2UgdGhpczoNCj4+Pj4gQ3VyaW91cyBxdWVz
dGlvbjrCoCBXaHkgY2FuJ3QgdGhlIHNhbWUgZ3JhbnQgc2NoZW1lIGFsc28gYmUgdXNlZCBm
b3INCj4+Pj4gbm9uLXZpcnRpbyBkZXZpY2VzP8KgIEkgcmVhbGx5IGhhdGUgaGF2aW5nIHZp
cnRpbyBob29rcyBpbiB0aGUgYXJjaA0KPj4+PiBkbWEgY29kZS7CoCBXaHkgY2FuJ3QgWGVu
IGp1c3Qgc2F5IGluIERUL0FDUEkgdGhhdCBncmFudHMgY2FuIGJlIHVzZWQNCj4+Pj4gZm9y
IGEgZ2l2ZW4gZGV2aWNlPw0KPj4gWy4uLl0NCj4+DQo+Pj4gVGhpcyBwYXRjaCBzZXJpZXMg
dHJpZXMgdG8gbWFrZSB0aGluZ3Mgd29yayB3aXRoICJ2aXJ0aW8iIGRldmljZXMgaW4gWGVu
DQo+Pj4gc3lzdGVtIHdpdGhvdXQgaW50cm9kdWNpbmcgYW55IG1vZGlmaWNhdGlvbnMgdG8g
Y29kZSB1bmRlciBkcml2ZXJzL3ZpcnRpby4NCj4+DQo+PiBBY3R1YWxseSwgSSB0aGluayBD
aHJpc3RvcGggaGFzIGEgcG9pbnQuDQo+Pg0KPj4gVGhlcmUgaXMgbm90aGluZyBpbmhlcmVu
dGx5IHZpcnRpbyBzcGVjaWZpYyBpbiB0aGlzIHBhdGNoIHNlcmllcyBvciBpbg0KPj4gdGhl
ICJ4ZW4sZGV2LWRvbWlkIiBkZXZpY2UgdHJlZSBiaW5kaW5nLg0KPiANCj4gDQo+IEFsdGhv
dWdoIHRoZSBtYWluIGludGVudGlvbiBvZiB0aGlzIHNlcmllcyB3YXMgdG8gZW5hYmxlIHVz
aW5nIHZpcnRpbyBkZXZpY2VzIGluIA0KPiBYZW4gZ3Vlc3RzLCBJIGFncmVlIHRoYXQgbm90
aGluZyBpbiBuZXcgRE1BIG9wcyBsYXllciAoeGVuLXZpcnRpby5jKSBpcyB2aXJ0aW8gDQo+
IHNwZWNpZmljIChhdCBsZWFzdCBhdCB0aGUgbW9tZW50KS4gUmVnYXJkaW5nIHRoZSB3aG9s
ZSBwYXRjaCBzZXJpZXMgSSBhbSBub3QgDQo+IHF1aXRlIHN1cmUsIGFzIGl0IHVzZXMgYXJj
aF9oYXNfcmVzdHJpY3RlZF92aXJ0aW9fbWVtb3J5X2FjY2VzcygpLiA+DQo+PiDCoCBBc3N1
bWluZyBhIGdpdmVuIGRldmljZSBpcw0KPj4gZW11bGF0ZWQgYnkgYSBYZW4gYmFja2VuZCwg
aXQgY291bGQgYmUgdXNlZCB3aXRoIGdyYW50cyBhcyB3ZWxsLg0KPj4NCj4+IEZvciBpbnN0
YW5jZSwgd2UgY291bGQgcHJvdmlkZSBhbiBlbXVsYXRlZCBlMTAwMCBOSUMgd2l0aCBhDQo+
PiAieGVuLGRldi1kb21pZCIgcHJvcGVydHkgaW4gZGV2aWNlIHRyZWUuIExpbnV4IGNvdWxk
IHVzZSBncmFudHMgd2l0aCBpdA0KPj4gYW5kIHRoZSBiYWNrZW5kIGNvdWxkIG1hcCB0aGUg
Z3JhbnRzLiBJdCB3b3VsZCB3b3JrIHRoZSBzYW1lIHdheSBhcw0KPj4gdmlydGlvLW5ldC9i
bG9jay9ldGMuIFBhc3N0aHJvdWdoIGRldmljZXMgd291bGRuJ3QgaGF2ZSB0aGUNCj4+ICJ4
ZW4sZGV2LWRvbWlkIiBwcm9wZXJ0eSwgc28gbm8gcHJvYmxlbXMuDQo+Pg0KPj4gU28gSSB0
aGluayB3ZSBjb3VsZCBlYXNpbHkgZ2VuZXJhbGl6ZSB0aGlzIHdvcmsgYW5kIGV4cGFuZCBp
dCB0byBhbnkNCj4+IGRldmljZS4gV2UganVzdCBuZWVkIHRvIGhvb2sgb24gdGhlICJ4ZW4s
ZGV2LWRvbWlkIiBkZXZpY2UgdHJlZQ0KPj4gcHJvcGVydHkuDQo+Pg0KPj4gSSB0aGluayBp
dCBpcyBqdXN0IGEgbWF0dGVyIG9mOg0KPj4gLSByZW1vdmUgdGhlICJ2aXJ0aW8sbW1pbyIg
Y2hlY2sgZnJvbSB4ZW5faXNfdmlydGlvX2RldmljZQ0KPj4gLSByZW5hbWUgeGVuX2lzX3Zp
cnRpb19kZXZpY2UgdG8gc29tZXRoaW5nIG1vcmUgZ2VuZXJpYywgbGlrZQ0KPj4gwqDCoCB4
ZW5faXNfZ3JhbnRzX2RldmljZQ0KDQp4ZW5faXNfZ3JhbnRzX2RtYV9kZXZpY2UsIHBsZWFz
ZS4gTm9ybWFsIFhlbiBQViBkZXZpY2VzIGFyZSBjb3ZlcmVkIGJ5DQpncmFudHMsIHRvbywg
YW5kIEknZCBsaWtlIHRvIGF2b2lkIHRoZSBjb25mdXNpb24gYXJpc2luZyBmcm9tIHRoaXMu
DQoNCj4+IC0gcmVuYW1lIHhlbl92aXJ0aW9fc2V0dXBfZG1hX29wcyB0byBzb21ldGhpbmcg
bW9yZSBnZW5lcmljLCBsaWtlDQo+PiDCoMKgIHhlbl9ncmFudHNfc2V0dXBfZG1hX29wcw0K
Pj4NCj4+IEFuZCB0aGF0J3MgcHJldHR5IG11Y2ggaXQuDQo+IA0KPiArIGxpa2VseSByZW5h
bWluZyBldmVyeXRoaW5nIGluIHRoYXQgcGF0Y2ggc2VyaWVzIG5vdCB0byBtZW50aW9uIHZp
cnRpbyAobW9zdGx5IA0KPiByZWxhdGVkIHRvIHhlbi12aXJ0aW8uYyBpbnRlcm5hbHMpLg0K
PiANCj4gDQo+IFN0ZWZhbm8sIHRoYW5rIHlvdSBmb3IgY2xhcmlmeWluZyBDaHJpc3RvcGgn
cyBwb2ludC4NCj4gDQo+IFdlbGwsIEkgYW0gbm90IGFnYWluc3QgZ29pbmcgdGhpcyBkaXJl
Y3Rpb24uIENvdWxkIHdlIHBsZWFzZSBtYWtlIGEgZGVjaXNpb24gb24gDQo+IHRoaXM/IEBK
dWVyZ2VuLCB3aGF0IGlzIHlvdXIgb3Bpbmlvbj8NCg0KWWVzLCB3aHkgbm90Lg0KDQpNYXli
ZSByZW5hbWUgeGVuLXZpcnRpby5jIHRvIGdyYW50LWRtYS5jPw0KDQpJJ2Qga2VlcCB0aGUg
WEVOX1ZJUlRJTyByZWxhdGVkIGNvbmZpZyBvcHRpb24sIGFzIHRoaXMgd2lsbCBiZSB0aGUg
bm9ybWFsIHVzZQ0KY2FzZS4gZ3JhbnQtZG1hLmMgc2hvdWxkIGJlIGNvdmVyZWQgYnkgYSBu
ZXcgaGlkZGVuIGNvbmZpZyBvcHRpb24gWEVOX0dSQU5UX0RNQQ0Kc2VsZWN0ZWQgYnkgWEVO
X1ZJUlRJTy4NCg0KQ09ORklHX1hFTl9WSVJUSU8gc2hvdWxkIHN0aWxsIGd1YXJkIHhlbl9o
YXNfcmVzdHJpY3RlZF92aXJ0aW9fbWVtb3J5X2FjY2VzcygpLg0KDQoNCkp1ZXJnZW4NCg==

--------------IytZh70LUF3jeF0x0ClKbXOS
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------IytZh70LUF3jeF0x0ClKbXOS--

--------------tYbLJuhukeFgUoH3LwEWStTL--

--------------oIIxPuFY5WvnE0tBaUGfzFWJ
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmJey6MFAwAAAAAACgkQsN6d1ii/Ey8Y
Cgf/fa3dM1JSR5n0u1qSuc6yvsRsjmsRbqYjGztYsmAk/gr+mMoSNZJgki9lC+flyJnexUJie5/T
FJB5nrXRyMVElNxHKHYfZIgNTDG5m8NO3y+JzxJuQiJiJERh6z+gK8J/NTl1CFW6X51ExDvSp095
CF+0CDOHicqoEWHMRHTk7GgQrzrVvQWi9KDv6Vpc3R3eXLry6jZL6926MCoElNygF+hbvmJBYyAS
qSvz+SHGvPlJiAi3cERgCGov8yQkintOerQGjjclITFHptbefHin+9JSdAEoBh2nIJcMxl1b3/2/
9gcoc4aefQluT4BFB1CzqQMCHyvJF/I9wPzvgFhCuQ==
=MsFz
-----END PGP SIGNATURE-----

--------------oIIxPuFY5WvnE0tBaUGfzFWJ--
