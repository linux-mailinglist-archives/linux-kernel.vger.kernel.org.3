Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6574E4C459D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240726AbiBYNNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:13:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241024AbiBYNMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:12:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB016181E55
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:12:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55D5961C54
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 13:12:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5131EC340F1;
        Fri, 25 Feb 2022 13:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645794742;
        bh=Xwz9kLVHyWZsdxcrnoF/sDH7jLbV2c8FkOg5piNNcDw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CTFtdiB9m3XjyyYr8JjVYHKb9pQ3sUnnAR1ggZoDV1hOgCnkZ85bbVT4OWVWvSVQy
         QqF8NxW16fMzL1vjsS7LF1elOCvJv9ax/XoBcre5bpmQlXQR7yxdczCTR5Ie5RxiNR
         9VwuFLUg2xgTKPGoS436tRrTTbuB+99BQ32k1w8dBQqoc22Vc/VzV+KgEV5ePE4pKq
         7v4yFGDmIE82udHcoP4QEIZr87D89BpDnDeak1+Z08Qrp9+0doivOcwfNcHjsUrx51
         Y57zCzUSAeeVGeJr86A6fpC4wc2cORjP8tpjnov680IfsJkSQZ2k1fCimue8Z0vNer
         JCPHgaZxY4ioQ==
Date:   Fri, 25 Feb 2022 13:12:18 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Meng Tang <tangmeng@uniontech.com>
Cc:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sound/soc/amd: Use platform_get_irq_byname() to get the
 interrupt
Message-ID: <YhjVssdVIP49T6uj@sirena.org.uk>
References: <20220225112358.19403-1-tangmeng@uniontech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ni88dYQ52S44UoyN"
Content-Disposition: inline
In-Reply-To: <20220225112358.19403-1-tangmeng@uniontech.com>
X-Cookie: I smell a wumpus.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Ni88dYQ52S44UoyN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 25, 2022 at 07:23:58PM +0800, Meng Tang wrote:
> platform_get_resource_byname(pdev, IORESOURCE_IRQ, ..) relies on static
> allocation of IRQ resources in DT core code, this causes an issue
> when using hierarchical interrupt domains using "interrupts" property
> in the node as this bypasses the hierarchical setup and messes up the
> irq chaining.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--Ni88dYQ52S44UoyN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIY1bEACgkQJNaLcl1U
h9CMsgf9HCDinfY/9LwPrkDH7m1gZJCWHoophXU3Zw9m91QZ/bwR9Bet0Rnm2mQy
8KCTy5XiW+h0GZ7SyHoHCoFMiKbWOupxRlOb7beVOP13RzlaP9r0DrpgCfva3grA
F05FNqMTHslXk1K9iBWZ0B82flpp5XvxWfeQ7K8ZclNrZ/l5qf22/gLOLN5zE+qG
rFT41o3+q4n5KD+4hwv4fcRh1/y73rkIDy+YY4enI4yU59voiPQ5B+jMxMU/beo7
jfB4t7sAgys3W+LSvd9nCDuC9K8U2vsS286shhMUvkCtyzduyVeSMkCb+Ah+Ocia
8SwFT8rD1dHuhvNDZrb3L2qNoIc8+g==
=XUgy
-----END PGP SIGNATURE-----

--Ni88dYQ52S44UoyN--
