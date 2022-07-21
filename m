Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6305757CA69
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 14:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbiGUMMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 08:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233544AbiGUMM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 08:12:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE3085D7C;
        Thu, 21 Jul 2022 05:12:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A96161D91;
        Thu, 21 Jul 2022 12:12:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DA86C3411E;
        Thu, 21 Jul 2022 12:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658405544;
        bh=bjLxvlVXamAjASEle08xmCl8qBx04BWEVs5DHeMu8Mw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ns1cEqWMytm09KDRjusjlPxfR1qr267qTII21k/oxK5j4XXiA6BfiZpii70rEUBj1
         +mCEtt83eiFLaUG9g0rpuUn4GhB82MYLJ1WPpWns10eHBLSiEUrhykQuWQTR11ICGi
         4IDZUWNrPIDgRj/Kp2gl4bmvVRzqUpaS2LTw2oZ2ze7xEpSoN59CDBixYSbfBhILJE
         q7amUFr5BW8PvrA6ixfVgHAjUgKEFt8NpCaXeBxfQHadz/DvzIGYxrvV474QB43l9E
         HjtcRtdYD78hXIbO/1lpe37h+fKRUGMGsXB9qmb2RoR2smqtcTSuu9WiSHdF0e7IMF
         Tpf64xF/JT0RQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oEV2W-0003Na-9F; Thu, 21 Jul 2022 14:12:24 +0200
Date:   Thu, 21 Jul 2022 14:12:24 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Mark Brown <broonie@kernel.org>
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
Message-ID: <YtlCqPWUCmw01Jon@hovoldconsulting.com>
References: <1657038556-2231-1-git-send-email-quic_khsieh@quicinc.com>
 <YtkrDcjTGhpaU1e0@hovoldconsulting.com>
 <Ytk2dxEC2n/ffNpD@sirena.org.uk>
 <Ytk+9W0Ur1ibqtw8@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CFA1nl4l5O882w62"
Content-Disposition: inline
In-Reply-To: <Ytk+9W0Ur1ibqtw8@sirena.org.uk>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CFA1nl4l5O882w62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 21, 2022 at 12:56:37PM +0100, Mark Brown wrote:
> On Thu, Jul 21, 2022 at 12:20:31PM +0100, Mark Brown wrote:
>=20
> > You could add a way to specify constant base loads in DT on either a per
> > regulator or per consumer basis.
>=20
> ...and also note that this is only an issue if the system gives
> permission to change the mode in the constraints which is pretty rare.

Yeah, apparently only Qualcomm is using regulator-allow-set-load at the
moment, but it seems pretty common there.

We should probably just drop that from the platforms affected by this
particular regression and perhaps later add it back where it makes
sense (e.g. after making sure all consumers specify a load in some way).

Johan

--CFA1nl4l5O882w62
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQHbPq+cpGvN/peuzMLxc3C7H1lCAUCYtlCpAAKCRALxc3C7H1l
CH3VAP0UC9lDdd/fIlxYLQa+xUSFqHJHrap+vbhZ0Co4s/SlkgD+JXqNWLFDmtEF
29yeuk3k7WUrvkX9OIjphqSsYKFRzwo=
=+ChT
-----END PGP SIGNATURE-----

--CFA1nl4l5O882w62--
