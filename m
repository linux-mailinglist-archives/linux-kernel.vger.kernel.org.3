Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930C350D257
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 16:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239394AbiDXOoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 10:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237612AbiDXOoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 10:44:10 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC32506CC
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 07:41:09 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id kq17so1898705ejb.4
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 07:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=RZeD7VZeCx2JfogRYjFn59CVQqv5yT2Ex57lPtVonrM=;
        b=GDOnFK53Lyz6+WpoTaj42rYsc+OyWpyddPpETFYQEHaaCDUl2915QVrDP3Yyqp8HuJ
         KYuPrGLvvfMWGw+u9El0tNbZ0SlcHWvtSBig2aAHZ8+62cFyGH9imSA8+B8Dab+r8Qg7
         i0nVRi0MUBvZYMuEjjAiB+fB0Y+BGx1OQdpFSt5advOo4lWOXOfWfAmvXQy4roS7namK
         2kVL1DNTPgB5b4LHAiA9xQQYEkpVzOmOT5bCvb/mTfs5g2EUbUgvVlFNYg3NmNx3UyfJ
         FlfhqOte5ah5NZ6F1zHvEbs+H7ve+Qne8pAvROKbtHQ5+8lxv7esUAShzfOqNygDy/v4
         4pGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RZeD7VZeCx2JfogRYjFn59CVQqv5yT2Ex57lPtVonrM=;
        b=dLjrnWN8tqBv4Bt15aDbPv3gzZ0I+XF0OBFzH05DwCdihgXG8//uq1OFiQiIBOPj7K
         mgg0XXnoHqjypEKclRiUy7O5k59fbM4yJFaCI7z+lt+qCeLIUNA+4l44lyj/jqWfZRiz
         ZrDbq2NGRj2+Mk26Zecn7jALy0f3rqTX53EpJeLw+75sq4BVaJb/kIXh6h0shZfIHWn7
         OE5E8/YMKscNKBiRCyGVofU0pDZEgpZsMM1c8w/TkiBCdfdG3bvDVaTqWoLFApVhKBnS
         qoPUGYcOAta1ot6Bdb2LVU0/9zzH8IButxvS4t4gw3tWEfh8LFvCDkoaZyEGjVEW4+/l
         6Hvw==
X-Gm-Message-State: AOAM533a1zeHeRKknGaGvr1YfoNJ5szeLagDesxA3vld06moSA44CZH6
        wH2Z6PQqBM/I/25akFNIqIWNyA==
X-Google-Smtp-Source: ABdhPJz7Ncqwo2BgPXvbIAy2wgLUD3MtUq3yFRoyLm0iwljhuBrfg6w+G3XuREblHM8OGKifSld2qQ==
X-Received: by 2002:a17:907:9710:b0:6f3:6e7e:d5bd with SMTP id jg16-20020a170907971000b006f36e7ed5bdmr7302793ejc.252.1650811267684;
        Sun, 24 Apr 2022 07:41:07 -0700 (PDT)
Received: from [192.168.0.235] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id s14-20020aa7cb0e000000b00410bf015567sm3279398edt.92.2022.04.24.07.41.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Apr 2022 07:41:07 -0700 (PDT)
Message-ID: <f19273c8-a8be-1bc2-d5aa-2f131822b4cd@linaro.org>
Date:   Sun, 24 Apr 2022 16:41:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/3] dt-bindings: net: qcom,ipa: fix example for
 upcomming smp2p conversion
Content-Language: en-US
To:     David Heidelberg <david@ixit.cz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Alex Elder <elder@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220424131522.14185-1-david@ixit.cz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220424131522.14185-1-david@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/04/2022 15:15, David Heidelberg wrote:
> Example of mpss was missing required properties.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  Documentation/devicetree/bindings/net/qcom,ipa.yaml | 5 +++++

This needs rebasing on linux-next and then probably won't be
correct/necessary.


Best regards,
Krzysztof
