Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D382D59616D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 19:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236099AbiHPRs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 13:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234406AbiHPRsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 13:48:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713977F133
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 10:48:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2B65611C5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 17:48:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33637C433D6;
        Tue, 16 Aug 2022 17:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660672115;
        bh=C1YHGG0YthjMsSCOVUr69nW/0HuxBkeuELLm36VaKp8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CG5FO7Ro7muFsASvnQgq8oAf3p64sAFGzrIXKyZWgrXwS6GNIu9NV+J9iv7av2Haa
         z8tITTyxL2DBgmcQWjE7YO4rA2Eg6Axnxvgt56JME1OANLCTZb6rn/MBWQARvVN9hB
         j7P2GASTFNlV9c3+YOtWrUjXU1yqPRewC0cYMzJzWikwY6rEw8Df26suIoJii2vmqV
         6Ytt4APrZXiT4LjGRe3dAhFPxq0DfjfG+6I0kI4IEtVmfQUIoc3jBCxiY/4gZouAe2
         YQ6alo8OXxMqNlMdB4fz84VCtSJ7I6uQXpGqeaq3lZ77NWenbwWFrZUz8tiACxP+2p
         NE4WH1ex/10Cw==
Date:   Tue, 16 Aug 2022 18:48:30 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Kevin Lu <luminlong@139.com>
Cc:     linux-kernel@vger.kernel.org, shenghao-ding@ti.com, kevin-lu@ti.com
Subject: Re: [PATCH v1 1/1] sound: Add a new kcontrol
Message-ID: <YvvYbkDSodLBkD0R@sirena.org.uk>
References: <20220815112715.21617-1-luminlong@139.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XfXYlpbAJLpIqcAb"
Content-Disposition: inline
In-Reply-To: <20220815112715.21617-1-luminlong@139.com>
X-Cookie: A bachelor is an unaltared male.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XfXYlpbAJLpIqcAb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 15, 2022 at 07:27:15PM +0800, Kevin Lu wrote:
> Add a new kcontrol for phase calib

This looks mostly good now - one small issue below which I'll fix up
myself and apply.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

> +	ADCX140_PHASE_CALIB_SWITCH("Adcx140 Phase Calib Switch"),

We wouldn't normally put the CODEC name in the control name, it's not
really relevant to users and if some disambiguation is needed it's
usually better to do it in a board specific way (eg, describing the
output the CODEC is connected to) using the support ASoC has for adding
prefixes.  Better would be "Phase Callibration Switch".

--XfXYlpbAJLpIqcAb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmL72G4ACgkQJNaLcl1U
h9Ca0wf/XQssZO8ZQOX6JyoFp4Z1CVs4uZOwqeWylT4J6B8nCgcGCjl9ct5BVMhN
I3KTKUtW0utYNhtaT1VcQ5l/ufMxXWoG9xv4KWa081bBM8qY7VGfMAV6McK2Z93f
aY9CxZnr+3WURXKVO1kpi+ZKKffNup4hPNgSJ+a9+UOjAioGrjT7Zqs7Z0U40/XF
3AYkbqXVIBTbMP7sDOoFu0dOqrNix5e/KLIrkkUDRZBrkWjwcp0jo05J9jFc7PdV
RXFfJ3Af1EfSEHS719e0LUHolccdtzZqH6SXIgVee6YoY229oaQO06cl5Xi6ugAA
Ns+nepN6aFUBkzXDsFA8kIRBFgi/hw==
=EuU3
-----END PGP SIGNATURE-----

--XfXYlpbAJLpIqcAb--
