Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D40158C947
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 15:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243037AbiHHNTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 09:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243259AbiHHNTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 09:19:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08E5617C;
        Mon,  8 Aug 2022 06:19:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CF6E61214;
        Mon,  8 Aug 2022 13:19:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F938C433C1;
        Mon,  8 Aug 2022 13:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659964779;
        bh=eQQG3w7iWYBgQ9L9vR2hhgfaLi4C3wIC0N0XBZUD6UE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UftdXnG9yQF3+pvKzjJvBCeqiOXZSUFohihYVej2PXb3/xiFG3Z6cOmvOK4ckeDvE
         563QMLfc3HafHPMX6Rno/xPd7LFtf5DbGLqA+K8jsQipl7wsG0dXhGuGnSVGSr9Le0
         b1PeFCLNF0ChWt1MwA1WHL4DcOCvCTCSF8AN2cxQSNQx2NDLvjKrmFX40alsHxoCHs
         1vEKg/BKpo5y0cuWg+XtcetqGKvE4nVL7aB/12CRPAziXMko1tMNyCB+AhjQjxeoKk
         xsj8jrt1ZX6Ga1Sikf5jLlnLiZJpc5RmxaMfrbjLHVfeeviQJRsh3aYkdqv0kisOHx
         r31tSLiitOv2A==
Date:   Mon, 8 Aug 2022 14:19:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Harsha Priya <harshapriya.n@intel.com>,
        "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Sriram Periyasamy <sriramx.periyasamy@intel.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH] ASoC: Intel: kbl_rt5663_max98927: Simplify clk_get()
 usage
Message-ID: <YvENZULMLWkeaCzO@sirena.org.uk>
References: <55e59c4792d64ff6336fcaa85ec15590553e9d63.1659903516.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h+2uZ44m+eEzN7zj"
Content-Disposition: inline
In-Reply-To: <55e59c4792d64ff6336fcaa85ec15590553e9d63.1659903516.git.christophe.jaillet@wanadoo.fr>
X-Cookie: Flee at once, all is discovered.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--h+2uZ44m+eEzN7zj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 07, 2022 at 10:18:54PM +0200, Christophe JAILLET wrote:

> Not sure the Fixes tag is needed. The patch does not fix anything.

You just answered your own question there...

--h+2uZ44m+eEzN7zj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLxDWQACgkQJNaLcl1U
h9AHtgf+NLieJb/NpzO1CTPoNd4n2HBmtAu3jtpeGHaJIGGbQtSKBrjJpibSPV5e
4rDQjw2jC0NDP6aF66TIko2uT/53ELZXRszH/9+GTRkbgubnMPOymgnEJm7hulDY
PFgqQLdYkEhiOvUpwFL1J6QrXntpP5hB6DTKr83J95QdgkAaXp1uAshxLZ/2vbh3
2S9ruT+ROnnmLqkvlxdLEtOP9rYVLLoquDY+zTzWNhWhPC0jYcQNsgHsuHI9pKUm
xJdE0s9zbEtuaeaPnxlGhwmXPI1Z5kCG9l44YVd/+6BhaUitCqzXe0Dp7Qe5ZFR0
8W7LTCLphAQMB1vM65di6lrGZNOCTA==
=1XmB
-----END PGP SIGNATURE-----

--h+2uZ44m+eEzN7zj--
