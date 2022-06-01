Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E1153A38B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 13:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350337AbiFALGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 07:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345782AbiFALGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 07:06:07 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EB3880C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 04:06:05 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id fd25so1672806edb.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 04:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zmUkWzeg4eeXLMNd3lfhrjjKEKVUaxqNRQUp3Ckt2Z4=;
        b=qocjSTMUZH9T2IQW3/obAwuW9pk070LbB8GfsSOVnRtrD9fopdPRvwtZ/JfC2x2L4J
         s5/HxRxzngbaSRGdruiCod/zCu5dVCoKc7Njqlylpz7FZev1Vq0oO8Ob0TDA/S9e0fyw
         jPZaEZBDl9f10zp324+0LbUUd6G1CNhCgcyGBGJtqyelHCqjhjGgm7MobkfDjJGItaHW
         0cVEkxV9zabA0mHtS1vCKHvyUb173mglxwrPfO/75smUNJEHUn4ROWpiZ5pwtUKt5Oik
         hd6Zz89OHoU3KlvkUQe5g9svtxh4Al9HXjzYeelvrQKXepE9z3xt6+d99zSfaPQzBsCI
         BOMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zmUkWzeg4eeXLMNd3lfhrjjKEKVUaxqNRQUp3Ckt2Z4=;
        b=g+vjefyY8bvjzvnKVr9wrm5CwmBam49X1x/1X4nenROf3KukuRh3ynfryOzwJpyBGA
         IWhqgmiMhOx5pZ3f1B1wgpE1lvp5TMHMJqzPSfAIQ83FglZMrGKf9c+8KzdhCYMDZ5d7
         wsb8hXPt2+t14IcS1w+s5J7OpmlvVNf7iqwCOjGoXjLvChjpRsYpYBZXEM3XUUqdA1eF
         ZnthT8Dm9JqaXnyPTMMy9lpXeqTvpSJdN60gJLbfbdP23iZgA08Ku+5bt5DwoPYS3C15
         TuVq+7yZH+6tNKIsfLiulBpLnb0QctIDhHMlGL72QAEOW95CeqsFhFrxA13xlc7iyT4g
         MpOA==
X-Gm-Message-State: AOAM532iWiqztJijr/12BBf+BKdFA25RRFS2Yw5/Mn5mSXruRTPLawZ+
        OocGapLiWp/un+d88jAtzHh3rQ==
X-Google-Smtp-Source: ABdhPJxGZfvPCA32qvZADlQLYkYuCMi7rvAeDhPjUHEigzmSsilnTNVK6tD84n4NNi8pnBGkqXJV0Q==
X-Received: by 2002:a05:6402:2553:b0:42a:ef31:4444 with SMTP id l19-20020a056402255300b0042aef314444mr69111155edb.46.1654081564014;
        Wed, 01 Jun 2022 04:06:04 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id bk2-20020a170906b0c200b006fef557bb7asm572545ejb.80.2022.06.01.04.06.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 04:06:03 -0700 (PDT)
Message-ID: <3389a816-0f51-ab83-1026-2201017a2f12@linaro.org>
Date:   Wed, 1 Jun 2022 13:06:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 08/11] ARM: dts: qcom: sdx65-mtp: Increase the vmalloc
 size
Content-Language: en-US
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wim@linux-watchdog.org,
        linux@roeck-us.net
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        manivannan.sadhasivam@linaro.org
References: <1654080312-5408-1-git-send-email-quic_rohiagar@quicinc.com>
 <1654080312-5408-9-git-send-email-quic_rohiagar@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1654080312-5408-9-git-send-email-quic_rohiagar@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2022 12:45, Rohit Agarwal wrote:
> Increase the size of vmalloc using the bootargs in sdx65
> mtp board.
> It is failing to alloacte the size needed for firmware and
> giving the error logs due to actual vmalloc region lesser than requested.
> 
> cat /proc/meminfo shows the size of VmallocTotal as 245760 kB.
> 
> [ 10.980356] vmap allocation for size 268439552 failed: use vmalloc=<size> to increase size
> [ 10.980505] qcom_q6v5_pas 4080000.remoteproc: unable to map memory region: 0x90800000+10000000
> [ 10.988542] In adsp alloc memory: adsp_probe 482
> [ 10.988592] remoteproc remoteproc0: releasing 4080000.remoteproc
> [ 11.001598] qcom_q6v5_pas: probe of 4080000.remoteproc failed with error -16
> 
> Thus, increasing the size to 300000000 as modem is not the only one using vmalloc region.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---
>  arch/arm/boot/dts/qcom-sdx65-mtp.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-sdx65-mtp.dts b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
> index 85ea02d..966385f 100644
> --- a/arch/arm/boot/dts/qcom-sdx65-mtp.dts
> +++ b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
> @@ -21,6 +21,7 @@
>  
>  	chosen {
>  		stdout-path = "serial0:115200n8";
> +		bootargs = "vmalloc=300000000";

I understand that issue comes from SoC-related driver but this is not a
property of the hardware. This could be added by bootloader if needed,
but in regular case this is a system setup parameter, so it does not
belong to DTS.

Best regards,
Krzysztof
