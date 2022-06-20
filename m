Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E3355205E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 17:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244182AbiFTPSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 11:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244134AbiFTPR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 11:17:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44D2B22;
        Mon, 20 Jun 2022 08:09:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4AB5D61204;
        Mon, 20 Jun 2022 15:09:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05906C3411B;
        Mon, 20 Jun 2022 15:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655737754;
        bh=UowpPsN4dwRx6/3c+/Ap4rkZrDx0R5Ze0ezebq/G9JI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oavu5I/YbxUqRbE8zqch6EIX41XpXQI0joby5hziQYwFeeIWNJveoetauTksx6kJw
         s5pkjUDxIHrbUvMJl+s7e42XXKBDikIs68DDJZf4HSQg0y6J3DC8Ik5UGJrO65M4Wz
         LNYUzn8xexo0ZssOhcPIC/vuo2Tx+puBCStNSyNXN2YReeF0h670DBH0+DTtfKOL+8
         RjOkUGkfPTj79Ts5qJrRVEDHJnTnB1BJYboaD/euBwpua/gu6LAbwnt16aVRCsX2Is
         DRsq3GXPwwjqNQl3dt7SG/Jp5M9k+SQBJ5sQbYyZUUL0beI3tc194vHcuTxyexU69G
         gOhT0VZsNTZmA==
Date:   Mon, 20 Jun 2022 16:09:07 +0100
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
Message-ID: <YrCNk+g6Xh7uC9fg@sirena.org.uk>
References: <AM6PR08MB4376C690036C5558058C4F16FFB09@AM6PR08MB4376.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4wRJYg8FNZuITX9R"
Content-Disposition: inline
In-Reply-To: <AM6PR08MB4376C690036C5558058C4F16FFB09@AM6PR08MB4376.eurprd08.prod.outlook.com>
X-Cookie: Good day to avoid cops.  Crawl to work.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4wRJYg8FNZuITX9R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 20, 2022 at 03:03:50PM +0000, Pierluigi Passaro wrote:

> > Via firmware description.

> Can you please provide any reference approach in the kernel code ?

git grep of_
git grep fwnode_

and I don't immediately remember what the prefix is for ACPI functions.

--4wRJYg8FNZuITX9R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKwjZIACgkQJNaLcl1U
h9DhxAf/QjS/aWkP17En2BvW+Gr3yNc/jrpVJq7UvOIWIXQbGH3NWey/fDtsW1Q8
SfV0/JZKiG69wIff6Plva4R6TMcU9FuJTlbb5wnU3Vl/IbY7sdG3tXh6epyt5UBf
xBKao3u3lpErY6OUF+xU6m9qf0MPlxGMVYgvQOOuJfE+0T6IBbS9fVSzr0assttw
199iCsBk1c+0dF/ZufZubBpZUk6Y+b+mmEDQ/4GoM2bsutX1Nw+EIqUw+HWK4YO8
CCltIK18dFjMm3bGhsEBCBcJCox0neYaCKmGhO9zb7YUTFlppaupdblWKBF58ylX
BJCFh2F9Ue/m0syfrLOvA169USrKNA==
=buGM
-----END PGP SIGNATURE-----

--4wRJYg8FNZuITX9R--
