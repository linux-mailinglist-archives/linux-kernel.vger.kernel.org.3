Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61DBC586EA5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 18:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbiHAQgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 12:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233464AbiHAQfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 12:35:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02550167F2;
        Mon,  1 Aug 2022 09:35:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6154FB8159F;
        Mon,  1 Aug 2022 16:35:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21692C433C1;
        Mon,  1 Aug 2022 16:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659371730;
        bh=+9uWdUN3aEqishlRYqXr79VqH0vtUQGydGAmxDsqieM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o+hSE5oTSTebEMSnHoLm/czAw9w3Wow3zbLekoMiO87Hvz/Dhk9g9nXpvveiz/keN
         cJAV5EQ/oUpR+X16Ir67HWGrXN/JCN2GE7iJH2+TCLeCSNPU3bBERf1izfGuzQzy83
         X4P8LJmuixD1qcWi4hRLGloV/Sio5172AejqLc3H3EsmyWOpoPINd/NByUrSq8RpxK
         MTewv4S2f8AFrszVikBPDsTqV+D5hteLzPV4NYlnUR99J670d/BW3JpwAMjU25vtCY
         QIU7+gCaAYtdtTzqXeCMuuEnprc7VdgkI5QwluojFd6MkwfG4kGNyrxAv/IaFFy6yw
         bamb/djCEDE7A==
Date:   Mon, 1 Aug 2022 17:35:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Jul 28
Message-ID: <YugAzWWl++ArhhPS@sirena.org.uk>
References: <20220728210236.76654a0e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WcWY6Z8fGuyJ8yYY"
Content-Disposition: inline
In-Reply-To: <20220728210236.76654a0e@canb.auug.org.au>
X-Cookie: Dieters live life in the fasting lane.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WcWY6Z8fGuyJ8yYY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 28, 2022 at 09:02:36PM +1000, Stephen Rothwell wrote:

> News: the next linux-next release will be on Monday Aug 8th.

I didn't notice this last week, I'll try to provide coverage for the
remainder of this week, hopefully the merge window should help this go
smoothly but no guarantees.

--WcWY6Z8fGuyJ8yYY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLoAMwACgkQJNaLcl1U
h9B09wf+KB3lXmmgohbh6ev0q4b2v/lXDbHaTO2XVPENdmPfDIuZ/705++rVjwBd
N9t7hlQbYHCBeIjwIjx/GVt7gAVhd1B3YequO/quyWeCgPmwPYTlUsCqT1s+9084
z18V7l8sA26/mdw0xfssF/tSGi+ZSMq0s+k+HwrTYwORw8ELch3ZxIjEAt9QYg9o
7jn2pYxJ8KuL4SgP9mNEJzUROPjk2/EzEphANijJbOKj73h5X8527OHwQFD6q3MW
FQX7RCu/QK+VdgjajxEB2qdOBDg/iPD6G8s8WIam+9YiKRAMwxK+GzY1+JXaXH7P
vdxVTv2Npy6fLyvb0CuDMcDz55DbwQ==
=wiXN
-----END PGP SIGNATURE-----

--WcWY6Z8fGuyJ8yYY--
