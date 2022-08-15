Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95857593632
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 21:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243488AbiHOSwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 14:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244203AbiHOSqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 14:46:45 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2BD41997
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 11:28:20 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1168e046c85so9015862fac.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 11:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=nzkiEUN15yoqYwUDSmfmqqu1RJj8u2Ige+qgLeq8dNM=;
        b=FnOF2oSIHjQvZrwpfABWIYj5vm/rL+xzLQN5tdxF2TYxqZl7qfG/TuxzlBQYurEeLV
         I7stWMJfvgdP2wA7mAtXJl9tEcWoBK6sRrn29p4ZXtpm86Xn1LRa07Zfat736zBxea/S
         s8FIVp85dDCCT3qWBTQjjrkzZfdG/qlXPvPclxM6ugvyfNVmBxHVIwuDgaRtCz2eoMnX
         BnF8b9Joa5itybCca04tGBL0/1r9KU/W10Q048cHl6o7ETTrp/cMXBqvk8MpjULc+rw9
         aEgf54uj6sh0mhJTk7OKhGYLUOP6Gy7n7d+zCu8cqJAWwsGvDGE80moCkuDC4Ea4SJzP
         ndAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=nzkiEUN15yoqYwUDSmfmqqu1RJj8u2Ige+qgLeq8dNM=;
        b=LMMXJzZp9q1YPFZWeR6TniTqc4orbp/YvErDuH15dneUyJhQG3XVMh+yhuf55pz7IS
         9+/cW9W/PqZVPAJxUSvj+0/lSoskUws5zoBQoSyJ2wyybMT9E7Q7vL+R5L3d/lmFIYRU
         i56MeJUUmVas4DFpgYJMhuymjgnyKrLjkRuE8XEs9m/H+YaD9U0um5sRkM63hadFzdeL
         ahow8z717bm7gCqDHQbO9nRc/AgCvGKOpNKNNOz6sMe7vLcUsKLplhclCSDDorMZXqBB
         5DmF9SlY07xIqLDqK8kMCSvHIwdxijaPY40CPqd1jbkGvKq0y7kCfetatdTe17hjzelN
         VGVw==
X-Gm-Message-State: ACgBeo1xV4joiDjtzoZO8cxIUpqlNa4Kmy/wrXx/GxrMNDdxTsSEnAUy
        hUodLx6B5RANW0sPE2hRMD3RdOtJXsnhQTIKbUBQwg==
X-Google-Smtp-Source: AA6agR4FscaLC2K7CnGdFK/q1e0Cm8YfPFt5HcTAN/4NAB1QfTL5GPe7+vLFjgDWtK8eYVDrTdv0xm2Bk5gFEK24ec4=
X-Received: by 2002:a05:6870:a18c:b0:118:5b96:1cc6 with SMTP id
 a12-20020a056870a18c00b001185b961cc6mr6865278oaf.105.1660588099459; Mon, 15
 Aug 2022 11:28:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220726084520.2895454-1-bhupesh.sharma@linaro.org>
In-Reply-To: <20220726084520.2895454-1-bhupesh.sharma@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 15 Aug 2022 20:27:42 +0200
Message-ID: <CAPDyKFqK3ywB9HW_FDdHTLNJ0rcVt3t7uMfJsBwfC1p0YhLrXg@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: mmc: Set maximum documented operating
 frequency as 384MHz
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, robh@kernel.org,
        bhupesh.linux@gmail.com, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org, agross@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jul 2022 at 10:45, Bhupesh Sharma <bhupesh.sharma@linaro.org> wrote:
>
> As Ulf noted in [1], the maximum operating frequency
> documented in the mmc-controller device-tree bindings
> should be updated to the maximum frequency supported
> by the mmc controller(s).
>
> Without this fix in place, the 'make dtbs_check' reports
> issues with 'max-frequency' value for ipq8074 sdhci node:
>
>   arch/arm64/boot/dts/qcom/ipq8074-hk01.dtb: mmc@7824900:
>    max-frequency:0:0: 384000000 is greater than the maximum of 200000000
>
> [1]. https://www.spinics.net/lists/kernel/msg4442049.html
>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  - v1 can be viewed here: https://lore.kernel.org/linux-arm-msm/20220725180916.2850228-1-bhupesh.sharma@linaro.org/
>  - Rebased on linux-next/master
>
>  .../devicetree/bindings/mmc/mmc-controller.yaml     | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> index ff5ce89e5111..802e3ca8be4d 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> @@ -88,11 +88,18 @@ properties:
>      default: 1
>
>    max-frequency:
> -    description:
> -      Maximum operating frequency of the bus.
> +    description: |
> +      Maximum operating frequency of the bus:
> +        - for eMMC, the maximum supported frequency is 200MHz,
> +        - for SD/SDIO cards the SDR104 mode has a max supported
> +          frequency of 208MHz,
> +        - some mmc host controllers do support a max frequency upto
> +          384MHz.
> +      So, lets keep the maximum supported value here.
> +
>      $ref: /schemas/types.yaml#/definitions/uint32
>      minimum: 400000
> -    maximum: 200000000
> +    maximum: 384000000
>
>    disable-wp:
>      $ref: /schemas/types.yaml#/definitions/flag
> --
> 2.35.3
>
