Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD6B5552DB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 19:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376827AbiFVRvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 13:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359437AbiFVRvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 13:51:44 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3CD35241
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 10:51:43 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id a11so11509878ljb.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 10:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=lyHjNlGIepIT/t3IaYDnRx3eF0Wl2lezOvJ866alVNE=;
        b=phpEogNR2Dg76Apl+C0m8n/9gUnfdkc6rnmv8hg35SveC82wohLJms9nr8qUFjSTrt
         4Wqhfvb7TrbFI0PccZBegFGbM6GWr4WH60OyCtbhsxjLU5Gc19GKXWPP4ElsqfSX70r4
         GI8QbEhNgxtYK4Xyzgo0aD4lxO8yoOXSP1ERqgttwcWrM9LBVriiDKrg6TWygQvTAYD1
         gwUXdUJl30pALaY/eKtcdJDLVMhcpnDNUTG8kt/basq2l9yPy5n4cAJPiHRVjSyhApU7
         AIhFhue8YAUjo6mD/YxRMnzlCFrk8+m/fUb1RIXRUrWefCqJsAgGjAgmDmmRQZi0niT4
         eSPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lyHjNlGIepIT/t3IaYDnRx3eF0Wl2lezOvJ866alVNE=;
        b=M6EQmjLsgHUGeOHn86cncyU9cTJcaSMUtNCQiq+0wl4rlxHHO+tzp/LFeSkxOrNfOH
         grsiK8RbcxCDhRVzzY2j5V4f68lTOcTPgAAwh4oxiQlsV+DfLpt8plnsR5qecs0YDsN4
         +Y6fd8D/r8kiW7mgmBTtL7DPTu6+HCM3JpXG9Rfu1iPv7ri8o73tiuqpFm02nqjwv55U
         bw+pFlSVaXuVe4kA56LmuY6RWDelxO5SR5LK6n/w0627OoHNmtE9WriA4ic43c5VKLLI
         32Phtm3cOLh28dXlug69+MLXsdZR45QzgBf7PmTtoTRGnww+XCpUkFZdT4xyo4QKQuE4
         /7Ng==
X-Gm-Message-State: AJIora8KeBqUCdIsLaZjgjpISNW5raG3q0GX3QGuxW7ZuvAoDXIQt8/i
        S9RzlpLlouePkl09k/Hb6lDk1Q==
X-Google-Smtp-Source: AGRyM1uqRH0eeNtScZfg9vgahrtzqeNiUZh3ZaiXJFRiWQWm4xvksCJ8mnE2AFxPxob07sW9BfcD1A==
X-Received: by 2002:a05:651c:211e:b0:25a:88ca:d766 with SMTP id a30-20020a05651c211e00b0025a88cad766mr2448216ljq.230.1655920301613;
        Wed, 22 Jun 2022 10:51:41 -0700 (PDT)
Received: from [192.168.1.212] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id k1-20020a192d01000000b00478fc20dc88sm2628594lfj.73.2022.06.22.10.51.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 10:51:40 -0700 (PDT)
Message-ID: <54ef4527-bb30-c7c6-ab74-0a2557c763cc@linaro.org>
Date:   Wed, 22 Jun 2022 20:51:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] dt-bindings: msm: update maintainers list with proper id
Content-Language: en-GB
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, vkoul@kernel.org,
        agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org
Cc:     abhinavk@codeaurora.org, quic_aravindh@quicinc.com,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1655916953-32039-1-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1655916953-32039-1-git-send-email-quic_khsieh@quicinc.com>
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

On 22/06/2022 19:55, Kuogee Hsieh wrote:
> Use quic id instead of codeaurora id in maintainers list
> for display devicetree bindings.
> 
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> index cd05cfd..c950710 100644
> --- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>   title: MSM Display Port Controller
>   
>   maintainers:
> -  - Kuogee Hsieh <khsieh@codeaurora.org>
> +  - Kuogee Hsieh <quic_khsieh@quicinc.com>
>   
>   description: |
>     Device tree bindings for DisplayPort host controller for MSM targets


-- 
With best wishes
Dmitry
