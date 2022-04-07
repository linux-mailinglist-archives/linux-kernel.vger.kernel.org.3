Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7AB4F7ECD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 14:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241480AbiDGMQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 08:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240282AbiDGMQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 08:16:06 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4121324BD51;
        Thu,  7 Apr 2022 05:14:06 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KZ0fW5j88z4xXx;
        Thu,  7 Apr 2022 22:13:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1649333641;
        bh=MSGiGfMrsCY+cwdbzhUi4BbKmNkxN9MYKn3xiEn0Dho=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rNSjlqWeCTSM+gVyuKWTJLS1BrOfrrI0EGcvnfnXZkN74NktFoHqOJfIqKNja+eyZ
         sPy1hmVF5qqGjYqaV4G3k9PbZv29p9cu2MxTTiuTZei1SL5KpSLBIuaztOrL84KXHC
         mvTxXg50c2ZbD+qBZa/Jq3FBa70g6Yqs+Ga6zoz/+LScssPrfkZ2IR8WNDJONqhjcZ
         e323Zu1SG4X/cUJLy77WVNxjBFE277h5TgJfnWU8Ez5ZEREj6Y8mOiBXYQs1+ShYY/
         FCPJcXSaQkPqr/WAIIE7hwaJrPnvaQstkFIRzLH8UoGycWs8Y5sSjnHSu1R8Eq4bin
         VqEZM92AXjCWw==
Date:   Thu, 7 Apr 2022 22:13:54 +1000
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
Message-ID: <20220407221354.5acc2711@canb.auug.org.au>
In-Reply-To: <CAOUHufbaPR3H2KcYywCf0ycFWh=2Nf1PwiO4t8tO6TXB9U1MwA@mail.gmail.com>
References: <20220407031525.2368067-1-yuzhao@google.com>
        <CAOUHufZ8x5B-e+Wwgrh+qWryf8dAbfMWVEE0s-AfwZ-H7DouQg@mail.gmail.com>
        <20220407183112.2cb5b627@canb.auug.org.au>
        <CAOUHufbaPR3H2KcYywCf0ycFWh=2Nf1PwiO4t8tO6TXB9U1MwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/6mpp.nsQNupxMrrWV5KylHR";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/6mpp.nsQNupxMrrWV5KylHR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 7 Apr 2022 03:41:15 -0600 Yu Zhao <yuzhao@google.com> wrote:
>
> > So, a couple of questions:
> >
> > Have you done a trial merge with a current linux-next tree to see what
> > sort of mess/pain we may already be in? =20
>=20
> Yes, the repo I prepared for you is based on the latest linux-next.
> There shouldn't be any conflicts.

Ah, that is a problem :-(  I can't merge a branch into linux-next if
that branch is based on linux-next itself.  linux-next rebases
everyday, so that merge would bring in the previous version of
linux-next - including other branches that may have rebased :-(

All the branches in linux-next need to be based on Linus' tree or some
tree that does not rebase (or one you can keep up with if it does
rebase).

The only exception is part of Andrew's patch series which is rebased
(by me) on top of linux-next each day.

> > Is it all stable enough now that it could be sent as a patch series for
> > Andrew to include in mmotm (with perhaps just smallish followup patches=
)? =20
>=20
> Yes, on multiple occasions, e.g., [1][2][3], I've claimed this
> patchset has an unprecedented test coverage and nobody has proven
> otherwise so far.
>=20
> Andrew suggested a cycle in linux-next [4]. So here we are :)

So the easiest thing for me is if Andrew takes it into his mmotm patch
series (most of which ends up in linux-next).  Otherwise I am probably
at some point going to need help fixing the conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/6mpp.nsQNupxMrrWV5KylHR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJO1YIACgkQAVBC80lX
0Gw6cwf+MTaNNd0mEgs/tJ4oSFU0X67FO4pXdyzCjCdp1UB54niZQdb3kMqfc02a
RRkhV0jDgdDYFiEsW3lsdb4qf+dOVx3CRFYz6u/gQ06xMe5CXo2BqvTd3gKmrYH0
uFSh0XaIdm2xW5WlQwg3gKgkgYlTNaqjt88X72GhV8HLPqgp58cl+APq/4UTz94+
5GEdaKM9Nyec6todaeP1Ih7WlL4Nj6KV+TQPq9/y3Kipfa0teIQMQQaHplOzfyXh
oUW58hcwYEaPuADo6SHMO0Ex6OtWE1PAe3OiYYMQ2dan3xU4hbQLtsUZGFJXdYR6
FpTRB/bJBWEeBekO3GsLLa8FrF1zLg==
=HCxM
-----END PGP SIGNATURE-----

--Sig_/6mpp.nsQNupxMrrWV5KylHR--
