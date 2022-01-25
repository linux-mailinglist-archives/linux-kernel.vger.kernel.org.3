Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A32249BD6A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 21:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbiAYUtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 15:49:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232548AbiAYUrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 15:47:32 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83432C06173B;
        Tue, 25 Jan 2022 12:47:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A574CCE1AF4;
        Tue, 25 Jan 2022 20:47:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3BC8C340E0;
        Tue, 25 Jan 2022 20:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643143647;
        bh=TFP+Nwp2VUBNr5Rylu8CpOFhr+/jZWdTynrxeXjFIPE=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=tPWiiWhwi3p8a/rAjJ2RUy8Vv9+6BQZ0Ym3wl77eBcFNILp70JnxTBJK+ixcYSpyF
         HzymCwBUs21yZuGCyGFHSay6hrd5UqnxhYE1atEclqSiB2s4otjlRr3RxFxKl4hKET
         aYFDmFwA1xAXcIaLJPWaBeiFu8fQytkr32e9Bjx8IEsZjB91xK1aN0pG3apdkeaR/y
         LDmPg3fQ5Xzs4glyfhI5xON/XY7N4enhSt7WBeO/ljB5EhSzTXbjAb3zbzis76WI6E
         To0QoQFoEXZnNxpxJMT2CKl6kyYRMYlWUqd+ajt9U3vAcRVBNE2ksdmjxLlNNUoKoZ
         luPrbWieViKrw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220121210340.32362-12-ansuelsmth@gmail.com>
References: <20220121210340.32362-1-ansuelsmth@gmail.com> <20220121210340.32362-12-ansuelsmth@gmail.com>
Subject: Re: [PATCH v3 11/15] dt-bindings: clock: add ipq8064 ce5 clk define
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
Date:   Tue, 25 Jan 2022 12:47:26 -0800
User-Agent: alot/0.10
Message-Id: <20220125204727.D3BC8C340E0@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ansuel Smith (2022-01-21 13:03:36)
> Add ipq8064 ce5 clk define needed for CryptoEngine in gcc driver.
>=20
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  include/dt-bindings/clock/qcom,gcc-ipq806x.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/dt-bindings/clock/qcom,gcc-ipq806x.h b/include/dt-bi=
ndings/clock/qcom,gcc-ipq806x.h
> index 7deec14a6dee..02262d2ac899 100644
> --- a/include/dt-bindings/clock/qcom,gcc-ipq806x.h
> +++ b/include/dt-bindings/clock/qcom,gcc-ipq806x.h
> @@ -240,7 +240,7 @@
>  #define PLL14                                  232
>  #define PLL14_VOTE                             233
>  #define PLL18                                  234
> -#define CE5_SRC                                        235
> +#define CE5_A_CLK                              235

Technically this is ABI and changing it is bad. I see that CE5_SRC isn't
used though so I guess it's OK.

>  #define CE5_H_CLK                              236
>  #define CE5_CORE_CLK                           237
>  #define CE3_SLEEP_CLK                          238
> @@ -283,5 +283,8 @@
>  #define EBI2_AON_CLK                           281
>  #define NSSTCM_CLK_SRC                         282
>  #define NSSTCM_CLK                             283
> +#define CE5_A_CLK_SRC                          285
> +#define CE5_H_CLK_SRC                          286
> +#define CE5_CORE_CLK_SRC                       287
