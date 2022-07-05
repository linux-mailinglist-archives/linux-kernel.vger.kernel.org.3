Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C557E566A60
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 13:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbiGEL5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 07:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiGEL5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 07:57:50 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E3817A8E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 04:57:48 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id t24so20161013lfr.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 04:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qaINgCuKuJ+N1ufby3FpYQHPfvNiLqvgxHa2OLQIWmA=;
        b=blPdvfpnWXyoiDUEJ9FHfyni319pJqlaWVzo1nq7TQcChhXpSglNj11BGyisTYFms8
         CBvniqM1PHfW2gzYrI9J8YLf4LCwHz96O8zMB8MflAGuIELaaudTtfbcJzLFdAkawfJt
         bQN+hPH02uNSb/N/B3xkwLuQbOsRrk8dV+cdpUbX7p1DMnhkcZw5D3YNUvpoEKzLC+o6
         GD1juKKyGXdSW7/rjn8SAT+TAxOc/EcKi+yqFstvaZo2nyh6bHKGR6Y0cPJTuC16tbNu
         rXO+jAsswGptF+ICLapCVVqqaDcP/Orv9P2hA/mfeuqakkJsKG1yyanQbna4qr28R+uH
         EOKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qaINgCuKuJ+N1ufby3FpYQHPfvNiLqvgxHa2OLQIWmA=;
        b=DhhNjbbqRZil2zVhiaF9E8QPaQ5TopGTS/+7epHgWTnj+OrjFRCuzL96b3l+xN6Ysy
         tVQWPbP9MPY3muXV/nxbyqH+j2oHz4hJ7s/bqMStnrT1pkjzQCICuJMgFIQK66q0suQz
         UFVMcYErZdgZ+wSUX83a9GkenVcw/DfElEzCxaJ38R0Lnj9F3oDVgdJoLL+9iV1BtNct
         dKUl/KUAuZvDtCu2cNLoTPMI8M9W0gIq2CnBTUxvYoLNEbnkU6bEJMmGnbX7BCG7HLPE
         +VX+JgTjqJS1l51bc79/SRi34ojlKQf7pNrey98lrZc4w11RXhXHyYQfg04RCJZg/0Rq
         bFvA==
X-Gm-Message-State: AJIora8e6wGlKB8vQWmEdRiuEW+9kyu2SMDAf2QgJyRuEmAiUl2nwCWw
        VgfF70kTkxdkdqTSM4B+Sf1oUw==
X-Google-Smtp-Source: AGRyM1vw8JHN23QBD8OFiC77SIfwW/1Akm5wiorwWgqYv9VlDNfxj97acoUnG0qh8x29vNFdD21hmw==
X-Received: by 2002:ac2:5f7c:0:b0:47f:993c:49f2 with SMTP id c28-20020ac25f7c000000b0047f993c49f2mr21194682lfc.189.1657022267360;
        Tue, 05 Jul 2022 04:57:47 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id t6-20020a056512208600b0047f79487758sm5660680lfr.133.2022.07.05.04.57.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 04:57:46 -0700 (PDT)
Message-ID: <e0433a4a-475c-7a4b-29b6-461d04356084@linaro.org>
Date:   Tue, 5 Jul 2022 14:57:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 01/14] arm64: dts: qcom: sc7280: drop PCIe PHY clock index
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220705114032.22787-1-johan+linaro@kernel.org>
 <20220705114032.22787-2-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220705114032.22787-2-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2022 14:40, Johan Hovold wrote:
> The QMP PCIe PHY provides a single clock so drop the redundant clock
> index.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   arch/arm64/boot/dts/qcom/sc7280.dtsi | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

-- 
With best wishes
Dmitry
