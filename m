Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72A557F0F5
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 20:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236744AbiGWSoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 14:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbiGWSoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 14:44:14 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6D86398
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 11:44:12 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id d17so10248499lfa.12
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 11:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=V4R0Y439OoJgCAwcGbvYV3ziDx/L2sIb2nb3jHALUdM=;
        b=YyTi79ofxoCYOriHGl62kjHsFVlAsTcp0JLq/dATlF85cV4Et2+7LcOtulLHy5gqmD
         It8CcAqDE6Xvr92R15OI46AfB/u0Uf9aPA0GAbxMZU4GGNT2HKpsCgEEeRJ8ET3IC7mM
         QsZYk/F8HOc0eMJLVBFLtrcixy6zqz/lB42jQl+nwopPd3VvSE+95bxZFZQratpAjyj6
         tKgScs1BIQTDR1labYyK3RSubGss6s86uVMIyGD/8MxSpll5pJ4/aNBukOEes7LIXLqE
         xwPwsUFC3hCzn5yfAzwrzI+pwslkZvq3kicFKhs8B+B0BDAYMpGoajyka2UvWb/bCY8S
         5U3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=V4R0Y439OoJgCAwcGbvYV3ziDx/L2sIb2nb3jHALUdM=;
        b=i+jWUv8FmeEvBQsR3lMzJnEaKYc28R/Xo6k9IMXyAdRyh2mkIFa4is8ypojj3wMd1o
         yxTJQRrfbXaxOYysicmijjzNI3TkVNa3J9dpf+NayAqK988xh4y41xV7FDMMnSygYOOh
         nBwZ4V9F5vaRaINcc5ItBiBIKEgEeD68DzSrWxs347YQilxE76ZZBGSNhW5nk3mkcI+S
         3AQm6Pa+ouWaYMD9hRCUH/iNfj2zDdA0BKMABdsEUeBXgHEhIyChhvehR7bVbPdpEwIW
         wRDrZtG17pOac1Lnqiy51hU9lePpBM07lpre0EL4lOTxDlq/T46pPWl7ZvMLMMhSjzzn
         i/TA==
X-Gm-Message-State: AJIora9FqNsOeeLuMcInth7QvLBQpYkeU8SD6+/FkJ/JLOHj3IVLeDpY
        kYDZdnwyZQjwK/IvbvTQWzL8JNg2W9ojIuR4
X-Google-Smtp-Source: AGRyM1vJJ64kmkl6SDxmGKuAeX+VvdZSx4UWmgd9iBWxqgfMMxWnagE8cpNfZH4qpAXYjvUWgnpLVw==
X-Received: by 2002:a19:e005:0:b0:48a:736e:153d with SMTP id x5-20020a19e005000000b0048a736e153dmr2232970lfg.458.1658601850679;
        Sat, 23 Jul 2022 11:44:10 -0700 (PDT)
Received: from [192.168.10.173] (93.81-167-86.customer.lyse.net. [81.167.86.93])
        by smtp.gmail.com with ESMTPSA id t4-20020ac25484000000b0047f8cb9401fsm1782012lfk.89.2022.07.23.11.44.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Jul 2022 11:44:10 -0700 (PDT)
Message-ID: <c5150e83-0e50-3be6-b6bd-bf30fe5e94d1@linaro.org>
Date:   Sat, 23 Jul 2022 20:44:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 3/3] ARM: qcom_defconfig: order items with
 savedefconfig
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220721155356.248319-1-krzysztof.kozlowski@linaro.org>
 <12020386.O9o76ZdvQC@g550jk>
 <2a865367-47b2-ccde-869e-942252a08c5c@linaro.org> <2246145.ElGaqSPkdT@g550jk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <2246145.ElGaqSPkdT@g550jk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/07/2022 20:17, Luca Weiss wrote:
> On Samstag, 23. Juli 2022 19:36:17 CEST Krzysztof Kozlowski wrote:
>> On 23/07/2022 11:58, Luca Weiss wrote:
>>> See also
>>> https://lore.kernel.org/linux-arm-msm/20191104210943.101393-1-luca@z3ntu.x
>>> yz/ (never applied for some reason)
>>
>> Mentioned patch is incorrect so should not be applied - it removes at
>> least TMPFS which is not desired. I did not check other removed symbols.
> 
> For this example: TMPFS is still enabled after this, it's selected by other 
> options, like DRM or COMMON_CLK.

I know, it does not matter. We had this case (with DEBUGFS and probably
others) and the decision was - user visible symbols must no be removed
by savedefconfig.

> 
> Imo not doing this just hides the brokeness as options wouldn't get selected 
> anyways when you do "make qcom_defconfig". Savedefconfig afterwards just puts 
> reality into the defconfig file. And yes, if some option gets lost then some 
> dependency for it probably needs to get enabled as well and this should get 
> fixed.

But dependencies are no being enabled, because expectation is that all
user-visible options are selected by defconfig.


Best regards,
Krzysztof
