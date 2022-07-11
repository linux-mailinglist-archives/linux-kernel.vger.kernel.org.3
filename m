Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1745B570024
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbiGKLVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiGKLU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:20:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BB8240B8;
        Mon, 11 Jul 2022 03:45:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AE16DB80EA6;
        Mon, 11 Jul 2022 10:45:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18BE0C34115;
        Mon, 11 Jul 2022 10:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657536322;
        bh=JJMcpurG9hZV0JukCAE1tIk7+gBNzOKf3z22c1hNDQ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FB3jpYBgsz/O96WX/z7FPWWjxtTxgEUZUkPpO1SwV/ztKVJW7OjpmZQ44P9e0YtON
         ZHnUbXIjFFTQW8QrguecXEcOjKUaq+r4GGcTVuUSMNP4Mh6EhRPt/eT7jReALr43ZV
         BwLP8dn6wGW/++YryiAoRQ75+pzW1330f4BUgSRrziFwQkTgBhL9iNvpx3ODsnintY
         7O/8EV009lE2EBZ1lmCS+VO75ALlzJxh4OUopqdnRhd3Fe5fFlS5a27xfSKIQgBQIP
         8/OE4U+5U1aq8k/mdqMLX9UEOYkF0bZ8Bvu7g7Wgx4i/qqVyPbGpwVJzHe4fCkxX8K
         D4gv3+HhRScKA==
Date:   Mon, 11 Jul 2022 11:45:16 +0100
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
Message-ID: <Ysv/PNJzSEwRnQVI@sirena.org.uk>
References: <20220707065800.261269-1-william.zhang@broadcom.com>
 <20220707065800.261269-7-william.zhang@broadcom.com>
 <20220711021131.3289881-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CPcBR/G9ERc+TFah"
Content-Disposition: inline
In-Reply-To: <20220711021131.3289881-1-f.fainelli@gmail.com>
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


--CPcBR/G9ERc+TFah
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jul 10, 2022 at 07:11:31PM -0700, Florian Fainelli wrote:
> On Wed,  6 Jul 2022 23:57:58 -0700, William Zhang <william.zhang@broadcom.com> wrote:
> > Prepare for the BCM63138 ARCH_BCM_63XX migration to ARCH_BCMBCA. Make
> > SPI_BCM63XX_HSSPI depending on ARCH_BCMBCA.

> Applied to https://github.com/Broadcom/stblinux/commits/drivers/next, thanks!

I was rather hoping for an answer on what the situation with
dependencies was here...

--CPcBR/G9ERc+TFah
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLL/zsACgkQJNaLcl1U
h9CxmQf/Zkc7j2WiGs21ddae4B5EISCvv02RbeP+N9o+QdSnpH0+yLQoLChuJ7uX
DPByofVbcLMwKwIRlMgUHchw1siJt15kogsJAbmguw+1bEDOTz3Dv5uqmH9hO0kG
+HrxYWqiBT0J9vqw5U2nX7nTy3A7MKdyi5ULTeZM7xAYK/uH/HqOJnofSQ8NHrGK
iRhjGno8n2f56aRMa85bD6aOfr4U5/damBRWb9Js16ZYCD1zHo77KzydO+lgrolr
uxM4cdVZn453AqCRkKmGJXqw+NGyKbp6zgOIIiEUDmdTvSY9QiycmU0aW94fDsdG
1NQufXfcMMZ33lV7MMJPjl8TwbUdMQ==
=xFf/
-----END PGP SIGNATURE-----

--CPcBR/G9ERc+TFah--
