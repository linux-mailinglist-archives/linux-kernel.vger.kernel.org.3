Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5817D57A899
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 22:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbiGSUwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 16:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240377AbiGSUwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 16:52:32 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A2C5D581
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 13:52:30 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id y11so26944194lfs.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 13:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Ho1u9oc1apc82F45Rk9oxun953BzeyPs1KX47hNllAI=;
        b=kMqqrL9JmL46yF6vvzkb6mZxFbj79pluny/lypH5z4MCS7+BX/TzZUUukMm4C0lb8Q
         Bdtw0CDN3xAOOVCNoSLR4RAPyF2hIjFsrUuHvg3jrPbU5/JEUEcUXrQ525Yl8gJ6TRYC
         NMEUG2DKs+K7xldhKKRt+IYtZi9TXCb839mZuWJxQ583Hlj9cphocZuSQEnvrxyRYh6y
         /3Q+pmAAyVZfYeJcLCjTsKrVA3V6kDrcSML76HPPq8yq13GRl8bG7yZqLuGggIWDDsqf
         GHfep0RiP11ydodmMsQKicsYFIN0qqhAIHcuoub8oys5Dgz54sk2O7BhkW6K1W68e2gy
         Gxig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ho1u9oc1apc82F45Rk9oxun953BzeyPs1KX47hNllAI=;
        b=d6AioR708cweGu1q80uiyI1SvIPHHwOWBSUvIhOQe5v/Vi5+/BDiTewp4ueQfu1Wp6
         OsSiA/xG47LM28OybqedZaxSf0Uda5VLgTqRS2dlHOUItFxWEIkyEr1l5HU4oOIVuFRO
         poGv6vhU4iuEWN80z8hgS/qgRxlSSVL5AZKPIR0DyyVOtxhAyuQknAG+zaN9Qimafb53
         7U+BC9un4ebQe018O2s4LxN4VWhmCtOOZlX2/JS7kpJOAydKZkFhbfOavbOrIR5R/LxQ
         gNnb0ZyGv4dHjyNwpvLplJBn3woL6idMwZxum/ocaRyj855pqmg/L+EeFmWz3kucW62P
         f2Ug==
X-Gm-Message-State: AJIora/TkJJ+62cP05MG1+84sm9tMdOKW9sLRE+I01j1YRieWDh6/0tU
        +pxmCj7M4ZPPZMWRFYZee2bBVw==
X-Google-Smtp-Source: AGRyM1uHBdLqv9xfynVEESfNHGsY84N+vmJ7Np/W4Vb8HenavrduZnQQC7IhqClIQvuuCXS9EBNC8w==
X-Received: by 2002:ac2:4e12:0:b0:489:ddbe:83c5 with SMTP id e18-20020ac24e12000000b00489ddbe83c5mr19543003lfr.371.1658263948809;
        Tue, 19 Jul 2022 13:52:28 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id w8-20020a05651234c800b00489dedf1dcfsm3375566lfr.289.2022.07.19.13.52.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 13:52:28 -0700 (PDT)
Message-ID: <bdfdc102-7d42-dc36-5b54-664aa7392efa@linaro.org>
Date:   Tue, 19 Jul 2022 23:52:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 3/3] arm64: dts: qcom: qrb5165-rb5: Fix 'dtbs_check' error
 for led nodes
Content-Language: en-GB
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, robh@kernel.org,
        linux-leds@vger.kernel.org, pavel@ucw.cz, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org
References: <20220719205058.1004942-1-bhupesh.sharma@linaro.org>
 <20220719205058.1004942-3-bhupesh.sharma@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220719205058.1004942-3-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/2022 23:50, Bhupesh Sharma wrote:
> make dtbs_check currently reports the following errors
> with qrb5165-rb5 led nodes:
> 
> arch/arm64/boot/dts/qcom/qrb5165-rb5.dtb:
>   leds: 'bt', 'user4', 'wlan' do not match any of the regexes:
>    '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
> 
> Fix the same.
> 
> Also while at it, fix a blank line issue in the led
> node.
> 
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
