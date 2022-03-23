Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6965F4E4E70
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 09:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242840AbiCWIpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 04:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242829AbiCWIpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 04:45:31 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A7131DF7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 01:44:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3202D210F0;
        Wed, 23 Mar 2022 08:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1648025040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=SFX4Zoc29vno8WtrDxS378hqAu13iL7PccJBITKfW+A=;
        b=UbsCt0bAHvdOFce6hCoHi3zSw/ivJ1BlWWwau8FuM6OnC7rrOZpZEIn5gCzxevivv3iZD6
        G+jRWBN108zjfPxBe2B6uWKhKqGBMSNDBocvorygv5ZPj1Vk/nKHeNltZZme/sHlmX92UI
        jHBOMRL1Atm6U9e+/02SXkttuaAibsI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 062BB13B9C;
        Wed, 23 Mar 2022 08:44:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id x1NFANDdOmJMCwAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 23 Mar 2022 08:44:00 +0000
Message-ID: <8e8ec786-74db-157b-a290-b1537941e91d@suse.com>
Date:   Wed, 23 Mar 2022 09:43:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     linux-mm@kvack.org, lkml <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <MHocko@suse.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
From:   Juergen Gross <jgross@suse.com>
Subject: blocking vs. non-blocking mmu notifiers
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------6gu2rAP0rMGxHnUVHNkFRX0n"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------6gu2rAP0rMGxHnUVHNkFRX0n
Content-Type: multipart/mixed; boundary="------------Kp5yg0KWZJOCf70tncEp4F3j";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: linux-mm@kvack.org, lkml <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <MHocko@suse.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Message-ID: <8e8ec786-74db-157b-a290-b1537941e91d@suse.com>
Subject: blocking vs. non-blocking mmu notifiers

--------------Kp5yg0KWZJOCf70tncEp4F3j
Content-Type: multipart/mixed; boundary="------------iNzNUtyJKMKTuwO3VSZsfBov"

--------------iNzNUtyJKMKTuwO3VSZsfBov
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGksDQoNCmR1cmluZyBhbmFseXNpcyBvZiBhIGN1c3RvbWVyJ3MgcHJvYmxlbSBvbiBhIDQu
MTIgYmFzZWQga2VybmVsDQooZGVhZGxvY2sgZHVlIHRvIGEgYmxvY2tpbmcgbW11IG5vdGlm
aWVyIGluIGEgWGVuIGRyaXZlcikgSSBjYW1lDQphY3Jvc3MgdXBzdHJlYW0gcGF0Y2hlcyA5
MzA2NWFjNzUzZTQgKCJtbSwgb29tOiBkaXN0aW5ndWlzaA0KYmxvY2thYmxlIG1vZGUgZm9y
IG1tdSBub3RpZmllcnMiKSBldCBhbC4NCg0KVGhlIGJhY2t0cmFjZSBvZiB0aGUgYmxvY2tl
ZCB0YXNrcyB3YXMgdHlwaWNhbGx5IHNvbWV0aGluZyBsaWtlOg0KDQogICMwIFtmZmZmYzkw
MDQyMjJmMjI4XSBfX3NjaGVkdWxlIGF0IGZmZmZmZmZmODE3MjIzZTINCiAgIzEgW2ZmZmZj
OTAwNDIyMmYyYjhdIHNjaGVkdWxlIGF0IGZmZmZmZmZmODE3MjJhMDINCiAgIzIgW2ZmZmZj
OTAwNDIyMmYyYzhdIHNjaGVkdWxlX3ByZWVtcHRfZGlzYWJsZWQgYXQgZmZmZmZmZmY4MTcy
MmQwYQ0KICAjMyBbZmZmZmM5MDA0MjIyZjJkMF0gX19tdXRleF9sb2NrIGF0IGZmZmZmZmZm
ODE3MjQxMDQNCiAgIzQgW2ZmZmZjOTAwNDIyMmYzNjBdIG1uX2ludmxfcmFuZ2Vfc3RhcnQg
YXQgZmZmZmZmZmZjMDFmZDM5OCBbeGVuX2dudGRldl0NCiAgIzUgW2ZmZmZjOTAwNDIyMmYz
OThdIF9fbW11X25vdGlmaWVyX2ludmFsaWRhdGVfcGFnZSBhdCBmZmZmZmZmZjgxMjMzNzVh
DQogICM2IFtmZmZmYzkwMDQyMjJmM2MwXSB0cnlfdG9fdW5tYXBfb25lIGF0IGZmZmZmZmZm
ODEyMTEyY2INCiAgIzcgW2ZmZmZjOTAwNDIyMmY0NzhdIHJtYXBfd2Fsa19maWxlIGF0IGZm
ZmZmZmZmODEyMTA1Y2QNCiAgIzggW2ZmZmZjOTAwNDIyMmY0ZDBdIHRyeV90b191bm1hcCBh
dCBmZmZmZmZmZjgxMjEyNDUwDQogICM5IFtmZmZmYzkwMDQyMjJmNTA4XSBzaHJpbmtfcGFn
ZV9saXN0IGF0IGZmZmZmZmZmODExZTA3NTUNCiMxMCBbZmZmZmM5MDA0MjIyZjVjOF0gc2hy
aW5rX2luYWN0aXZlX2xpc3QgYXQgZmZmZmZmZmY4MTFlMTNjZg0KIzExIFtmZmZmYzkwMDQy
MjJmNmE4XSBzaHJpbmtfbm9kZV9tZW1jZyBhdCBmZmZmZmZmZjgxMWUyNDFmDQojMTIgW2Zm
ZmZjOTAwNDIyMmY3OTBdIHNocmlua19ub2RlIGF0IGZmZmZmZmZmODExZTI5YzUNCiMxMyBb
ZmZmZmM5MDA0MjIyZjgwOF0gZG9fdHJ5X3RvX2ZyZWVfcGFnZXMgYXQgZmZmZmZmZmY4MTFl
MmVlMQ0KIzE0IFtmZmZmYzkwMDQyMjJmODY4XSB0cnlfdG9fZnJlZV9wYWdlcyBhdCBmZmZm
ZmZmZjgxMWUzMjQ4DQojMTUgW2ZmZmZjOTAwNDIyMmY4ZThdIF9fYWxsb2NfcGFnZXNfc2xv
d3BhdGggYXQgZmZmZmZmZmY4MTI2MmMzNw0KIzE2IFtmZmZmYzkwMDQyMjJmOWYwXSBfX2Fs
bG9jX3BhZ2VzX25vZGVtYXNrIGF0IGZmZmZmZmZmODEyMWFmYzENCiMxNyBbZmZmZmM5MDA0
MjIyZmE0OF0gYWxsb2NfcGFnZXNfY3VycmVudCBhdCBmZmZmZmZmZjgxMjJmMzUwDQojMTgg
W2ZmZmZjOTAwNDIyMmZhNzhdIF9fZ2V0X2ZyZWVfcGFnZXMgYXQgZmZmZmZmZmY4MTIxNjg1
YQ0KIzE5IFtmZmZmYzkwMDQyMjJmYTgwXSBfX3BvbGx3YWl0IGF0IGZmZmZmZmZmODEyN2U3
OTUNCiMyMCBbZmZmZmM5MDA0MjIyZmFhOF0gZXZ0Y2huX3BvbGwgYXQgZmZmZmZmZmZjMDBl
ODAyYiBbeGVuX2V2dGNobl0NCiMyMSBbZmZmZmM5MDA0MjIyZmFiOF0gZG9fc3lzX3BvbGwg
YXQgZmZmZmZmZmY4MTI3Zjk1Mw0KIzIyIFtmZmZmYzkwMDQyMjJmZWM4XSBzeXNfcHBvbGwg
YXQgZmZmZmZmZmY4MTI4MDQ3OA0KIzIzIFtmZmZmYzkwMDQyMjJmZjMwXSBkb19zeXNjYWxs
XzY0IGF0IGZmZmZmZmZmODEwMDQ5NTQNCiMyNCBbZmZmZmM5MDA0MjIyZmY1MF0gZW50cnlf
U1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lIGF0IGZmZmZmZmZmODE4MDAwYjYNCg0KSXQgd2Fz
IGZvdW5kIHRoYXQgdGhlIG5vdGlmaWVyIG9mIHRoZSBYZW4gZ250ZGV2IGRyaXZlciB3YXMg
dXNpbmcgYQ0KbXV0ZXggcmVzdWx0aW5nIGluIHRoZSBkZWFkbG9jay4NCg0KTWljaGFsIEhv
Y2tvIHN1Z2dlc3RlZCB0aGF0IGJhY2twb3J0aW5nIGFib3ZlIG1lbnRpb25lZCBwYXRjaCBt
aWdodA0KaGVscCwgYXMgdGhlIG1tdSBub3RpZmllciBjYWxsIGlzIGhhcHBlbmluZyBpbiBh
dG9taWMgY29udGV4dC4NCg0KTG9va2luZyBpbnRvIHRoYXQgSSB3YXMgd29uZGVyaW5nIHdo
ZXRoZXIgdHJ5X3RvX3VubWFwX29uZSgpIHNob3VsZG4ndA0KY2FsbCBtbXVfbm90aWZpZXJf
aW52YWxpZGF0ZV9yYW5nZV9zdGFydF9ub25ibG9jaygpIGluc3RlYWQgb2YNCm1tdV9ub3Rp
Zmllcl9pbnZhbGlkYXRlX3JhbmdlX3N0YXJ0KCkgaWYgdGhpcyBpcyB0cnVlLiBPdGhlcndp
c2UgSQ0KY2FuJ3Qgc2VlIGhvdyB0aGlzIGRlYWRsb2NrIGNvdWxkIGJlIGF2b2lkZWQuDQoN
CkFueSB0aG91Z2h0cz8NCg0KDQpKdWVyZ2VuDQo=
--------------iNzNUtyJKMKTuwO3VSZsfBov
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------iNzNUtyJKMKTuwO3VSZsfBov--

--------------Kp5yg0KWZJOCf70tncEp4F3j--

--------------6gu2rAP0rMGxHnUVHNkFRX0n
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmI63c8FAwAAAAAACgkQsN6d1ii/Ey/H
jQgAnIe6RGnGr9CEBIB2sNTuiQfgh/jnskk5fZSxyWI4Jw8SEweK+TWY1nALwAxygPGv3xkOXMy1
En1hVbstiL51+7w+H3Bo3HXowYVEdWCzB94PfQX35RAG3I9HWYhvUoITXN5apNY+dEfyHd/FUDkB
005o55t9LsPb8e2JiQVRbttZNaSaNm6dzthiViwEC5kk/PJPmLwqtJGCWrG8lqHBR0G+QdUJb3+g
8TY6XuUe6p6bw2OP6Z6MPBB+6XAXfnUqc3hTy8zX3yb/p0hGoT6cypS413ZcUxOsBxpaGvLoIx9B
xD3SmCIsmLhlg3jbEtRFLd7T6EpCXeB7LSYm3J4kuQ==
=yUkc
-----END PGP SIGNATURE-----

--------------6gu2rAP0rMGxHnUVHNkFRX0n--
