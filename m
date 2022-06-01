Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90F6539FA7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 10:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350893AbiFAIim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 04:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350881AbiFAIik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 04:38:40 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9AF5BD05;
        Wed,  1 Jun 2022 01:38:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 59E0A21999;
        Wed,  1 Jun 2022 08:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654072717; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CjnjTUOt6Fu0aO1yNBhxHsZXxRqsep1ZqcFMKllrABY=;
        b=srDillpiMXFP0Ubv2nkG2vV4/2IZftPEVjdCTGkfCmpOxVRPvjYxj6+h90VmhOShs6/zhM
        dDljdZqggDTb+9C5tUFBKCsY0/CoplvHsSpxi7VEe0mwKORr6G9jsLD6O/0+7pfbS+aHA+
        q6IXBcgvBpw7ZLimnhYasXici3m41LA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 290801330F;
        Wed,  1 Jun 2022 08:38:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id R053CI0ll2L+VgAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 01 Jun 2022 08:38:37 +0000
Message-ID: <4ca4a04b-7064-3643-479a-ea31e584426d@suse.com>
Date:   Wed, 1 Jun 2022 10:38:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220601075613.28245-1-lukas.bulwahn@gmail.com>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH] MAINTAINERS: refurbish SWIOTLB SUBSYSTEM sections after
 refactoring
In-Reply-To: <20220601075613.28245-1-lukas.bulwahn@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------CNHvSQllro22hVMkKP0eQ6NP"
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------CNHvSQllro22hVMkKP0eQ6NP
Content-Type: multipart/mixed; boundary="------------pOzjEYk631dHLtJDTbkAOhdn";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>, Christoph Hellwig <hch@lst.de>,
 iommu@lists.linux-foundation.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <4ca4a04b-7064-3643-479a-ea31e584426d@suse.com>
Subject: Re: [PATCH] MAINTAINERS: refurbish SWIOTLB SUBSYSTEM sections after
 refactoring
References: <20220601075613.28245-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20220601075613.28245-1-lukas.bulwahn@gmail.com>

--------------pOzjEYk631dHLtJDTbkAOhdn
Content-Type: multipart/mixed; boundary="------------GFgIjmLAKHFy6G7eiTOibFfe"

--------------GFgIjmLAKHFy6G7eiTOibFfe
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDEuMDYuMjIgMDk6NTYsIEx1a2FzIEJ1bHdhaG4gd3JvdGU6DQo+IENvbW1pdCA3ODAx
M2VhYWRmNjkgKCJ4ODY6IHJlbW92ZSB0aGUgSU9NTVUgdGFibGUgaW5mcmFzdHJ1Y3R1cmUi
KQ0KPiByZWZhY3RvcmVkIHRoZSBnZW5lcmljIHN3aW90bGIvc3dpb3RsYi14ZW4gc2V0dXAg
aW50byBwY2ktZG1hLmMsIGJ1dA0KPiBtaXNzZXMgdG8gYWRqdXN0IE1BSU5UQUlORVJTLg0K
PiANCj4gSGVuY2UsIC4vc2NyaXB0cy9nZXRfbWFpbnRhaW5lci5wbCAtLXNlbGYtdGVzdD1w
YXR0ZXJucyBjb21wbGFpbnMgYWJvdXQNCj4gYnJva2VuIHJlZmVyZW5jZXMuDQo+IA0KPiBV
cGRhdGUgdGhlIFNXSU9UTEIgU1VCU1lTVEVNIHRvIGluY2x1ZGUgYXJjaC94ODYva2VybmVs
L3BjaS1kbWEuYywgd2hpY2gNCj4gY29udGFpbnMgdGhlIHN3aW90bGIgc2V0dXAgbm93IGFu
ZCBkcm9wIHRoZSBmaWxlIHBhdHRlcm4gdGhhdCBkb2VzIG5vdA0KPiBtYXRjaCBhbnkgZmls
ZXMuDQo+IA0KPiBGdXJ0aGVyLCB1cGRhdGUgdGhlIFhFTiBTV0lPVExCIFNVQlNZU1RFTSB0
byBpbmNsdWRlIGFsbCBzd2lvdGxiLXhlbg0KPiBoZWFkZXJzIGFuZCByZXBsYWNlIHRoZSBw
YXR0ZXJuIGluIGRyaXZlcnMgd2l0aCB0aGUgc3BlY2lmaWMgb25lIGZpbGUgdGhhdA0KPiBt
YXRjaGVzIHRoaXMgcGF0dGVybi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEx1a2FzIEJ1bHdh
aG4gPGx1a2FzLmJ1bHdhaG5AZ21haWwuY29tPg0KDQpBY2tlZC1ieTogSnVlcmdlbiBHcm9z
cyA8amdyb3NzQHN1c2UuY29tPg0KDQoNCkp1ZXJnZW4NCg==
--------------GFgIjmLAKHFy6G7eiTOibFfe
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------GFgIjmLAKHFy6G7eiTOibFfe--

--------------pOzjEYk631dHLtJDTbkAOhdn--

--------------CNHvSQllro22hVMkKP0eQ6NP
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmKXJYwFAwAAAAAACgkQsN6d1ii/Ey/q
1gf6AyHW6leFjmiqq9OZVGfnN3PfDur4Sj7DA6BZoC0l9Ds53a3bRxeWCn/LXrdf2HRdrucFAVVX
KjYyCfIZPEA9fFRWm9tFhTsPa1A8hpcisOoQGRYLDpJlDSOnZiLce+HzrlyFfOCG01Si/+2aGqb3
+ZZJ9YmrIQJTlJ+hJ+bOcDXIMYDOo+d06vg1qSuFG2Z+YiPOMuoKNHcKVllz6ovidFaoAqEU+0nx
vVEGBk/6Wiy2/eq3DaqTqFLaAoF8pOby7DRJ1OTJ7yNOvNx5izsFxo3RPHo+y8/Q7XO367ocFD/K
KxUn2S2yW8YNTUzwjJIMtvPfFIXD0AvOP3vD4ebtzA==
=uOd4
-----END PGP SIGNATURE-----

--------------CNHvSQllro22hVMkKP0eQ6NP--
