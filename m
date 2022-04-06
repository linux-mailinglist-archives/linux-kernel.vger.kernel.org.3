Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5024F6652
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238454AbiDFREr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 13:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238403AbiDFREH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 13:04:07 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91753255C12
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 07:48:54 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id i27so4756067ejd.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 07:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hWg5rr2A6nX4SfC/Pk1Y5oFdVdet7nrbWCNkMt2/CtE=;
        b=ZJkoxABazYWZUfKwJQVJsQ/f/sTRqY4q7kgP+BmxaBH680bfL8NW5LK3KR7IA8F2ld
         ulYkm89Hqy1x/SIN8TER5PEnWvE7HzxHAWRdzQKr1lRwAf5tY+bEmmuf7LwyLqeWJh6m
         62DKI1uSzSGkDlIrZE4PkZXYW4TBAB3BtsW94v3Wn7SvAfnmBDCd83hhBZtEVmT2Surg
         YqwCEMqxbPGHGHvU9FW/+KJvX5l9nL+lqWSkjfSp7tym1/sMBChf/UrMvHJQNbxBv/4d
         M5js8KfZsABnGi+5pfUSk9E474jEhDICPLCgPY3/sikIHhZfb5uVBVp1wWOHJ3Quq0zd
         uebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hWg5rr2A6nX4SfC/Pk1Y5oFdVdet7nrbWCNkMt2/CtE=;
        b=rNV4Kxm1A9HWAQYac8bFH0dCP08jyrFek7KdtOH7GTzNIX+g3Ly0ssIAIyeNp9WKU5
         M46z2U32Vn7WPNiqRcp7JPWGWBFRxvek/A/WAaAutGH3Smuy5PNNz+3eNiVJPgD8dp6Q
         yhkPKKvxh0niBj3HDsgWMRAsxkhExzsM4ty65A4tx8eqPNDXNbofWvDctODFhn1z+A7d
         G5F7x1CNDGTr28TeY0YS6VcH+t6RktwjxC95INrbynF9Qpdo6eRnlBoj+/9N7NgKXDAk
         aogovx/c1n8kwQO2et7RMHuwyycAc4/yn0uPj3AQSGmpEE4O45XE9ev3ZKGfn2e2YqGQ
         2c/Q==
X-Gm-Message-State: AOAM532GLbRFuc6B6rCewAkMZL/meAr/7WJsrJ3e2Rb7+xM5RVD71f0+
        lJ6JIejFHBYsGbyjCxgcazx105EjZ6y25bHiNnQYAA==
X-Google-Smtp-Source: ABdhPJwNgadfcl8AdRRaDfiaVyBHv4fyImm+NLtsG6q4Q83Avrp9z6SLWFvc1ZCKExavjB0TD/Gp9XyFA3ws9rxpwnQ=
X-Received: by 2002:a17:906:3cf1:b0:6cf:86c6:8a12 with SMTP id
 d17-20020a1709063cf100b006cf86c68a12mr8739042ejh.202.1649256533034; Wed, 06
 Apr 2022 07:48:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220405161114.1107745-1-arnaud.pouliquen@foss.st.com>
In-Reply-To: <20220405161114.1107745-1-arnaud.pouliquen@foss.st.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 6 Apr 2022 08:48:40 -0600
Message-ID: <CANLsYkzFr5Zfzz5YL+bOLijwsrWdGiM=zcyS4-G2+A+p9JdGEw@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: defconfig: Config that had RPMSG_CHAR now gets RPMSG_CTRL
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
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

On Tue, 5 Apr 2022 at 10:12, Arnaud Pouliquen
<arnaud.pouliquen@foss.st.com> wrote:
>
> In the commit 617d32938d1b ("rpmsg: Move the rpmsg control device
> from rpmsg_char to rpmsg_ctrl"), we split the rpmsg_char driver in two.
> By default give everyone who had the old driver enabled the rpmsg_ctrl
> driver too.
>
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
>
> This patch is extracted from the series [1] that has been partially
> integrated in the Linux Kernel 5.18-rc1.
>
> Update vs previous version:
> - Add missing "---" separation marker after "Signed-off-by".
>
> [1]https://lore.kernel.org/lkml/15be2f08-ba03-2b80-6f53-2056359d5c41@gmail.com/T/
> [2]https://lore.kernel.org/linux-arm-kernel/CANLsYky1_b80qPbgOaLGVYD-GEr21V6C653iGEB7VCU=GbGvAQ@mail.gmail.com/T/
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 50aa3d75ab4f..3f8906b8a2ca 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1053,6 +1053,7 @@ CONFIG_QCOM_Q6V5_PAS=m
>  CONFIG_QCOM_SYSMON=m
>  CONFIG_QCOM_WCNSS_PIL=m
>  CONFIG_RPMSG_CHAR=m
> +CONFIG_RPMSG_CTRL=m
>  CONFIG_RPMSG_QCOM_GLINK_RPM=y
>  CONFIG_RPMSG_QCOM_GLINK_SMEM=m
>  CONFIG_RPMSG_QCOM_SMD=y

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> --
> 2.25.1
>
