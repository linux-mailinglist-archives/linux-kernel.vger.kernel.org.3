Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E75544983
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 12:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243096AbiFIKz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 06:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236028AbiFIKz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 06:55:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66EA12622;
        Thu,  9 Jun 2022 03:55:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5EE261D69;
        Thu,  9 Jun 2022 10:55:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE994C3411F;
        Thu,  9 Jun 2022 10:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654772122;
        bh=fFvXj5SRoTp6Hhi5ZcyQ5FroE/o0H8XmIrhJK4iz2Ho=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pluRCe16VSHhiKwQqtHn/heSRjUJgv4phLQst9mzI3o5ksVNMtTXeElw1YZXgOaSO
         oeQCNorZCg/CIJrivCpOc9Pfck+Ki3RfzaaJAehf9VVjkL7VoXs6QDDdkh11PNzUGa
         +CQTjrwRAKgKG5AM7ci1iIWCanvmC32Kkm1NU6JxMW0C6H9aYkntKHoDR6uTLIau3R
         bDLlTxHkGftnC9JWhUKyNBVaSFX6/imoNzF7C3/N/Vt0y6kSFuCRCWbd+M+63IptAV
         HGxekt2l3LlK4UQXNRWbfNH7O9HUhUxEm9GEfgnvl8kCD/5lxDMyeFAPu7hTjI4vGj
         DvqecRiM/KU/g==
Date:   Thu, 9 Jun 2022 11:55:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     conor.dooley@microchip.com, lewis.hanly@microchip.com,
        linux-riscv@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next 1/2] spi: Remove unnecessary print function
 dev_err()
Message-ID: <YqHRlaqy/UD0vDKU@sirena.org.uk>
References: <20220609055533.95866-1-yang.lee@linux.alibaba.com>
 <20220609055533.95866-2-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0bXiklFNAPTpnN3I"
Content-Disposition: inline
In-Reply-To: <20220609055533.95866-2-yang.lee@linux.alibaba.com>
X-Cookie: Space is limited.
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0bXiklFNAPTpnN3I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 09, 2022 at 01:55:33PM +0800, Yang Li wrote:
> The function platform_get_irq() never returns 0, and the print function
> dev_err() is redundant because platform_get_irq() already prints an error.

Are you sure it never returns 0?  Note that 0 is a valid IRQ number on
some architectures.

--0bXiklFNAPTpnN3I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKh0ZQACgkQJNaLcl1U
h9DOywf8CpYl578fRtjDaeqN5f0T9EqOZQtgYzfzILNoXGC066ucH53ffM+mJrOE
eEy3bPlm/63pb7NUyNfc3wqEK8lIXR00D7VmCw7xBcfvDKsoskfXiN8ipLE3cDS4
0wMY94olcidpbXmrZgghFqSy+J5+cy9Fqis1tw6qygnFnXyUpoFULOJFdujP7Pi8
VU3cunpin9zsBXJkGbJfgcSQBW9TwZnve7+Zi/aJ0wk+Xm49lO0easreafN2IRa4
0dw1Xfm4x2kIADe9tNbms7TqjbNfG55pnHWseFT2y6yOiz6MKGDDlJMoGehUV56J
SFjy59OdlizDGuu1EtBePOPim4CKPQ==
=bqmh
-----END PGP SIGNATURE-----

--0bXiklFNAPTpnN3I--
