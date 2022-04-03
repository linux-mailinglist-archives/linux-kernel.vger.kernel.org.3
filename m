Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC674F0C56
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 21:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376364AbiDCTmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 15:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376353AbiDCTmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 15:42:19 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8398727B35
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 12:40:23 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id v12so10431329ljd.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 12:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=HtO1Op4EULGuNh03X4DV2PvRHFpqexefkL4qM7EQ8hs=;
        b=Vva63TToIflctX178TlzjoBSwvG9ymyH8fkUFzsJbWemLSthhs3fmUiyct2jJXfuul
         cBWrmGUChH7mrrtvKlbT+UvTMA1kr4EGroRz89d9ZgRjBKqjhw8b6Pjx9Drm+2KP3ffr
         qCaQcnpudkB1x6f/TsesEIgup+s8tupM0OkNckNeY94nH0LSyoG4CwZboW/Hdt25PAcJ
         sQFqduKzh+wRrNkQBH2bKey2AY958WP2O9dI5/Wdtz/wZ0MDwOZqcOy8Lz7GFJgKEqMC
         KQo46IBKc9PhJAb+EVBtnQVsPyqsfla9tpQgL26rsToQlejCjGBroM2zOCQ3JxObDDsq
         /ggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HtO1Op4EULGuNh03X4DV2PvRHFpqexefkL4qM7EQ8hs=;
        b=b0bzm9CAQ6BMsWvkq4lxu8+C2jAav6Mo8WTbyqA/6ap26d3EG0iDR3EYMbghyYd188
         O+cfHNNMD6Hd+QZovIAlRB48amY3r77Meo+HbZvrTSkUwrqjHD3fFYHvOgvhc39E1/yP
         x8PO4nbei1fLbX+pwosFF2B5Ug8jXu8434EctJIv1p/O7x8uMl9mXChvKFnfbAawstjg
         E1UFhkmia0UkZETwVA4rY10NSaHwj79hSgft8xGx/8MzHCpiXpdPcmDiVf23xXz5QQEG
         nq0fpzeGeTRBwk66ZQGBoAT0oghpWYZNAEhhmjbBoJi67TYQuFYUA3+QhqU6tvpcTEZX
         Su9w==
X-Gm-Message-State: AOAM533cZ55pbMk3EzXXBqIvaveEeQWGsbYdQ8+5KS9C8bhVdYJd4cCz
        gVg8gdIQZ7q/GAa2YcMNSZcmKA==
X-Google-Smtp-Source: ABdhPJw7jctSDj8NStIfPObweDUKTSouSVeuWxido0zNdu27djMaTmXtm8LsIEAvN6zkHp/iSjViQA==
X-Received: by 2002:a2e:3615:0:b0:24a:fc28:f0b3 with SMTP id d21-20020a2e3615000000b0024afc28f0b3mr10332615lja.4.1649014821787;
        Sun, 03 Apr 2022 12:40:21 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id z16-20020a2e9650000000b0024af767c536sm860592ljh.19.2022.04.03.12.40.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Apr 2022 12:40:21 -0700 (PDT)
Message-ID: <19015645-86ce-5a7e-e2a7-d4af01417b74@linaro.org>
Date:   Sun, 3 Apr 2022 22:40:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/5] arm64: dts: qcom: msm8996: Revamp reserved memory
Content-Language: en-GB
To:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Raffaele Tranquillini <raffaele.tranquillini@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210926190555.278589-1-y.oudjana@protonmail.com>
 <20210926190555.278589-2-y.oudjana@protonmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20210926190555.278589-2-y.oudjana@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/09/2021 22:06, Yassine Oudjana wrote:
> Fix a total overlap between zap_shader_region and slpi_region, and rename
> all regions to match the naming convention in other Qualcomm SoC device trees.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>

Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org> #db820c

-- 
With best wishes
Dmitry
