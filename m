Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07CB570807
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 18:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbiGKQJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 12:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbiGKQJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 12:09:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CF770E69;
        Mon, 11 Jul 2022 09:09:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 142DFB810A7;
        Mon, 11 Jul 2022 16:09:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2BE5C34115;
        Mon, 11 Jul 2022 16:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657555787;
        bh=1Qdi/Q0tKjz8oNHPlKjsC6Lj+SOxYtkZt7rWDGrToRY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CkSMmcbn9o7y/kluSx6Akj5rVRxTZ4m+hOy2j+nUAgXNjz/M0EIfZhkjj/DxciWkw
         Ss9VeLEiPY36uQMdH2aS7yPHV9TV9BhzSI8YzQyhgIvGNpye7Rj/hD0mehQ4hMabBS
         VwwqsdQ6wICIgDeJcafT1fexNfffmSXKmBGspqrxuGOur5GoUr4dskIJboC7wweD2C
         xY+cpj/GW5JJOPW5iyVZWrcK24H8RSO1NQhtvxMhTNC0uAgPr26SyHIgGHRQ3rGM0V
         a2cDVwBEkOKv0KbO3MEF0U1m3gJrmVtS11PgMb/smUiP396R3m/zzMyZVkJ+ifhHzf
         xoXbGKMkuLRmQ==
Date:   Mon, 11 Jul 2022 17:09:38 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>,
        anand.gore@broadcom.com, dan.beygelman@broadcom.com,
        kursad.oney@broadcom.com, joel.peshkin@broadcom.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [RESEND PATCH 7/8] spi: bcm63xx-hsspi: bcmbca: Replace
 ARCH_BCM_63XX with ARCH_BCMBCA
Message-ID: <YsxLQgR8qj/JQY2G@sirena.org.uk>
References: <20220707065800.261269-1-william.zhang@broadcom.com>
 <20220707065800.261269-7-william.zhang@broadcom.com>
 <20220711021131.3289881-1-f.fainelli@gmail.com>
 <Ysv/PNJzSEwRnQVI@sirena.org.uk>
 <ce3f1df4-6919-e666-a8d0-a856e5d7bc3b@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sHb/8weEcalzkkyG"
Content-Disposition: inline
In-Reply-To: <ce3f1df4-6919-e666-a8d0-a856e5d7bc3b@gmail.com>
X-Cookie: I am NOMAD!
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sHb/8weEcalzkkyG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 11, 2022 at 09:04:39AM -0700, Florian Fainelli wrote:

> Each patch is independent from one another and there are not dependencies on
> the Broadcom arm-soc tree(s) other than for CONFIG_ARCH_BCMBCA which was
> introduced with v5.19 with b32c613b3fda3e1c26119609f1ad6b19178f82f5. That
> said, I prefer to take all patches via the Broadcom arm-soc tree(s) to
> ensure a timely inclusion for our upcoming v5.20 pull request, and ensure
> that all drivers are converted in one release cycle.

> If you want to give me your Acked-by or that I drop this and take it via the
> spi tree, please let me know.

Acked-by: Mark Brown <broonie@kernel.org>

--sHb/8weEcalzkkyG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLMS0IACgkQJNaLcl1U
h9C4bQf/VUFPe2ZDuiR/mCrppClqCWe1VGX9sRa/Jx4ihttjnt636Y2fJZAddkf7
6XyzrXfJDsfyoD4BFwwStgJ6fVfLf/yjm3BvK5D/8PJQN4K3tzmXxRWDFLN1rMyh
5tTGBGi00rvPvAMmuGK8PIdokqDPd/k44ZVRs56/fby74BrBNahGCUSgf7x5lXMB
IpV7VMWyz341SutrYtwk7PZaWL8cZ0QJ7RqlhCbVDQ8Out+Rx01cfFcbfVv2wrLM
QyH0VuITIFFJCVidHQWLVeCWlVSL4OjCzWTUd/1WcLxmG/plD1z8QCuk5xLnTs0l
MdIs2HkMXZgwSRU58q9qB92Dd+tkhA==
=iZfY
-----END PGP SIGNATURE-----

--sHb/8weEcalzkkyG--
