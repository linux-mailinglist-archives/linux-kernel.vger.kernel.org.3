Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6091650BBB7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 17:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449463AbiDVPc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 11:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377794AbiDVPcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 11:32:22 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3387F5D648;
        Fri, 22 Apr 2022 08:29:28 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id e2so5298925wrh.7;
        Fri, 22 Apr 2022 08:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7CJFggtV+qbVm+vx1mWXtLgoNJlaTKSAglgOgNLxrFw=;
        b=nNk2fwG8qYWFD/V8Qs3GK9eyHJuu7PFXywZgc5i6Vrm9h5unYx2W2kULcaI+h+5o5n
         MkOChHCJCOrN93vLOCk5UvewvWRmG8fX+cp6R9hjXIT0R1lr/J71yPc5YzTHNuumzhC3
         1lEnKEosS/Hb4YOEfUHPMJk3vxKZRgIQLW3ZvFxblcfc4heA4r2HVH+rgQ/3aCykJ07U
         zcl+lZGxd4OYsJ8+g6biyuuZ73lrjEqvFSCMsFXay3dd//UHFhjbQcLwoFMVjdYb1nJw
         nxE+DYY9Yxn56JYjjMX/54ewDuwKwkjZ47igmoPbrBh+Iy29/1wNnICNLhRFVGWJzN9j
         qMIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7CJFggtV+qbVm+vx1mWXtLgoNJlaTKSAglgOgNLxrFw=;
        b=Wf4eb6j7UaAZB8h4757nBihTDdH4CXkFiGm+epXqIJ+mwodC5C7kopdWb872dMAM1Y
         VuaEz6m8qaD2PCT/sWavZPHokou+J6VFDzppTZnv3kgg/JNKYsbFT8qfybOkhJTlFP8Z
         RsKPM6aga9LE0n0cEPs8qxINbh/0iwIkd4IEHqMbNiHevQ3zyd6SNMz2AyaIymE5Lc3b
         GeZYmj0+z29hzIkIYKPmcVGP74p6jC2Kzv4h9kwDgu4EjY4MpCkZS4tpbqHH1CwSBaQB
         C4MTHkuxR6uYVs6XGLl81vgMcDL/SsSxDUba3+QkrBoBJqaouMTMlSiCC5PCK8GEn00j
         4kpA==
X-Gm-Message-State: AOAM530QaazBpxKk7++shhMdvaEO0Iv8Xp60wgFZyodXyBCTFTc6DJVv
        A9iBAjjMMHQvjoSkUYtwFZ8=
X-Google-Smtp-Source: ABdhPJzB6yGh8Mk4HIz4bYLXtwzWGwyWB6T2XW8pPrpVOQ+A9SRHhiBmTfRmJN7ThoZMIQcqGqyIDQ==
X-Received: by 2002:a5d:4ec6:0:b0:207:a120:b2c5 with SMTP id s6-20020a5d4ec6000000b00207a120b2c5mr4275161wrv.481.1650641366716;
        Fri, 22 Apr 2022 08:29:26 -0700 (PDT)
Received: from [192.168.1.145] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id l8-20020a5d6d88000000b0020a98986534sm2093115wrs.43.2022.04.22.08.29.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 08:29:26 -0700 (PDT)
Message-ID: <9499ded6-22c3-17b3-e1f7-e982d063f1f1@gmail.com>
Date:   Fri, 22 Apr 2022 17:29:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] arm64: dts: mediatek: mt8173: Add gce-client-reg handle
 to disp-mutex
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, robh+dt@kernel.org
Cc:     krzysztof.kozlowski@canonical.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20220228110329.245366-1-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220228110329.245366-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/02/2022 12:03, AngeloGioacchino Del Regno wrote:
> Add a gce client reg handle to the disp mutex to enable MT8173
> platforms to use MediaTek's CMDQ for extra performance.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Applied, thanks

> ---
>   arch/arm64/boot/dts/mediatek/mt8173.dtsi | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> index 291db4fcbb25..9eaea1156e25 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> @@ -1278,6 +1278,7 @@ mutex: mutex@14020000 {
>   			interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_LOW>;
>   			power-domains = <&spm MT8173_POWER_DOMAIN_MM>;
>   			clocks = <&mmsys CLK_MM_MUTEX_32K>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1402XXXX 0 0x1000>;
>   			mediatek,gce-events = <CMDQ_EVENT_MUTEX0_STREAM_EOF>,
>                                                 <CMDQ_EVENT_MUTEX1_STREAM_EOF>;
>   		};
