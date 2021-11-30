Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44044462A2B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 03:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237292AbhK3CI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 21:08:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbhK3CI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 21:08:58 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07E5C061574;
        Mon, 29 Nov 2021 18:05:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3FCCDCE16EA;
        Tue, 30 Nov 2021 02:05:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D0FC53FC7;
        Tue, 30 Nov 2021 02:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638237936;
        bh=MjWwVT64eoyCbc1/O2psCx9reohaUCeSTRbK/whaPFE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=NYrBBQhpMMwiGnPokNzFZCGoDmDnHwv+FYxImN45IzOuDdZsBvwlKblFIoz2rvmcs
         C5togcT5j0Try0e6ySJyYrAOmfCYLZMQ2lCNQup9d/NSAd/tEDlRh9BEplyvTB/y8/
         K+GCFEwrvkBh81WqK/H/eQZZhOpSryQkKQuM1QUCJY9gxzqY113wHZoZV7ooukQnZX
         kJpY45Bd2C4Fub0PtXeOd/0zruuGn+bPzHKX28VIXN7ND1Itiko/P9MfFiGECzH3qU
         RWJvklvamIp+LzM5EOqrL35nhLoEWBU1Qzv2DGHqpSTZG+86qCIQwpRKyX/Lw93cC/
         5adJmRhGlRSTg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211114012755.112226-4-konrad.dybcio@somainline.org>
References: <20211114012755.112226-1-konrad.dybcio@somainline.org> <20211114012755.112226-4-konrad.dybcio@somainline.org>
Subject: Re: [PATCH 04/16] arm64: dts: qcom: sm8350: Specify clock-frequency for arch timer
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Date:   Mon, 29 Nov 2021 18:05:34 -0800
User-Agent: alot/0.9.1
Message-Id: <20211130020536.52D0FC53FC7@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Konrad Dybcio (2021-11-13 17:27:43)
> Arch timer runs at 19.2 MHz. Specify the rate in the timer node.
>=20
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8350.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/q=
com/sm8350.dtsi
> index a30ba3193d84..60866a20a55c 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> @@ -2484,5 +2484,6 @@ timer {
>                              <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TY=
PE_LEVEL_LOW)>,
>                              <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TY=
PE_LEVEL_LOW)>,
>                              <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TY=
PE_LEVEL_LOW)>;
> +               clock-frequency =3D <19200000>;

Does the firmware not set the frequency properly?
