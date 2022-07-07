Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA428569B45
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 09:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235143AbiGGHDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 03:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235072AbiGGHCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 03:02:47 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8620631219
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 00:02:34 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id a39so21090854ljq.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 00:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=eskG10ne3YWs38KEldudontLzs+ZPvsxgipjdxWifI4=;
        b=TJI7aGxHDGnIBbTc/xwugkSrZklg9G/ApWT1dIdrcN48L9yIhdb4Q3leMyjBHCoOxy
         GwEqn2aomlIs4leTEfuxP+XnL17cvw4sMFpGTHMGndmCn70gzJ8Xy1rdQZrWrdyE601C
         +u7U3woz2MTHADw3lfZEHsUMDrC/9LSeHFWVmbVzHSolc0gg12jllVTs6AIQzO/MSH3l
         IsLWltQBCNJalbSRIavoW9E12KRy+HMzIH6EasR2YZ7+0DvOpvzqFlol2BVk07fp+2uD
         649hzaEt3T/NCPqSv7jv9L75v8fSyGD3w85sZWdFej+S91yg9/5eq/dzOMv46w7PcEX7
         BdmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eskG10ne3YWs38KEldudontLzs+ZPvsxgipjdxWifI4=;
        b=Bkehimz47ilhg+WmQ52eDdBMCyUifAyYRu4lzUCofNUqWTcxn+nkH4puQRcc8Yp4h/
         32IPSy0wBohEqwksv82yD+1K9fHqofglXMO7liJlXzMu7kYp3I378SO52XP660k2fedO
         BzN2WyGgibyIFajIJYKj7WKDlB9gdxHCxIlhGrKcAIeGQsVvRszSPhaCSchX1WycD6/Z
         zS8R2x9wT29wiwQzNHQRUoCxhB9thLOyTrHUqDz2CDE9l7NJmWgX0AOMwPu/tXojYcOV
         5Vn1YCDaxck4IUfswHD4DxSdTw42E6DH3jnpbyuRHA/Y13bsxz81dBAZzKRshnY8AvW3
         YSOQ==
X-Gm-Message-State: AJIora+2gVKDuNPZJgMGxvhD5cfYzBcp5Uj8rQnk6emX0rwqL45mrc5t
        vReQbvn6yYuZVgEY6qH1RxdOmA==
X-Google-Smtp-Source: AGRyM1vh00Jq/dsU1Ex0hoAH49aA8RnZTGUqhwi+MAYpHBFLG3wACRh+GfJJcXVCSaEH8bn9rleh7A==
X-Received: by 2002:a05:651c:230a:b0:25a:7556:d865 with SMTP id bi10-20020a05651c230a00b0025a7556d865mr26190591ljb.42.1657177352817;
        Thu, 07 Jul 2022 00:02:32 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id z25-20020a195059000000b004853028282bsm967104lfj.270.2022.07.07.00.02.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 00:02:31 -0700 (PDT)
Message-ID: <f373aeeb-7f8e-5eb4-9230-4cb924032e5e@linaro.org>
Date:   Thu, 7 Jul 2022 09:02:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] Revert "arm64: dts: qcom: Fix 'reg-names' for sdhci
 nodes"
Content-Language: en-US
To:     Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     swboyd@chromium.org, Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220706144706.1.I48f35820bf3670d54940110462555c2d0a6d5eb2@changeid>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220706144706.1.I48f35820bf3670d54940110462555c2d0a6d5eb2@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/2022 23:47, Douglas Anderson wrote:
> This reverts commit afcbe252e9c19161e4d4c95f33faaf592f1de086.
> 
> The commit in question caused my sc7280-herobrine-herobrine-r1 board
> not to boot anymore. This shouldn't be too surprising since the driver
> is relying on the name "cqhci".

Thanks for finding the issue.

> 
> The issue seems to be that someone decided to change the names of
> things when the binding moved from .txt to .yaml. We should go back to
> the names that the bindings have historically specified.
> 
> For some history, see commit d3392339cae9 ("mmc: cqhci: Update cqhci
> memory ioresource name") and commit d79100c91ae5 ("dt-bindings: mmc:
> sdhci-msm: Add CQE reg map").
> 
> Fixes: afcbe252e9c1 ("arm64: dts: qcom: Fix 'reg-names' for sdhci nodes")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> This is just a straight revert. That presumably means we'll get some
> "make dtbs_check" warnings that were fixed by the commit being
> reverted. I'll leave it to the authors of the original commit to
> adjust the bindings to fix those.

Thanks for the report. I can help here.

Best regards,
Krzysztof
