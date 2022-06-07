Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29C354046E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 19:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345344AbiFGRMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 13:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344376AbiFGRMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 13:12:07 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D311021FD
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 10:12:05 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id fd25so23877020edb.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 10:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=516c1ECeAdlTDYUv5SFW9WeHPEyFi2CPyVtGYdPkmAE=;
        b=dMWz8Fu3pnpw7EgoHQ8AoC3kGZ93ymrLgYNbUyChqTuJIaSdzlRMJYc2hThjfcvEwT
         xisRuno3peKuEKyqG+5tPELfFRBU2Y3AYcY56udOuCNl/HXC1GmQ44uxO5QgK53f83Ad
         jGFl9UVWsMqBujvYjmJ+ZL9zUiF2uoWE69PYXzH3dFDPvPYQtjKC21JkJLLCjPF9fcmP
         rJGzJo1Rh85V9h7gtjh0eSNaxu74ud8uzRJHGaIkkpDV2Q5u2UvTWGQKFUOHlQ9jGig4
         Z90ZJ6sS0msIRaYbPtWA/3DmV8Wg9rL3ldvq7sKcFIkCI4Y10GyX446hKN+OpDc4ETQP
         PP4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=516c1ECeAdlTDYUv5SFW9WeHPEyFi2CPyVtGYdPkmAE=;
        b=KTZDjnCwDqQfF9dN9nVh/MdupYfpM7LfZ+O7oKbdZrhWvvrC3lc/d1ahuvZKD48rqO
         OV+PjjU1bZtwlFwjvcIm9XKjK0x7+L8wkr9ENQ0udPUC/qAL9XDPrVUF90wNo93B+f12
         XwS6g5knhJFLlM3/uPCjR+unj9Zq/4q36lUwf7kgMqKgoOg6xkDOmIljGX0oRSmf63rl
         oblDS6HrZ4ErUFonB7kkFupD6cnWh+t7jN6YhL15dD8tEYePQC7p+3413kcSIIYO37R9
         cgYeEMPTTdJBAvXxnBBa90WgS6zAKNCZYOEE/EFaspNkhx2nOe2lbFHub+ntsFXt67aW
         nAEQ==
X-Gm-Message-State: AOAM532hen9wbAhpqEuFcD/2QccohOE5k8Dig1dI64zmJ+vSXm0PNIE5
        6KMaFrIfj8fw4zyUG2r5x46bgg==
X-Google-Smtp-Source: ABdhPJzvpSk0Qjg661liVIKltScH0Q9G3bh+JG3VX3DkiOZwIcBf4+cWHgZ6prLeIuDfqneiTvvBwg==
X-Received: by 2002:a05:6402:35c9:b0:431:3b5f:ecc1 with SMTP id z9-20020a05640235c900b004313b5fecc1mr18641630edc.349.1654621924477;
        Tue, 07 Jun 2022 10:12:04 -0700 (PDT)
Received: from [192.168.0.186] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id d19-20020a056402145300b0043151e18630sm4521204edx.21.2022.06.07.10.12.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 10:12:03 -0700 (PDT)
Message-ID: <cd9b1212-0950-9fd8-7481-e3ef14de2131@linaro.org>
Date:   Tue, 7 Jun 2022 19:12:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 1/3] dt-bindings: mediatek: add vdosys1 RDMA definition
 for mt8195
Content-Language: en-US
To:     Bo-Chen Chen <rex-bc.chen@mediatek.com>, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     matthias.bgg@gmail.com, airlied@linux.ie,
        angelogioacchino.delregno@collabora.com, pavel@ucw.cz,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        "Nancy.Lin" <nancy.lin@mediatek.com>
References: <20220606031818.13646-1-rex-bc.chen@mediatek.com>
 <20220606031818.13646-2-rex-bc.chen@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220606031818.13646-2-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06/2022 05:18, Bo-Chen Chen wrote:
> From: "Nancy.Lin" <nancy.lin@mediatek.com>
> 
> Add vdosys1 RDMA definition.
> 
> Signed-off-by: Nancy.Lin <nancy.lin@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
> ---
>  .../display/mediatek/mediatek,mdp-rdma.yaml   | 88 +++++++++++++++++++
>  1 file changed, 88 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,mdp-rdma.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,mdp-rdma.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,mdp-rdma.yaml
> new file mode 100644
> index 000000000000..678abb321cc2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,mdp-rdma.yaml
> @@ -0,0 +1,88 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/mediatek/mediatek,mdp-rdma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek MDP RDMA
> +
> +maintainers:
> +  - Chun-Kuang Hu <chunkuang.hu@kernel.org>
> +  - Philipp Zabel <p.zabel@pengutronix.de>
> +
> +description:
> +  The MediaTek MDP RDMA stands for Read Direct Memory Access.
> +  It provides real time data to the back-end panel driver, such as DSI,
> +  DPI and DP_INTF.
> +  It contains one line buffer to store the sufficient pixel data.
> +  RDMA device node must be siblings to the central MMSYS_CONFIG node.
> +  For a description of the MMSYS_CONFIG binding, see
> +  Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml for details.
> +
> +properties:
> +  compatible:
> +    - const: mediatek,mt8195-vdo1-rdma

During my review I missed that part. But your testing should not miss it
- please always run `make dt_bindings_check` and do not send code which
fails.

Best regards,
Krzysztof
