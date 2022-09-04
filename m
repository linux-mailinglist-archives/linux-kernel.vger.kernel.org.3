Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972605AC606
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 21:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234482AbiIDTPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 15:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233821AbiIDTPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 15:15:46 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93682AC42
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 12:15:44 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id z29so10346021lfb.13
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 12:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=yxLVewTHSv4Xq6/5Z/Fr5zJXfSu3q0A9v6Ujj4sysNo=;
        b=gY7oQffKOe8RLllBIFsceNq0mOknLJBf/z9s8U52PVRc5LJse3DXKRBtSfkYwEEM6A
         mEzXk63I3xm0C8ZZcbbqdwrlhFY4DcmejpdHugVGE4n8DETSxa56NC8xN0rhKknCZ6Cz
         Hh6ucgNB5VnEAJjLLLlCvWPFYRT9X0gHd/TnYsAx1L7mEPnpUDJHvEy58coAla2yGZsO
         c2mAkNQywRzRx0WMBX7xNWE+kdU9j9kk1vl6j3+Rs/qNLb1EuLfjMv0ZQPWfpCm743RZ
         jj0rFNSHMCSWeljZbTxf4qGS9cf9xMWIeFkVmGTlr6nlB6hstfFtcO6Ja2XbPe3Ijy2D
         gLqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=yxLVewTHSv4Xq6/5Z/Fr5zJXfSu3q0A9v6Ujj4sysNo=;
        b=fhcprC/twSTk4J1/jwym15Ms7g49iYDr/eelR2MbhMb+cst2nh9piSZvyPNVLE02Km
         /hhlaiN++9ITL253vJptfZ57VFN+O44Qer4qYRCE9IjhbXODbqeD0jafLNPkVbDoA+U8
         bVzdLZiL/TPDBhqI4iQgrak5K9Ms0pjcpPSGt3LWq6keqHG42QeL5wYdNHE+wWw61kIn
         2sln0l6NCVWJd6adaolCC561pFYkP9AIrx+7W5G0FcBbE5BVaS16XFlClGmS5ePj0DJ4
         c1hen7zPji+oab2o6wwSjHJI3PJ8Pq+4fzTFDolVZ0vNLe2zLv5z+wIJClidl2/bjfPV
         wrCQ==
X-Gm-Message-State: ACgBeo1yw+b/L5UJIue2+DeNFIgyb1367KFnvPLAMLh0yWF9msyaQMne
        hZaCW1wKn4JuK+HRriiIrO7zxQ==
X-Google-Smtp-Source: AA6agR76U4ZjwwGZKGOS/A6eRNqmnQgw14s80bPnLr3eF672TCAKb8bB7e9alAhcpm059HJ4F7/IIQ==
X-Received: by 2002:a05:6512:1315:b0:492:cbc8:e10d with SMTP id x21-20020a056512131500b00492cbc8e10dmr14598407lfu.41.1662318943152;
        Sun, 04 Sep 2022 12:15:43 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id a27-20020a05651c031b00b00263630ab29dsm1093876ljp.118.2022.09.04.12.15.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Sep 2022 12:15:42 -0700 (PDT)
Message-ID: <8c845d02-c63f-9b1c-25af-10fe705717a2@linaro.org>
Date:   Sun, 4 Sep 2022 22:15:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 3/9] dt-bindings: nvmem: Add SoC compatible for sm6115
Content-Language: en-US
To:     Iskren Chernev <iskren.chernev@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20220903174150.3566935-1-iskren.chernev@gmail.com>
 <20220903174150.3566935-4-iskren.chernev@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220903174150.3566935-4-iskren.chernev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/09/2022 20:41, Iskren Chernev wrote:
> Document SoC compatible for sm6115.
> 
> Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
