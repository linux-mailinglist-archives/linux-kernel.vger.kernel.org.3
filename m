Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E150A553302
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 15:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350377AbiFUNLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 09:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiFUNLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 09:11:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2065B1DA6D;
        Tue, 21 Jun 2022 06:11:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B13B7614FC;
        Tue, 21 Jun 2022 13:11:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAA18C341C4;
        Tue, 21 Jun 2022 13:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655817102;
        bh=4xEME0PJkdFrWYpmGq18CjMHFdjMkxkM8iVMwtol8e0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eUVPXq0oGf0ynQ+mmppKszQbX0ExCvwwwyzClTkcVE2WThQMGV7mvgtdtLwZi9kpe
         dDtkTM9jnjSnDNtlRJewWC2apC09nfHB0duGnIXX0vqBCDd2TgvrAQUuRzZP/zIVMI
         Qpxjuj6zkn5CTumFR0+GSS6TqhPfsPduG/ILTsZ028IBm564m0B90BDHOesyPEfIDJ
         lgcjqomPUoKP17Xs6KIlERtTK2y7LLH3NVb06Zrn7GoO6wqzZKmX5zptHYXZ/71NYW
         AIei+ef2lro1GS4HLIqKo7DmO+D52U9EVKbAKnLXvmtcoi3VNenn9OmHeZRQM95nvV
         l6dTKpR7L08qQ==
Date:   Tue, 21 Jun 2022 14:11:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pierluigi Passaro <pierluigi.p@variscite.com>
Cc:     Alifer Willians de Moraes <alifer.m@variscite.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Eran Matityahu <eran.m@variscite.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
        "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shengjiu.wang@gmail.com" <shengjiu.wang@gmail.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>
Subject: Re: [PATCH 4/4] ASoC: wm8904: add DMIC support
Message-ID: <YrHDh6lzdZXj7HcQ@sirena.org.uk>
References: <20220307141041.27538-1-alifer.m@variscite.com>
 <20220307141041.27538-4-alifer.m@variscite.com>
 <AM6PR08MB4376411B180D8860E2AD3AE0FFB09@AM6PR08MB4376.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zPDn0Yp+KJI2UZco"
Content-Disposition: inline
In-Reply-To: <AM6PR08MB4376411B180D8860E2AD3AE0FFB09@AM6PR08MB4376.eurprd08.prod.outlook.com>
X-Cookie: Edited for television.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zPDn0Yp+KJI2UZco
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 20, 2022 at 07:53:56PM +0000, Pierluigi Passaro wrote:

> > This means that DMICDAT2 is not usefully selectable at runtime, you've
> > got IN1 as digital and IN2 as analogue, so while the DMIC/ADC switch is
> > useful the DMIC1/2 switch is not.

> A customer could have the following working configuration
> - pin 1: DMIC_CLK
> - pin 24: LINEIN2R
> - pin 25: DMICDAT2
> - pin 26: LINEIN2L
> - pin 27: DMICDAT1

> with no shared pins: here there's the chance to select DMIC1, DMIC2 and
> LINEIN2 at runtime: I can't find a reason for a fixed behavior.
> Can you please elaborate ?

So in that case the driver should offer the DMIC1/2 selection.  The
driver should be looking at which pins are wired up as DMICs and only
registering controls that can actually be used in the system based on
the pins that are wired up.

--zPDn0Yp+KJI2UZco
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKxw4YACgkQJNaLcl1U
h9BfeAf/UZDQPNisaKHZIdpACSlbsSETLopyOjBB/groSLMQsNWcxbfkFhXkhdZS
mASQEVcOrYDiXD7yh6dcIeBAys+tfFZkrbX5YVBy+3sMm9jufXa7k3gbcJ6fA5rx
ARo7N0DMY9I2YqAkQ6dtTOxIicnYMxWJibPLagGEc6WiGGbi1CfnlZJ8UmHKTy7T
CFIAQes0bK4R26y7dZW7ogoSAClxlwImn9pLvrkwEh9VppUsP7XR/SauygBUsl3g
8gR9o1PjcVI3heKldnX1mQrzN13oJfBm2Vjd+7VGl8cLs3ZaQ8cx4dAgt+zj1JTF
7EXAU2zpt9gbnFQhQXfk+PuFpldzwA==
=5L+0
-----END PGP SIGNATURE-----

--zPDn0Yp+KJI2UZco--
