Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA55B5AAC3E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 12:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234804AbiIBKT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 06:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235662AbiIBKTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 06:19:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53F7B5D
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 03:19:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BC9461F2C
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 10:19:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE557C433C1;
        Fri,  2 Sep 2022 10:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662113984;
        bh=CQFx9BBIPV7rdst2Un3d9cttBBfsNAdm1vSROFPyvS8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Af1FAASI/LcZV3vInAumEI3Ik4yHBJdqHINEcBAVU3Rk3bK+6Yi0dEhhDNXTLh9Yt
         oyH0YoYmxz2+Qo8yEEeeD3SIOUGi7KpqWLaDObeKUu5sCfsEGRswNuNZeLVn7X4z1c
         yViv5D5x8PKeeAZY6kAw4dEVkwaRe/bPopwcO9TFCPpusAy2YwVr0UYoz0I1W7UhUj
         qhbxO9wnqIqoZ4JYv+3QBn/0WsnWFtiiv3YBDw3cJnARowVQSgTgR6cyww/8UUqOvY
         nbX8d/iSAhiqOgT0dwgV0QNEfiEavxzE/T267GI+0CkDrR126t/DKzkKSbqtAzwzRn
         IjkqJIeAeOVMQ==
Date:   Fri, 2 Sep 2022 11:19:38 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "chunxu.li" <chunxu.li@mediatek.com>
Cc:     linux-arm-kernel@lists.infradead.org, matthias.bgg@gmail.com,
        sound-open-firmware@alsa-project.org, tinghan.shen@mediatek.com,
        linux-mediatek@lists.infradead.org,
        project_global_chrome_upstream_group@mediatek.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        yc.hung@mediatek.com, pierre-louis.bossart@linux.intel.com,
        peter.ujfalusi@linux.intel.com, daniel.baluta@nxp.com,
        angelogioacchino.delregno@collabora.com, lgirdwood@gmail.com
Subject: Re: [PATCH v2 0/2] Introduce sof_of_machine_select
Message-ID: <YxHYusRPbwO2ZcAt@sirena.org.uk>
References: <20220805070449.6611-1-chunxu.li@mediatek.com>
 <166128061023.1031684.5884182401063110421.b4-ty@kernel.org>
 <9b3d787387685f2153fe7c99b77a8b8b482f8954.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="U0OKg5qn858JZiGC"
Content-Disposition: inline
In-Reply-To: <9b3d787387685f2153fe7c99b77a8b8b482f8954.camel@mediatek.com>
X-Cookie: I doubt, therefore I might be.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--U0OKg5qn858JZiGC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 02, 2022 at 11:57:51AM +0800, chunxu.li wrote:
> On Tue, 2022-08-23 at 19:50 +0100, Mark Brown wrote:

> > If any updates are required or you are submitting further changes
> > they
> > should be sent as incremental updates against current git, existing
> > patches will not be replaced.

> It looks like the patch didn't applied success.

> The patch link is=20
> https://patchwork.kernel.org/project/alsa-devel/patch/20220805070449.6611=
-2-chunxu.li@mediatek.com/

> the merged link is=20
> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/commit/=
?id=3D6ace85b9838dc0162b474dbbbb6b388e7561f6a7

As covered above please send incremental patches fixing any issues.

--U0OKg5qn858JZiGC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMR2LkACgkQJNaLcl1U
h9Ay6Qf9H/ErQa/tLh9xUc0xSn/fYKkv8V8kj14lZGVScxHAlQKI4cFqYZ/dRVIH
/QTdDm4kJ/W9ObW78riLSTYjbYeWHBjcBTsiYjOdFURI7LV5qjCl769st4JkYLpB
au8x+0B8e/Sv4BLY64KeRBsaQ22JwVrZT6wf9L4WhTwwDA/QpKSLR9nMsB2pwc26
TGe2wjhXZeu7b9d16wQLQZWZJ2uv0CjWgzcvuloIfTmsG16M5vf9AjCvjjVQ2Si+
fRNS59ViX8C5SYuY11b55QGMti1+iA0R73lt7tnqeqgKg23pDheUvo2Q4jNx3Lrz
ZGvqUaJwA69z7a5nAj5Fg2KC0i8btA==
=/dmj
-----END PGP SIGNATURE-----

--U0OKg5qn858JZiGC--
