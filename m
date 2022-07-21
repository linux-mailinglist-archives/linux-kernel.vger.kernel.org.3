Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271C657D139
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 18:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233932AbiGUQRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 12:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233886AbiGUQQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 12:16:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B108AEE5;
        Thu, 21 Jul 2022 09:15:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C7068B825B5;
        Thu, 21 Jul 2022 16:15:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEA70C3411E;
        Thu, 21 Jul 2022 16:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658420143;
        bh=aKwoXurJ8ulRwPNPOsnWs3xQ4UsvWh88KPItgK8MMuM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=npMkh7m8Oh15DP+rI1DqB9B6lnCWY4QLz0BSHjNzOUiW5cjyCaXHRlEd8Fh9rBVSI
         1J0z4KZBzuDLMtao4Zd3EvoxDszjxkXRiyUK2qW9zw3cG1FqkcC83CcPiL3+VHviGo
         JrFc11zQ+/gZvn+MKNiFpS9U3yVv9ykaSJPFhrjWewCu1Lw93RPgc/yqCtCM+3OzeH
         o4Fpa4nBuq+QoWT6YDkuYYVdlxElEFfhZorA8Ov3DMZJp0/6SKohfmb/jCZb4jyhfd
         JI7KbshgSKgvg2iGH3aBr2HmLKbCpiqBRLWXkUcy3+B+onZ51F8TkUkq0v2/tW6CNw
         7VWqVoa93Elmw==
Date:   Thu, 21 Jul 2022 17:15:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Johan Hovold <johan@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        "Abhinav Kumar (QUIC)" <quic_abhinavk@quicinc.com>,
        "Aravind Venkateswaran (QUIC)" <quic_aravindh@quicinc.com>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v16 0/3] eDP/DP Phy vdda realted function
Message-ID: <Ytl7p1UHidn2yHfv@sirena.org.uk>
References: <1657038556-2231-1-git-send-email-quic_khsieh@quicinc.com>
 <YtkrDcjTGhpaU1e0@hovoldconsulting.com>
 <Ytk2dxEC2n/ffNpD@sirena.org.uk>
 <CAD=FV=UQGXqVkew544f3RDtWb3virRHWiafBAxK3ncb5wmVYwQ@mail.gmail.com>
 <CAD=FV=WuyKAwLwJ80uv15jBPO=W9F7FGZ4dAci+CncwF0WPfOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bUeDuiEk6fcD6K16"
Content-Disposition: inline
In-Reply-To: <CAD=FV=WuyKAwLwJ80uv15jBPO=W9F7FGZ4dAci+CncwF0WPfOw@mail.gmail.com>
X-Cookie: Exercise caution in your daily affairs.
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bUeDuiEk6fcD6K16
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 21, 2022 at 07:52:01AM -0700, Doug Anderson wrote:
> On Thu, Jul 21, 2022 at 7:39 AM Doug Anderson <dianders@chromium.org> wro=
te:

> > vdda-phy-supply =3D <&vdda_mipi_dsi0_1p2>;
> > vdda-phy-supply-base-load =3D <21800>;

> Ah, sorry to respond to my own thread so quickly, but I just thought
> of a reason for the "matching properties" solution instead of the two
> cells. It would allow the SoC "dtsi" file to specify a base load while
> the board "dts" file can then specify the supply. That feels like it
> could be a nice solution.

For a per device thing it probably shouldn't be called a "base load",
it's just the load.  I would question how useful this would be, aside
=66rom the concerns vendors will likely have with disclosing actual power
consumptions if the number never changes then it is immaterial which
device contributes which milliamp of load, you just want to configure a
fixed mode on the regulator and have done with it.

--bUeDuiEk6fcD6K16
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLZe6YACgkQJNaLcl1U
h9BkCwf/ZX/ZcVyHzQF89Ws5jgAkSI71g6b+vTVGymg8Q8k62rRqUk7v8t+c6EyS
IbyN2L5dNL+Fs7+aJvGJi9EhHaVxsErDeSKYqEKGnq/RJG0oHdt5lYMPoHOddnZU
c4h8YZoVsFQqKbXwogmK01nG/OVYYID52ALzV6j04F+xAazbjwY5ftLOFcsplQ1z
yqy6qiD5dnu6kYWNS6RgVhCIeY4WaRulldCHqrHz9DV549sxsv/0cDrT19ZpcZkp
HkwgeFUhCd/xRDuhiZp+XTHwgg2AC8txVpqggzA2kXgNVmxzN8rcFLjYVtoOglMz
PWh0O6ZDoxu0TIGGjCudo2nCbYnIdQ==
=Lepm
-----END PGP SIGNATURE-----

--bUeDuiEk6fcD6K16--
