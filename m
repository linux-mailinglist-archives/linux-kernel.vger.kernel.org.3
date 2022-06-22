Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9E2554A4C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346332AbiFVMq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 08:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343770AbiFVMq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 08:46:56 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088B43526C;
        Wed, 22 Jun 2022 05:46:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6D297CE1FA1;
        Wed, 22 Jun 2022 12:46:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C52CC34114;
        Wed, 22 Jun 2022 12:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655902012;
        bh=/JpW+MAHG6QANCQr3Dhf2Dft36ErEiGWlnr8flDHyx4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UXKN57sGJH8mvMvKBd9DwnAWiSGlnl3txMLFktjIqifSztLXkACZQk3EW0IXqVRIe
         2KnTRFlA1ZO9z8bMCU1Q6E2lIQrDHBb4ejyk/l4lxy0DoAGHDz0YJSgG+pG406CQS8
         a8T/Ci1ODscDlnjiMkSDCONDCjYyWf4z4AiiUUU0eaZAqL2EVeV33dD0COgsAI4YUg
         YMIr25VPmVPA7uikrS0LRAgRwss5XUZDD2np98dJlNOI8tXE4Yn/sBnd1dEmCrfbL4
         fV512pxos0Crfdq8aLqCz5A6qLhkUBEISIVmHpYxBQJyq63aBvYjEXmgHtdk+ozF7q
         ifjVTHNRDE2QA==
Date:   Wed, 22 Jun 2022 13:46:46 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        robh+dt@kernel.org, quic_plai@quicinc.com, bgoswami@quicinc.com,
        perex@perex.cz, tiwai@suse.com, srinivas.kandagatla@linaro.org,
        quic_rohkumar@quicinc.com, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] ASoC: google: dt-bindings: Update
 sc7280-audioreach-herobrine compatible name
Message-ID: <YrMPNpE+RWIZP372@sirena.org.uk>
References: <1655892799-29641-1-git-send-email-quic_srivasam@quicinc.com>
 <1655892799-29641-2-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vKK8oBS2+ubOpulY"
Content-Disposition: inline
In-Reply-To: <1655892799-29641-2-git-send-email-quic_srivasam@quicinc.com>
X-Cookie: Truckers welcome.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vKK8oBS2+ubOpulY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 22, 2022 at 03:43:18PM +0530, Srinivasa Rao Mandadapu wrote:
> Update audioreach based compatible string for sc7280 based ADSP enabled
> platforms.

>    compatible:
>      enum:
>        - google,sc7280-herobrine
> +      - google,sc7280-audioreach-herobrine

Isn't the DSP firmware selection a purely software one?

--vKK8oBS2+ubOpulY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKzDzUACgkQJNaLcl1U
h9Cq9Qf/XODQj9ijI4XCvV7JMPgGqnBmpV961ywot0AgWRVTxh+vn1mYXulQq/YU
/NJgVpeyp/+JHvSX7IRr+HpbmaSWp9Yu+GfroD8P47PyceQ+7TEHU4CM7QdxeOAU
bBonT5ukV9nRtaREKW4nKjhTdzGkSa84o3k2zMVUB+1S02LyilDEpQNQ7SrYrJeQ
zIuArN368oSuNYKelxjViqp0knxVQ40YBo8ib6Z749YCtBZCGYDJXUvur722XJ/t
VQPqMf00GufWgH1esQVoVUOJmO9S9WsmO/zj9SHXHFvGMF3BPj9fpy1YVeS1a4vr
cZpjmtLdGdzCiim7L0OmcyB6Ky4jRg==
=wlSz
-----END PGP SIGNATURE-----

--vKK8oBS2+ubOpulY--
