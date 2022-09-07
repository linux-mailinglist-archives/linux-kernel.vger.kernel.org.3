Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD9D5B02DA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 13:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiIGL0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 07:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiIGL0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 07:26:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FFCB276E
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 04:26:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42C9C61877
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 11:26:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9CC3C433D7;
        Wed,  7 Sep 2022 11:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662549993;
        bh=ciKLrkYNMWLS2k+Fc43SiKpXyXILR6c+3eE5MBG7T3A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LPlQbUpJ0/GfVJ79v+DQw7K+hLnoTy6P3P/Eigcwov/vXUqdo+tDEmqOzIN9xpDKO
         pEPDX2/TJBgk0mdc+oLiMaShk9PsbyZrochyu/SWH8d31fKGpRuRaE29JayEEymV0E
         wfsgdVdN+Vl7nVdGac+0JQ+mvPHnqaHQLiJF+762jBE6LLVAZnZT4GxIGAlkSGo1Mk
         SIcHgX4HfZpsmQnBmMrhBv3SqaH5tOkByrDhNszmdjJKex7sSq1YKhDBmZpNOfkM1O
         PuugOHSJpQPDlVP4OQV195vamUDYIUZ811km2Ga53mXj14L32BfHvgmvqRv/4AMu5c
         boGUWYW12sTmQ==
Date:   Wed, 7 Sep 2022 12:26:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     vkoul@kernel.org, yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
        peter.ujfalusi@linux.intel.com, ranjani.sridharan@linux.intel.com,
        kai.vehmanen@linux.intel.com, daniel.baluta@nxp.com,
        sanyog.r.kale@intel.com, alsa-devel@alsa-project.org,
        sound-open-firmware@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH 3/7] ASoC: SOF: Intel: Don't disable Soundwire interrupt
 before the bus has shut down
Message-ID: <Yxh/4xQIvitrldRW@sirena.org.uk>
References: <20220907101402.4685-1-rf@opensource.cirrus.com>
 <20220907101402.4685-4-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y4vOpZSr9wJlnE+n"
Content-Disposition: inline
In-Reply-To: <20220907101402.4685-4-rf@opensource.cirrus.com>
X-Cookie: You have a truly strong individuality.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y4vOpZSr9wJlnE+n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 07, 2022 at 11:13:58AM +0100, Richard Fitzgerald wrote:
> Until the Soundwire child drivers have been removed and the bus driver has
> shut down any of them can still be actively doing something. And any of
> them may need bus transactions to shut down their hardware. So the
> Soundwire interrupt must not be disabled until the point that nothing can
> be using it.

Acked-by: Mark Brown <broonie@kernel.org>

--y4vOpZSr9wJlnE+n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMYf+IACgkQJNaLcl1U
h9C1lQf/QQ7834+HysNjSeJWB8OQqFmAuvTcRvjskQ7KiMtML52BD0aYaHgAJVNA
+sPph3cYAkcu4h8OM5G4OZ1nDVHcJ9bIDQO0ybGx4V6B4IfTqm2HcBZI5XjuvAy/
xcRiOoCR9QoWHe83pNTQMH3j0/sC6WNlE38KMokQS1MFJmx3ld0XdjmOpKhF04TM
A9tVkWAzzJjFaK9aWY+aJRJkD4xyVJBHq9n/EtgMW4MeppzzBch7tCJrQHh1XG9i
3kmXQRrQ7S80q9m8zI3UlfvVfTflUPK/h6o+szJTBmyeZLDG4GkPKQyWWm+EwAjY
9UzaLD8yNp8o9DCGxb6SzOFsfMDzTA==
=GacH
-----END PGP SIGNATURE-----

--y4vOpZSr9wJlnE+n--
