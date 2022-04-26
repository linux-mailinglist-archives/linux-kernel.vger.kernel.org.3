Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2F650FB2C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349266AbiDZKpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349268AbiDZKpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:45:06 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4484C35272
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 03:35:02 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id i19so3455880eja.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 03:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=LHOLjPb0Gd87HYrejyxO3Dkz7va58yAZPFUDJ9tFmx4=;
        b=JuyytUXtIijlMjojBPasSxCObLn+H2rVGhEM7P2YbYAupd9seWkHRymgjkwYAxLdrE
         3uiTl1rDAmGb799ZARMjyPe3iTEVogLZxPzVsD69MJ69y1tQ6qHaah5EjZpPCe+GRDZT
         Vn0EJvA5Q1tUxX6tMqgamhVveIa0k1oUWn0o9rTFAIdnB0xyDwZJvre13s3OKhwCbD7y
         sOfX/tn+bMjtDzsozFrThShtXHZbO4gGFaN/7H7db2mGKhBUT8ma/xrU8SXqw110HY05
         7IGYsP+GYfW2LblJpM2DMXAO953d9a05DbWd4qYoEmvbhxL3VK7ApnS0DGYOrWR7fhis
         KzgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LHOLjPb0Gd87HYrejyxO3Dkz7va58yAZPFUDJ9tFmx4=;
        b=DiUV7G7F/BKaszI4lbK9dKLK9QF8kmyPqqvjDP6KzYoPYGy9dYpuCTIsYU4n15AdXo
         b1ONkycep4vlGF+Lt6fs09eLMT2pMW4yerQ+SB5E43RT7DAyg3IefaswZs59NrLN/tqC
         1AruPKz2Zv9qUagYoqUFBdX1IOUXLoesdXQv4S1i++MFbEW6jhKSZt9xY3jyh+Yb31KJ
         sQuCjJ+Xi3QhQ6MZrAv15HdPN7TAZw6ITNsZ8i3vBb5s5WpoSsCZk4uPuatMMThKLanJ
         wqh9Mx9LJcFG6ojWU7a9nKK2/mQE6O1pjWQZln0sftRZ0li8mNI0HjNArm4wvWd5uWAC
         gepw==
X-Gm-Message-State: AOAM531LvCG0oXwqwEFV0ggmTrhuTOWiKbmG9s642bPF6ahsrvD2eOaG
        gmAr9+4BglcWHk7v4rCuGn8SQA==
X-Google-Smtp-Source: ABdhPJxw2pK4EmRfd/xR78vgBtt0JVfot3Kjrzt69s/MPOpmCUNpD31PPUksf+4+gVizgrZES5dl4A==
X-Received: by 2002:a17:906:b0c5:b0:6f3:bb5e:54a8 with SMTP id bk5-20020a170906b0c500b006f3bb5e54a8mr477383ejb.534.1650969300701;
        Tue, 26 Apr 2022 03:35:00 -0700 (PDT)
Received: from [192.168.0.249] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id x19-20020a05640226d300b004228faf83desm6338221edd.12.2022.04.26.03.34.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 03:34:59 -0700 (PDT)
Message-ID: <0f522c24-36b5-67f1-e282-2d6f5b81645d@linaro.org>
Date:   Tue, 26 Apr 2022 12:34:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 2/2] dt-bindings: mailbox: qcom-ipcc: add missing
 properties into example
Content-Language: en-US
To:     David Heidelberg <david@ixit.cz>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220426101837.16201-1-david@ixit.cz>
 <20220426101837.16201-2-david@ixit.cz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220426101837.16201-2-david@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/04/2022 12:18, David Heidelberg wrote:
> These missing required properties are needed for
> smp2p binding reference checks.
> 
> Also includes cosmetic change to the example formatting.
> 

Missing reported-by:
Reported-by: Rob Herring <robh@kernel.org>

> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
> v3:
>  - add Krzysztof R-b

BTW, this patch confuses me a bit... You sent it some time after I sent
a fix:
https://lore.kernel.org/all/20220402155551.16509-1-krzysztof.kozlowski@linaro.org/


Best regards,
Krzysztof
