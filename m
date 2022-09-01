Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF2B5A9B71
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 17:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbiIAPVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 11:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233225AbiIAPVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 11:21:07 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F11E3C8F4;
        Thu,  1 Sep 2022 08:21:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E90CD20195;
        Thu,  1 Sep 2022 15:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1662045661; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oQoq4bqQp7xDr4YMkqk9mdRdNYnybE6NtXuH/R709S8=;
        b=BlnfTdmzfEyX3DONFJzlyJLtdMETXUSg3qcaBBRvAAgCQPTeWqbyCnhqHgBiwaT9+yWxcN
        iRvbRhUSJ+vbfbryWrxexdRB9d19CRGCQPzR1um9gD0UR59dV3fJh+dTwL6fPBztMfluIJ
        zhKToXzB2xKMnXGopb10V2jmlBGDeyE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A5BBC13A89;
        Thu,  1 Sep 2022 15:21:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dSweJ93NEGOtdQAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 01 Sep 2022 15:21:01 +0000
Message-ID: <efb37ff0-5e0f-0813-3ffe-a8745ecf968b@suse.com>
Date:   Thu, 1 Sep 2022 17:21:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 0/3] xen-blk{front,back}: Fix the broken semantic and
 flow of feature-persistent
Content-Language: en-US
To:     SeongJae Park <sj@kernel.org>, roger.pau@citrix.com
Cc:     marmarek@invisiblethingslab.com, mheyne@amazon.de,
        xen-devel@lists.xenproject.org, axboe@kernel.dk, ptyadav@amazon.de,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220831165824.94815-1-sj@kernel.org>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <20220831165824.94815-1-sj@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------CAINiOsjmi0msmQ0OUfeF4Kz"
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
--------------CAINiOsjmi0msmQ0OUfeF4Kz
Content-Type: multipart/mixed; boundary="------------zXbVxqxcXeKv8xitDfEShKed";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: SeongJae Park <sj@kernel.org>, roger.pau@citrix.com
Cc: marmarek@invisiblethingslab.com, mheyne@amazon.de,
 xen-devel@lists.xenproject.org, axboe@kernel.dk, ptyadav@amazon.de,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <efb37ff0-5e0f-0813-3ffe-a8745ecf968b@suse.com>
Subject: Re: [PATCH v2 0/3] xen-blk{front,back}: Fix the broken semantic and
 flow of feature-persistent
References: <20220831165824.94815-1-sj@kernel.org>
In-Reply-To: <20220831165824.94815-1-sj@kernel.org>

--------------zXbVxqxcXeKv8xitDfEShKed
Content-Type: multipart/mixed; boundary="------------XOd2EQ3pU0OaWz2JuWcdTqkZ"

--------------XOd2EQ3pU0OaWz2JuWcdTqkZ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMzEuMDguMjIgMTg6NTgsIFNlb25nSmFlIFBhcmsgd3JvdGU6DQo+IENoYW5nZXMgZnJv
bSB2MQ0KPiAoaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcveGVuLWRldmVsLzIwMjIwODI1MTYx
NTExLjk0OTIyLTEtc2pAa2VybmVsLm9yZy8pDQo+IC0gRml4IHRoZSB3cm9uZyBmZWF0dXJl
X3BlcnNpc3RlbnQgY2FjaGluZyBwb3NpdGlvbiBvZiBibGtmcm9udA0KPiAtIFNldCBibGtm
cm9udCdzIGZlYXR1cmVfcGVyc2lzdGVudCBmaWVsZCBzZXR0aW5nIHdpdGggc2ltcGxlICcm
JicNCj4gICAgaW5zdGVhZCBvZiAnaWYnIChQcmF0eXVzaCBZYWRhdikNCj4gDQo+IFRoaXMg
cGF0Y2hzZXQgZml4ZXMgbWlzdXNlIG9mIHRoZSAnZmVhdHVyZS1wZXJzaXN0ZW50JyBhZHZl
cnRpc2VtZW50DQo+IHNlbWFudGljIChwYXRjaGVzIDEgYW5kIDIpLCBhbmQgdGhlIHdyb25n
IHRpbWluZyBvZiB0aGUNCj4gJ2ZlYXR1cmVfcGVyc2lzdGVudCcgdmFsdWUgY2FjaGluZywg
d2hpY2ggbWFkZSBwZXJzaXN0ZW50IGdyYW50cyBmZWF0dXJlDQo+IGFsd2F5cyBkaXNhYmxl
ZC4NCj4gDQo+IFNlb25nSmFlIFBhcmsgKDMpOg0KPiAgICB4ZW4tYmxrYmFjazogQWR2ZXJ0
aXNlIGZlYXR1cmUtcGVyc2lzdGVudCBhcyB1c2VyIHJlcXVlc3RlZA0KPiAgICB4ZW4tYmxr
ZnJvbnQ6IEFkdmVydGlzZSBmZWF0dXJlLXBlcnNpc3RlbnQgYXMgdXNlciByZXF1ZXN0ZWQN
Cj4gICAgeGVuLWJsa2Zyb250OiBDYWNoZSBmZWF0dXJlX3BlcnNpc3RlbnQgdmFsdWUgYmVm
b3JlIGFkdmVydGlzZW1lbnQNCj4gDQo+ICAgZHJpdmVycy9ibG9jay94ZW4tYmxrYmFjay9j
b21tb24uaCB8ICAzICsrKw0KPiAgIGRyaXZlcnMvYmxvY2sveGVuLWJsa2JhY2sveGVuYnVz
LmMgfCAgNiArKysrLS0NCj4gICBkcml2ZXJzL2Jsb2NrL3hlbi1ibGtmcm9udC5jICAgICAg
IHwgMjAgKysrKysrKysrKysrLS0tLS0tLS0NCj4gICAzIGZpbGVzIGNoYW5nZWQsIDE5IGlu
c2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQ0KPiANCg0KRm9yIHRoZSB3aG9sZSBzZXJp
ZXM6DQoNClJldmlld2VkLWJ5OiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+DQoN
Cg0KSnVlcmdlbg0K
--------------XOd2EQ3pU0OaWz2JuWcdTqkZ
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------XOd2EQ3pU0OaWz2JuWcdTqkZ--

--------------zXbVxqxcXeKv8xitDfEShKed--

--------------CAINiOsjmi0msmQ0OUfeF4Kz
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmMQzd0FAwAAAAAACgkQsN6d1ii/Ey/f
Hgf+NtistZlmf1qGYX/+wGy2DO972jLlom8DItCYrJ+2iaNffsH4Lyuz6uBRm45XwVYS8JCoBfY9
isDdLyxiq/mB82HCTI4rSznw/RXD93qZxpB9Ly48kitFArGhskGnm1zx28pRMtT9Uc9sd/bcfQQ9
koN0M3Ak9y0d3J8suqObS0grcqCdye3SRXnJ3iw/y1bDVxEb3ree/KrfcVy44Em5nvteM44igCsy
BQQxRSDmJwbMiAVIc1e1Gf5LfZuNjnKI+pQBzo7GOBmHfbTbRx9Xi8ZXvbb1YQ5v3rxU2OmJYekA
wGrmsH//uLsCMpPyZcKeeVdCLCyB4NSUZ+we+vPVgA==
=+pQd
-----END PGP SIGNATURE-----

--------------CAINiOsjmi0msmQ0OUfeF4Kz--
