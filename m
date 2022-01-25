Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2094E49BD62
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 21:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbiAYUp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 15:45:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbiAYUp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 15:45:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5602BC06173B;
        Tue, 25 Jan 2022 12:45:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F2F56B81AC6;
        Tue, 25 Jan 2022 20:45:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91DB4C340E0;
        Tue, 25 Jan 2022 20:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643143555;
        bh=GrIQi0bv9lykmB4UzeR7Qnu8XC6OdARITlu/yReOLLE=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=WA71G37HOOyAxASGGBJqlQrYA/cYfG8e8NqETQCgIJt6p2xS6EwEyqqyLdvaHF+v9
         lbX38DStxwJvDO6x9DsmNAw5kxxKGCsQU5X1hfBEiT06yRMf/VtQzEOWrnmDJMyLlI
         4qcOU5HtSOARUkvC2Grf/D8L2wm/4tm+UXpRMFrH2v2dToMM0DrEcVyXYoXVKC1Wwv
         GTAF6f4RLP0NdWm21xsRm/GDGB8QWtmEF1HxQzK+3/g47Qu9fhREXkUjTGR2KvXgsO
         +VcMeDd19z2bwj5MWI+6rsdf6HrLsjkibWYL2lx9y2ulMFOGQLQO7Gx8vmeDE27/73
         EP77OuizuJ6UA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220121210340.32362-11-ansuelsmth@gmail.com>
References: <20220121210340.32362-1-ansuelsmth@gmail.com> <20220121210340.32362-11-ansuelsmth@gmail.com>
Subject: Re: [PATCH v3 10/15] drivers: clk: qcom: gcc-ipq806x: add additional freq for sdc table
From:   Stephen Boyd <sboyd@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Taniya Das <tdas@codeaurora.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 25 Jan 2022 12:45:53 -0800
User-Agent: alot/0.10
Message-Id: <20220125204555.91DB4C340E0@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ansuel Smith (2022-01-21 13:03:35)
> Add additional freq supported for the sdc table.
>=20
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  drivers/clk/qcom/gcc-ipq806x.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ipq806=
x.c
> index 77bc3d94f580..dbd61e4844b0 100644
> --- a/drivers/clk/qcom/gcc-ipq806x.c
> +++ b/drivers/clk/qcom/gcc-ipq806x.c
> @@ -1292,6 +1292,7 @@ static const struct freq_tbl clk_tbl_sdc[] =3D {
>         {  20210000, P_PLL8,  1, 1,  19 },
>         {  24000000, P_PLL8,  4, 1,   4 },
>         {  48000000, P_PLL8,  4, 1,   2 },
> +       {  52000000, P_PLL8,  1, 2,  15 }, /* 51.2 Mhz */

Why the comment and fake rate? Can it be 51200000 instead and drop the
comment?
