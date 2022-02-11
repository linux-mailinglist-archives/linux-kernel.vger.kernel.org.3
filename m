Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8AD4B250D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 12:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349784AbiBKL6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 06:58:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234144AbiBKL6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 06:58:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E109EAE
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 03:58:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9D55619D7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 11:58:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B7CAC340E9;
        Fri, 11 Feb 2022 11:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644580724;
        bh=pgz5WoyfElnAyzBIovA0IXn76dZ8q1uHsh96lNL+XAI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V5oUialuPGmZ70jHjuFpzC/zncDrcjgmjV/chXHS1MOpvH46ZCdBB6gPoeOwyuDs5
         S0FH6N6snATeM/uDQ0tOrdbfcbKTZ1zU2Af6fzcN+ZaUq7jdZgk7DlKlcw5n0FfDbN
         T9TRnHyjoi4SV/Q+VBCw/EJZP+LIz1M9WjOeTqy6LSm7WECz0Pd2t1S7pqGrxxYTYw
         QFnRyReKldltujYEXPImbvKFMiRzLk9AA6OGOlHau0W9dSk2C/ylZI0gbRxXvZpZba
         05rjN2QwlljnC++eiK/8VAFO4Hr7bAP/qnsXblASkVmiu258weJTz/VoudFkHcZaIn
         yoMCanTuXa1nQ==
Date:   Fri, 11 Feb 2022 11:58:39 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Luiz Sampaio <sampaio.ime@gmail.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH 31/31] sound: soc: sof: changing LED_* from enum
 led_brightness to actual value
Message-ID: <YgZPb39aPMm64gSL@sirena.org.uk>
References: <20220121165436.30956-1-sampaio.ime@gmail.com>
 <20220121165436.30956-32-sampaio.ime@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="plmduE3cU0Ei6ORP"
Content-Disposition: inline
In-Reply-To: <20220121165436.30956-32-sampaio.ime@gmail.com>
X-Cookie: do {
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--plmduE3cU0Ei6ORP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 21, 2022 at 01:54:36PM -0300, Luiz Sampaio wrote:
> The enum led_brightness, which contains the declaration of LED_OFF,
> LED_ON, LED_HALF and LED_FULL is obsolete, as the led class now supports
> max_brightness.
> ---

You've not provided a Signed-off-by for this so I can't do anything with
it, please see Documentation/process/submitting-patches.rst for details
on what this is and why it's important.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--plmduE3cU0Ei6ORP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIGT24ACgkQJNaLcl1U
h9Dligf+M7qs1xkty0Kg+UH9bpC0lH91jFsVPaoq+vPltqshE0VI0JvJryAUdaA3
040Qmc5PWko17MNBzyf+9ME5bDy+gQzhgiREmqPnNnQQYg6p4/ib9VtPQ01U+juB
5cSXcNp5YHv/1Ewum9vvSGUDgLnHeTqp8NDF0CyosRL88EvPEcA93jrFh+KzzB7y
mrSNhEpXNcFaCHpUgN/PjjEpOzgRuwwEihTa5IFoeAoiLqkT0rZUvi3pW3ieyUpN
0oIMw5VKrUN/q+Ub5yXgZc6qdCtyy9VlHPsk/2jPfw/EwBOb39u1A5JVCmeqP+DL
/LwIe7ZulmRGqnE02dtCKbujcehWdA==
=nfQH
-----END PGP SIGNATURE-----

--plmduE3cU0Ei6ORP--
