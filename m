Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D9658EDB7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 15:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbiHJN5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 09:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiHJN5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 09:57:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3346BD70;
        Wed, 10 Aug 2022 06:57:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88561614CE;
        Wed, 10 Aug 2022 13:57:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BD2AC433C1;
        Wed, 10 Aug 2022 13:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660139860;
        bh=8U9yFOGIsXPYWmmnHIYLkHpeD5RKwBawgrNQqyoYFfM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N2HOEhRqGwBfJPfdmKK0Bn6Nzt07oLlpSXiNyADoQ7PN0jhltBCRr6m1p6CtP/XE0
         UO0ylwcggBYllVAIfR4Lihsq2rGG1HaPBug1pa50c8GpEvmmUPzMJ+xDyMhwUfiU+r
         oiJ11orrOdDYtHDX3fjUqeaFvcziXD9V8JTufeieE0LDb/PYDxyk0Qgw9vy8VWve76
         y1J+BBupGRONFNsNFXt4syOMPrkC8wcKGh/QNft8y8LbHjebDyYzcAlUo6KBpIkheV
         pc6IHhdr2K24E4mBJ8sI+VDFDwn85QTCzuj5/meMCk2tevBN9B7vdcSSTCo2mRVKco
         04I0CZHGv7CXw==
Date:   Wed, 10 Aug 2022 14:57:36 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        christophe.kerello@foss.st.com
Subject: Re: [PATCH v2 1/2] spi: stm32_qspi: Add transfer_one_message() spi
 callback
Message-ID: <YvO5UKACe2FMa5K4@sirena.org.uk>
References: <20220810093215.794977-1-patrice.chotard@foss.st.com>
 <20220810093215.794977-2-patrice.chotard@foss.st.com>
 <YvOtZtrRHd4AT+j+@sirena.org.uk>
 <d41e3814-3fab-18a3-7218-d5c28eaecff8@foss.st.com>
 <YvOxOg0vXSGrZLfP@sirena.org.uk>
 <38200a6f-fdc1-fa94-7bc6-91ca528235ed@foss.st.com>
 <YvO1U7VB7WQv0oKR@sirena.org.uk>
 <cfc882a2-c8f3-0ec8-706e-a16dccc9fda7@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qp2XHivCik8DSJHB"
Content-Disposition: inline
In-Reply-To: <cfc882a2-c8f3-0ec8-706e-a16dccc9fda7@foss.st.com>
X-Cookie: First pull up, then pull down.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qp2XHivCik8DSJHB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 10, 2022 at 03:52:39PM +0200, Patrice CHOTARD wrote:
> On 8/10/22 15:40, Mark Brown wrote:

> > Can't the controller figure this out by looking at the properties of the
> > connected devices?  You'd need to just return an error if we ever
> > triggered transfer_one_message() on a device that can't support the
> > operation.

> It should be a solution.

> I just noticed another point, property parallel-memories is an array of uint64 which represent device's size.
> In case a FPGA is connected to the qspi 8 line bus, parallel-memories property will be set with what ?
> simply random value to make dtbs_check happy ?

> IMHO, adding a new proprietary property would be cleaner.

I tend to agree that this is all rather unclear for things that aren't
actually storage.

--qp2XHivCik8DSJHB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLzuU8ACgkQJNaLcl1U
h9C8lgf/Ty/PVO0gORA+r8yXkatIJMlVbunpNkmNDYE+OPE1h59+rHpcNnt4pzcv
JACDJhEStqwIsqNOfBxHD5J7D4+jbRvCXhiL70yqKhOTw64DkUa65AJY136SSqLS
XGvpjz1QMv98fljk/zS1PBDAQ8ysQ7xtY2wxQh+aqelNiTgsDb8TFC/T22C/iDxF
2tRbU6HlL6VKoUUKHOvB4lBuTOo2gyMuloxVASblBnOqOO8Sb9er8P1ka4R1+BxE
76U+2YCwNiDOZaug7c39cUKHWwYXwArj7TUlSszHiROFyHe0pkW0m/G550FVa9uF
r5LLiJ7asVOVuuRyf5ow2bvxvAl6Yw==
=Ovrt
-----END PGP SIGNATURE-----

--qp2XHivCik8DSJHB--
