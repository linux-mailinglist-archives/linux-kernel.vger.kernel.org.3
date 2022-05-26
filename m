Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D197534EC7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 14:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243412AbiEZMDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 08:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiEZMDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 08:03:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EBED02A2;
        Thu, 26 May 2022 05:03:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D6CAFB81D21;
        Thu, 26 May 2022 12:03:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DC14C385A9;
        Thu, 26 May 2022 12:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653566614;
        bh=SHqqNURW0tOPuSJZlgicE58CRfglRqKvrHRf4aGn/KQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nFhOM90Uf3ORx2YP3k0ca345cTnr8wjLC/1P+VIqBbxasy12k7Y+25tNh1w1Hb26S
         mUThSla4M+oq3Aw1xnSwORP9KVIPYVwEpowS0QRmFWFbTciiy2/iJIrIfwd3N0rG7o
         dUV51RKtzbjF86DS6+rWCsiOkTNMH/BVj4gn5yHjJQPvuFeJf7vIP8+EFtIki+FdbZ
         iQo5l4ohVe9E7LKdZ2So8Lf3AtverLb2a2wXHDKH4C3B4nkAZnmFhy0Em0wXgC9dSh
         k4Q2P+cKpsrYvqXEvPJeHvwVRSqdvw4cdSJU7Hjvvtri3ykQNZ+D1y3uUJbL8g0cOS
         qFUbTlr4DKpIw==
Date:   Thu, 26 May 2022 13:03:21 +0100
From:   Mark Brown <broonie@kernel.org>
To:     =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shane Chien <shane.chien@mediatek.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] ASoC: dt-bindings: mediatek: mt8192: Add i2s-share
 properties
Message-ID: <Yo9siXkJ5FUD0+w6@sirena.org.uk>
References: <20220509205847.607076-1-nfraprado@collabora.com>
 <20220525205346.6ik67nduv3zexl4p@notapiano>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9qit21t6XD5yksAs"
Content-Disposition: inline
In-Reply-To: <20220525205346.6ik67nduv3zexl4p@notapiano>
X-Cookie: Money is the root of all wealth.
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9qit21t6XD5yksAs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 25, 2022 at 04:53:46PM -0400, N=EDcolas F. R. A. Prado wrote:
> On Mon, May 09, 2022 at 04:58:47PM -0400, N=EDcolas F. R. A. Prado wrote:
> > The Mediatek AFE PCM controller for MT8192 allows two I2S interfaces to
> > share the same clock and act as a single interface with both input and
> > output. Add patterns for these properties in the dt-binding. The

> Gentle ping on this one. Any feedback for v2?

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--9qit21t6XD5yksAs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKPbIgACgkQJNaLcl1U
h9BEugf7BubpYYtmW6MsYqo17GyOLuEtujTpIaBpCHr3zKHc/G1ALk3Jic2PFQm6
SB/+DOLHkLjRB/u+jrX8LqA6LIxIJru5qi8RLa0dtuae75+uLoTe8qBs8HrxOQBK
QTPYr1vlII6EKUM8gw3LcucEszhcahCvPfuyQ1w6mmfPXqV+SpyZ3skJ+YwcvK5e
XefO3Ju7mxtkSNStuKQ02By2CxSUD2gRj2lkqVk8BUN/KPFWe0la6tn5xfvt9hig
e/hDuIqgm/EsPhoQSzJo93geTQpN8ATDiKPrRod0d8xMXFu687sbquNQBQYGhVzR
6Y9ziy+V1HLDz+UWE8WzWYuGQknX5g==
=d5lb
-----END PGP SIGNATURE-----

--9qit21t6XD5yksAs--
