Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34014F79D4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 10:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243080AbiDGId3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 04:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243045AbiDGIdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 04:33:25 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6511728B6;
        Thu,  7 Apr 2022 01:31:23 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KYvjY6Rg9z4xZ3;
        Thu,  7 Apr 2022 18:31:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1649320279;
        bh=sG3iKOR7eX1exkY5m5McEH06+OHvCNrCCmrkW2t6mPw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Tb6aWuQnBAXP6tq8BkXFqkJ9qXQ7j+Ssg31lMCAA3ftBlIlAfTA4TlFldTXWjJhj6
         UiGPVJxV44LH3mYCfXlb9U7LmX35v9CXzzTK/VHPEgu6Q+HiZmkLo71wAv1z6kKByR
         lwo5svIrEXZX/6v6J94Lix58+6g2sIbQOheKlI7OwKTSoOx57H8wcVrx/5nPf9vY0x
         cGOsbRqFmeWeNMeL5U+47uKhAdFImXVQn7FGHeMwNVN/aT9uqcNRwr3F8176aJpGVY
         LaHvSQJjXveD6JVjgLYF6iiFtWdeOrrLJHQAFzDLx+Op/LIx/Xn0+NnLkZga29q5Gs
         TLp1u7PGIAHiw==
Date:   Thu, 7 Apr 2022 18:31:12 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Linux-MM <linux-mm@kvack.org>, Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Barry Song <21cnbao@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Page Reclaim v2 <page-reclaim@google.com>,
        "the arch/x86 maintainers" <x86@kernel.org>
Subject: Re: [PATCH v10 00/14] Multi-Gen LRU Framework
Message-ID: <20220407183112.2cb5b627@canb.auug.org.au>
In-Reply-To: <CAOUHufZ8x5B-e+Wwgrh+qWryf8dAbfMWVEE0s-AfwZ-H7DouQg@mail.gmail.com>
References: <20220407031525.2368067-1-yuzhao@google.com>
        <CAOUHufZ8x5B-e+Wwgrh+qWryf8dAbfMWVEE0s-AfwZ-H7DouQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/vv2ccmDjANVQ_zxEAVutc2L";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/vv2ccmDjANVQ_zxEAVutc2L
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Yu,

On Wed, 6 Apr 2022 21:24:27 -0600 Yu Zhao <yuzhao@google.com> wrote:
>
> Can you please include this patchset in linux-next? Git repo for you to f=
etch:
>=20
> https://linux-mm.googlesource.com/mglru for-linux-next

I get a message saying "This repository is empty. Push to it to show
branches and history." :-(

> My goal is to get additional test coverage before I send a pull
> request for 5.19 to Linus.

Good idea :-)

> I've explored all avenues, but ultimately I've failed to rally
> substantial support from the MM stakeholders [1]. There are no pending
> technical issues against this patchset [2]. What is more concerning
> are the fundamental disagreements on priorities, methodologies, etc.
> that are not specific to this patchset and have been hindering our
> progress as a collective. (Cheers to the mutual dissatisfaction.)

I have not been following the discussion as I am not an mm person, but
this is not a good sign.

> While we plan to discuss those issues during the LSFMM next month, it
> doesn't seem reasonable to leave this patchset hanging in the air,
> since it has reached its maturity a while ago and there are strong
> demands from downstream kernels as well as a large user base. Thus I
> sent that pull request to Linus a couple of weeks ago, implying that
> he would have to make the final decision soon.
>=20
> I hope this gives enough background about what's been going on with
> this patchset. If you decide to take it and it causes you any
> troubles, please feel free to yell at me.
>=20
> Thanks!
>=20
> [1] https://lore.kernel.org/r/20220104202227.2903605-1-yuzhao@google.com/
> [2] https://lore.kernel.org/r/20220326010003.3155137-1-yuzhao@google.com/

I had a look at those threads and I guess things are better that your
comment above implies.

So, a couple of questions:

Have you done a trial merge with a current linux-next tree to see what
sort of mess/pain we may already be in?

Is it all stable enough now that it could be sent as a patch series for
Andrew to include in mmotm (with perhaps just smallish followup patches)?

--=20
Cheers,
Stephen Rothwell

--Sig_/vv2ccmDjANVQ_zxEAVutc2L
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJOoVEACgkQAVBC80lX
0GzE3Qf5AQTCVeynkAsn3+qk9evNVsNw+dWxlovauW3+RjhUcon2308Q6aN7oSPw
fex528YIkIZ5WBjpCvTqt2qy/wsUfN01Terj/MrmC1NVIWSVdQxQo1xydTpbwRym
aKXyxU4rcp1o17/P65KZsISf0KXPXFKnLdPAKs5wEbgD6at5eohehdsGYCWk9hnX
1f/rEP51PEmxl9AE91SbpTvw3Mj5uKz282I3mUJiqQaIDPcNbPv6qM9RLKRYa9Kn
IOdqR6+UvqVE0BLoi0Q3ikCuC7RI3wSuAsDlKhLL7QtlbRDjKbAT/qTxo408JScg
pPI07lXejPErRWE6+HSo4yLiLW9+iQ==
=mvXT
-----END PGP SIGNATURE-----

--Sig_/vv2ccmDjANVQ_zxEAVutc2L--
