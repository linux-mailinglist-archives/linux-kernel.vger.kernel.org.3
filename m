Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5AF5578E7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 13:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbiFWLon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 07:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbiFWLom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 07:44:42 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B315A4CD56
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 04:44:40 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id c1so29103027qvi.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 04:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bRssUP7Qyiwf2B6rtjrdjEQfEg9fVJc6BLmXnQSQ1d8=;
        b=tg2iriwD73aWHHozE/1hw6S3dvsiQDqyw192D5Uvb3tVOls78V+XRUKdGY7zQ6ovt3
         ro1nSlvQsaYm4YHVoRPrhLNT52gkOEcGzlLe99Wf58ZnqSo/UDYwtsthVT5ebHJAyzjf
         +aSuUCxWCMhD1ngemCBQHDS0mWNsxV5qOVyQvHmKoJzcToeKN10el5UgoHzJlHG4yJ5K
         uou8rp/+OMuN3itLAm+lBHhFl93sR84kL7pn4mz/RMKnQ9hNIm+npyQIorOygR89Ot1B
         OuV5pCH56Y1OOVTqZQsXGJnBhi6IkJ/g3ZkpZFeSPBealzsXy5VQCYRFBjXqkrfXh38D
         WrGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bRssUP7Qyiwf2B6rtjrdjEQfEg9fVJc6BLmXnQSQ1d8=;
        b=UQX//OJ8vpHTCRu4tJ8CBRnTMKusAk5+XcimPn2r5WSs9hqIbpXLe7OfA3qTn/kpFe
         4vWOKJG2ZhzOBbBU7ee/X780OrJYUrJxYSLHfcsXyfsGSrCZJ/40ykuept5H+ElVRQrd
         KIpapU6oWmItMFE0g53d+fp9KIjMoR4Ppf4i5QC3BXdNeOSzdBcP3RHwYHaw2Sp9P1US
         jASeV11pTT5CX9y5qcA1GBix+memOa04sjexjdZt9CJMT1LMePCm+/rHjJdMI+iyznkB
         14GDFL7++YUCPN76vj96xCWZFDH0DLzWBwzOcI8Nd5isp9j4f7qJZNpQoAI/4NtSEhiq
         D04g==
X-Gm-Message-State: AJIora+EOpvPKKy9deUAqf+wqL6EouFCTkNaVF+vQQkp7B16CdooU8TJ
        N/yjcyrZBWe2IGZNdp82e6C4dqnfuYnrwiG0sX3EDrznS3I2CQ==
X-Google-Smtp-Source: AGRyM1uEAyvgAhj12Q7Pch8RZuPkQJtMdlm3nJy5abbVrrUtoijAls3SkgTnnDYwAyImRkngkIUcp661/l68sOJV6FE=
X-Received: by 2002:ac8:7e87:0:b0:306:6575:6035 with SMTP id
 w7-20020ac87e87000000b0030665756035mr7539261qtj.629.1655984679871; Thu, 23
 Jun 2022 04:44:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220623113314.29761-1-johan+linaro@kernel.org> <20220623113314.29761-2-johan+linaro@kernel.org>
In-Reply-To: <20220623113314.29761-2-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 23 Jun 2022 14:44:28 +0300
Message-ID: <CAA8EJpp0XAZ3V9XQ2QnbrVoiKrdD_mxoTpKuzC34hKVPQ7wT0g@mail.gmail.com>
Subject: Re: [PATCH 1/3] phy: qcom-qmp-pcie: drop obsolete pipe clock type check
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 19 ++-----------------
>  1 file changed, 2 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> index b2cd0cf965d8..385ea3d8de08 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> @@ -2210,26 +2210,11 @@ int qcom_qmp_phy_pcie_create(struct device *dev, struct device_node *np, int id,
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

Please remove the brackets around a single statement. With that fixed:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

>
>         generic_phy = devm_phy_create(dev, np, &qcom_qmp_phy_pcie_ops);
> --
> 2.35.1
>


-- 
With best wishes
Dmitry
