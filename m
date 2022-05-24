Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E567B532FB2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 19:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240001AbiEXRds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 13:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239992AbiEXRdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 13:33:45 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C17269CDB
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 10:33:44 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id gh17so23754824ejc.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 10:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=TDDiVK/0RrLn3b/aahT7btm7i296B2V0gGDLOx8X1ZY=;
        b=qBqVLj0xgRV22kdm183vJuStce0HuTo2gKgvnAjIFKwH65LuG+Tf0xOhNXRzvTXICs
         Tsi1vuETbH3G8ZqjfFnydAFMGGb1/8HPBxixEueqj+mULEsvfNBY/rYzthky1af8QVHf
         pNlTnyhFJOduccrjtYdrZ9JcqmEdIKyiQJd62Yh9jpnONAzSNLLvZesxrJ2gPDSE+aWX
         Nf9nnIOlQ+2ljoBsmwSI4HWrLhxZ8465YQ2fi+Tl3M4QSAzUNuMoErrPyxgkHj4xBRpj
         sWa90IvRxFO4UZ34rlhA1uS1dDljxy+J4EKXs6wo5wdybfMS6eXdJ2ZjbD1xIwv/CAZ3
         4KKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TDDiVK/0RrLn3b/aahT7btm7i296B2V0gGDLOx8X1ZY=;
        b=WtnCBb2/BFNWSPzqJXFaKtKu7Ljf3gjFijcF0QcSBsdMFMbHW2Rxn+EA+1qw86eBgu
         XIn0PBIVUsN7gel19rwnVA2SIxnp4I4JUdJq0jmKtaRoyLgUoItyQA2BoRfIpn/D1DST
         bhMw3gwUTBqshPGlpmzsKewpiDrArA9MXzmz3Nl02SxGa1TG/KH0GjR8rx3Yh/MIWFC2
         abfzM+q190T9wkLE7WAILTWe6uwpe+hWsPWaPbt4k9ahKxsW4fSuLnVUX30WkbN0F8fK
         AeU56NiZ4a6PMon/8dKIaqbRooOh5hrN2Miuw8Fg3uO1EA1BeJJnUdJvfFQ+v8kfKTJ3
         6TUw==
X-Gm-Message-State: AOAM533AVT++pRUKGKFIn1XczZEEywApk6wzJQvu+VxFI8U8eGWG1m/h
        KBnx0K6PPh+wEz+4r6l6+HtCuw==
X-Google-Smtp-Source: ABdhPJw7idjF6lR2c/kScDlKjd/kk16xrz+CaaIEfnwGa6wCZpqyj8x7XEUhkdjJq4pGJueB1TiovQ==
X-Received: by 2002:a17:906:a11a:b0:6fe:9814:70eb with SMTP id t26-20020a170906a11a00b006fe981470ebmr23763019ejy.118.1653413622914;
        Tue, 24 May 2022 10:33:42 -0700 (PDT)
Received: from [192.168.0.177] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id ay18-20020a056402203200b0042aa08c7799sm9560487edb.62.2022.05.24.10.33.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 10:33:42 -0700 (PDT)
Message-ID: <9badcfce-1db2-5381-bab8-8e52b875cebd@linaro.org>
Date:   Tue, 24 May 2022 19:33:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 3/3] dt-bindings: remoteproc: qcom: Convert SC7180 MSS
 bindings to YAML
Content-Language: en-US
To:     Sibi Sankar <quic_sibis@quicinc.com>, Rob Herring <robh@kernel.org>
Cc:     bjorn.andersson@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        ohad@wizery.com, agross@kernel.org, mathieu.poirier@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, mka@chromium.org
References: <1652978825-5304-1-git-send-email-quic_sibis@quicinc.com>
 <1652978825-5304-4-git-send-email-quic_sibis@quicinc.com>
 <20220520224011.GA374485-robh@kernel.org>
 <371ce290-1deb-bff2-112b-71be8c005b37@linaro.org>
 <a5ad7884-d2c5-aeb0-405e-0121bb51f0a1@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <a5ad7884-d2c5-aeb0-405e-0121bb51f0a1@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/05/2022 04:00, Sibi Sankar wrote:
> Hey Rob/Krzysztof,
> 
> On 5/21/22 8:04 PM, Krzysztof Kozlowski wrote:
>> On 21/05/2022 00:40, Rob Herring wrote:
>>> On Thu, May 19, 2022 at 10:17:05PM +0530, Sibi Sankar wrote:
>>>> Convert SC7180 MSS PIL loading bindings to YAML.
>>>
>>> I suppose there is a reason the sc7180 is being split out and the only
>>> one converted, but this doesn't tell me.
>>
>> I am also confused, especially that last time I pointed out that there
>> is work already:
>> https://lore.kernel.org/all/20220511161602.117772-7-sireeshkodali1@gmail.com/
> 
> https://lore.kernel.org/all/e3543961-1645-b02a-c869-f8fa1ad2d41c@quicinc.com/#t
> 
> The reason for the split was discussed on the list ^^, thought it
> wouldn't make much sense adding any of it to the commit message.
> Also since Krzysztof said he wanted a alignment between Sireesh/me
> we did exchange mails saying I'll take care of SC7180/SC7280 (since
> they had pas compatible which is overridden by mss compatible) and
> he could continue with the rest.


Sounds good to me, but Rob's got a point - this background should be
better explained.


Best regards,
Krzysztof
