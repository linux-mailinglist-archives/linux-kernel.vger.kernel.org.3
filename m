Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188614E9A69
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 17:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244261AbiC1PKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 11:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244253AbiC1PKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 11:10:34 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F8D286C4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 08:08:52 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id h23so20839685wrb.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 08:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=HNhb7r/LKhCf7ktLcFjFiDUTXjUe/4x79E9mxzYgx1o=;
        b=nU9yW6rS1+26VMUlhMihK742eYLWAVyY979qq0i723Yt0460w264cwqXztxkZOkG+h
         is9yHp/h1rhhIWWeSonnZ3mHkbnocnMtWU7OgxJMgi7WsOZ7mk9QjfqiqaTeb8FYfRoD
         wt+mn5mi1uACHCSlrwZ8QdiftYf4xz5sTLmpid/vi/r7tg98sQCAztFNBLm3W5pBCgsW
         35EtfR9NF3I/0jRVZnnjZKAIy9CNCnV90QGW1dGx5Qivq5acPVG1m3u1aSRWp8Cyox2z
         1GVrUfHL74T0GCFMDnKZ74ioszI7iJzafgluJlCXcAlgV/Cu9LoBMGOD6xKDbuOjdAbi
         7T9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HNhb7r/LKhCf7ktLcFjFiDUTXjUe/4x79E9mxzYgx1o=;
        b=Bt56tMPeKKFRFe6fsj85OS6dJI4SV1o0JkiQaCKeuNxQjPr9Q6y046xbM6Z46f2bZF
         Mlsnn7U9tNDLuijNoA/upuZ9w+wRvTK2IHHvADYN9BxlpzS2Wwd1a7w3eB7x9UCQCnxn
         aa1EIg+3WluXGrlC0pK1qUEe1bEf2zSF+lxtCJzCCOiAJ2DWgHYB9QkWF6q3AZ5g2E06
         yDRUkeHv7nnPKeIKg9z7F0bb6SC04ENV3RrBNCzR/ubMMO4XD3bEuAqmnF6/QcrTAjiF
         X01v1pCezbXTX6+EF9P4UAZcLtBia8GZ0EjVbyt9fEOFAgwtobeArjm6Pwi0fwsHBAy2
         sQhQ==
X-Gm-Message-State: AOAM530q0YIXdi2cGUS2UCB/22QILHPhJMjiEZ0nbLE4X6wH9xxwfaOD
        aOz0BmIa//qZlAQthWxKd0my1Q==
X-Google-Smtp-Source: ABdhPJzOOgAJZIkk8oY7G+cG8+D3hzrGwhDFaIVXQH1eROLtVBHDaxuSvZlweoB8VjB++jcWWG18rw==
X-Received: by 2002:adf:e342:0:b0:1f0:648f:c32b with SMTP id n2-20020adfe342000000b001f0648fc32bmr23857646wrj.204.1648480131068;
        Mon, 28 Mar 2022 08:08:51 -0700 (PDT)
Received: from [192.168.0.162] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id 2-20020a1c1902000000b00380d3873d6asm12256243wmz.43.2022.03.28.08.08.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 08:08:50 -0700 (PDT)
Message-ID: <ae06ecc3-da1e-ddf2-3d20-c9f1cbed5550@linaro.org>
Date:   Mon, 28 Mar 2022 17:08:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/6] arm64: dts: qcom: sm8250: move qup-opp-table out of
 soc node
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220328143035.519909-1-vkoul@kernel.org>
 <20220328143035.519909-4-vkoul@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220328143035.519909-4-vkoul@kernel.org>
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

On 28/03/2022 16:30, Vinod Koul wrote:
> The soc node expects all the nodes to have unit addresses. The
> qup-opp-table does not have that which causes warnings:
> 
> arch/arm64/boot/dts/qcom/sm8250.dtsi:916.32-933.5:
> 	Warning (simple_bus_reg): /soc@0/qup-opp-table:
> 	missing or empty reg/ranges property
> 
> Move the qup-opp-table out of soc node to fix these warnings
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8250.dtsi | 38 ++++++++++++++--------------
>  1 file changed, 19 insertions(+), 19 deletions(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
