Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D1354BA71
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 21:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244708AbiFNTSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 15:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348588AbiFNTS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 15:18:29 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E8B29C86
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 12:18:25 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id h1so8516495plf.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 12:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=3hYo58giO756Nq17jRB4A4D+eaiCFVzK8Vfjbc4Oh+o=;
        b=C7el04sMSIat6W96z22BeTYVjWwGcAlQULymQ6Y3dqpfyczEYEVavvflfNH8t/Cj99
         x2g2Xn3hhaZvrwjOPm/lVCRyC0nhA6KlTsgkD9lBtmKe1fEKgWq8xt2B6MDprNs8zNPh
         SS7Sk1W8ICtEcmA/yOxNr/AfG20Z30Gr3qGiXwSpStXJBNiurFBBeqi8K9j0q6MBDEI2
         6UJ6gaXUUEO02VAWg03qQD/Moq9i7a/2flalIrEOJfN4OP7zRhRoIlHGUvSTEKaO6oIE
         uWS3fPEiM42Ug0OS2bhWEMFbvJ3vB84wRO6bUZGfX1uufAUQ2p3jzsn41WqtHIfPpzz1
         vcgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3hYo58giO756Nq17jRB4A4D+eaiCFVzK8Vfjbc4Oh+o=;
        b=PWWGGCbQedoVm+eId99uXqWhQjlmx6yAY35rSrkLVONQyB7x2kH6QC2Ox91qTl8g4F
         Ma4TjrH53Q0U964ZSS/0VFwRIMIJu5AVw557L3AUjkmSDJHb+fFGkrsYFitPs8C/jj9Y
         SY3tMOH6qCVlPw9bBAxobURLV9PB7qCqVj3A+vMiada6nr7qQNyX15GSjWyEGrqKiOCq
         /r/+GElZd+X2b1diYV4U0rCNw+I1/+RZRo9s2auvRJDynkaWCBCQrYvLF4lq9VRQHTms
         jFoumbZcle0tuhaR+doig+eWZwTUh/b0zazDjk36Y4uEQQbEqCz3YimRUrlRcpZDdQnj
         sK4Q==
X-Gm-Message-State: AJIora9jqSFDyihH6oQ9qUbGkmUfpxjmAdUBExeNezaxWCZEMgSdtidy
        sHlfSpSo/jQXfJ9vhreX1QCHAA==
X-Google-Smtp-Source: AGRyM1tuHjbaqXs+7aghcEEp8rKNGSZssX8kuM31YU6OetEN14CKRCXjzx0TBQrL8CyxowH1ASWJXg==
X-Received: by 2002:a17:90b:1808:b0:1e2:a335:ad04 with SMTP id lw8-20020a17090b180800b001e2a335ad04mr6135419pjb.110.1655234304868;
        Tue, 14 Jun 2022 12:18:24 -0700 (PDT)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 17-20020a17090a005100b001e87ae821f8sm7781425pjb.36.2022.06.14.12.18.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 12:18:23 -0700 (PDT)
Message-ID: <81493b57-a35e-3082-f5a8-36c8278a8bf3@linaro.org>
Date:   Tue, 14 Jun 2022 21:18:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/2] dt-bindings: thermal: qcom,spmi-temp-alarm: convert
 to dtschema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "Ivan T. Ivanov" <ivan.ivanov@linaro.org>,
        Kumar Gala <galak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220608112702.80873-1-krzysztof.kozlowski@linaro.org>
 <2c778212-1ff6-6afb-aa13-917bbffcfebc@linaro.org>
 <c317ba82-e77f-147f-6c4e-c975d1d313ea@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <c317ba82-e77f-147f-6c4e-c975d1d313ea@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/06/2022 21:17, Krzysztof Kozlowski wrote:
> On 14/06/2022 12:01, Daniel Lezcano wrote:
>> On 08/06/2022 13:27, Krzysztof Kozlowski wrote:
>>> Convert the Qualcomm QPNP PMIC Temperature Alarm to DT Schema.
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> ---
>>>    .../thermal/qcom,spmi-temp-alarm.yaml         | 85 +++++++++++++++++++
>>>    .../bindings/thermal/qcom-spmi-temp-alarm.txt | 51 -----------
>>>    2 files changed, 85 insertions(+), 51 deletions(-)
>>>    create mode 100644 Documentation/devicetree/bindings/thermal/qcom,spmi-temp-alarm.yaml
>>>    delete mode 100644 Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt
>>
>> Applied this patch.
>>
>> I can pick patch 2/2 if needed, just let me know
> 
> Thanks Daniel. I guess Bjorn will pick up the DTS patch.

Ok, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
