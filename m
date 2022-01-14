Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45C3948E9EA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 13:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241093AbiANMb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 07:31:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241124AbiANMbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 07:31:41 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13EBC061747
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 04:31:40 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id p27so18087289lfa.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 04:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xDB9pjVqGD1dQ8+6dzFJliMRED2Jt1OjaEA1IchGi8M=;
        b=ReyvIptj7RRqxpHFzMpQjIy82ZqrWdPtWRN3+0N3zxjB86qONhi83ofHJ1Qt+ejiSN
         xaFWJ0MjIFbYApFl06KPrz3c1Jq3En6SVx+iUKEbCo/5/pXpAOwjaNKHmo6FlXZEyZvs
         NVD2eAJMayt2B7VnwDg4kPJquaazORDGDAN7Db8kbp6a2Ej4la/xX/Jfs20SRBExN+yv
         j+FyMrGotrLEsXugDdmRn4rp/01QHJ5Zxa/ehMh2QBKU47jj0dzwBTdo/It0jy+pCODW
         z+pqomt/kAwiIwjrUjmjBcDYhRnZnyVmKLOhkQPyhybJwLyFNnhfSDAOIDcUEhWqqeOr
         B9Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xDB9pjVqGD1dQ8+6dzFJliMRED2Jt1OjaEA1IchGi8M=;
        b=5oHZjtDQmXbaKdGbL0HNtqHJo1pmP1wZM/7mYve/ARvmlQk4gKB2FDSD5n2UYW/eYw
         OMpcEivoP363Oi9pOaSnqqvBMFuAMx4AG9OQILDgPaN/poCOrcS1HF/Negq1doVmslzk
         +dCf4JQFiGBaExiYWAn67VS8E6kbgdvD+WnFWaYTdH8wgYLWYP4X87TLnm5wylnfCbAp
         oo6Y1lVWk8f7EJON9LPc5HWiZgHn1EiWlUA4Y5OML+NdMS9QcCXlBQkFJ44lruKta/C5
         gTBVedE4Gi5TbCPMz/4I1eGQb9Ce8pD7NMl2Wi5LLB0AkHSNTzvPxP+JQ43R9963kwbK
         Rukw==
X-Gm-Message-State: AOAM530hZpINibR/CKPm465Ls4TXl2wjNElcZ4XdXlVViPkGLOzlNaOh
        5tky4bu0TH8ehGKKX0bqNYNiOR+MgLIrbV2aHIHY8Q==
X-Google-Smtp-Source: ABdhPJznzNCo9hG045Q6eX8tEtX83stSw+DtAOr0Ov57fJHf8C08RuY41HbwkMroG3vbti+HpUjkNCGsmYTlOXhlx3w=
X-Received: by 2002:a2e:9217:: with SMTP id k23mr101368ljg.229.1642163499194;
 Fri, 14 Jan 2022 04:31:39 -0800 (PST)
MIME-Version: 1.0
References: <1641749107-31979-1-git-send-email-quic_mkshah@quicinc.com> <1641749107-31979-6-git-send-email-quic_mkshah@quicinc.com>
In-Reply-To: <1641749107-31979-6-git-send-email-quic_mkshah@quicinc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 14 Jan 2022 13:31:02 +0100
Message-ID: <CAPDyKFqbQYvTtsxmP_WKjGdf3Uq78LXMCgehGdGcfmnA9LjV-g@mail.gmail.com>
Subject: Re: [PATCH 05/10] dt-bindings: soc: qcom: Update devicetree binding
 document for rpmh-rsc
To:     Maulik Shah <quic_mkshah@quicinc.com>
Cc:     bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, daniel.lezcano@linaro.org,
        quic_lsrao@quicinc.com, quic_rjendra@quicinc.com,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Jan 2022 at 18:25, Maulik Shah <quic_mkshah@quicinc.com> wrote:
>
> The change documents power-domains property for RSC device.
> This optional property points to corresponding PM domain node.
>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

BTW, it would be nice to get the binding converted to the new DT yaml
formal, perhaps something we can look at doing on top?

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt b/Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt
> index 9b86d1e..85b9859 100644
> --- a/Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt
> +++ b/Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt
> @@ -78,6 +78,11 @@ Properties:
>                     CONTROL_TCS
>         - Cell #2 (Number of TCS): <u32>
>
> +- power-domains:
> +       Usage: optional
> +       Value type: <prop-encoded-power-domains>
> +       Definition: Phandle pointing to the corresponding PM domain node.
> +
>  - label:
>         Usage: optional
>         Value type: <string>
> @@ -112,6 +117,7 @@ TCS-OFFSET: 0xD00
>                                   <SLEEP_TCS   3>,
>                                   <WAKE_TCS    3>,
>                                   <CONTROL_TCS 1>;
> +               power-domains = <&CLUSTER_PD>;
>         };
>
>  Example 2:
> --
> 2.7.4
>
