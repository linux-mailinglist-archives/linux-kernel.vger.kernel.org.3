Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C75646B57E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 09:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbhLGITr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 03:19:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbhLGITp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 03:19:45 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACBEC061746
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 00:16:15 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id d72-20020a1c1d4b000000b00331140f3dc8so1598062wmd.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 00:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wV05YmqytZZ4i77GlP1Brthyva63mRUa2qE0+W2OXv4=;
        b=cC1Hbczjdh2dzt9ciK2qiKC3ZkYz1fGNc8p1h3oLUa2PWAkb2rVdSC0aavqJ+hIEzx
         pcvAhgPMbMkSHKM2in+pdz8ejZ2PqF/iimPZYtPQuW4YbhrLGril86javjmtKtUImtuH
         ZbQ9sVHkJZyetxai1yhoAKKC9qIRnccfGo4bqqCYFOUoJ0nMsc4ZaNR4ohPMMBMLYeq7
         5uSC9mLsvmQineh9UG21iURMUPJPQuwv8iGgoi/PBa323WyfEWbcdE7FWPdyC/L6aDau
         PXbmlej1r2JWIDKbmZZVVFWUIEidbsWHPyibno6dYOAKDAvZ/QWNTpn80CUMKZO2uJqe
         Q38g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wV05YmqytZZ4i77GlP1Brthyva63mRUa2qE0+W2OXv4=;
        b=bntXhrtLCyb6gWiVUVZxIWNvvVsffotcNbubo4HijE31ck/3jo9/BeVXu+9WqWF49I
         iyUA3G3FNOKtE/Lz6ianQ24fePfnF3LILr6fk3j0CUPIPc/P84W90xpBi2QYCq+4PY0j
         Z3XfWYaK3Y2n3+xKw+dU5kp8ZE+8U96JwvqK5W/gma2FQmtbMI38Wur0PfZwC9PSRhux
         5HvR3jn3Fd1oUqAI4g6VqJ31frw4URdaj5JK76TFuS9yEJjvqSKkknzu87OF/5eymU8r
         mttzJSwggYw0kRwOeM8Jt+BfzJSoGUiwspCI58+6BB4mg2V4UyrAKgwSLTe5KI5xoCoj
         9RHQ==
X-Gm-Message-State: AOAM530/CTakQDzNYvwa/1GAyJ+7E4sbUw/XrMxRNz2+IMPAEPCiB6gZ
        om/IftyIdM3H+dD8v1q+4D/o/PMroC1e4vxWlkooLg==
X-Google-Smtp-Source: ABdhPJy/5bX081hEllcHF+ciiU1wOWxT4YMmlv0lSO4Mp0uNC6xawLDFYKeG14mC3/pJJ+ZqaKc0D9h7/Cwk8IFQCsM=
X-Received: by 2002:a7b:c7cd:: with SMTP id z13mr5087144wmk.59.1638864974238;
 Tue, 07 Dec 2021 00:16:14 -0800 (PST)
MIME-Version: 1.0
References: <20211207080843.21222-1-arnaud.pouliquen@foss.st.com> <20211207080843.21222-6-arnaud.pouliquen@foss.st.com>
In-Reply-To: <20211207080843.21222-6-arnaud.pouliquen@foss.st.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 7 Dec 2021 13:46:03 +0530
Message-ID: <CAAhSdy3GDArfbQgusdDg-mi1bdTfDhFMaF4qa5-KFv1regwJ-Q@mail.gmail.com>
Subject: Re: [PATCH v8 05/13] RISC-V: configs: Configs that had RPMSG_CHAR now
 get RPMSG_CTRL
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-remoteproc@vger.kernel.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com, julien.massot@iot.bzh,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 7, 2021 at 1:39 PM Arnaud Pouliquen
<arnaud.pouliquen@foss.st.com> wrote:
>
> In the patch "rpmsg: Move the rpmsg control device from rpmsg_char
> to rpmsg_ctrl", we split the rpmsg_char driver in two.
> By default give everyone who had the old driver enabled the rpmsg_ctrl
> driver too.
>
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> cc: linux-riscv@lists.infradead.org

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/configs/defconfig      | 1 +
>  arch/riscv/configs/rv32_defconfig | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index c252fd5706d2..c0439d3ffb8c 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -97,6 +97,7 @@ CONFIG_VIRTIO_BALLOON=y
>  CONFIG_VIRTIO_INPUT=y
>  CONFIG_VIRTIO_MMIO=y
>  CONFIG_RPMSG_CHAR=y
> +CONFIG_RPMSG_CTRL=y
>  CONFIG_RPMSG_VIRTIO=y
>  CONFIG_EXT4_FS=y
>  CONFIG_EXT4_FS_POSIX_ACL=y
> diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_defconfig
> index 434ef5b64599..99eabad7ca0f 100644
> --- a/arch/riscv/configs/rv32_defconfig
> +++ b/arch/riscv/configs/rv32_defconfig
> @@ -89,6 +89,7 @@ CONFIG_VIRTIO_BALLOON=y
>  CONFIG_VIRTIO_INPUT=y
>  CONFIG_VIRTIO_MMIO=y
>  CONFIG_RPMSG_CHAR=y
> +CONFIG_RPMSG_CTRL=y
>  CONFIG_RPMSG_VIRTIO=y
>  CONFIG_EXT4_FS=y
>  CONFIG_EXT4_FS_POSIX_ACL=y
> --
> 2.17.1
>
