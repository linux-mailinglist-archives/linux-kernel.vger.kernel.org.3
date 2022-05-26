Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D12534740
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 02:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243389AbiEZAAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 20:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbiEZAAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 20:00:44 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D278C9E9C9
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 17:00:43 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id m11so153344ljc.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 17:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5zFPj/Lsz3VZ73WXe7ELTaWMJ+ZxRrgEb+Xb7Ni6Ng8=;
        b=rRb5O2lnxUEM86uGzt4QARS8Zro0rCTRgxDkl72s/BixfUdbeOJwKVcaD6sELjlSeL
         4wmxYHFoW+AHCNuRytUGE4osuUmVWxyQCJatTr9mFb0JWbVTuj5hDcbb9Bx8ah5Y2ANr
         oZTJ2gOqyKcx6NfQ1+DdnUw4f+31qvAbu/fiaIekn4aWvMj0V7Z20BLH0f0nR83FZBeU
         8K4sAyz8DXY7Xn2Bgx2Y+YDU1ceZ5+zxwx6tlN/oN5VCtrNT8SE8QCnKSE4zm7F87OUp
         ALjVkTFCx/ZYSdNj/vQB71ouBav/PQRWiNsrSOYkR4UPxJwDV5WsXpsy1zIVEox2c/E7
         8wnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5zFPj/Lsz3VZ73WXe7ELTaWMJ+ZxRrgEb+Xb7Ni6Ng8=;
        b=Rk4LxUXfApkFTMcNK1VQKNBRm8fGPq4Kg8w85JxWlmQJeiEdZRnJjZ0FQP3VRN1c95
         rn8SJLNqRorVe44FJGaNQ8Hv5f6mkD+O5/NfYNsGfAmxtdG4djo7APe14iypuL0NAMEX
         IdT0jQ2ATi0Ls7o2p8xGS9o4e8KW5lUvJt/g7xegILgqTnK0t6dAjcta/6jGmAZj+j05
         MtKu2pBedwvzISGwAuK762BYyiA7ABTbjkzZFN9afEoXv1RFIMc6B2LOpdqt0VyHwtqO
         LGBmdvCnKvNqV3f6o5IQpJ5B/cFOL6AXHReyoRIN0BARLhhDcxhS//DsAhJHTQ0GKBFc
         co4A==
X-Gm-Message-State: AOAM532YfA1fvpCk7ci8IRCHWp5jm8UjA/7OPxX/vpVdLrsCLASRFyPh
        QrDxQTjJNr75t0k1SxkPMsV2VA==
X-Google-Smtp-Source: ABdhPJziV0fg3DLoCNTmn2wELrZo2bGxcnHBlQlnXkE4kaPIaEikeAE1K5M8cxYQfWgnJZf5fwVgtQ==
X-Received: by 2002:a05:651c:512:b0:253:fd41:12eb with SMTP id o18-20020a05651c051200b00253fd4112ebmr5878583ljp.429.1653523242170;
        Wed, 25 May 2022 17:00:42 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id d13-20020a19384d000000b0047255d2118fsm16353lfj.190.2022.05.25.17.00.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 17:00:41 -0700 (PDT)
Message-ID: <941eb91e-cc80-4987-f481-63bd53b739e0@linaro.org>
Date:   Thu, 26 May 2022 03:00:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v13 1/3] phy: qcom-edp: add regulator_set_load to edp phy
Content-Language: en-GB
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        agross@kernel.org, bjorn.andersson@linaro.org
Cc:     quic_abhinavk@quicinc.com, quic_aravindh@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1653512540-21956-1-git-send-email-quic_khsieh@quicinc.com>
 <1653512540-21956-2-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1653512540-21956-2-git-send-email-quic_khsieh@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/05/2022 00:02, Kuogee Hsieh wrote:
> This patch add regulator_set_load() before enable regulator at
> eDP phy driver.
> 
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/phy/qualcomm/phy-qcom-edp.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)

-- 
With best wishes
Dmitry
