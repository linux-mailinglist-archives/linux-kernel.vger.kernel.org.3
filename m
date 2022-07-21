Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDBD57CA8A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 14:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbiGUMTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 08:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiGUMTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 08:19:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA637FE53;
        Thu, 21 Jul 2022 05:19:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFF2761D99;
        Thu, 21 Jul 2022 12:19:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61BA7C3411E;
        Thu, 21 Jul 2022 12:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658405970;
        bh=90w2BUPeykw3L6eLJY+/iA8CSo+mOdpNtZFfyxQV4f0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tWtei2IC7LLKMGuWx7OGmZgtYIVw4sviob/MPlLdZgzbvwsFiP/8QcIl4G3V+Jvho
         EMkotHCrFkkBqURuWz6tyy4e0rBs0ijIZBiOy8NOcA5fZk0JYz28r2x1Y/qTJs8dFi
         48859ytlpZ9sB6o4XpUx8xz42gNEGucfsNaeKrenBeK0gckaR9rJ4SC8jN2B/BHIsp
         dvdcJzDw70LRng0iclAuYiZiVmOXJz0hG9jlFrmhJ89tzmsojekCLxUayku0d+EkVp
         TBUnYrXukoA1iQ2z0YnXsXC/B6KVtUgOtbTL/zQr/bc7now+6sRMymqX1AjdcSlqab
         RM2EviGUa5vlw==
Date:   Thu, 21 Jul 2022 13:19:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     avifishman70@gmail.com, tali.perry1@gmail.com, joel@jms.id.au,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        openbmc@lists.ozlabs.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 0/2] spi: npcm-pspi: add Arbel NPCM8XX and full duplex
 support
Message-ID: <YtlES7MX6nJr8l+L@sirena.org.uk>
References: <20220721101556.118568-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="O7bov1l8TjWxvFne"
Content-Disposition: inline
In-Reply-To: <20220721101556.118568-1-tmaimon77@gmail.com>
X-Cookie: Exercise caution in your daily affairs.
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--O7bov1l8TjWxvFne
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 21, 2022 at 01:15:54PM +0300, Tomer Maimon wrote:

> Tomer Maimon (2):
>   spi: npcm-pspi: add full duplex support
>   dt-binding: spi: npcm-pspi: Add npcm845 compatible

It is not obvious why these are a series, they appear to be entirely
orthogonal.  If there's no relationship between patches it's generally
better to send them separately, that way problems with one patch won't
hold up unrelated patches and reviewers aren't left wondering about why
things are grouped.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--O7bov1l8TjWxvFne
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLZREsACgkQJNaLcl1U
h9DmJQf+M5sCikLx8XCc5AhzopEJBxC42hfe5IBR6mlpIWp/dv3JYI8Q+8rvNl/F
7lXeQgGxQHJoFGE0RihkSSZYdEFw6Rb8OXhyodqQbyI8iukuiSTL8NzA0JbpzCTu
tZm+JRU3zWu39jyFdRGST22mgJHxfrSWxEdAm0T+0AOYY4GNAn4cquIHVH9wwU/g
bPqOsc+nDa0B0aZrDrdrndq2iBFKuHkKt+Ig8vGmsn/U1eyIFK6Rr+SXEqS6zQnS
mEdWhyIyEWkz9+61h+bzkTvtmlaLgIAoWjA+Kc/3droutXOp9BK9inOEcgA0u1Av
P3IrCNU8vqB0vHqWtrNU+S3lXuOolA==
=wHf8
-----END PGP SIGNATURE-----

--O7bov1l8TjWxvFne--
