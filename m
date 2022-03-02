Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF6F4CA5A3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 14:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239848AbiCBNMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 08:12:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239431AbiCBNMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 08:12:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DED832983
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 05:11:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BD038B81F94
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 13:11:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC00C004E1;
        Wed,  2 Mar 2022 13:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646226710;
        bh=HH6BcwYmzPzwuwKnKZ0uOj8l/hGrP7oWeQFG40wMCR8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AB7b86DM0maYg6oUioxF6IsG2D78ibFRMHYQtGUaAThypyBCQPiC+Yp1QLmd+aY59
         DjhpLzgknEwstFtzZ0YaONUO+7jHKxBuq8W5uu0ARQ9Ydurr0U0bNTQuf4CVo7bCjN
         2iaPBE9uxEHmwAic4FL23lJ8dv6GDxuHvYsZwUWQIu+c8f/G7jsGYtv6BVXwnkvNfM
         jgmiFmKQqDRzh6dVA73NJdN78+GKEGGpX9/O+sy7DUMvIsayh9hGBCacVX0lty/xNu
         wX46l6xR5x+rwCV1nT71gXlkMNHpnqdFsEgTCNyagrgauxogT5yrFjdEY98Xg3du4n
         XgnoLG0mdvpBw==
Date:   Wed, 2 Mar 2022 13:11:45 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "Yang.Lee" <yang.lee@linux.alibaba.com>
Cc:     lgirdwood <lgirdwood@gmail.com>, perex <perex@perex.cz>,
        tiwai <tiwai@suse.com>, tangmeng <tangmeng@uniontech.com>,
        alsa-devel <alsa-devel@alsa-project.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: =?utf-8?B?5Zue5aSN77yaW1BBVENIIC1uZXh0?=
 =?utf-8?Q?=5D_ASoC=3A_amd?= =?utf-8?Q?=3A?= Fix an ignored error return from
 platform_get_irq_byname()
Message-ID: <Yh9tEYtfKTBIICQS@sirena.org.uk>
References: <20220301064920.37788-1-yang.lee@linux.alibaba.com>
 <Yh4UGGuspsc/gAyY@sirena.org.uk>
 <53306907-c963-4740-9a90-c1249ba0dff4.yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="X6e1+/WO22PbXzdY"
Content-Disposition: inline
In-Reply-To: <53306907-c963-4740-9a90-c1249ba0dff4.yang.lee@linux.alibaba.com>
X-Cookie: The sheep died in the wool.
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--X6e1+/WO22PbXzdY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 02, 2022 at 09:17:21AM +0800, Yang.Lee wrote:

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

> The function dev_err_probe() is called in function platform_get_irq_byname() to print the error code.

That doesn't seem at all relevant to the error code being returned which
is what the review feedback was about:

> > If an error code is being returned we should report that error code
> > rather than squashing it down to -ENODEV.

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

--X6e1+/WO22PbXzdY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIfbRAACgkQJNaLcl1U
h9BNxwf9EbCJYEIUuEHT4sfAEoL+oFQovgYwW1G0unYzJ5kgO0t0NXEDRVx7Yo/S
O63wumrjLCGoIgofpYa0xJ2WtnBAe5LchcLCdFo5GrwLvrgMHtup4lAWo8ZfiJc6
DynyIUycZcdmlz9XqPIvsaZ8sUNHV83BtpwtgLT5QtJtmhQwqaLnYDdWJh2A3CE9
R4DkZejr7792OHDjHsoEUB93DqcPjUhvY6tDbQvcwEBNnv48YOS+lw9V7vGRKQFa
pQZrOeo5OeV29WOJPFo1LbL4WExvAXOpQoCr17YXrfP3LeQ061gsFLvCAfvZOH34
YjL5Td+BT4IYahRiNjh8i90DKi1VeA==
=qTYQ
-----END PGP SIGNATURE-----

--X6e1+/WO22PbXzdY--
