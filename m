Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C429B502F9F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 22:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351911AbiDOURz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 16:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351201AbiDOURx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 16:17:53 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2002E3A727
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 13:15:24 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id z15so6528937qtj.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 13:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=AVlaJ3+JyBV6uy3xWobzUMDIswV9zZwop66b5nDrPzo=;
        b=wSdp3PScNWgt43IiKr/hciI5s/OwStC/qks/OfNtWzDi5vqCFYT1i4FUnT/yyo45y7
         I2QnHgsoHk/9Fon0tTmegIm+Qk1aHed2P7V1tJgFrNo+gP8syAbBrI5XUouhDZ8LkI67
         LAzOTg08807jITxKhC2Ikja3M7B9BJd9GeGIelqA3Px1WYCFkdvhPdxPO3l2A3sdMgpR
         gY2kU4MnkUGQLd6uiuPhOkILltUAsVyS8zuvC9tjKksHf1+t0DX7rgHNUTSbza/xKkQ+
         mYTONn6lSMFITX2u4+9HlpWlOa3t88u1ui9j/fiiUtPhA2GtctviRH9RO0i1vweJNzyp
         60tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AVlaJ3+JyBV6uy3xWobzUMDIswV9zZwop66b5nDrPzo=;
        b=zT8mIMwkKI1Ubz9ohdiki/aKrFdkiGRi/HhqvrVi1PoeWqjaolQaxUW/MJeehGwejD
         ufwWkpDztqr5mLnqFXDnrGqyd8rnAp60IQbADUC8EgWYxEOJeHxgg1F9TuQhJvt5wB0P
         uXCPUe/AyuewxQYjBBDnq89LpRB3MbCA97tquHsp6797TawasKd3kWjIVCPYvIYTnCCc
         CLX79qEHh/p0a9+wlcEqEAaN0KDCCcQSVR/XPitfM3JQsBDgXr2PL01P/A4/aVvJ5o3P
         T5ItubnXaov8Enhu4OXQJETs6v0ljM/8oTOzm0Ck5fuX5I1o2lI4EuUlBAFWBCYpcSKO
         SWkg==
X-Gm-Message-State: AOAM533oQy12MDz4biHnbK5N371LIZFwBloRsl6A+Ji8sJ6vukcsJfDK
        uKt9KhVPgAXl0HIjYEyhG1r6Tg==
X-Google-Smtp-Source: ABdhPJyeAw9SUhcl+oEJ0iNchLSf6F+3IxtcHl+vy/czuU6D6/1++E3JAQBfCLpeJMs+r5OYN919yg==
X-Received: by 2002:a05:622a:1987:b0:2f1:df49:44fa with SMTP id u7-20020a05622a198700b002f1df4944famr588791qtc.125.1650053723200;
        Fri, 15 Apr 2022 13:15:23 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id y15-20020a05620a09cf00b0069c80404de6sm2168915qky.31.2022.04.15.13.15.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Apr 2022 13:15:22 -0700 (PDT)
Message-ID: <d32fc9f8-65cd-a30f-cdf2-f019bbe7cd69@linaro.org>
Date:   Fri, 15 Apr 2022 15:15:21 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
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
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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

What's the proper thing to do for properties that stop being
used?  Do we delete them, like this, or deprecate them somehow?
Old DTBs might define the values that are deleted here.

Shouldn't devicetree@vger.kernel.org
  be copied on this and
the other DTS patches?

					-Alex

> ---
> 
> I don't know who should apply this. Probably whoever takes the dtsi
> patches, Bjorn?, because otherwise dt_bindings_check will fail.
> 
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

