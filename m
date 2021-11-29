Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2FDE4616C1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 14:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346758AbhK2NlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 08:41:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231942AbhK2NjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 08:39:10 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669CCC09B127;
        Mon, 29 Nov 2021 04:17:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B301CCE110A;
        Mon, 29 Nov 2021 12:17:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1AE1C004E1;
        Mon, 29 Nov 2021 12:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638188262;
        bh=TS0mCU94vpdYlwPE1yfgV3rJM5zYoKRFZ02zqnwnIc8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q2FdC8BxDJO5arAsfllDiOjmNKcMbKtMHhH8KXyX5jN3sswMsNvwGp2GB+ANob4dn
         jsyxsSewepb2cASZGni/DwtBlY4P1h3/DWkbY2JPIRaG2QpOW/IrYZg7wXiKI08zaQ
         9Dl4B9AspiN23D9z8CjQi2oewTY40dMQ02WpbFGtwW2eNe0llodNES7fxUN9GRUgbl
         YnmXdS6MJYxrd0CcWTSOwdrIjy0nafs1m4Gr7+eBJFLHVUX+wLWzS7Y/aiszon3jb+
         Mtk20qYDNKhJSvK8HhYinxSaqzbOXJdbcFgZorWuksilN6qpZARwshlNQpK+W5xoMT
         X1PgcPBdnDmEg==
Date:   Mon, 29 Nov 2021 12:17:38 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Dominik Kobinski <dominikkobinski314@gmail.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        ivo.ivanov.ivanov1@gmail.com, linus.walleij@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, dominikkobinski314@gmail.com
Subject: Re: (subset) [PATCH 1/4] pinctrl: qcom: spmi-gpio: Add pm8226
 compatibility
Message-ID: <YaTENEobjxF7Cgx+@sirena.org.uk>
References: <20211127122626.GA3798@debian.domena>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="g2QDtMqK+ThNTGXI"
Content-Disposition: inline
In-Reply-To: <20211127122626.GA3798@debian.domena>
X-Cookie: Thank god!! ... It's HENNY YOUNGMAN!!
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--g2QDtMqK+ThNTGXI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Nov 27, 2021 at 01:26:31PM +0100, Dominik Kobinski wrote:
> I have sent a v2 of this series (https://patchwork.kernel.org/project/linux-arm-msm/list/?series=586091), but forgot to set this patch series to superseded. Sorry for the confusion.
> The only change that was actually made to this patchset was the commit message to the [4/4] patch, as pointed out by Bjorn Andersson. There was also another patch added at the end of the v2 series, but I believe it doesn't concern this subsystem.
> I'm not sure how it should be handled now. I am really sorry for not setting this series to superseded earlier and complicating the whole situation.

Since you didn't quote any context in your reply I'm not 100% sure what
this is all about, the message you're replying to is a pinctrl one but
the message is to me so I guess it's something I applied.  If there's
any changes needed in code that's already applied please send an
incremental patch with those changes.

Please also look at your mail client setup - it's not word wrapping
within paragraphs and for some reason it set a Reply-To with the message
ID of the message you're replying to which confuses things.

--g2QDtMqK+ThNTGXI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGkxOEACgkQJNaLcl1U
h9AeNAf/ZN2/Uki9zWoyT12smlvz/CQBeTgBV8gkVXzd+pMsP8ho1rDC0gi95qoc
brej3HMCNG3Ft8qnyzQGswbea//vlwy4iV/97gXB96DzzX85/n2fdeFr3U7bl5Aa
ZNpmmxttXF4GSzbIAE2t6yUdEGvIthsRhzKE2OW8/6nVUUl06cncchIHZR/t93Hy
/K8d9Dz+CkL4XHDFcBRUrqScCuCt+xmv+qqOhzxJUiD4ljCdFxz1PryhwF4OA4HA
lK3DGoj1XsUa6j/29Nq1RTJnATlxHXxn3Zsg8ZCptPEl/3lPGDAFXDQvblUeEQrw
naAW8IgzSpWPYS1ye15ZTd8hDYgiKg==
=tGim
-----END PGP SIGNATURE-----

--g2QDtMqK+ThNTGXI--
