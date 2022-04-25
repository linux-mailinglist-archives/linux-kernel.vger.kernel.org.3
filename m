Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F51850E055
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 14:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241842AbiDYMeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 08:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239099AbiDYMeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 08:34:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8040E689A9;
        Mon, 25 Apr 2022 05:31:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DEB861387;
        Mon, 25 Apr 2022 12:31:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B728C385A7;
        Mon, 25 Apr 2022 12:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650889861;
        bh=N0EPdIugLassIihiD8xp49ZT5dPSUmJIgdJqAlE+nSE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z/yuTpraSYCgI0XxlJDCsizFMfmjirMAtKX4Y1wt7s9LdG4YGyGgc84912JNJ8JjN
         T4vNJwTVGfWLG1aPhxej5T8tjcPU+wGTPRO90URvR4LCJCQDKi+dOxDSNRUmTCVtrK
         Y+vieWmMQPB1oe9xczsqo0kQ7KWJv+LRM6Ks/3Wm0OCeCJKFuXBoVnU+mvwMESXPio
         36iSjDG1FYJlLE7c+wNeN0R3TJ5uUrWD8Rj0q8oLPBLV2zhRq1ggKHHtlB1ER1ApUp
         jufUFMZsfFplUoevdVHPeluIdm6iuFsSIOpyVZC3CqCtzmuJArkGz+P8KwqVMa1rhc
         Ep3wwEYs/48Ag==
Date:   Mon, 25 Apr 2022 13:30:54 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Ryan Lee <ryan.lee.analog@gmail.com>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org, krzk+dt@kernel.org,
        perex@perex.cz, tiwai@suse.com, srinivas.kandagatla@linaro.org,
        ckeepax@opensource.cirrus.com, tanureal@opensource.cirrus.com,
        cy_huang@richtek.com, pierre-louis.bossart@linux.intel.com,
        drhodes@opensource.cirrus.com, pbrobinson@gmail.com,
        hdegoede@redhat.com, lukas.bulwahn@gmail.com, stephan@gerhold.net,
        arnd@arndb.de, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ryans.lee@analog.com, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH V3 2/2] ASoC: max98396: add amplifier driver
Message-ID: <YmaUfkvy7YKCSLST@sirena.org.uk>
References: <20220423021558.1773598-1-ryan.lee.analog@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2viRuOuJVnHOO/9B"
Content-Disposition: inline
In-Reply-To: <20220423021558.1773598-1-ryan.lee.analog@gmail.com>
X-Cookie: An apple a day makes 365 apples a year.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2viRuOuJVnHOO/9B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 22, 2022 at 07:15:58PM -0700, Ryan Lee wrote:
> This series of patches adds support for Analog Devices MAX98396
> mono amplifier with IV sense. The device provides a PCM interface
> for audio data and a standard I2C interface for control data
> communication. This driver also supports MAX98397 which is
> a variant of MAX98396 with wide input supply range.

I'm missing patch 1 with the DT bindings?

--2viRuOuJVnHOO/9B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJmlH0ACgkQJNaLcl1U
h9Au7wf+LPH2wys4lkiylSgsOXYqnmceMt/19R5Cc7v3Z19l8s2kwrklNBSav+U9
ckbIb9YbZ37YFCy74pHh2xZvWkxVXDIVsqoOIP2cLN04FKahUI7ENAwpjlfDSYZ5
cTkHjfQYhD7s1viNKzbsVrH/G0rXHmBXmS8Pzimf5ycTngeel0RJ1mZY6ydMSjwR
hpEzx5ZUGUnnQ1ukNtwdFcCmnh3eAXgKmhq+fLy1MYkDuiCKvNGGHK5a5pEVEvSa
1g7CFjB8Sxb+WXYXa2d2hjLmfLlb1taU9p64va0uS4ritLofg+vNnwJCV5nZWx/5
JOcQi7nrDP94gooyMGwjc5iVP6byqw==
=R52l
-----END PGP SIGNATURE-----

--2viRuOuJVnHOO/9B--
