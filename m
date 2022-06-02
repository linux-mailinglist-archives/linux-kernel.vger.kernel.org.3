Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE2553BB1A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 16:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235508AbiFBOlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 10:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236235AbiFBOkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 10:40:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A70289A04;
        Thu,  2 Jun 2022 07:40:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E4F6BB81F75;
        Thu,  2 Jun 2022 14:40:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43372C385A5;
        Thu,  2 Jun 2022 14:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654180831;
        bh=iBt0yGuyvumHUwyuQr18kXniXAo9MJXH2585H5hKla8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KnA3YFQ7j8yovXKqZZHf98aMqPQXaKbrNvbDtD3Hh4yQcCCWr8B+DPoIiBBRvY4Xx
         QoXt4d5YFEu9rjuO7QTIhIl5mFCEg8DOn5a7RVbzn9+pmE7yzQ6EayZMg0FkLr8BtF
         vU65OU1eBFDiG6rWtaoAz+m61R2r2ciCb1o+ZUSBLZ0wtY2iwdvX2h5h8q6trmxmFf
         EDtMTstKRcHBR3wdbP6CD39z4Jbq4hwrO+64Dcdb48XGkBrCTgdSSWmuSizUhKV7uz
         boNKhT0KgtI8V1SLapZX7sXJSWX77PbYJtAIIIy45LAJPMgLhrfbwhuZVUkywmo7kE
         dFu0Y9Zo0WkAQ==
Date:   Thu, 2 Jun 2022 16:40:29 +0200
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        quic_plai@quicinc.com, bgoswami@quicinc.com, perex@perex.cz,
        tiwai@suse.com, srinivas.kandagatla@linaro.org,
        quic_rohkumar@quicinc.com, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: lpass-cpu: Update external mclck0
 name
Message-ID: <YpjL3X73LyefYjI7@sirena.org.uk>
References: <1654169206-12255-1-git-send-email-quic_srivasam@quicinc.com>
 <1654169206-12255-2-git-send-email-quic_srivasam@quicinc.com>
 <20220602143245.GA2256965-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0ZilQwiK5vRHCj/y"
Content-Disposition: inline
In-Reply-To: <20220602143245.GA2256965-robh@kernel.org>
X-Cookie: May your camel be as swift as the wind.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0ZilQwiK5vRHCj/y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 02, 2022 at 09:32:45AM -0500, Rob Herring wrote:
> On Thu, Jun 02, 2022 at 04:56:45PM +0530, Srinivasa Rao Mandadapu wrote:
> > Update "audio_cc_ext_mclk0" name to "core_cc_ext_mclk0",
> > as MI2S mclk is being used is from lpass core cc.

> This is safe to change breaking the ABI because ...

The driver was only just merged so didn't make it into a full
release.

> Names are supposed to be local to the module, not based on their source.=
=20

Indeed.

--0ZilQwiK5vRHCj/y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKYy9wACgkQJNaLcl1U
h9Dudwf/ZQG4R79+Icg0Uh1Cmk3yjzWw6xvBIZLjQDaXBBCdISJ8tvELqQM8GFVj
IpFpKAnDC6ATOXTY+M8YK3D9Mf76ehf74T2VZt3ePnDjtmSHGWoZkvpKg1SkDtxe
8Oo7jo4nhx4Rb1ObaORZECl5InigJp29ywUhEQ9O1l4RKWYMyuW+LTsTB7ODxw9n
kI9tZkFFZNk8ZRgVqXoN/wYirD2NFkOYmt6vv8hP+tN2e1pLm2Du2yO+Tzzlw3Z1
6PJqCjVbDhxj4XtK5zDbk85DS3+6JMKKGwf+vUhkgN6JGsPR9OGT6F1UJ7zNjDYy
+Nsj7dBqnpYjZOUkWCbTW8wSbWFknQ==
=/oaJ
-----END PGP SIGNATURE-----

--0ZilQwiK5vRHCj/y--
