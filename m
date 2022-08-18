Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCC7598A24
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 19:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345003AbiHRRUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 13:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344440AbiHRRT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 13:19:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C79A181;
        Thu, 18 Aug 2022 10:18:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2BC3BB82305;
        Thu, 18 Aug 2022 17:18:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89CB3C433C1;
        Thu, 18 Aug 2022 17:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660843083;
        bh=Fvr29lWD5OIUEN35R23Bjt8QeBsONWcWpcpJpOcymIU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pRnCaxOFGvyUfTtD5W+19BBAQpvjB3MxSsGi48BpacNyVtfyKzpF4amNJBsB8ScIn
         OH8K9FTD2N4n1zCxqNG81VN1/DpfeGG56QSORAJrih1j69YF6ghLFspJ3nNOpj70wJ
         pV6057MGc86jiuR7U2fdz+md6d+yLFS4+qTZJB22U4CUZnu6pq7nsnBz3tOFJ2k88Y
         n7x9xsPHTeShbYJJ/EDf/ta7+APT2sUXDTb1Cr6OTOVxo+QfjmQK7g1vdsWTRwTA90
         sfg2l2pC1LxfpxSCobQS+n3hDqB8ozF/k5UWEHwH7ZcnS/3MIRnt/G9Kh0/E58OUsY
         tpeLzSwhhuBsA==
Date:   Thu, 18 Aug 2022 18:17:59 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        corbet@lwn.net, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] docs/arm64: elf_hwcaps: unify newlines in HWCAP lists
Message-ID: <Yv50RxlDf0qpK9v8@sirena.org.uk>
References: <49253b17-738d-795e-f539-55857fdaee64@suse.cz>
 <2bac83ef-d5a9-b8c4-0fb3-cef4272e7156@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JCZdgl1Eo0V8MWR1"
Content-Disposition: inline
In-Reply-To: <2bac83ef-d5a9-b8c4-0fb3-cef4272e7156@suse.cz>
X-Cookie: Logic is the chastity belt of the mind!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JCZdgl1Eo0V8MWR1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 15, 2022 at 03:37:58PM +0200, Martin Li=C5=A1ka wrote:
> In git revision 94bdaa7d9a9d778d893c670d494c06d8e007c1cd I unified
> vertical spaces in a list of features.

The normal way of describing commits in a human readable fashion is to
include their title as is done in Fixes: tags.

> Since the revision, another commits added new features that have a differ=
ent
> horizontal spacing.
> Fix these extra newlines.

This new format .rst is forcing does seem less than ideal for people
reading the actual file but oh well

Reviewed-by: Mark Brown <broonie@kernel.org>

--JCZdgl1Eo0V8MWR1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmL+dEYACgkQJNaLcl1U
h9ACcAf+Lg5+ZgAxlKsyQN51MJ8HJxveKjnMSstP0dARwR4ZNx3qcJOgAF0iyhbV
5rejBUUwdmHpSCP1JC756Eh3cW/z+cEIX4lKUZvKl5161Njpl+2xIGKHU7nEISnu
goBRBfFuUqBklZvZMr8uVELcvq4EXy/jv5lTxUsShuEuKEpZKYL9uiVplfnLE872
h/Q7T5ZgIUYsg+VhYcRoFlKKABJEKniSkyrWrc/Xku9tNlBoHCe1X9+ezD3g81qK
gue8lJHkLTZESos7enzxR7dq1sfm6rLAn4DKhIdbDCtjn+CJDwBrsJaMiKaIbaLm
VlNIn/14Ye3Xlpb6KviND/d4NDELWg==
=zsTW
-----END PGP SIGNATURE-----

--JCZdgl1Eo0V8MWR1--
