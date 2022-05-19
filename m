Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2741252C848
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 02:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbiESACt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 20:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbiESACq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 20:02:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E882B4BE;
        Wed, 18 May 2022 17:02:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37ABD6177F;
        Thu, 19 May 2022 00:02:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F87C385A9;
        Thu, 19 May 2022 00:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652918564;
        bh=yitfK/3kua0WBhTTRp7TVdCoOUJjFApZa1qfRybAxN8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=XInV3sP++2LWAQu5jk0rdxF5i+DmgsdYuU1AOtHrRpLL8zX0z8MJ6rabYACKBPprh
         Em11oud9BCqOszN7CQiJfbrFavu//LdzHbZ0NaxVCTYGHRtftBV0vyoiKKoX+7xQKv
         4MXXaA03mWj9i6k6b/Bejmsmvl6G+qSpD/oK8nq7P8IM+QZdZ9iHjx5j6UyCCMfmSO
         BGDgn5rBFvre2n/BxxovvyRQe1y7Xap4n7ZF3MBAJsTX1BPdjQiy/DIV/zXycwLKaf
         N67PEDvil5VB+UAdqujz9LPKuiPvDJoYTEn9/BrVsiUgJqr3AWZ+ITXPJx4JAiZanu
         PUJ/B8GTZ1twg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220501103520.111561-1-krzysztof.kozlowski@linaro.org>
References: <20220501103520.111561-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/8] clk: qcom: alpha-pll: correct kerneldoc
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
Date:   Wed, 18 May 2022 17:02:42 -0700
User-Agent: alot/0.10
Message-Id: <20220519000244.84F87C385A9@smtp.kernel.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krzysztof Kozlowski (2022-05-01 03:35:13)
> diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alph=
a-pll.c
> index 4406cf609aae..969d98fca5df 100644
> --- a/drivers/clk/qcom/clk-alpha-pll.c
> +++ b/drivers/clk/qcom/clk-alpha-pll.c
> @@ -1439,7 +1439,7 @@ const struct clk_ops clk_alpha_pll_postdiv_fabia_op=
s =3D {
>  EXPORT_SYMBOL_GPL(clk_alpha_pll_postdiv_fabia_ops);
> =20
>  /**
> - * clk_lucid_pll_configure - configure the lucid pll
> + * clk_trion_pll_configure - configure the lucid pll

configure the trion pll?

>   *
>   * @pll: clk alpha pll
>   * @regmap: register map
