Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCC0527E49
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 09:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235932AbiEPHKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 03:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237000AbiEPHKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 03:10:15 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DA7E08F
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 00:10:04 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id b32so16996837ljf.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 00:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=sxWW7nN1MX4qR5x7vYWxWhZdhe/dlQM1wOVqJQxUPUw=;
        b=xfgSJvvTfpB3bhvG57n8DdOASbQWiiD0aJbEx2q9VQiFwTMWieLv+76CkJZ+U2n5nd
         SeLg+QQPZ6V0nSyPBqobwtFuUOpjjzJSoROqSiq2V7Lj9xLXR9XI2j8rJYfID1yZzMj8
         XYC4vFiYINn/Pu0Kw38I6/ttfnhseJChXYkyHSKswuerj7YUKcUcoGx6WrX3zTuWbAFj
         BTqaz6IRcnWwUweLAZORhNAjK8LbQDIP25u3i0mgFmyuV3xVI+3yddr0b/HTBSLyGUff
         JthW+Y2HVfZJFRs03mpTS0HA5Y3waFMYbEb0YtBrM8ENx2y/t+3UVmH84hiaV9lxEk+f
         7xOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sxWW7nN1MX4qR5x7vYWxWhZdhe/dlQM1wOVqJQxUPUw=;
        b=73oqqgTKc/OvalfrOeqvvL7ihkWvXH+wxPNNDTTOm1cfHDJp0CLyFiChhE/evMsZK5
         aCa3Ct5eSZ2Ib8pSfZar+gQP+DrYsHHZDE8PvfyR27SHnFdcOGrV0BNRBlxEjg0UI0Zo
         Va6/ubAD5AlqITxNgQ1y7IBBeNRJZkFWsZKJy/HjBoI+l1KtHBQ4dYtPUNH52Mu4dk2e
         M9es4Kik91FO+1tJ1oleQTE14NAprLQVOjIki1W4PpH10tfUCTg+Gd4pFM9B3DUcA58G
         Y7HqUw0yzNYK0ftfYRIAJBcaHt2U0T9mAFxUDoujP/Qpm40E5kGXQvlDKhXBNAOYnxsT
         pVdg==
X-Gm-Message-State: AOAM532cXyvh6LPnTZRiGksEyuze7UJBzbSE6wd4PW8cfNufxfqaIx2Y
        hSH9BTXKIYPMwFU07crqe2fbzA==
X-Google-Smtp-Source: ABdhPJzxRNYsZvOCN6MRG+JxA+WtxP3xo+m55ow/RQL6xD2LzouYeDYYoKb2Omp9nqb+r+aHW9F1iA==
X-Received: by 2002:a2e:bc14:0:b0:24f:5060:1dc3 with SMTP id b20-20020a2ebc14000000b0024f50601dc3mr10335364ljf.432.1652685003164;
        Mon, 16 May 2022 00:10:03 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id o5-20020a05651205c500b004758e4e6a96sm1222932lfo.245.2022.05.16.00.10.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 00:10:02 -0700 (PDT)
Message-ID: <03e99a02-1233-3882-e1e5-24ab1bbaf257@linaro.org>
Date:   Mon, 16 May 2022 09:10:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 5/7] arm64: dts: mediatek: mt6795: Add fixed clocks for
 32kHz and 26MHz XOs
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, paul.bouchara@somainline.org,
        kernel@collabora.com
References: <20220513171617.504430-1-angelogioacchino.delregno@collabora.com>
 <20220513171617.504430-6-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220513171617.504430-6-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/05/2022 19:16, AngeloGioacchino Del Regno wrote:
> Add the 32kHz and 26MHz oscillators as fixed clocks in devicetree to
> provide a good initial clock spec, since this SoC features two always

I don't understand that part with actual patch. You claim here you add
clocks, but in DTS they were already before.

Additionally, these clocks do not belong to DTSI because, AFAIU, these
are properties of boards. At least their frequencies should be moved to
the board DTS.



Best regards,
Krzysztof
