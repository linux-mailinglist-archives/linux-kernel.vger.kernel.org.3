Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3A457ECC6
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 10:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbiGWIgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 04:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbiGWIgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 04:36:17 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E16B18E16
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 01:36:16 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id by8so7769901ljb.13
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 01:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=UFNgKWXdIG6DQFBmwM7XyaYQFbIAlbR9vbv7ZA7sYD4=;
        b=xwby9q+fB01FO2mS7fKnVXiA1AOLFxxqsXAyshQcITRU+HVTULFKnJSAu0rpdTWLdX
         7J7diRX15MjxeNOZGeSr/07eAe/qSCX7eVlEkSFYgobhDZR7ziVahvfHAXCW+k1L+vX4
         0Tq77hQKLtiO7q4eAfrlSk24CTRpnW2l8+V0hGbg0q/jNEDZaLlMoE1lPA/ZkMdmPdPl
         6u0KQAyda3jodzgnPQQbkr5+Jzp8KNvPsGr2JsH8/5hupplxS2yisBLWF2T2rQPNum52
         m9MMvJ3Mm0x13S+SghtoKKKEsExJmqk8ewdaF9e/lAlQ02cgTzTAqGu5ZSV1AHoUmBll
         xypQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UFNgKWXdIG6DQFBmwM7XyaYQFbIAlbR9vbv7ZA7sYD4=;
        b=zss3WA3JK+fKwBgEf6UcinHNrZ+5m7y4WXTpkQ/3AudFcpB4NV9je1lAKfRvtVx5GH
         ms+aWkdhRqmCpjiYZPpwhVFh4q8sy8siB5nszkAg+hGOfYXZPRhwhXSMrR1eeJKGA8Nn
         BTfx1hHEonrUNHTLc6s0Baf3+TAbIJks7ZsjS6XXbjYbr64S9uB4m0O9pFuYepE0rsO7
         NDLvDYlE423+MgJHDZY1QqeZez54/U+a4R74+HAuYzQAuuq4o1bJbu9aasjkdi6h2Mrs
         +3aPdYnFby16vubhCnrl8PFOGZdvjVtN3UJ/ZwYfQV82TV0NiglMQJuemOHoOhnUK9aO
         wp/g==
X-Gm-Message-State: AJIora9cBykqyfR0sa1iKvE453NOrH9sqa6XN5WNwBkaEcfyCkDRH+4K
        LO9tRMTS5rEf1ECILTgwk/Ud7A==
X-Google-Smtp-Source: AGRyM1tC6obcKeJ8XV3Kqpjx1vuO1ZcdPvxoiANz+5GuluNWs+REVtSy3fdPz4vCVsjZoHNtum4bUQ==
X-Received: by 2002:a2e:a36a:0:b0:25d:d73d:d8c9 with SMTP id i10-20020a2ea36a000000b0025dd73dd8c9mr1160570ljn.68.1658565374570;
        Sat, 23 Jul 2022 01:36:14 -0700 (PDT)
Received: from [192.168.10.173] (93.81-167-86.customer.lyse.net. [81.167.86.93])
        by smtp.gmail.com with ESMTPSA id x14-20020a056512078e00b0047f79c636f7sm1541978lfr.167.2022.07.23.01.36.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Jul 2022 01:36:14 -0700 (PDT)
Message-ID: <fec6bd98-5efd-fe34-6d75-1765219acd82@linaro.org>
Date:   Sat, 23 Jul 2022 10:36:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 10/10] arm64: dts: qcom: sdm845: add LLCC BWMON
Content-Language: en-US
To:     Steev Klimaszewski <steev@kali.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rajendra Nayak <quic_rjendra@quicinc.com>
References: <20220720192807.130098-1-krzysztof.kozlowski@linaro.org>
 <20220720192807.130098-11-krzysztof.kozlowski@linaro.org>
 <25673493-4171-62b0-f696-1316d115f388@kali.org>
 <96552a95-8939-3ac2-c9b3-14dabaf53923@linaro.org>
 <d814a6da-b0d7-2fd1-fd14-8f1f3b88666f@kali.org>
 <d89a540f-672d-83de-d19d-00f10e4370d1@kali.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <d89a540f-672d-83de-d19d-00f10e4370d1@kali.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/07/2022 04:37, Steev Klimaszewski wrote:
>>
>> Currently it's 5.19.0-rc7 (torvalds tree at 4ba1329c) with a few extra 
>> patches on top, the bwmon set included.  It's possible that secure 
>> world uses it, but I do not know enough about that to say one way or 
>> the other.

To test patches you should apply them on maintainer's tree or
linux-next. Applying on other trees of course might be useful for
testing some backports, but it is independent process and different issue.

>>
>> -- steev
>>
> I think you may be right; I just applied this patchset to -next 
> (20220722) and i do not see the error message there.  On my 5.19-rc7 
> tree, i am also testing a patchset that enables qcom devices to access 
> efivars, so possibly we are ending up in secure world there?

Actually mapping of IO space should not touch secure world, so this was
a long shot assuming you test it on the next.


Best regards,
Krzysztof
