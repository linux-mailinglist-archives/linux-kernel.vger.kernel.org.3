Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B5951FBA3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 13:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbiEILwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 07:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233304AbiEILwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 07:52:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F99216073
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 04:48:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE1F161219
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 11:48:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B8EC385A8;
        Mon,  9 May 2022 11:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652096902;
        bh=cd1eyufqewLBiozYF7IjayD6HKPYr13nvygC0lANLlw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dCCZDMBg6ReQTD29fQLdwgvReyi6b6WtcFjPlJ2lZ8vxL8RZHqdRybT4ZV3DgskMn
         +BOOgda6YecpkLMiStUHe1bDTIHuhcuTc9A8SUSu39UhMX0yLnFHsM3zoCQULWGJpg
         fm3vvO9yuPTIbObPjLt4p2wo3pAS6mdll6TlecHcs0JXpO7CBqXlVGuhZuvyepuiSn
         QVhethMwXyjAanyl2PdIEtjsRpXx8hnvYpkMPaMnjPZOQXmSIFyhmCR0lUjbu2rim4
         vDdPS3PYRsY1RaogYc6ckuTg+rmkteeXZj8V4qRphjjEmtQj5Gk8l0B4eh88cf/aFx
         dlNyPrB6rqeIg==
Date:   Mon, 9 May 2022 12:48:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Zheyu Ma <zheyuma97@gmail.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: tlv320adcx140: Register a callback to disable the
 regulator_disable
Message-ID: <Ynj/gQQbQ8JFEcQL@sirena.org.uk>
References: <20220509085925.1548328-1-zheyuma97@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3fbrUoSA93r0CmS5"
Content-Disposition: inline
In-Reply-To: <20220509085925.1548328-1-zheyuma97@gmail.com>
X-Cookie: To err is humor.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3fbrUoSA93r0CmS5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 09, 2022 at 04:59:25PM +0800, Zheyu Ma wrote:
> The driver should register a callback that will deal with the disabling
> when it fails to probe.

This doesn't apply against current code, please check and resend.

--3fbrUoSA93r0CmS5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJ4/4AACgkQJNaLcl1U
h9D+Ewf/fxATUeYh+xRG7Mylx3kTcxLKKYB0GdYAv/UpVPmuJS5Ad12vOZiu93Ep
nRuiuUCjOWqsavf7eUawKkqL508SemrhLvpP7VIejhtF9LbSopnZxKmpYU3nGmJK
dAq9rdg92EqderFmy4pBlMxDST8fuuJgyeouyP6KTsWv0GhMYlZQ+wCK23opkDc8
HL6SOWLvQz0stZUIWahiuonfCgtg7/vULv/7FiKvPkVNvnzBgVQ9ba1gE23SmUBZ
CGbdMsGz9cuwxEvvFTODcylKp/VK6jo67wUaFvO8OH3rzjKYEciXFghyGosGunUf
LItiY6tIhtkUDTyNSPDUVAkrXEAZtw==
=cWs+
-----END PGP SIGNATURE-----

--3fbrUoSA93r0CmS5--
