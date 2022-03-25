Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9634B4E6ED5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 08:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345828AbiCYH2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 03:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237022AbiCYH22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 03:28:28 -0400
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525E8C681C;
        Fri, 25 Mar 2022 00:26:55 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id yy13so13641459ejb.2;
        Fri, 25 Mar 2022 00:26:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=a+j8iDAcqHRMjDYWdIndi1goKgpRCRF0MsuxhuhbRqA=;
        b=7S7mj5ISCtJtBwVd8qRZeIQ9rgMKS+9UjcgpbsRecrfkgVMdgZjU+f7YjjOADto5ZZ
         rCYWAJLCNbXXdoAIxkqudpSSjP/aZLXUsUL/g2Ac7kJm27XSp4BxCqnZp8f3Y5Xa0fam
         pflhxjPjwNWi66uCYEbyJHJqbS9hnk6xcbesLdweoQ809zE0+edDkTUPvg1pG4y5di1T
         rL3w8hwHTeeOrW9j3HUE2nPMIpCE9lGI2+jJwk4s1tJfulxTnptdBUZv+J44YAYCtRLx
         f+4Xzk0yl6vB8xZyo6fmAP5mPS2jMfljLsyFSMcFcooF3imPg5xGxrP4Bi/+aU/9FPjY
         jUbg==
X-Gm-Message-State: AOAM532xDljUqUKO5qiBcoPbhHnAuhLHF1cHBEriURfC1jjO6A8NVQwt
        OGNx+U3ZZcIiLVKyYLz3KhQ=
X-Google-Smtp-Source: ABdhPJwMjuFr8s+7vPIyoto5nV0AL7QjRXt4Feurs6e4O7RNqIl6/0ns0nzEUIUnG36qMugOEqnerg==
X-Received: by 2002:a17:907:980d:b0:6d6:f910:513a with SMTP id ji13-20020a170907980d00b006d6f910513amr9501941ejc.643.1648193213782;
        Fri, 25 Mar 2022 00:26:53 -0700 (PDT)
Received: from [192.168.0.158] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.googlemail.com with ESMTPSA id z6-20020a056402274600b004194fc1b7casm2526951edd.48.2022.03.25.00.26.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 00:26:53 -0700 (PDT)
Message-ID: <f35537de-6352-e6db-b4a6-17b1ab96deda@kernel.org>
Date:   Fri, 25 Mar 2022 08:26:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] arm64: tegra: Enable hda node for P3737 + P3701
Content-Language: en-US
To:     Mohan Kumar <mkumard@nvidia.com>, robh+dt@kernel.org,
        krzk+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com
References: <20220325072141.28597-1-mkumard@nvidia.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220325072141.28597-1-mkumard@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/03/2022 08:21, Mohan Kumar wrote:
> Add iommus property for hda and enable the node for P3737 + P3701
> platform.
> 
> Signed-off-by: Mohan Kumar <mkumard@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts | 1 +
>  arch/arm64/boot/dts/nvidia/tegra234.dtsi                      | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
> index 34d6a01ee1c6..156d5d95fde7 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
> +++ b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
> @@ -1751,6 +1751,7 @@
>  
>  		hda@3510000 {
>  			nvidia,model = "NVIDIA Jetson AGX Orin HDA";
> +			status = "okay";

Nodes are enabled by default. Why do you need this?


Best regards,
Krzysztof
