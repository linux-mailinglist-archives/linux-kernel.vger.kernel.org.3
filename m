Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E3757CA1B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 13:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233299AbiGUL4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 07:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiGUL4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 07:56:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC58D10B1;
        Thu, 21 Jul 2022 04:56:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8C385B8243D;
        Thu, 21 Jul 2022 11:56:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6C87C3411E;
        Thu, 21 Jul 2022 11:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658404605;
        bh=bQi+xZq9b9DToWtN6MtK9Eyx2oVXPsN/YNsJApzwPXk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r9NvCZHAHtXI5zVzVvnKkmsqZVsKfhdPIPnASOgzTo7PexDO/+J6R0Cytrc4sHc1F
         lOiUzAoTX5qkasHi55O3pWUVejl39Zg+ZHpkU4rDhA9ITfR0cIRWtYRyEMyAF+JBrS
         0OQlVDCeR6Lii1osz8YYTMQUtV9IzocfTMk0t/4XcLkJvmbq6HDshTtaoP5SbeW7jC
         R4hm+Ne4pCCTkQspJ7avyF2QtKCiLCLhZI5C2nTCjcGoEPQs9HxbK79b8R159hnyuH
         O5x4+tyGI4U6RyzRFUydhUdDuJ2B+6oH76X6ospfT/MdnY4Giwv3PpN8t9RAIU0kTT
         e3hgDYESt60PQ==
Date:   Thu, 21 Jul 2022 12:56:37 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, dri-devel@lists.freedesktop.org,
        robdclark@gmail.com, sean@poorly.run, swboyd@chromium.org,
        daniel@ffwll.ch, airlied@linux.ie, agross@kernel.org,
        dmitry.baryshkov@linaro.org, quic_abhinavk@quicinc.com,
        quic_aravindh@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v16 0/3] eDP/DP Phy vdda realted function
Message-ID: <Ytk+9W0Ur1ibqtw8@sirena.org.uk>
References: <1657038556-2231-1-git-send-email-quic_khsieh@quicinc.com>
 <YtkrDcjTGhpaU1e0@hovoldconsulting.com>
 <Ytk2dxEC2n/ffNpD@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9EvVpXRtaCTHvahb"
Content-Disposition: inline
In-Reply-To: <Ytk2dxEC2n/ffNpD@sirena.org.uk>
X-Cookie: Killing turkeys causes winter.
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9EvVpXRtaCTHvahb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 21, 2022 at 12:20:31PM +0100, Mark Brown wrote:

> You could add a way to specify constant base loads in DT on either a per
> regulator or per consumer basis.

...and also note that this is only an issue if the system gives
permission to change the mode in the constraints which is pretty rare.

--9EvVpXRtaCTHvahb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLZPvQACgkQJNaLcl1U
h9C4Swf9EuzQYYxQIE3HdaloWAtNQHqp+O9hc6A5uGIlqvQ0+1hCyKTNm/0LdZTB
a2quGYwotizns28XjF1CPNAa80hvUgC2z4eyze8DKnSBm8LVAOcSkhI25xY+rwyn
V43nJzwu8lvtoSb/imoh28i22Zw26qMB4equfXXQtysXS3jyGy8uVEyqBbuNTx/f
WFnEh2yYmdz6HlIFGfXLtV6eWFi6rf8pLpzg1h3JV1nKvW3SKmJ4U4G/FnfqvNZ4
h8DE4YK2Vzy3VadPRNwuSAZYwl+RXXlVSoQbQZbdD4itSVcdt62rm/hdZ6727nMn
wAihahnCrAecenK9FFwbCTZO+0LMYQ==
=i7fU
-----END PGP SIGNATURE-----

--9EvVpXRtaCTHvahb--
