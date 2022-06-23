Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741BA5578EA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 13:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbiFWLpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 07:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbiFWLpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 07:45:17 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAEF4CD43
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 04:45:17 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id v6so3918980qkh.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 04:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YRiMFknIosk7rzc3FACzC8i3+BE+kw7LbKBj/XF0BiA=;
        b=el/gpLoFkmjQMFb+n5tfsNyJZsnuaZISi5iUTVxKQu1KCODSOBgPxey4akKrwM5Odj
         Y73S+/Xk1ZfiAcWDjHdLq51Nlf6LREV70byKAVFjxzQuBr4js8HDQlu0+mfr0kjJ1PPl
         TsKXp5SnT/8pG3qH+gEEMBXdJoZdgmrYrqsp7TFzuTKz/glMoWyGODdjuchGSBs5/j4E
         RDTMjo7xnbLFKWGKAXlFuVEE71j/W3TEktUCuxFsp/vJk3mLIoSFV6yItAn+m0iAEG9a
         TrF5ZK2Wi/8vWDCyiX5vpivedlt7M+wkVB7WYGJTx8vI/b/ynV02CFjXjMJXA1EBhPmc
         lxRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YRiMFknIosk7rzc3FACzC8i3+BE+kw7LbKBj/XF0BiA=;
        b=ZKFiu/pHyotU4p2LjyQ1AuPAUE2xq9EkYLw3lU9iczLnsoK5ri7RTm/Hg1NpOEa99w
         VnvJd060SMN6ZvL3IA2Je1kEVzF3moPWazGLKia7j2kieLBUQJ2ZOZz/ZStcz/Wjf+Z0
         MFJxzTILfwlnS8gcK5pFEOS1PrqKwFu/agSKwGUpGAAfta4tBbVCa0HN0I+adBWKTM6P
         a2Y4JYTEIT90+WDQIkEiMlemKBuoz0m0i4oLWg966QGzxeOi+m9MxHD5DrE5HLSmiZHu
         uEk/E563qZ1AABVM7b6r797Nks47b1phMAH646V9iIxqh2YQcWnRXoqSvdyvYIrvvaOW
         338w==
X-Gm-Message-State: AJIora/mnWC8RVRD3ZOpph3zILzvCXKy83CAkgOH2wa9mlaGAPtoIIKH
        EC2OMQWOX0iO3/vTAov+syPaaXyRXfvPV3iorczqWl/s9x7Aw+SK
X-Google-Smtp-Source: AGRyM1uNhkwV7YKwEBnt0+jA8ukX9HYxfgdPreFB+ew9E+uDqJwgxZLpklUoZOZBCem94Jw61TCl5xPv+/YYYMUYNc4=
X-Received: by 2002:a05:620a:4305:b0:6a9:3829:c03 with SMTP id
 u5-20020a05620a430500b006a938290c03mr5786648qko.363.1655984716194; Thu, 23
 Jun 2022 04:45:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220623113314.29761-1-johan+linaro@kernel.org> <20220623113314.29761-3-johan+linaro@kernel.org>
In-Reply-To: <20220623113314.29761-3-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 23 Jun 2022 14:45:05 +0300
Message-ID: <CAA8EJpp6aeZvkkQx1Fep_09QcPB0i3Tq8J6x-d4jw5-=Fg7FjQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] phy: qcom-qmp-pcie-msm8996: drop obsolete pipe clock
 type check
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jun 2022 at 14:33, Johan Hovold <johan+linaro@kernel.org> wrote:
>
> Drop the obsolete pipe clock handling which was used to treat the pipe
> clock as optional for types other than PCIe and USB and which is no
> longer needed since splitting the PHY driver.
>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  .../phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c  | 19 ++-----------------
>  1 file changed, 2 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
> index 48ea1de81d7c..812d14afb5ec 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
> @@ -904,26 +904,11 @@ int qcom_qmp_phy_pcie_msm8996_create(struct device *dev, struct device_node *np,
>         if (!qphy->pcs_misc)
>                 dev_vdbg(dev, "PHY pcs_misc-reg not used\n");
>
> -       /*
> -        * Get PHY's Pipe clock, if any. USB3 and PCIe are PIPE3
> -        * based phys, so they essentially have pipe clock. So,
> -        * we return error in case phy is USB3 or PIPE type.
> -        * Otherwise, we initialize pipe clock to NULL for
> -        * all phys that don't need this.
> -        */
>         snprintf(prop_name, sizeof(prop_name), "pipe%d", id);
>         qphy->pipe_clk = devm_get_clk_from_child(dev, np, prop_name);
>         if (IS_ERR(qphy->pipe_clk)) {
> -               if (cfg->type == PHY_TYPE_PCIE ||
> -                   cfg->type == PHY_TYPE_USB3) {
> -                       ret = PTR_ERR(qphy->pipe_clk);
> -                       if (ret != -EPROBE_DEFER)
> -                               dev_err(dev,
> -                                       "failed to get lane%d pipe_clk, %d\n",
> -                                       id, ret);
> -                       return ret;
> -               }
> -               qphy->pipe_clk = NULL;
> +               return dev_err_probe(dev, PTR_ERR(qphy->pipe_clk),
> +                                    "failed to get lane%d pipe clock\n", id);
>         }

Same comment. Please remove brackets. With that fixed:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

>
>         /* Get lane reset, if any */
> --
> 2.35.1
>


-- 
With best wishes
Dmitry
