Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC23746533C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 17:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351627AbhLAQs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 11:48:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351495AbhLAQsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 11:48:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7087C06175F;
        Wed,  1 Dec 2021 08:45:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2181EB82040;
        Wed,  1 Dec 2021 16:45:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E915FC53FAD;
        Wed,  1 Dec 2021 16:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638377111;
        bh=Nhf2om/v2NQGCvvM2KbwouBAg91Y+6ySqaNQjBtulLU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QQsSJmWheDiKio+d1s7Xfm9eE+UmkkhZdSg6ChxdT0kEFrf2vIJazcg4t8SP4RtgR
         yY4JvK0Td3JlCiBopx4MQwyPYyB58fcvEtu/7tTHWiZ/8ASwPpK9R/e67MVqEnwj48
         SiTpTck1b05JgQBdKTgX5TPFnz/OxXBQ5KbflWoaZtxuibVYEPdn0yLm9LLKBYOTpw
         qcjCsgFSNZIgnJZDOvlB78QE2xwvInFUoBDWiCq2JYs6NmsUXFSgQGZR06dKs8FypK
         ZA8IiRQQxmjcKwcHfg4YZbgc4xZMwTTYIOuUlkOgLx7+C54SLWWKMeRAVMNJtXGsZ7
         E7RqMNttjkyvw==
Message-ID: <77838f03-ef45-114b-bfed-2f12e568a644@kernel.org>
Date:   Wed, 1 Dec 2021 18:45:06 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: Add Qualcomm SM8450 DT
 bindings
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211201072557.3968915-1-vkoul@kernel.org>
 <20211201072557.3968915-2-vkoul@kernel.org>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20211201072557.3968915-2-vkoul@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

On 1.12.21 9:25, Vinod Koul wrote:
> The Qualcomm SM8450 SoC has several bus fabrics that could be
> controlled and tuned dynamically according to the bandwidth demand
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>   .../bindings/interconnect/qcom,rpmh.yaml      |  11 ++
>   .../dt-bindings/interconnect/qcom,sm8450.h    | 171 ++++++++++++++++++
>   2 files changed, 182 insertions(+)
>   create mode 100644 include/dt-bindings/interconnect/qcom,sm8450.h
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
> index 3fd1a134162d..cbb24f9bb609 100644
> --- a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
> @@ -104,6 +104,17 @@ properties:
>         - qcom,sm8350-mmss-noc
>         - qcom,sm8350-compute-noc
>         - qcom,sm8350-system-noc
> +      - qcom,sm8450-aggre1-noc
> +      - qcom,sm8450-aggre2-noc
> +      - qcom,sm8450-clk-virt
> +      - qcom,sm8450-config-noc
> +      - qcom,sm8450-gem-noc
> +      - qcom,sm8450-lpass-ag-noc
> +      - qcom,sm8450-mc-virt
> +      - qcom,sm8450-mmss-noc
> +      - qcom,sm8450-nsp-noc
> +      - qcom,sm8450-pcie-anoc
> +      - qcom,sm8450-system-noc
>   
>     '#interconnect-cells':
>       enum: [ 1, 2 ]
> diff --git a/include/dt-bindings/interconnect/qcom,sm8450.h b/include/dt-bindings/interconnect/qcom,sm8450.h
> new file mode 100644
> index 000000000000..786fce091c84
> --- /dev/null
> +++ b/include/dt-bindings/interconnect/qcom,sm8450.h
> @@ -0,0 +1,171 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2021, Linaro Limited
> + */
> +
> +#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_SM8450_H
> +#define __DT_BINDINGS_INTERCONNECT_QCOM_SM8450_H
> +
> +#define MASTER_QSPI_0				1

Why not start from 0?

Thanks,
Georgi

