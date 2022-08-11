Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97CDA58F902
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 10:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234468AbiHKI1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 04:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234458AbiHKI05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 04:26:57 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3828790813
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 01:26:56 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id u6so13221392ljk.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 01:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=aFp18g3W0LGsukVneJEK/1E3oiiot3UTXvd9sFAT8nw=;
        b=FqWcBq881TMTPntLfTmspF/MO4q8vssSHi7sEwMMId7K8gaHZO7iDS19GycjfK/9eX
         cFkAyPoL+ZxgFs9dY8+KnKf6KghP2eQzh3/5e6CQ/yNuLXuxNR9SPKZrpjiyncVvDb3O
         XXeumafKovUw/dYZQxYK5tO0Uaaw87e+2IHMLlXkYC2LEPH0U3H7RPvoAztqsE04Q7FO
         Mf+k14XGfUr4CH3epxKAHe8GlAmmds9FGDbUI0nJLOb1IsNlO9dOjdxiEQQeUqdAQup0
         8VNiPpAsjtTUvBYLnnqxgnUTB3eLW0jqoT030lVtBRxB3+Ebqa1AV3PA1it84KPPmRUC
         l0Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=aFp18g3W0LGsukVneJEK/1E3oiiot3UTXvd9sFAT8nw=;
        b=ldV/ilJ8vVzUO78n5w+rOslsaVIFq5bnJgPHodhlI0du7CMFwdDwmVHX8vOasMH3JD
         ycl9SUYcPGysoV3qUjLVbaH23WmOP2GBsrRVvDTNiUnVaYjol7sX6/+T5HLWRQTnAfEu
         kdG8ja1kcIiBx8bk6leYXgrwqPb2UEe3BSroJ97bmV2eFWlRXLkTZ3QQc+LZXcl+ZIig
         6SxWoNf1FsBiqQ0KGb1+yJLulAHyi0nKRB4SGuhfkWXKHEU+HvtxSgNiA+NbapyuYeB1
         5nkIyep5OraTOxkRjKGTlpiwzFHKpk0STwmFMteFBCcaFoiQYYnUH2y7/XnUvWTVzVVG
         Fu6g==
X-Gm-Message-State: ACgBeo10gR2Gben9Q3p+luiJAxXKQnIE1Ux5d4sYyp8bPV+rsyV8vTSj
        /3bOUsBQubyh89oqyUuqla/Pfg==
X-Google-Smtp-Source: AA6agR7WKZFo0Gd0CrwW+kQqeYyEuLnmEdTMd3As+yvfv/ebcpxDY62N1UnBLOwwuNPgfwQgBjnxwg==
X-Received: by 2002:a05:651c:154b:b0:25e:c73d:a786 with SMTP id y11-20020a05651c154b00b0025ec73da786mr7507173ljp.397.1660206414645;
        Thu, 11 Aug 2022 01:26:54 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id t5-20020a05651c204500b0025e08d58e75sm720412ljo.133.2022.08.11.01.26.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 01:26:54 -0700 (PDT)
Message-ID: <1cbb9946-2171-46ee-be6d-84b914ecc47f@linaro.org>
Date:   Thu, 11 Aug 2022 11:26:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/3] dt-bindings: display/msm: Add binding for SC8280XP
 MDSS
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220811040121.3775613-1-bjorn.andersson@linaro.org>
 <20220811040121.3775613-2-bjorn.andersson@linaro.org>
 <db9b74f9-1f65-5b88-1c81-0a3fd6dcf9a6@linaro.org>
 <74afb676-4a85-7a8e-f7ea-20d8a0967d7d@linaro.org>
In-Reply-To: <74afb676-4a85-7a8e-f7ea-20d8a0967d7d@linaro.org>
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

On 11/08/2022 11:04, Krzysztof Kozlowski wrote:
>>
>> additionalProperties:false on this level
>>
>> which will point to missing properties (e.g. opp-table)
> 
> I'll fix existing bindings which have similar issue.

Hm, I think Dmitry is already working on this:
https://lore.kernel.org/all/20220710090040.35193-5-dmitry.baryshkov@linaro.org/
so your patches should be on top of his.


Best regards,
Krzysztof
