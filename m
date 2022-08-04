Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3583589BC8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 14:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238920AbiHDMlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 08:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbiHDMli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 08:41:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A86E2AE07
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 05:41:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CAF4361758
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 12:41:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F5EC433D7;
        Thu,  4 Aug 2022 12:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659616897;
        bh=Dc8h4lXPsmDxSsos/j+7yqEliVIW1p/oerQvtS7WdCg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GRsuPn65ESqnBp32JRUoDmuH6zGlK8xou9hyDdZflWicz2iUIEMP6HkB5NkWtbe/+
         JWlXBjY7yczQBjyWx6Pft9+ePBzGnA+A68/lMKhv3d5ckL5zq3Yh2S1iS7c7XtH5PL
         rHlc2GZbYX1lsjUNfLqdWFwhHAHZmAJkoZRLev7SKVHlGlfxdesblmNHkxpNURNwMa
         ONnKlZzDU1JOAH8AJms/hZqoi4OvJ8RwxTSgm02gxSyPUGR/MuxFjWVpPvn3N7gEOG
         4kt1RSAYu8ta0fpCR2JXy8G03nMZuzVnuv1LNZRleQv761DhK9hFagSMIBb7kHvxgp
         KOeh8yDsATBRg==
Date:   Thu, 4 Aug 2022 13:41:30 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Chunxu Li <chunxu.li@mediatek.com>
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
Message-ID: <Yuu+elYxBv3xZ1O2@sirena.org.uk>
References: <20220804091359.31449-1-chunxu.li@mediatek.com>
 <20220804091359.31449-3-chunxu.li@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EPdOmWtiZ4ZH+2f9"
Content-Disposition: inline
In-Reply-To: <20220804091359.31449-3-chunxu.li@mediatek.com>
X-Cookie: Did I say 2?  I lied.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EPdOmWtiZ4ZH+2f9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 04, 2022 at 05:13:59PM +0800, Chunxu Li wrote:

> +static struct snd_sof_of_mach sof_mt8186_machs[] = {
> +	{
> +		.board = "mediatek,mt8186",
> +		.sof_tplg_filename = "sof-mt8186.tplg",

The mediatek,mt8186 compatible looks like a SoC compatible not a board
compatible...

--EPdOmWtiZ4ZH+2f9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLrvnoACgkQJNaLcl1U
h9CJ+wf+NC3QV3rzYT893qKD9jkvsm37SLmwNK0cEbtOpP0ohpK2gakhRwXQzh+B
/wS1eGl0aXdtaxOkKueZwXQONVV7MsnuxuGXwyHFrcPwfuVICQPm1vQWwSLmBcS/
iUmtW8SSN++aMZwgYEUAJiFmbMDl5eH/gHTdn9y5dFi+9yQkE2Rw9uieV8eNfrZD
GBhv0YHtv687Q8VOL3FXafwlw5qruOIUYZ6ixEYoalp/rajx1CNxta++q+nse1KV
mDHHEdY4xb84FDeKV/VA8UTHICqp6NYIQgLoRyWkk7n1wPEvSebxTpGJJGoBVabe
RhAhhFa0pZfWYE5UBgEJ9BOpBQCsCw==
=zf1M
-----END PGP SIGNATURE-----

--EPdOmWtiZ4ZH+2f9--
