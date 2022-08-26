Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89DED5A24F5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 11:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344113AbiHZJtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 05:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344088AbiHZJtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 05:49:35 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FF4D7593
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 02:49:32 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id x10so1074494ljq.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 02:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=fgD8MArf1fhW9WPJLzTNQiXID3sIQlI/i4dJ7hULjQw=;
        b=pkIvtxZgK8rMviwZp9ukD+I1XdMf6fNNSJlASJL+GEQDb2yfYKwmodPS56zxUTI/yz
         Pre9JxUwDK0jZv4S6/AnQX/lnZWp0dtvfaUlgjNv0xMh4zzdKTl0G1tUNVxQmV7m1EDj
         hyfinRvPUPeiUauxLpJZP5jakcTjshy6k9UtIdnCZo0ko9d7alKBWBr4KI7hZyct7/BZ
         OLUINoeVLck1b+MxE0NNd/VXhW9RaxB8ulWABWAHR5xjF5Kz9JMr13CKSMOFwFqHT+U2
         MpQXB0ojp8I+0ZxOWBjrVLjPkSmooPyoE3pT+9LTOFtAwqAN7twPrHtl4X1hs9dB8vUO
         OyrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=fgD8MArf1fhW9WPJLzTNQiXID3sIQlI/i4dJ7hULjQw=;
        b=Sy0a3kqS1MNXtRuU1pOmxXYuvjdBxNUkI9yIwMKL7eBxGKh/4b/cxopD1GXrXfC98j
         WC+16nOs+4yaTOxITgVIMULxnjS+IfeczcNKKLsoGMf4Z4DDS64v0sXY7EbRye1ZG1oH
         SRpW3EVzlfqVsGVa+OS5ciZTlkrXfFX6RsygOe8aPw9DCtkrg35WjtsxeC2RQU+wqCYp
         T97h0+tiE2Ck0hpG13FbXk0KsKL0R8bM9ghxapDbSk3pagYegH3vAYAjlV/bd0v0IBLy
         iUELkQYDm5qjbt4QwXUZRvAD4aj0GDTmYfWk4YOZbO6mwStcIMctcMqVIA803Ficn+kx
         x36w==
X-Gm-Message-State: ACgBeo3nQQ8VKdfQB/1IOt7Vhzsa05Pny85srxgxopeol9FKSYAf9gKR
        LdY8QrJtny5WhqjyUh+FoaQ0OQ==
X-Google-Smtp-Source: AA6agR7sEd1utbCeElTi22gwgYpzu+d48/EbFU6j2iMazTayKRbT7oIMBOoasmz4JE2cWrX5tHUG+g==
X-Received: by 2002:a2e:844a:0:b0:255:46b9:5e86 with SMTP id u10-20020a2e844a000000b0025546b95e86mr1976897ljh.388.1661507370397;
        Fri, 26 Aug 2022 02:49:30 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id x14-20020ac259ce000000b0049306939413sm319933lfn.211.2022.08.26.02.49.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 02:49:30 -0700 (PDT)
Message-ID: <568516e1-6a8c-34b7-7525-ba9cc522a465@linaro.org>
Date:   Fri, 26 Aug 2022 12:49:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v2 4/5] dt-bindings: display/msm: dpu-sc7280: add missing
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
 <20220817062059.18640-5-krzysztof.kozlowski@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220817062059.18640-5-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 17/08/2022 09:20, Krzysztof Kozlowski wrote:
> The 'display-controller' child (DPU) of Display SubSystem (MDSS) uses
> opp-table, so reference it which allows restricting DPU schema to fixed
> list of properties.
> 
> Fixes: 57fd4f34ddac ("dt-bindings: msm: add DT bindings for sc7280")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

