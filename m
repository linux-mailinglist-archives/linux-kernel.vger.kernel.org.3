Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32BA65A24F4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 11:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245572AbiHZJtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 05:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344115AbiHZJtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 05:49:42 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D8DD7D20
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 02:49:40 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id q18so1051456ljg.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 02:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=GsqQd6SAPDb0fT70p8X6mFpGFngwmS41ZDD9UsqFcxM=;
        b=d1nSLkhbrdejwMFn1KOzIxhMbISvE9dkw2GzI0Y7U9LKhmPsdU3SRgViqhhXOyeajl
         7MbraVMYy1297njGx4aE0/zxZdRtTjtM/ix23VUqFNWG1/QqkCzPDGHibRE/1koKNa8G
         COui3DNktwzEbduZe8148dNYMkHTph0MFQSTNax21JmV7gEBo5+VKofjV2biZqvWx+oS
         8Zkoda0Gp2ve/81BaS1KhTgVye5s0iS5rRUNj3JgdBtDuZqwFncsQeHVDWQmU89VNoay
         99f5IosEbRYSUU4BgrLEz7D13wuPF7LMD5oauszVP1QRGnXoYjHR/1KP2qmlwkNip4my
         Jz1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=GsqQd6SAPDb0fT70p8X6mFpGFngwmS41ZDD9UsqFcxM=;
        b=CUpim/xMEZLn/D8gOCPjpvCwe1IOPM/4I9ByWcblc/oBZmV+u3eMofoyBUyJDdZekx
         aZ62wmnRAj5ghEVi+l/ywigFL6rlDlCDmXkDEcz7ZZyL7aKDXX5wfFhCJVGfqKXebxmZ
         N4uMfHOQ+L/Zkt0yawc4SInBz5EIUaomeTJEc2trz+WyvZ+Ip5VSnJ+61XaLlXhMIUNj
         U749fVKVwosVnJeRwxwgF0KgjmMIJEAxAm+ocJEtN5n+3RMkHTh6r81geD4Bg4ZsJq0B
         +Cittd+SWD0gzG+OTVBGZiA/bHlrIADQm7d18vPCbKAh9xg1vA9wVAt7e6z7SYuN8CIn
         hXyg==
X-Gm-Message-State: ACgBeo1Bbqi6y6MraN0Z0ZT9GodMEQdPqTSOMGCBfwHera1GcbzPrz66
        GYERjnfrz18efslFwNSopjdrGg==
X-Google-Smtp-Source: AA6agR40xBnaJlt4y96z7hQide+xi8Mu/NLv05DSdTOgVzbHuyvjhtAMDPEwIh7iOcbU1H66d7/K2w==
X-Received: by 2002:a05:651c:238c:b0:261:d468:d633 with SMTP id bk12-20020a05651c238c00b00261d468d633mr2085578ljb.479.1661507380275;
        Fri, 26 Aug 2022 02:49:40 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id s6-20020a056512314600b00492e0be5f4fsm335755lfi.34.2022.08.26.02.49.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 02:49:39 -0700 (PDT)
Message-ID: <15a6ca5c-75e4-c901-3813-dce0d1dd0d14@linaro.org>
Date:   Fri, 26 Aug 2022 12:49:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v2 5/5] dt-bindings: display/msm: dpu-sdm845: add missing
 DPU opp-table
Content-Language: en-GB
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Del Regno <angelogioacchino.delregno@somainline.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220817062059.18640-1-krzysztof.kozlowski@linaro.org>
 <20220817062059.18640-6-krzysztof.kozlowski@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220817062059.18640-6-krzysztof.kozlowski@linaro.org>
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

On 17/08/2022 09:20, Krzysztof Kozlowski wrote:
> The 'display-controller' child (DPU) of Display SubSystem (MDSS) uses
> opp-table, so reference it which allows restricting DPU schema to fixed
> list of properties.
> 
> Fixes: 3d7a0dd8f39b ("dt-bindings: msm: disp: add yaml schemas for DPU bindings")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

