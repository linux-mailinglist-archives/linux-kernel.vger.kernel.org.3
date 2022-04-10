Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4BC4FACF7
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 10:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235884AbiDJIxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 04:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiDJIxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 04:53:06 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5851D9
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 01:50:55 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id t25so2079782edt.9
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 01:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qkHp9efjKo+08fg4LskoQ/kpJrLhjOIZ8+TDrahF3Nc=;
        b=whfpqsmdhbXxm2NFs1rPzFdjVmFiFGG/u6K8P+UnrLlcsFHI6PhB4XWftpVXejHU0V
         uacEetx+LlabE4EGeHqx86wBZprNiwDkX2Qj14UbdVPn6ziHf+tibbIOcubTi4GS0FmZ
         2AiI43Ll7jitMle4hKna652Z1rY9koYNb0Egkjvi6Bn7+3yvq6h03nj/1Jnbrc6wynJU
         YAexTJbLGoEwNwtZqpp9z8zkGAtFipbyfbiOBNLAbccQC7PaJaLilw6wuIaquddjj8ay
         vATkmUy2c6Vn91IQjRqTOwQbPCBsN7bOq4ogjElkw0ajdYRWxNPIPsiyFb5uGnF384lX
         Au5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qkHp9efjKo+08fg4LskoQ/kpJrLhjOIZ8+TDrahF3Nc=;
        b=P9PnRGOUDWaiALlR+y3SAsweZTE1u+b9pQYeaB9S62XrzgnHrF2GeXfFmNmkrO3tEK
         C3EfcAYJ5OJ5kgo8d3r5Mo2D//U7rWPVm6oiCif55V6MDUYhyF3R43/cpdEUpL1sgXUn
         IERft41WWotyLzbn1ECDPEwmr5EAH9I16x+Kku4uw6nbcRpnve45DGkuTmdrVHL1K/av
         l2JI2k9zedYXKvk6CoGYcjHXowcvCxDFlYEb0NwjbpIqSyohjd1zP2rzNtMetK/W78k8
         qDLGEEbvo9o5Ka4eTNtK6W63eEMkf6QtvwOYuPqpOVz6vuRueRkXhXDXqNRDd8HMrTLW
         8a0Q==
X-Gm-Message-State: AOAM533oyzpzT930hYV6eo1SQRsZs/IfNawfKjOGuxaz1SAG0ggt7geL
        6suCohmJpkZYSJvJ+kpDigl1eg==
X-Google-Smtp-Source: ABdhPJwmQFyxybmNZNePbemtfTxdJfcwWMw87mwBZWwVTxsc+wYfwvdNXJhYKjRILB9fx1SCwhm5Gw==
X-Received: by 2002:a05:6402:c13:b0:41d:71e1:9b8c with SMTP id co19-20020a0564020c1300b0041d71e19b8cmr4006273edb.258.1649580654131;
        Sun, 10 Apr 2022 01:50:54 -0700 (PDT)
Received: from [192.168.0.188] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id i14-20020a50cfce000000b0041cbaba8743sm11363940edk.56.2022.04.10.01.50.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Apr 2022 01:50:53 -0700 (PDT)
Message-ID: <550e04f5-acd9-e50a-1aae-4e639951e35e@linaro.org>
Date:   Sun, 10 Apr 2022 10:50:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] dt-bindings: firmware: convert Qualcomm SCM binding to
 the yaml
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Heidelberg <david@ixit.cz>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        ~okias/devicetree@lists.sr.ht, Andy Gross <andy.gross@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211218194038.26913-1-david@ixit.cz>
 <YfhT/ltPDhQZV0Bo@builder.lan>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <YfhT/ltPDhQZV0Bo@builder.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/01/2022 22:26, Bjorn Andersson wrote:
> On Sat 18 Dec 13:40 CST 2021, David Heidelberg wrote:
> 
>> Convert Qualcomm SCM firmware binding to the yaml format.
>>
>> Signed-off-by: David Heidelberg <david@ixit.cz>
>> ---
>> This patch comes with followup question -> since not all definitions
>> follow `"qcom,scm-*chipset*", "qcom,scm"`, should I change them or adjust this
>> binding to cover all cases?
>>
> 
> I don't remember why some platforms has the generic "fallback" and
> others doesn't. I don't have any objections to defining the binding as
> you've done.

Looking at the driver it seems that there some differences between
certain versions and generic qcom,scm. For example they require bus
clock which could mean they won't work without it on a "qcom,scm"
compatible. That could mean that original "qcom,scm" also required that
bus clock but it was for example always enabled. Or that clock was never
needed on "qcom,scm".

I think this should be converted without generic fallback, IOW, the
original bindings are not accurate and driver+DTS are better hints how
it should work.


Best regards,
Krzysztof
