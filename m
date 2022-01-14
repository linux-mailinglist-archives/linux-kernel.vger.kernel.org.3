Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C04648E9FB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 13:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235955AbiANMg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 07:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbiANMg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 07:36:26 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0199C06161C
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 04:36:25 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id p27so18128549lfa.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 04:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SSzezY2jwvG4+eW0wbMu/xOqdxgjDbfSgLN6Au8+Zrc=;
        b=QBLyTADGzXb9Yk307zk3N0XT1xp21JkFjPvJmMKSYw5BjxHHvG6D6Uu7Fxd2vhDulo
         lVBMxMXGS8WDHtbx2bFlu3bNP+Mx5248ulH7GBF6SOe8aMMcZSRyEsEJ/YR5+qga/4F6
         X4t+ZWmfXRvQ0kcJ6lqaay0KeRRs7t/gKbq+rpxAvyEyz8m7FmvTxvVlQpN6RBFcViV3
         o7YRcq/qEQaievfhHucpoD4ezmuA5n/cRtrc9qfwkDZLYRqwCYhLxxn9D5oQMkOTDtSl
         mBrFnbpwx6QL6rHICP/MbH7ETcTfKVYyfCBiPCXX3d4etrBTHWiwBwvBYBJYDUWYmKkC
         47FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SSzezY2jwvG4+eW0wbMu/xOqdxgjDbfSgLN6Au8+Zrc=;
        b=vWZtqnH25G7ZoTqG9TnQnLhwoEcwiz3SHDuThkgDv7Njbufs3BVZUF05x79s9aVd7A
         WKeEuz4SsylPCdJwN096tVuCvfbuK/EOIwCAq+JaE5zP0fntPhv7UC3zAuwHmBgHBV6Q
         MJnVkfcCgxV8iRBchBkY1pFbMp6GOTGkcsRLi6oVVaPjSwnmfG7S78xveRA0Fwzctm21
         53Cp4d3VzQHE6VVOBWoTLO/vQYkjPwl0AGrVwxsVeNlUrcHwa61f4X7o6nFlxjFXKqlD
         lB8ZzNUMhrO2DeYVi2aGX8cUQzGvqHMCYzl2kdWCFPpNYdqPDu6t7Zz9XHxrt/pe1/QT
         zUhw==
X-Gm-Message-State: AOAM532evAz2uzJpRXsym/9TyBUWsuTJuKEeLKQypmQ41w9QOF6HU8Es
        t6JG1FEyrT7jjJsEI6cDMwvzcIv/j9jzlhng0GQe4w==
X-Google-Smtp-Source: ABdhPJwe10Fbr0Jt+27ibm7UUvRFe3FsREn49iuUAe39IhMRm5FxvcIiHZTb94mylal21zbJVAgK2fF95oXXD56cib8=
X-Received: by 2002:a05:651c:98f:: with SMTP id b15mr6550226ljq.367.1642163784010;
 Fri, 14 Jan 2022 04:36:24 -0800 (PST)
MIME-Version: 1.0
References: <1641749107-31979-1-git-send-email-quic_mkshah@quicinc.com> <1641749107-31979-10-git-send-email-quic_mkshah@quicinc.com>
In-Reply-To: <1641749107-31979-10-git-send-email-quic_mkshah@quicinc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 14 Jan 2022 13:35:47 +0100
Message-ID: <CAPDyKFrASmBKRLLvWS-TUBdrtgPieuu1p0jco+qAuWo6HV2E=A@mail.gmail.com>
Subject: Re: [PATCH 09/10] soc: qcom: rpmh-rsc: Save base address of drv
To:     Maulik Shah <quic_mkshah@quicinc.com>
Cc:     bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, daniel.lezcano@linaro.org,
        quic_lsrao@quicinc.com, quic_rjendra@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Jan 2022 at 18:26, Maulik Shah <quic_mkshah@quicinc.com> wrote:
>
> Add changes to save drv's base address for rsc. This is
> used to read drv's configuration such as solver mode is
> supported or to write into CONTROL_TCS registers.
>
> Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/soc/qcom/rpmh-internal.h |  2 ++
>  drivers/soc/qcom/rpmh-rsc.c      | 18 ++++++++----------
>  2 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/soc/qcom/rpmh-internal.h b/drivers/soc/qcom/rpmh-internal.h
> index 32ac117..6770bbb 100644
> --- a/drivers/soc/qcom/rpmh-internal.h
> +++ b/drivers/soc/qcom/rpmh-internal.h
> @@ -91,6 +91,7 @@ struct rpmh_ctrlr {
>   * Resource State Coordinator controller (RSC)
>   *
>   * @name:               Controller identifier.
> + * @base:               Start address of the DRV registers in this controller.
>   * @tcs_base:           Start address of the TCS registers in this controller.
>   * @id:                 Instance id in the controller (Direct Resource Voter).
>   * @num_tcs:            Number of TCSes in this DRV.
> @@ -115,6 +116,7 @@ struct rpmh_ctrlr {
>   */
>  struct rsc_drv {
>         const char *name;
> +       void __iomem *base;
>         void __iomem *tcs_base;
>         int id;
>         int num_tcs;
> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
> index 5875ad5..c2a7c6c 100644
> --- a/drivers/soc/qcom/rpmh-rsc.c
> +++ b/drivers/soc/qcom/rpmh-rsc.c
> @@ -882,8 +882,7 @@ static int rpmh_rsc_pd_attach(struct rsc_drv *drv, struct device *dev)
>         return dev_pm_genpd_add_notifier(dev, &drv->genpd_nb);
>  }
>
> -static int rpmh_probe_tcs_config(struct platform_device *pdev,
> -                                struct rsc_drv *drv, void __iomem *base)
> +static int rpmh_probe_tcs_config(struct platform_device *pdev, struct rsc_drv *drv)
>  {
>         struct tcs_type_config {
>                 u32 type;
> @@ -897,9 +896,9 @@ static int rpmh_probe_tcs_config(struct platform_device *pdev,
>         ret = of_property_read_u32(dn, "qcom,tcs-offset", &offset);
>         if (ret)
>                 return ret;
> -       drv->tcs_base = base + offset;
> +       drv->tcs_base = drv->base + offset;
>
> -       config = readl_relaxed(base + DRV_PRNT_CHLD_CONFIG);
> +       config = readl_relaxed(drv->base + DRV_PRNT_CHLD_CONFIG);
>
>         max_tcs = config;
>         max_tcs &= DRV_NUM_TCS_MASK << (DRV_NUM_TCS_SHIFT * drv->id);
> @@ -961,7 +960,6 @@ static int rpmh_rsc_probe(struct platform_device *pdev)
>         char drv_id[10] = {0};
>         int ret, irq;
>         u32 solver_config;
> -       void __iomem *base;
>
>         /*
>          * Even though RPMh doesn't directly use cmd-db, all of its children
> @@ -988,11 +986,11 @@ static int rpmh_rsc_probe(struct platform_device *pdev)
>                 drv->name = dev_name(&pdev->dev);
>
>         snprintf(drv_id, ARRAY_SIZE(drv_id), "drv-%d", drv->id);
> -       base = devm_platform_ioremap_resource_byname(pdev, drv_id);
> -       if (IS_ERR(base))
> -               return PTR_ERR(base);
> +       drv->base = devm_platform_ioremap_resource_byname(pdev, drv_id);
> +       if (IS_ERR(drv->base))
> +               return PTR_ERR(drv->base);
>
> -       ret = rpmh_probe_tcs_config(pdev, drv, base);
> +       ret = rpmh_probe_tcs_config(pdev, drv);
>         if (ret)
>                 return ret;
>
> @@ -1015,7 +1013,7 @@ static int rpmh_rsc_probe(struct platform_device *pdev)
>          * 'HW solver' mode where they can be in autonomous mode executing low
>          * power mode to power down.
>          */
> -       solver_config = readl_relaxed(base + DRV_SOLVER_CONFIG);
> +       solver_config = readl_relaxed(drv->base + DRV_SOLVER_CONFIG);
>         solver_config &= DRV_HW_SOLVER_MASK << DRV_HW_SOLVER_SHIFT;
>         solver_config = solver_config >> DRV_HW_SOLVER_SHIFT;
>         if (!solver_config) {
> --
> 2.7.4
>
