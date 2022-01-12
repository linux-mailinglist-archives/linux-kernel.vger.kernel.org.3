Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2206948C5DC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 15:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347612AbiALOUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 09:20:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242224AbiALOUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 09:20:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFED4C06173F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 06:20:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58413615CE
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 14:20:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8FC0C36AEA;
        Wed, 12 Jan 2022 14:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641997239;
        bh=RRhmaQsH91uHTw71wtOmZx3VIMdk1PxtBkkRzyfrfzc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UYbz0uXPInouIEqplR6A9hPjOld8c0c8CYH/JiMN8KLMHaYRs4infv05/HmmzSBsy
         po1SBDs4Pxh/Tem2uVpLaqdB+XSMuN3j897nqD6TrJB0RVGkYFuUuwalRHGeUKQ0So
         bjJBmjTJmQ4STq2PAc3Fg4IvyphLvTiYNP2en6adwMnGieQjlaGHkNIxfEt46IOUhU
         9n6lbhkk0ogGDrF8e/9Q5pcJc5ZNd4Ko+iXCLcdK2ffHB/zVPIpBcTLHcaqLeK/YKW
         wtFkTJ58wtE+xizv7mbdfSsttoumIjIb1k31dsGm67fz5Fn9gcM+sz+7562dE8kwP6
         sUH/coXQjLCQQ==
Date:   Wed, 12 Jan 2022 14:20:34 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     cezary.rojewski@intel.com, srinivas.kandagatla@linaro.org,
        bgoswami@codeaurora.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: codecs: Check for error pointer after calling
 devm_regmap_init_mmio
Message-ID: <Yd7jsoTqhdzldOHT@sirena.org.uk>
References: <20220111013215.494516-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yFTNbuUxyqjoLy6G"
Content-Disposition: inline
In-Reply-To: <20220111013215.494516-1-jiasheng@iscas.ac.cn>
X-Cookie: //GO.SYSIN DD *, DOODAH, DOODAH
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yFTNbuUxyqjoLy6G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 11, 2022 at 09:32:15AM +0800, Jiasheng Jiang wrote:
> The devm_regmap_init_mmio() may return error pointer under certain
> circumstances, for example the possible failure of the kzalloc() in
> regmap_mmio_gen_context(), which is called by devm_regmap_init_mmio().

This doesn't apply against current code, please check and resend.

--yFTNbuUxyqjoLy6G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHe47EACgkQJNaLcl1U
h9Dt+gf9Eb/xv7Ke6BmtuB7TbiXVjloQqaMz+eAF1LXUtO/K/ChdrowhQSMHLeRa
wkiUVm8zh/+rAiN9g/ZcaCECI4/yv7VIyWbgSUAEy6GCZfCsYuSAO1b0KpyQTWDd
Nb6Gd/QNEDrOOXQN6utAWk2X0SYY5B1kaJAKjBtGDFEoRCDJ8XgD2LFjJQkjZi7O
aHMISkOB8//AWGXkz3z9xeB3uMLmama8Chc1gV34Knvl3l3f5TJAEnJ5RnWjk5GQ
pKFkNJ5HFCeYjHAY/+pEnHsvRwp+Nspot1O+gK3DNfbKFRMMmm+BJt6ON0dnxQtb
0TWOLm+pZDyERLLtLl7TeYDSQwaN9g==
=635e
-----END PGP SIGNATURE-----

--yFTNbuUxyqjoLy6G--
