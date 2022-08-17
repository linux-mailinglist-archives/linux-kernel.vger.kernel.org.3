Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392F5596E98
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 14:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236580AbiHQMlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 08:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239656AbiHQMkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 08:40:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA4B89902
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 05:40:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B5E161038
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 12:40:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F9D1C433D6;
        Wed, 17 Aug 2022 12:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660740043;
        bh=f0Oc8xOFa+rcK6EyjWVGAbQLovpcnlfo7fvFXauDoiA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hXU8cirYykqO5FqL9jfqzNfEzUIpM3VGrytLNuA2xj9p+ewdMh9R9eSkJn8vN7o9f
         DdmL6w2c18hYCAychszFzGUY9wivzy9GhIgXAtgovNgW3Z6lrkla+dMFnXAx/PeqEB
         Mg1m+fyZJPq+HbP/UOpzeVYQUC06nYtJoSTCzRFSOAwrwLttpEbrgHcIe4SYJlvaSY
         peV5BrbEvW93kaiyBb3jVbjNSb8cnLQuxbEl9J/NNmEo9AutsDYteoN8GTDdqk0xpl
         OWe3q0gZIWkMbQjTPs+DIHkT6/omLraJKh9Oet8ONH0UtwK/kxF0zzciHla9nLTaLc
         ulcTV3qVGUcOQ==
Date:   Wed, 17 Aug 2022 13:40:37 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     Icenowy Zheng <uwu@icenowy.me>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH 2/2] ASoC: Intel: Skylake: try to get NHLT blob with PCM
 params as fallback
Message-ID: <YvzhxcyP18SYlutV@sirena.org.uk>
References: <20220725111002.143765-1-uwu@icenowy.me>
 <20220725111002.143765-2-uwu@icenowy.me>
 <4208aece-0aea-ba86-9a00-9e217546e1dd@intel.com>
 <3346b62c3cd7e07766457c9140849a31d6d8775c.camel@icenowy.me>
 <85648922-27df-051d-8ae8-d0e4e810198a@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a6fVL5w7GoNQhqFZ"
Content-Disposition: inline
In-Reply-To: <85648922-27df-051d-8ae8-d0e4e810198a@intel.com>
X-Cookie: Use extra care when cleaning on stairs.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a6fVL5w7GoNQhqFZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 16, 2022 at 09:08:31PM +0200, Cezary Rojewski wrote:

> I know not what "speaker-test" means. Could you specify which endpoint you
> are speaking of? Providing either alsa info or at least output of 'lsmod |
> grep snd' would help. I'd like to be aware of which machine board are we
> talking about.

speaker-test is one of the standard alsa-utils apps, it plays generated
audio (sine waves, various varieties of noise, whatever) with command
line specified control of the audio parameters.

--a6fVL5w7GoNQhqFZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmL84cUACgkQJNaLcl1U
h9CxEAf/eQrr0qgLq085cHm7e7fvKF5p4zJ070QqYPsGtZhYdcAqCbWvLNcTUZ/b
+XloPRX+tyUyracowfpY90ODmJlxHYUgnDwsltJroDE8pUzX9Dftf81b5Rf09B9r
po2Vbd23q8X9HOy6Y7OjXQtmdV0F4sy8pjUNolV6jqkBDFguRbWxUCydK2TUkV7W
19jXsrjaqPGc5/eepoG44QPQIRKeu1khonM59Ek4+faJQO+l8ZwH9yDGeLvcz3HU
Aq028EVhlKNCTy309tUGk4TB9+pISdTfsiglPGePOtKSsVtVbwjEvLpXq/1dbbp8
XICFQ5sis57qZwkpz5ECvEt+d1+JyQ==
=YtUs
-----END PGP SIGNATURE-----

--a6fVL5w7GoNQhqFZ--
