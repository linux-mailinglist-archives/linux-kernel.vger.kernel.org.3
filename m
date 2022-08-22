Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32CD959C3D3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 18:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235914AbiHVQO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 12:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235004AbiHVQOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 12:14:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2C32C10B
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 09:14:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC1DF611D7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 16:14:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5D95C433C1;
        Mon, 22 Aug 2022 16:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661184862;
        bh=VfxwmQyY1k2NzPt+1UZYvEgGjJI2gAhCSwC0aBuS5l0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e1NwVfeJ9Ad/qSBNDH68vNs1WvlmFEYBCjEdHHePKRbkFqng4aiLqjPoiRXO0Wx1e
         IA5FZYoULIcx3QO5frlh9X197PP8TtK++mizaMp+FfrnqNoNzITLLz1oS0TDp9+JA6
         0yRVMQSS7zG9T6Teuc8ubsI/mGd/GKIXFPcLULQKsKhpDn1QGJSUaGcBOJL3v9EQbM
         FMlCJI7iqDMCi0X9vLxRSeA8R14dwZ4+DDiWIIYEvH2t0cLSLw90ESOTdgu58oExJL
         5WMcHbb2KLtCP/Z8sdP1n0FBT9z01iJmqeoMKSSr8JZlGwsI7z1UrZRRtuTFaQLuD3
         yBdeuNX22JvGQ==
Date:   Mon, 22 Aug 2022 17:14:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>,
        alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: dapm: Export new 'graph.dot' file in debugfs
Message-ID: <YwOrWf3+9c3o5FPO@sirena.org.uk>
References: <20220822095242.3779-1-povik+lin@cutebit.org>
 <YwN2Pd4Ez08yDFno@sirena.org.uk>
 <3234D74E-0DFF-4BB5-87ED-6135BAC1F31D@cutebit.org>
 <19b60ea9-6bee-1cc9-5384-89231fce3a99@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/lY9LArAiCvVh4P1"
Content-Disposition: inline
In-Reply-To: <19b60ea9-6bee-1cc9-5384-89231fce3a99@linux.intel.com>
X-Cookie: Do not write in this space.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/lY9LArAiCvVh4P1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 22, 2022 at 03:06:03PM +0200, Pierre-Louis Bossart wrote:

> The Chrome folks used an 'asoc_dapm_graph' python script since 2014
> according to the copyright information. IIRC it was python2 so might
> need a bit of work.

> https://chromium.googlesource.com/chromiumos/third_party/adhd/+/refs/heads/master/scripts/asoc_dapm_graph

That's a different tool but also interesting - doesn't look like it's
too advanced Python wise so should be fairly easy to update for any
Python 3 incompatibilities.

--/lY9LArAiCvVh4P1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMDq1kACgkQJNaLcl1U
h9CgJQf/T/noyjLy9gGJUSy87tOqoWe7zUNpA0QTr56GbMNO9ICucL8cwYYuoqkL
JH7Fi++XqbeFFCSsfC13R4cwaJgYCRAshf2Za/IsSn9TTT8InHl6n4OHXo2hV/4E
4VB7dDPi5pfG2qZXLcJmDMKXekSmUAwPhso0+F/1Yvo6sruKwtYb6DPthKKpadJF
tXWrYhxxt7/LmDL62PBqUEUV9y7rWj7Hc6tI2Rtba4HGlra+jdQNbMOZDo+3ipkL
FY8A6RqLDI7J02C8OUEkO77u8jYs3mBlmfiPzZE9EcXhqXlYiWpS7EvPXhL4i0DT
/L/N6X2H/jfMtn3ywl7/oGFBAjRNfQ==
=0/Pw
-----END PGP SIGNATURE-----

--/lY9LArAiCvVh4P1--
