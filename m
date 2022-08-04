Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A7F589CBF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 15:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239899AbiHDNdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 09:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239908AbiHDNdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 09:33:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238BA3B972
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 06:33:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B40AD61824
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 13:33:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDAB4C433C1;
        Thu,  4 Aug 2022 13:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659619989;
        bh=4UN4Sh851nEfGxs4mtdDwaJj3APw+mKwvZfqZjce8ZQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gw1Ka9jQm2EnMMwx87dKHUeoy+UdaWeKnJcFzH+ufqWvkB/UIKAQPeylrazG6dB6A
         RvphiLRFHzxrQnyj/OXMm0IgsSoYtEu3gKvOkKRQ+vHGDkAhhGPSbTn0RMLsK3DALZ
         pzNMyDmjzyTO/vugVmqZDxnpuLb3L5wqtYSvNapb5/ADyPcBDSS9kXdp1IfiRmBi/t
         kpqDpJalEFzyxxu0f0ArUAKsUVggAgDUN9p8rT46mQlP/rJ41DEqi2tK12e8bUTjU9
         hUCIex+JS390PNT80Ryac2vYSt+QGBNepf6IMPJ+vQJe/NQHTeaYA0G/zcR4uJSv9g
         Ntb+B+G04n5uw==
Date:   Thu, 4 Aug 2022 14:33:02 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "chunxu.li" <chunxu.li@mediatek.com>
Cc:     pierre-louis.bossart@linux.intel.com,
        peter.ujfalusi@linux.intel.com, lgirdwood@gmail.com,
        angelogioacchino.delregno@collabora.com, daniel.baluta@nxp.com,
        matthias.bgg@gmail.com, yc.hung@mediatek.com,
        tinghan.shen@mediatek.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, sound-open-firmware@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        project_global_chrome_upstream_group@mediatek.com
Subject: Re: [PATCH 2/2] ASoC: SOF: mediatek: Add .of_machine_select field
 for mt8186
Message-ID: <YuvKjn3cW5im2Yw9@sirena.org.uk>
References: <20220804091359.31449-1-chunxu.li@mediatek.com>
 <20220804091359.31449-3-chunxu.li@mediatek.com>
 <Yuu+elYxBv3xZ1O2@sirena.org.uk>
 <46f972f41a8c1bbfc2bfa42c431308f6b5fe2234.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6kGedXdUenW5S127"
Content-Disposition: inline
In-Reply-To: <46f972f41a8c1bbfc2bfa42c431308f6b5fe2234.camel@mediatek.com>
X-Cookie: Did I say 2?  I lied.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6kGedXdUenW5S127
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 04, 2022 at 09:21:37PM +0800, chunxu.li wrote:
> On Thu, 2022-08-04 at 13:41 +0100, Mark Brown wrote:
> > On Thu, Aug 04, 2022 at 05:13:59PM +0800, Chunxu Li wrote:

> > > +		.board = "mediatek,mt8186",
> > > +		.sof_tplg_filename = "sof-mt8186.tplg",

> > The mediatek,mt8186 compatible looks like a SoC compatible not a
> > board
> > compatible...

> Our dts config as below:
> kingler board:
> compatible = "google,corsola", "google,kingler", "mediatek,mt8186";
> krabby board:
> compatible = "google,corsola", "google,krabby", "mediatek,mt8186";

So the SoC is listed as a fallback for the board and things work out
fine.

> Which of the two approaches do you prefer?

I think it would be clearer to keep what's being matched the same but
rename the .board field to be .compatible, or possibly .system_compatible
or something if it's unclear what's being matched.  That'd be more
normal for specifying a compatible string anyway.

--6kGedXdUenW5S127
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLryo0ACgkQJNaLcl1U
h9AV2wf+P1McXNe47oxC4pSkB6Vp8RnE2YJLp73cxmN6fQR0tXycCwlIB4nTYrWt
C7H/h1k9T+ARv2785fTMpykEQmPUjhdAQW5TXdewWzvoey37H03oE1SkpJrqKsVh
VMDX+njYEvDzi3OL+D/JMxPVCzPQnnk8SwSRo8KUV4yxaLCZ5aJEQ73hXL7kwkYT
EK+KjGM010dcK8X79ZGDBE/0N5UgOWTbWw4WpQH6mNCzAcMhmiCCS48t25W+5fXj
BT05BMe4/RSuo6Q3Oznve6xsfjhPkAC9/bdvDszSagBZDrOuqq0Zt0gh3LayI60O
5LASb2bTbtSyzAys/ISEh1xt+33Tfw==
=AqQy
-----END PGP SIGNATURE-----

--6kGedXdUenW5S127--
