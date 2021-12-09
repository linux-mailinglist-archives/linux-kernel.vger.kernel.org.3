Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B22E46EF63
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 18:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242023AbhLIREP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 12:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241839AbhLIREF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:04:05 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC5CC061A32
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 09:00:32 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id ay21so11878195uab.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 09:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nr5wuPhhGNTWonGmo2iX/gwdOzJ5S4cBCmGZ538zbok=;
        b=NuDQEGrch6pNlNwYhNqd2wRy3q6W+rwMD/HsJRZhVNBHkpuPJoUbjulXl1homoseF7
         1kKcr1HS2zoHGQQbixwftxedLSup7HNF2iiDJ04EHLOs1thMrn+1EWilS7DaRl119Jwi
         I153BpHn87yCHVAxsHrI3Ecf6L6WByIvOdyJj2cG6+dHgYw6WJrs6MeuBGLDZ5gqRThH
         nrZjKsu0OEOd1GBpvvojAC3FEXgHsQeK3gKQS6RdVvw/H4Z3Qamyvkc79HPUFzLMAXdH
         6qJVFSWpexQi3VDB9BTMZyxVICvTBg7F9Fz4+ic625GPauuEelloWtYlTBlIZ1E3BU3u
         BHOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nr5wuPhhGNTWonGmo2iX/gwdOzJ5S4cBCmGZ538zbok=;
        b=FazDiDDbKl6gGAQ0yf/LjR4NPsMHMSgeixCMTcydlFo3o9Vanuud/Qm+3FsT8N1+Gd
         hIe1NAcDqsQ+aIm5LFaqjsvPi3M9OWC0rlPJn4HJT4RgiBhtmU0V1+cEmdhIQ+pdul3W
         iJ7eG/wavrzQ2ODZzQr2gR/aGGXZKBNtOYMIK9E7UawYZpW09zp/1uEKOHwCw2XHMBHR
         ll+DjJTv0hkYukTRH0m9OXI8/k562LlYv26rc3AJ27lIS7qOocJD9QD2ahibsEJ5RFsN
         f3rayagA/LkwhkEFTj6+q3lj5GJT2pmThbySBf9l291RTogKlzDhBfLSiEm4J4pMD25B
         3YUw==
X-Gm-Message-State: AOAM531DjCPzDqitwvBuLA9bD+7dSu3k3TREiVtbnJQnTD5FgkkiTgxy
        0bHXOWeZm+B2TixzIoMfk8pskEhpIph4LcxAT3KA+SsJx2rfdAFHdFM=
X-Google-Smtp-Source: ABdhPJz0iRDOuw/M+YaSvjbo97c5cFzgJ2BQX0SuXLvY44zzegatZmpXZ1bu6kLKl5yEfvfXxPxcTI41wUiGmm6vGZg=
X-Received: by 2002:a0c:fb09:: with SMTP id c9mr17896098qvp.119.1639069220198;
 Thu, 09 Dec 2021 09:00:20 -0800 (PST)
MIME-Version: 1.0
References: <1639063917-9011-1-git-send-email-quic_rjendra@quicinc.com> <1639063917-9011-2-git-send-email-quic_rjendra@quicinc.com>
In-Reply-To: <1639063917-9011-2-git-send-email-quic_rjendra@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 9 Dec 2021 20:00:09 +0300
Message-ID: <CAA8EJpqVtGQCzQwkZ2jJ5EnhtANNRPuFOYQhQkFvHJ30xU8quQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] soc: qcom: rpmhpd: sm8450: Add the missing .peer
 for sm8450_cx_ao
To:     Rajendra Nayak <quic_rjendra@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, mka@chromium.org,
        Vinod Koul <vkoul@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Dec 2021 at 18:32, Rajendra Nayak <quic_rjendra@quicinc.com> wrote:
>
> sm8450_cx and sm8450_cx_ao should be peers of each other, add the
> missing .peer entry for sm8450_cx_ao
>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Vinod Koul <vkoul@kernel.org>
> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  drivers/soc/qcom/rpmhpd.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
> index e7e150c..2032cf3 100644
> --- a/drivers/soc/qcom/rpmhpd.c
> +++ b/drivers/soc/qcom/rpmhpd.c
> @@ -264,6 +264,7 @@ static struct rpmhpd sm8450_cx = {
>  static struct rpmhpd sm8450_cx_ao = {
>         .pd = { .name = "cx_ao", },
>         .active_only = true,
> +       .peer = &sm8450_cx,
>         .res_name = "cx.lvl",
>  };
>
> --
> 2.7.4
>


-- 
With best wishes
Dmitry
