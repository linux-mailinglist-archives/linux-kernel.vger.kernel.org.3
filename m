Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86E8847C069
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 14:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238116AbhLUNEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 08:04:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238087AbhLUNEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 08:04:01 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB087C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 05:04:00 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id bu9so7644257lfb.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 05:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zQ60oAIcpzw/aiNJhWx+YuVYFuBdeA2tf0TAL6Ahzz8=;
        b=FyzJPWLK3MyD0A05R6cOZTiRbRyu0I9pVEa6AYgGVM6NdVhcIEicsgbDxbLp2psgKo
         dXh/oeeKPbpXFFp19/VKSLvBrwTcqXpVX4O7bcllIlKULHYrDPOxeVYxw7mTyYiKX7S/
         kECmy4o/0HfM2VaHzN28A4mg7HKDvWfEt+VFD4lORru9SBBeKhTlZyd6XfI+aY3+jivK
         Fg4BolkuW1gS9ylNqY/bOKph9tjpatGAt/q2FfH+Oo8ZWULkaq/Isg7M+NGj0kiYQWqp
         rvlXVW/wqjmlKQJjppoE0wDTliuS1//Yf+LNNclTw0EXeizQnFGnSI1gjHvUWwlKPHCJ
         8AyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zQ60oAIcpzw/aiNJhWx+YuVYFuBdeA2tf0TAL6Ahzz8=;
        b=C/mTmAvCmyU9Fy9/SdX/S30wEjf9NPckKgjsLdwDoabg8BkOWfvIWvjCPUZyddRfnE
         CjhYbcdA0F2qdjzDPAOK5DfpjJ4Z+4S8B2F+KkA6xBn+ZJ+chyYoOfdS+1LSfKXg+Fkx
         DEfn9gwkU2hn2UYHo4eNtxUauvLnWHeG4J2S0B09RJniP3eRPByRmdZnslLKHybtZHLL
         yLIVbKQ4yvjwLNhbDp5YKy1rZR+tvEwLBkLcTWzsfBJbwlzY3ssgA5Ofu4Z1UIwW+cT3
         D1c6LBg/vsSp8CQwDChNDNpse2mTMM98Qr2FgyNg9Hlk+PdJ4czszxOWp4cuw4q61NJl
         tcmA==
X-Gm-Message-State: AOAM530NdXkEBx6BdBAUls1q671iEhCQtGFSTI2Tg7U3idpS8JJm00JD
        qS5MmLOkmZaauoVZQ754fVw9Amzyep8b+fNGZdia2w==
X-Google-Smtp-Source: ABdhPJzpHVkr+LzfFPjvMMJmCxmbRiPqxVa67nqEOcia2o3P/Jocj0CMojpVyoSnx3VLPJ3yKe0f5hkaclinOBqd9kM=
X-Received: by 2002:a19:5019:: with SMTP id e25mr2973830lfb.254.1640091839021;
 Tue, 21 Dec 2021 05:03:59 -0800 (PST)
MIME-Version: 1.0
References: <1640076288-32714-1-git-send-email-haibo.chen@nxp.com>
In-Reply-To: <1640076288-32714-1-git-send-email-haibo.chen@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 21 Dec 2021 14:03:21 +0100
Message-ID: <CAPDyKFrmUgQCYyrN5FRhZ2+L=buJNA01RwNKUPEhLaEx6qhy9g@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add i.MX sdhci maintainer
To:     haibo.chen@nxp.com
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, Kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Dec 2021 at 10:13, <haibo.chen@nxp.com> wrote:
>
> From: Haibo Chen <haibo.chen@nxp.com>
>
> Add myself as the i.MX sdhci driver maintainer.
>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Thanks for stepping and helping out with maintenance!

Applied for next!

Kind regards
Uffe


> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 210bded08641..1e72f46b43b0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17283,6 +17283,13 @@ L:     linux-mmc@vger.kernel.org
>  S:     Maintained
>  F:     drivers/mmc/host/sdhci-omap.c
>
> +SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) NXP i.MX DRIVER
> +M:     Haibo Chen <haibo.chen@nxp.com>
> +L:     linux-imx@nxp.com
> +L:     linux-mmc@vger.kernel.org
> +S:     Maintained
> +F:     drivers/mmc/host/sdhci-esdhc-imx.c
> +
>  SECURE ENCRYPTING DEVICE (SED) OPAL DRIVER
>  M:     Jonathan Derrick <jonathan.derrick@intel.com>
>  M:     Revanth Rajashekar <revanth.rajashekar@intel.com>
> --
> 2.25.1
>
