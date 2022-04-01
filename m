Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D694EF812
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 18:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349367AbiDAQjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 12:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350581AbiDAQiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 12:38:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8626C1AA056;
        Fri,  1 Apr 2022 09:16:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39351B82370;
        Fri,  1 Apr 2022 16:16:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98425C2BBE4;
        Fri,  1 Apr 2022 16:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648829796;
        bh=QX63Fn0eIgqEzcIIs1tirFb9cVGOSCZjLncptockG0w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q1nDlwiu9xUgQzfzc44B/c9aOelMsTe1UrKgUfsMg10qRetGAJe8yFX3jCleyVyYw
         lBsIU54sESdNSkDqo0w2Lj5vOz6rIaqNcpHTEI+AWykxLqXyDM5PxabEOB0wKvAepF
         eLHEzYZpDti2+zHcOFhCPAhFU51w5QLf8w/Hy0wFK2KL+QgeV+OkCYw1YuQbqSm0TX
         tZxvF5xADvH40388zZ7kuvP2Uhl1v2dmHgi28KUYdf2wxU2kSRqFQvlJ3Xp7kQ5wIx
         w+9MxzNbxsJZCXI0MjVyMq5Z1PyKzUd2UbcLY+c0JWrny+ZxC4bqoe4oM9aPdfi3OL
         N3+543RJ/ds4w==
Date:   Fri, 1 Apr 2022 17:16:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] modpost: restore the warning message for missing symbol
 versions
Message-ID: <YkclXzHamGiOJJGz@sirena.org.uk>
References: <20220401155610.1280262-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ERM5Vcs9RzIVdQ6X"
Content-Disposition: inline
In-Reply-To: <20220401155610.1280262-1-masahiroy@kernel.org>
X-Cookie: Universe, n.:
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ERM5Vcs9RzIVdQ6X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Apr 02, 2022 at 12:56:10AM +0900, Masahiro Yamada wrote:
> This log message was accidentally chopped off.

Acked-by: Mark Brown <broonie@kernel.org>

--ERM5Vcs9RzIVdQ6X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJHJV8ACgkQJNaLcl1U
h9BPZgf/Sfv3McX+bh3xSWnkxUleIIraRJQKSsPAS01PUQQ//vHzAJX+OBvTYA3S
w1u4K6JSQaVyoDSxLUVrT4fVbxrRNESImFDhDl7cFoFtkHAhS1UC010i4UR+g50r
KOIT5Jqyb7QghVkMo6Ak+bLWfeBf+o49JVz/5l2m6ek6er/QPrKO3/rcSN9dExgS
PzaAe2y0bkLIxQ04UCudAtF8agSvW4mLQU098KR3zviDAMKRMoAgbEfePS8JgWxE
RB0wWLaeuBEBSI22a255kd8Z4l4agADtv2QudSH0/mipUySVm/OgOtqxY6GHhRFP
pgVuBaU+AuIWUmUVU8yKHeagfF6LnA==
=tYvk
-----END PGP SIGNATURE-----

--ERM5Vcs9RzIVdQ6X--
