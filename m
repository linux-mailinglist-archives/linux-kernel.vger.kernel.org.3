Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4B8515E7E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 16:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382905AbiD3PCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 11:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382903AbiD3PCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 11:02:41 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06A0546BD
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 07:59:18 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id q20so6082924wmq.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 07:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+5JXfzkj+vhJJIZIKEEhm3Jlf2F+NoZCaiRzdzaWrsg=;
        b=ONHYY+zTfSdlfeMSBI1tStKUm6Q8vLchai0CCsjvN4g2BRsTk7UZiYWn1DC8l1owSO
         U0Q61wd0if6oQIdx3xvMN3RpIRX/PEYVkcJkfwc3XsXMmIg2w0hzhYtW3S758yL/a+u8
         FUhtNEWRuXgSbet1i9Fr3zdtzt1ICpxnXrgGeigPyA7FY8JdRV/Iy7+NfRK4gNfOTmWp
         SgBLE8+YT+xbwQb6Swj4/3n86m4PZ1YYLvyAYpG0cu8bGYqR31fTbYSOHKTzN6aRY8G5
         DR0OFq9AyaCPo3cVTDotzHAB4ZNNaSuHiv54xmJOv3tC6Fpt7SJpvLWwjqOQY5wcfr5Z
         qwtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+5JXfzkj+vhJJIZIKEEhm3Jlf2F+NoZCaiRzdzaWrsg=;
        b=pOhpkVkg8BpGzykFc+F2GKxbEBDjw6FhGs+zbKkEY0lQaFIdOnJOHnq6/NiYbi157k
         dgBw7Q/mVXKAJWvXJ2oyTRpJq+Av4oLrkPXV8LsLDL7W4NYAKiDrVAvRjNULLGwcjYK4
         c9WT4gJndl0qm0d6uXbZzgCD2InDDUnSkWzz7itTd98+GuFFi/qrJtwVr7n8tYIAUVh8
         gb+hQpCxxI4jhjQ+0tep34VM2aKZga59JmV/1IqG9BQbNCM5I39L5vL/HMopTJpUpwSR
         VpnRgmAyAtHQnTYH9NHAemqJ2VD+y8eKGNEWt11CQ03iLP01ojFE34lDs7lNb/HmbG9g
         nuBA==
X-Gm-Message-State: AOAM530fMbnKNmPihETnqPXOwLYUOC6oLk10Dfx8Gtd7Lyy27mXHwtgH
        027NRieZe+IrEx0hRLhwzhYaFw==
X-Google-Smtp-Source: ABdhPJy5uZmXFILh6aV3PA32I/1yRS2g4Z0v/3sQGk3nbfPs0topDKt8c1VtIf/89B6ythh3IXqatw==
X-Received: by 2002:a05:600c:2102:b0:394:2765:580c with SMTP id u2-20020a05600c210200b003942765580cmr3871520wml.150.1651330757590;
        Sat, 30 Apr 2022 07:59:17 -0700 (PDT)
Received: from [192.168.209.234] (92.40.198.136.threembb.co.uk. [92.40.198.136])
        by smtp.gmail.com with ESMTPSA id v13-20020adfa1cd000000b0020c5253d8b9sm2147055wrv.5.2022.04.30.07.59.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Apr 2022 07:59:17 -0700 (PDT)
Message-ID: <79f37538-cd4c-963c-225c-bf6b70d684de@linaro.org>
Date:   Sat, 30 Apr 2022 16:00:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v14 04/10] dt-bindings: iio: adc: document qcom-spmi-rradc
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Jami Kettunen <jami.kettunen@somainline.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
References: <20220429220904.137297-1-caleb.connolly@linaro.org>
 <20220429220904.137297-5-caleb.connolly@linaro.org>
 <f56061fe-adec-a148-e085-0561f84e8b3d@linaro.org>
From:   Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <f56061fe-adec-a148-e085-0561f84e8b3d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/04/2022 15:44, Krzysztof Kozlowski wrote:
> On 30/04/2022 00:08, Caleb Connolly wrote:
>> Add dt-binding docs for the Qualcomm SPMI RRADC found in PMICs like
>> PMI8998 and PMI8994
>>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> 
> You got my review tag, didn't you? Any changes in this patch?
Yes, I did, and applied your suggestion, apologies I totally forgot to 
pick it up.

Shall I resend? Or who will be taking this patch? Would they maybe be 
happy to add it?
> 
> Best regards,
> Krzysztof

-- 
Kind Regards,
Caleb (they/he)
