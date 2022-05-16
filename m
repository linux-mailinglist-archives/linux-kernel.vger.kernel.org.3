Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28CA52937D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 00:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348495AbiEPWQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 18:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234501AbiEPWQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 18:16:13 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C972C123
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 15:16:11 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id b20so13348134qkc.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 15:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=EDpKgH3/WPZM/363RddYVU5cX26QwXiUYlUKXjvLI+w=;
        b=rr0Lzlh4RQe5+hFaBPjqPfkCkryQUmL7dQa++VAGdy52rMii+uf5cEQYN0/J/o1IBf
         uR4WcAfuUSb+weiCYWwpFa9EXBjFsvyC81WKH1B6mUA5Qzt666Yf7WWD+0r2SOXltpcV
         vUL6IUV/O21kvSj5iTVHZ6ivPLn6NrIyG3S4zB2HCc3fbp/3NKE85/Zir1Qn8NjQSBs5
         Gk4FCwBor0V8fIPZ0q9GztHXRakIuhk8qYv0TXQjtVS7TBVlG4obJhZjI5EiRWhUZ2U8
         jYX21mOkrSrXPHuDr1mRj4m9lLMhCMAiYONHrx93BZriczvyMaHaSnLEuPRceClGuftI
         SFnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EDpKgH3/WPZM/363RddYVU5cX26QwXiUYlUKXjvLI+w=;
        b=764+zME6Vhb0D7HHjmN5B89+0M9v7l6c5HKPJGBYttKW/yccwsKNrtw/hAdS/ZR+HI
         ATRw6QNeLqgSGuP6u3znLW6MXrDNeDss07ML2EhQAbBUyDK2EjgdHNQT0BoozIgd0NPG
         LNZ66NI4f3De4gEP0ouNbnOCfDKw/VGc4lUTdTLj9IDZg5ipsSpwADp1Jmh4nJ952PLz
         OuiN+28jpAC/OoQvpSpXhOj1IufvWjBE7E7zTGS4ee7MfQ6q+gE0jGcsWTNROl16FIm1
         UhJ52BNFDAbQt+M3mgI885LYPWVXZ+NqOgN6SNxuqoGgzplIOcDAf+DtWNi9IK5J69v0
         +JwA==
X-Gm-Message-State: AOAM531UhX6mkpFwX6wM8oXcXb7+/QKu48pW8ZIiHv8AqiFRPmUpCk/m
        p2BajN4gRpucdycSmBm6EQ/UeA==
X-Google-Smtp-Source: ABdhPJxG7XD4iDKgNS58sELNuzjPJk3namOwny1F4tvwGJp483qDx5nUXnvRn7ROwnWdZjAvvLQlyQ==
X-Received: by 2002:a37:b986:0:b0:69f:ed3a:55cc with SMTP id j128-20020a37b986000000b0069fed3a55ccmr13892091qkf.558.1652739370681;
        Mon, 16 May 2022 15:16:10 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id 2-20020ac85902000000b002f39b99f6b3sm7091530qty.77.2022.05.16.15.16.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 15:16:10 -0700 (PDT)
Message-ID: <a17603a8-f273-0dde-8e84-3c0616ff04aa@linaro.org>
Date:   Mon, 16 May 2022 17:16:08 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 5/2] dt-bindings: interconnect: Remove sc7180/sdx55 ipa
 compatibles
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Mike Tipton <quic_mdtipton@quicinc.com>
References: <20220412220033.1273607-1-swboyd@chromium.org>
 <20220415005828.1980055-1-swboyd@chromium.org>
 <20220415005828.1980055-3-swboyd@chromium.org>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <20220415005828.1980055-3-swboyd@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/22 7:58 PM, Stephen Boyd wrote:
> These interconnects are modeled as clks, not interconnects, therefore
> remove the compatibles from the binding as they're unused.
> 
> Cc: Alex Elder <elder@linaro.org>
> Cc: Taniya Das <quic_tdas@quicinc.com>
> Cc: Mike Tipton <quic_mdtipton@quicinc.com>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
> 
> I don't know who should apply this. Probably whoever takes the dtsi
> patches, Bjorn?, because otherwise dt_bindings_check will fail.

I don't see this commit applied anywhere, though I
might have missed it.  Is this for Bjorn, or Georgi,
or someone else?

					-Alex

>   Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
> index 5a911be0c2ea..ab859150c7f7 100644
> --- a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
> @@ -31,7 +31,6 @@ properties:
>         - qcom,sc7180-config-noc
>         - qcom,sc7180-dc-noc
>         - qcom,sc7180-gem-noc
> -      - qcom,sc7180-ipa-virt
>         - qcom,sc7180-mc-virt
>         - qcom,sc7180-mmss-noc
>         - qcom,sc7180-npu-noc
> @@ -68,7 +67,6 @@ properties:
>         - qcom,sdm845-mem-noc
>         - qcom,sdm845-mmss-noc
>         - qcom,sdm845-system-noc
> -      - qcom,sdx55-ipa-virt
>         - qcom,sdx55-mc-virt
>         - qcom,sdx55-mem-noc
>         - qcom,sdx55-system-noc

