Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0170E50D217
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 15:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236916AbiDXNlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 09:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236298AbiDXNlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 09:41:51 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2478FEE9B6
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 06:38:51 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id y3so4503150ejo.12
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 06:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0/aR4FG3opfP8wTU42wsK2pjpb2lLl/56PN0te8U1K0=;
        b=gjcKJHwunnnQUYJuweRcZ4XrtvNF7vGQYWRV8gUf6bnQxNG2kwh/uss2F7Sz60ggNr
         xFaycIotrnx6LSeiTfByGBZUJLJlsUc2azBvA01Zf3KQmpwRYs9faMyilCbDqd3FbRtm
         bUtT8vYrt9NzZaQ+kIRDiMDHk9uwnZ7vj4pcEyGn4I8SHbEHnUtmxygspeUKZtwGiFuD
         MnJDkESTEDi8yjvPr8T5HKoyv6qeJ0Rgc32+paz0CYLlNz+bF8gEB5zjgIJZnzy9j7AU
         o720N/dml63+DRh6sAodrJ8frdTG/6Vqk++ZnvD2ZfWP4sKFwtYMENENMcefAR3qXeF7
         NmFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0/aR4FG3opfP8wTU42wsK2pjpb2lLl/56PN0te8U1K0=;
        b=vzzoiZKeAcNSBWm6JM5QWztLZeTM6qqMg7UWlrPZNhWDYgdHUSqaqOjrnylqaGxt5t
         xo4L7cqzBg6e4cdBOTjvaE4NPWMeEVLrkxzNWHWksFZYivZGniZpOeqsAHceeXiOPD0l
         irizDy3o3jySIZm33O6jaIV4z28MEppOANrqcX148hpflkIKXT+nLVvKyF0ej7BbF4UG
         46PO13DzVeAGMuObw0BiKKhj2kUtGWsAO9mz6zLTVvVVBYNW7AOe+Og9cuvaQs32ayuq
         Q8bu/+vO674m1Yhnv1/lndozv8MgbgSP/89MyI9iyfTXZHVQ4YpN+pYI2y1oxkbmPJzP
         mRRg==
X-Gm-Message-State: AOAM530uu2bWhfg5i7PnLD8Z3ZWv9HCkE7N+p5yyCbSm5WUuE2D0zB06
        BKBMs/t1FT2uKmXexdwLj27CuBBSH544/A==
X-Google-Smtp-Source: ABdhPJz3zBuOc6qL/jK+PtKnZ3hFOPsD1+aIaU9X5jsHg0iuxfme3W3oCizOrczlAVwjkYkI9WQ0Cg==
X-Received: by 2002:a17:906:7751:b0:6ce:e3c:81a6 with SMTP id o17-20020a170906775100b006ce0e3c81a6mr11719145ejn.278.1650807529701;
        Sun, 24 Apr 2022 06:38:49 -0700 (PDT)
Received: from [192.168.0.235] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id b26-20020a1709062b5a00b006e8daae2359sm2608403ejg.95.2022.04.24.06.38.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Apr 2022 06:38:49 -0700 (PDT)
Message-ID: <e794c995-7f8f-a75b-6f30-1cbcbd9edd56@linaro.org>
Date:   Sun, 24 Apr 2022 15:38:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 3/3] dt-bindings: soc: qcom: convert QCOM SMP2P binding
 to yaml
Content-Language: en-US
To:     David Heidelberg <david@ixit.cz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220424131522.14185-1-david@ixit.cz>
 <20220424131522.14185-3-david@ixit.cz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220424131522.14185-3-david@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/04/2022 15:15, David Heidelberg wrote:
> Convert Qualcomm SoC SMP2P binding to the yaml format.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
> v2:
>  - dropped constraints on sub-node names,
>    converted patternProperties to additionalProperties
>  - adjusted name from "Point 2 Point" to "Point to Point"
> ---
>  .../bindings/soc/qcom/qcom,smp2p.txt          | 110 --------------
>  .../bindings/soc/qcom/qcom,smp2p.yaml         | 136 ++++++++++++++++++

This was already done. Sorry that I did not notice your earlier work, I
am usually checking for prior work but this was missed.


Best regards,
Krzysztof
