Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2644EC47F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 14:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345454AbiC3Mlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 08:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345118AbiC3MlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 08:41:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE897DF4B4;
        Wed, 30 Mar 2022 05:30:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26CF5B81C26;
        Wed, 30 Mar 2022 12:30:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B08C340EE;
        Wed, 30 Mar 2022 12:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648643410;
        bh=wMFzbAJ1w3I769LKcQvR0OeV1wjnRKl15NqgNqHjMPM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jooz5o26y2T7lucnkeTlKNAUZ6dwp3eoPFEtxeqpOFFaLNFKr5oWouRbAlRA4eOpU
         R4GJT0rTVrF95heK9efPmE+2RKbqxBBb6hW6ti3o4Ay0qwCGCcQIlzuGopfhxvI9YH
         6DVldjBxxNxJPB+tlFbmflOjHnioNZtEYaeFwyij4glVPevgwWQqQH7h7V9QCYoVdX
         Z7ZLTB/E+L+UkqVieV7+/kkd6Z5x7SR+N4vLdwkNov88B3292HF1u+xGFVA0p8gpyH
         boOy/oJPqR5/jKoH+gw1Xrxj22CghA0VjZ1uVJ8x2X38JcHH8koY+2XJ4zOiENX9/Q
         x+1IXAavckAzw==
Date:   Wed, 30 Mar 2022 13:30:02 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc:     =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>, robh+dt@kernel.org, tzungbi@google.com,
        angelogioacchino.delregno@collabora.com, aaronyu@google.com,
        matthias.bgg@gmail.com, trevor.wu@mediatek.com, linmq006@gmail.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Tzung-Bi Shih <tzungbi@kernel.org>
Subject: Re: [v7 2/4] ASoC: mediatek: mt8192: refactor for I2S3 DAI link of
 speaker
Message-ID: <YkRNSoBKFvYYyZLu@sirena.org.uk>
References: <20220324064511.10665-1-jiaxin.yu@mediatek.com>
 <20220324064511.10665-3-jiaxin.yu@mediatek.com>
 <20220329223002.uo7kiemopkh7ak4x@notapiano>
 <dee3fbb7c9f0c3e1f11143db1d6fc4381cab827f.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jOMai26txzsrB1Jf"
Content-Disposition: inline
In-Reply-To: <dee3fbb7c9f0c3e1f11143db1d6fc4381cab827f.camel@mediatek.com>
X-Cookie: Two is company, three is an orgy.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jOMai26txzsrB1Jf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 30, 2022 at 10:33:06AM +0800, Jiaxin Yu wrote:

> "(Although I think this would technicallybreak the ABI?)"
> ==> I can't understand this question, could you help explain it in more
> detail.

Making a previously optional property required means that systems that
previously worked may stop working unless they update their DT, DTs may
be distributed separately to the kernel and perhaps even baked into
firmware or similar.

--jOMai26txzsrB1Jf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJETUkACgkQJNaLcl1U
h9DbEwf+JUOC5DnLCotwK80wPY+Rv+Fxpva35UGKpU+JgyM/o50OQtmaefr3nyZ7
rItM7lPU81Hj7CJv0/hKjwsTmIVugxE7tOao1mBV9wLaStQfn2tx79wtLhiSYeNH
Ig0F79Jy0tY/TnytxA7d8XYUzguiwLqQIBbC6VHIYfO08FdMyloI+3SILPHK1VM+
SN23X+R9nG0CJImoNZMP1DDGodHkB9u+YhhB66cULenBpGMVNDKU1cPLTytp3nvP
bDz70kaMHgFqMgY01LMzQ/1TBfRMm7isoInZl6nGUnDOo9pCzmctaPZyBgRQ5mod
XaHgRucIShC8OJ16S0YCPs8CfbgvvQ==
=2Po5
-----END PGP SIGNATURE-----

--jOMai26txzsrB1Jf--
