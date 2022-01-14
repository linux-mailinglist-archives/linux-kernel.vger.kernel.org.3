Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16B4748E9D9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 13:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241047AbiANMar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 07:30:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241036AbiANMaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 07:30:46 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12F8C06173E
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 04:30:45 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id x22so29668204lfd.10
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 04:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dFRXtZZJM1w8961wsdhrLcj24zD7zb34E9qEnauBJXU=;
        b=idPRQ8dlVpadyH1EnirRdmBZfw36VmY5JeDrBgyETgygFDTDNjO3OicMzeXhdzNjHX
         ZDn6mUnyfs3HzMQG7yaW2qR2ih94hpk5bb2omZNNsCljHWruVgHiVJbJmX86H7CY44kT
         /odSrXFwMtcxBoGbj1nS62G1dCqrpZdpUdL4JZqn1YyqQgC9bY5QUH2t1uHHnjiGNspf
         KyGle92on+jBisHCxaFBGI+pjfxka9i3nnBSHe8a3auq9EcP58O6YoEz+SvelslkSKnB
         TRDwhpLZ1OtpeZQjp/rSUBAUVxHsdgPoNirq+rGKlLTOvkpkAvS8J81AeXnJkkrle9ob
         JKtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dFRXtZZJM1w8961wsdhrLcj24zD7zb34E9qEnauBJXU=;
        b=u/pBt1W2k00uZ4B+7oj1PdwH84GKYCEVvWYXNk/2CfqjhEtkTK6pal85+Rs7B47p0g
         IYY02SAfvWt5EFaT38646M43Y5apo7yhZ9rpM4OT/LdnIwMaoq7QN/ZzZu3CMai6OEtB
         XNfoFwMa/RJjfam3bSKx2K/DQvYm8AEedYQroazg+kYpizp+fkJDTYo+nVK/zyf+4ubm
         BavxH7zUL4N4YhK1jKZmEmfeZ536oIsYbpQlhRiI8A7H1oU67U04Dx8s+5ltLlZehGcc
         Rx4ZRIiuWzttilTEsL3K9QxRp6CenZyDIOt2h14PgYRTu0zf/8Us3cDCNgCSSiB3CTDr
         TMbA==
X-Gm-Message-State: AOAM5323ItNbaySMQXl/SMUbNU36uv0N6I80875sZbwnT+z8W0fJ4XIp
        IUbBaU28iKgu/ryfcKGs7aWEtlmn6T3ch3MkF+2ceA==
X-Google-Smtp-Source: ABdhPJyWQeFWRdC1re5kRbvMitOb6K7LNOupUy6c8ve0Xxr9HTyFtNXTC7xc5QWnESF9qUEg9Ikn6HYvX3IjDLt4aEU=
X-Received: by 2002:a05:651c:98f:: with SMTP id b15mr6534836ljq.367.1642163442620;
 Fri, 14 Jan 2022 04:30:42 -0800 (PST)
MIME-Version: 1.0
References: <1641749107-31979-1-git-send-email-quic_mkshah@quicinc.com> <1641749107-31979-7-git-send-email-quic_mkshah@quicinc.com>
In-Reply-To: <1641749107-31979-7-git-send-email-quic_mkshah@quicinc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 14 Jan 2022 13:30:06 +0100
Message-ID: <CAPDyKFrYKRz=S_9_6RNGWn4p3K1MLP63rRfVDSKvH_o8SjZCeQ@mail.gmail.com>
Subject: Re: [PATCH 06/10] soc: qcom: rpmh-rsc: Attach RSC to cluster PM domain
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
> From: Lina Iyer <ilina@codeaurora.org>
>
> RSC is part the CPU subsystem and powers off the CPU domains when all
> the CPUs and no RPMH transactions are pending from any of the drivers.
> The RSC needs to flush the 'sleep' and 'wake' votes that are critical
> for saving power when all the CPUs are in idle.
>
> Let's make RSC part of the CPU PM domains, by attaching it to the
> cluster power domain. Registering for PM domain notifications, RSC
> driver can be notified that the last CPU is powering down. When the last
> CPU is powering down the domain, let's flush the 'sleep' and 'wake'
> votes that are stored in the data buffers into the hardware and also
> write next wakeup in CONTROL_TCS.
>
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>
> ---
>  drivers/soc/qcom/rpmh-internal.h |  6 +++-
>  drivers/soc/qcom/rpmh-rsc.c      | 60 ++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 62 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/soc/qcom/rpmh-internal.h b/drivers/soc/qcom/rpmh-internal.h
> index 344ba68..32ac117 100644
> --- a/drivers/soc/qcom/rpmh-internal.h
> +++ b/drivers/soc/qcom/rpmh-internal.h
> @@ -97,7 +97,9 @@ struct rpmh_ctrlr {
>   * @rsc_pm:             CPU PM notifier for controller.
>   *                      Used when solver mode is not present.
>   * @cpus_in_pm:         Number of CPUs not in idle power collapse.
> - *                      Used when solver mode is not present.
> + *                      Used when solver mode and "power-domains" is not present.
> + * @genpd_nb:           PM Domain notifier for cluster genpd notifications.
> + * @genpdb:             PM Domain for cluster genpd.

/s/genpdb/genpd

>   * @tcs:                TCS groups.
>   * @tcs_in_use:         S/W state of the TCS; only set for ACTIVE_ONLY
>   *                      transfers, but might show a sleep/wake TCS in use if
> @@ -117,6 +119,8 @@ struct rsc_drv {
>         int id;
>         int num_tcs;
>         struct notifier_block rsc_pm;
> +       struct notifier_block genpd_nb;
> +       struct generic_pm_domain *genpd;
>         atomic_t cpus_in_pm;
>         struct tcs_group tcs[TCS_TYPE_NR];
>         DECLARE_BITMAP(tcs_in_use, MAX_TCS_NR);
> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
> index 01c2f50c..5875ad5 100644
> --- a/drivers/soc/qcom/rpmh-rsc.c
> +++ b/drivers/soc/qcom/rpmh-rsc.c
> @@ -14,10 +14,13 @@
>  #include <linux/kernel.h>
>  #include <linux/list.h>
>  #include <linux/module.h>
> +#include <linux/notifier.h>
>  #include <linux/of.h>
>  #include <linux/of_irq.h>
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
>  #include <linux/wait.h>
> @@ -834,6 +837,51 @@ static int rpmh_rsc_cpu_pm_callback(struct notifier_block *nfb,
>         return ret;
>  }
>
> +/**
> + * rpmh_rsc_pd_callback() - Check if any of the AMCs are busy.
> + * @nfb:    Pointer to the genpd notifier block in struct rsc_drv.
> + * @action: GENPD_NOTIFY_PRE_OFF, GENPD_NOTIFY_OFF, GENPD_NOTIFY_PRE_ON or GENPD_NOTIFY_ON.
> + * @v:      Unused
> + *
> + * This function is given to dev_pm_genpd_add_notifier() so we can be informed
> + * about when cluster-pd is going down. When cluster go down we know no more active
> + * transfers will be started so we write sleep/wake sets. This function gets
> + * called from cpuidle code paths and also at system suspend time.
> + *
> + * If AMCs are not busy then writes cached sleep and wake messages to TCSes.
> + * The firmware then takes care of triggering them when entering deepest low power modes.
> + *
> + * Return:
> + * * NOTIFY_OK          - success
> + * * NOTIFY_BAD         - failure
> + */
> +static int rpmh_rsc_pd_callback(struct notifier_block *nfb,
> +                               unsigned long action, void *v)
> +{
> +       struct rsc_drv *drv = container_of(nfb, struct rsc_drv, genpd_nb);
> +
> +       /* We don't need to lock as domin on/off are serialized */

/s/domin/genpd

> +       if ((action == GENPD_NOTIFY_PRE_OFF) &&
> +           (rpmh_rsc_ctrlr_is_busy(drv) || rpmh_flush(&drv->client)))
> +               return NOTIFY_BAD;
> +
> +       return NOTIFY_OK;
> +}
> +
> +static int rpmh_rsc_pd_attach(struct rsc_drv *drv, struct device *dev)
> +{
> +       int ret;
> +
> +       pm_runtime_enable(dev);
> +       ret = dev_pm_domain_attach(dev, false);

Unless I have missed something, this should not be needed.

This is because it's a regular platform driver and we only have a
single PM domain to attach for the rsc device. In this case, the
platform bus is capable of managing the attach to the genpd. See
platform_probe() in drivers/base/platform.c.

> +       if (ret)
> +               return ret;
 > +
> +       drv->genpd = pd_to_genpd(dev->pm_domain);

I couldn't find where this pointer is being used later in the driver.
In any case, you can probably use dev->pm_domain directly wherever
needed instead.

> +       drv->genpd_nb.notifier_call = rpmh_rsc_pd_callback;
> +       return dev_pm_genpd_add_notifier(dev, &drv->genpd_nb);

You should call pm_runtime_disable() in the error path.

> +}
> +
>  static int rpmh_probe_tcs_config(struct platform_device *pdev,
>                                  struct rsc_drv *drv, void __iomem *base)
>  {
> @@ -963,7 +1011,7 @@ static int rpmh_rsc_probe(struct platform_device *pdev)
>                 return ret;
>
>         /*
> -        * CPU PM notification are not required for controllers that support
> +        * CPU PM/genpd notification are not required for controllers that support
>          * 'HW solver' mode where they can be in autonomous mode executing low
>          * power mode to power down.
>          */
> @@ -971,8 +1019,14 @@ static int rpmh_rsc_probe(struct platform_device *pdev)
>         solver_config &= DRV_HW_SOLVER_MASK << DRV_HW_SOLVER_SHIFT;
>         solver_config = solver_config >> DRV_HW_SOLVER_SHIFT;
>         if (!solver_config) {
> -               drv->rsc_pm.notifier_call = rpmh_rsc_cpu_pm_callback;
> -               cpu_pm_register_notifier(&drv->rsc_pm);
> +               if (of_find_property(dn, "power-domains", NULL)) {

Rather than parsing the DT, I think it's better to check if
"dev->pm_domain" has been assigned. As I indicated above, the platform
bus manages the attach before the driver's ->probe() callback is
invoked.

> +                       ret = rpmh_rsc_pd_attach(drv, &pdev->dev);
> +                       if (ret)
> +                               return ret;
> +               } else {
> +                       drv->rsc_pm.notifier_call = rpmh_rsc_cpu_pm_callback;
> +                       cpu_pm_register_notifier(&drv->rsc_pm);
> +               }
>         }
>
>         /* Enable the active TCS to send requests immediately */

Beyond this point, you need to call the below to manage the error path
correctly:
dev_pm_genpd_remove_notifier()
pm_runtime_disable()

> --
> 2.7.4
>

Kind regards
Uffe
