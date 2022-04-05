Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C4E4F22F7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 08:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbiDEGTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 02:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiDEGTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 02:19:14 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A51F4BFD8
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 23:17:09 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id qh7so14435087ejb.11
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 23:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=wnC1f8YDtYHNPe58mCUlMB+PyON8jqf3+fp0IpUSZD0=;
        b=xzuLOwLyCXrLv1dokk2FWFBOO44zcV6ewLuCmTFE0G8HBvd24YyNf0DfoyKeGTx+BY
         wMHoYl3dp5qPoPCTerQ6xb33Nbi4lRWXsG///0gtflmW2a8JIH7eRn8+c72TRRLrvFpB
         MyVesHv6Je1j1aWqmHGYhmswa5qf2vtl8WQnVB6L7wMPbmv3DpxUuaDmJgJy+a9guSgr
         zcNwP9QbwHxnB53bU02ep6SHfSuLobsm8vWpOZCWJEyAUwDBP/HMrFCGCaHJvfmp/idi
         lsakOuxwGr1742neG8kByio2RhJAndFRV4cEb67WOcl0AeK4nkEGERkvFxMI/lJwhF++
         mjBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wnC1f8YDtYHNPe58mCUlMB+PyON8jqf3+fp0IpUSZD0=;
        b=iREPlulALxcx8WeGg0b6VWIwrjVY9vDaoPRcwaonrxJ7FuVU/hNgUEdHgHVv5p6xq5
         Uz9RJplGUQp6x7CZEfentHFSY68kj9Mr7iToTjIH7xMjCz3vMoWmtl39EBqq7V1DJYXT
         LKtAdc80sikqAsQsCI7X4qP/MB6leyGpv5qoCd9hoIJTF7JCy/5nSsVYWrnaDv7Op2Pa
         ljOby5BouoCUpFz3ULiFtPW4arV5gITVqILOXEXlDb+Vx3yXo6wI1wxgPhsROdK7YZNR
         mBCrf8DP//dTp0JoYgl0AO7I2A6/MCSbU1wuhCOp8O5/669Rg/mpFNeSmAhh1bPoWRbt
         OcMg==
X-Gm-Message-State: AOAM531Iov1ApJHBLPf8jg2x2ahic7SyNMtghbmhMzSKmzaGxfltM2cu
        uxX/1aUE3VyAZyQPFnRdLsz3/Q==
X-Google-Smtp-Source: ABdhPJzfMa9yu8jBzyIt+Qz59BV1ER2+WNzKmSdRxOGpZ5b6wWzlMIOIPHO/6wVUU9cjrjk4Uy8+TQ==
X-Received: by 2002:a17:907:2d90:b0:6db:729e:7f25 with SMTP id gt16-20020a1709072d9000b006db729e7f25mr1948257ejc.203.1649139428004;
        Mon, 04 Apr 2022 23:17:08 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id q17-20020a1709064cd100b006e78206fe2bsm2995333ejt.111.2022.04.04.23.17.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 23:17:07 -0700 (PDT)
Message-ID: <9eb91adf-9c2a-5535-b236-6517672ef9ce@linaro.org>
Date:   Tue, 5 Apr 2022 08:17:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] dt-bindings: clock: qcom,smsm: convert to dtschema
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220401215949.222965-1-krzysztof.kozlowski@linaro.org>
 <YktygNS7OwWDJCNK@robh.at.kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <YktygNS7OwWDJCNK@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/04/2022 00:34, Rob Herring wrote:
> On Fri, Apr 01, 2022 at 11:59:49PM +0200, Krzysztof Kozlowski wrote:
>> Convert the Qualcomm Shared Memory State Machine to DT schema.
> 
> Umm, the subject says 'clock', but this isn't a clock binding.
> 

Uh, copy paste. I'll fix it and change the pattern as well.


Best regards,
Krzysztof
