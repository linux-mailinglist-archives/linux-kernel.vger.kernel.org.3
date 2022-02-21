Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550B84BE489
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379311AbiBUPjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 10:39:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344377AbiBUPjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 10:39:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5C8BF61
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 07:38:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 244BDB8121C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 15:38:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7248C340E9;
        Mon, 21 Feb 2022 15:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645457919;
        bh=vyhH6QDK2y/VOZf+VqbC/i41rAHGmnbQYzgPlCQvsDI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XufoZflCAf1o8fUH6RfrzWS6ni5BE4oZundMspjLGkd/3bvV0u6Rt1e7l3TMr2q1E
         egfaabk1izjL0TyBrLHFbHrvn40h/XWWIqlAHsBn6n7Vgfr2jnP75lOinHGkQo60Zi
         ScaxlQD0hqkp+MzHQkoVKM3Xk6qjo6AXMB1oqZcNMA7t2sx9HhB+FCd4pcC06rAH80
         neaVYCycYMsx+Ab/tu2uUXUATVZglWuSRE67bKE0M+ZttAxkRoUNzMc8mLl/DqgSfe
         mA6AnMXK2gCI8ehzf1kPCMQpo3CVLoCUUslOu4uZuKS63xqyC51FYgba2JrqPNbHk8
         fFYAh6RX976Sw==
Date:   Mon, 21 Feb 2022 15:38:34 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com
Subject: Re: [PATCH 09/10] ASoC: codecs: tx-macro: setup soundwire clks
 correctly
Message-ID: <YhOx+nQ/G+HNRXbq@sirena.org.uk>
References: <20220221131037.8809-1-srinivas.kandagatla@linaro.org>
 <20220221131037.8809-10-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yyHhfwr2MmYyQ0yO"
Content-Disposition: inline
In-Reply-To: <20220221131037.8809-10-srinivas.kandagatla@linaro.org>
X-Cookie: I smell a wumpus.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yyHhfwr2MmYyQ0yO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 21, 2022 at 01:10:36PM +0000, Srinivas Kandagatla wrote:
> For SoundWire Frame sync to be generated correctly we need both MCLK
> and MCLKx2 (npl). Without pm runtime enabled these two clocks will remain=
 on,
> however after adding pm runtime support its possible that NPl clock could=
 be
> turned off even when SoundWire controller is active.
>=20
> Fix this by enabling mclk and npl clk when SoundWire clks are enabled.

A lot of these commit messages sound like earlier patches in the series
introduced bugs which isn't going to be ideal for bisection.

--yyHhfwr2MmYyQ0yO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmITsfoACgkQJNaLcl1U
h9CGBwf/Rk/9rLx89vaRjZ9CYWDcfqgqNBJE0kJcU2Dk9g4BnJDHXJR8UxTFFWm7
/6y50AXt6mAVMDoMj50Fv/L44E4GNu99KaUv0Honb0wd+9t4r81nNiJsZhGNL7E6
C1DVpyc9HPICqqXUDX5KByX+UzIh5ddieRvpiB9HVRX90dOrVAy4XND78sTw7UV+
3MUTyENBPgSCX6UiQnuAnZhvQX/5gNbhkedrk7gZ/akArzUL0IIMqO02/Yu/ngPi
jk4f0SKxs+qXIBVDscyvfQZbFeidScPG9ytCsXDJTPB2JvGzlyzQKjg/PJk9iJ51
EiJiSTGuW7Mn1PBPgvtd76jppvkKvg==
=K0xZ
-----END PGP SIGNATURE-----

--yyHhfwr2MmYyQ0yO--
