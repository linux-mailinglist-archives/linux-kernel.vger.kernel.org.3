Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662A45A2DB3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 19:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244746AbiHZRmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 13:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344930AbiHZRmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 13:42:04 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB26E2C64
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 10:42:01 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id w22so2254232ljg.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 10:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=rw3ft7Xiuq6jQh7CexeaJRVGi6CosNconl2BfPOtJXg=;
        b=s847w+OO7cYhJyVS3QmbSC+ByjtLv8K5yKznoyPw5hZeTr4Bek8MTxQEaof5/WC8Gf
         pwxv/xSzlQA9YefMjG/9uI/pKA3KUT93EN1o+cVxKj9RaxHdjMSmcBWzrXNjfMgFUWvy
         tMYh1xSmY8EkAu2FJET39FDgmdDpVOqajSQvmNw1wWFo1qMpzK2amdWuDd/JNbIQXSSh
         8wjGDV+o5d9/o7zJbIV502ev5GDKfTHqmOo9abPNo1GrGju9iSLJlQqOIbx0XwapaHGX
         umrbKtRe92nJj8Sx+mflxGhb//qti5iUngVfK3wcsIJLEf+O+M6gOMDSHuXj7Doy+6jo
         lkRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=rw3ft7Xiuq6jQh7CexeaJRVGi6CosNconl2BfPOtJXg=;
        b=hk20kVRpeCyVUeHJIsB516Pk7tDE/u1lGAA1CgO1YWNHzcyT2+UiOCa7PtushRXVF4
         8s/q/oSubFWrE5JgRTYojS9d/4CM6MVtbtRjvQrF0BTbSBcFBogpEA3HFSdxOBIBdbWl
         7KJp3deELbVcgdqiX18TSZl/F5gDZTn6LQkvTXpBaIWuBlxNoWexrTOtQw0j0OFzVwnC
         tp5dO/HacF+g/Sy2NR+iHYBL16EHd+UtCuzYtKbCfnuwIsr/Krd3xzeJ/AMHhEJnhtcH
         E/LJfVO3eAtPhcj6BpiRhG+0/wOKsp5jFhxgfHbo8XNsOuCyBJmEqJjBUlm5jj3Ftnep
         WPCg==
X-Gm-Message-State: ACgBeo1PgQU7RIXP2ZNJra8kGbzQKIILnuH+WDkpFVxda7pQegs6Zt7c
        c5Say7Yua0OaOL72CtfY7VUmag==
X-Google-Smtp-Source: AA6agR5O4np8N7uZzKIuzC3AmkW23UMkTi/wwqOWxiQRm5W1buJbivDheV/iRyfq+Jvv1q4deP+neg==
X-Received: by 2002:a2e:93c8:0:b0:261:e5a7:56ed with SMTP id p8-20020a2e93c8000000b00261e5a756edmr2689909ljh.483.1661535720141;
        Fri, 26 Aug 2022 10:42:00 -0700 (PDT)
Received: from [192.168.0.71] (82.131.98.15.cable.starman.ee. [82.131.98.15])
        by smtp.gmail.com with ESMTPSA id c28-20020ac244bc000000b00492ef1ee7b0sm422450lfm.290.2022.08.26.10.41.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 10:41:59 -0700 (PDT)
Message-ID: <58d791f3-2a45-1ddb-79ac-852656be2b50@linaro.org>
Date:   Fri, 26 Aug 2022 20:41:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 1/2] dt-bindings: arm: qcom: Document additional skus for
 sc7180 pazquel360
Content-Language: en-US
To:     Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Bob Moragues <moragues@chromium.org>,
        Henry Sun <henrysun@google.com>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20220826102513.1.If97ef7a7d84bcc2cf20e0479b3e00c4a8fb5a2fd@changeid>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220826102513.1.If97ef7a7d84bcc2cf20e0479b3e00c4a8fb5a2fd@changeid>
Content-Type: text/plain; charset=UTF-8
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

On 26/08/2022 13:26, Yunlong Jia wrote:
> pazquel360 is an extension project based on pazquel.
> We create 3 sku on pazquel360:
>    sku 20 for LTE with physical SIM _and_ eSIM and WiFi
>    sku 21 for WiFi only
>    sku 22 for LTE with only a physical SIM
>  Both sku20 and sku22 are LTE SKUs.
>  One has the eSIM stuffed and one doesn't.
>  There is a single shared device tree for the two.
> 
> Signed-off-by: Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
