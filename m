Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B51B50647F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 08:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348837AbiDSGdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 02:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237280AbiDSGds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 02:33:48 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6DD140C8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 23:31:05 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id k23so30810201ejd.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 23:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/rrLKvmQMfKWM71Vt4ACdmZv7rtrzaFdefyFe3yrPL0=;
        b=TxQpED75D37zNwWP0eZ4Dppk/q0LBcVqFM6ORmD7xS3vp6VttRdoUTzqm+XP5vOFB0
         Ctlm47B6Emw1ElvrpbN9QjQq7etONKq0Fbe+h2PELH5bpevYVaHc0zL4bcpO5Qu1e8ng
         VBoBvyM85yJHIOcjSeDLAlGnhqt81eY9ktqQssIFMEbOujGk25Tjs0P1764K49T1dInS
         gq25ZkM3ab/TjSjwESqF2E+Q65bRBe48H/wOBG8hMorzLyEUchddko3rhab4wIHEZ4u2
         Ed518cl9OebJFYVdZjYw+ib48Z0+1HgqZLZwbpyFngfqIxORmv7aMQjvtzynGBzn8m9q
         UGQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/rrLKvmQMfKWM71Vt4ACdmZv7rtrzaFdefyFe3yrPL0=;
        b=K2YYC1p6mIPhPGxXJHXqKx2zeJQNeM1wYcgoEOMo2NJ9fLJJ2ago6ae3UXpKzIJK4t
         vl91utX7g2ZzvPyvP40jkD1p5YrcrrlKJJZ07yRKybjF7GU8YYbzbnaIa6phZjrkxjXz
         faRrmz5xiu5zHIeqIbLX7mLqUc+Q8gYQCGXlahjLPP8ChgP8pUauIZWaqP5VSL9KG1Uu
         Y0h6cBh+wrdG5lL2b9Bs9BVNECHVxbpDD1cBcyOpaUHLW0ieaffRy2SJGSciudnXpYla
         7lkGYtmzwri35FOr7xREDFVyZhBiatQm+RMrgr3M7LKrAgabLlo3n7OZeHM3JUSbkAK1
         X4Ew==
X-Gm-Message-State: AOAM5327eBcGEZ+Ehrjz1vvnBOI+1sO9uyog4xxjro6x8a5r0Fsq4Elv
        MTBbtZf2G74wNQdLK64cZYv10g==
X-Google-Smtp-Source: ABdhPJzYgvXLYpatm5Bb1YZMvzLwkeUp5lptQM5SS++47h8EOa4UubW5sk4ag3uCpQcwEUHKYqtY7A==
X-Received: by 2002:a17:907:1c9b:b0:6ef:5e62:fd62 with SMTP id nb27-20020a1709071c9b00b006ef5e62fd62mr10556403ejc.686.1650349863942;
        Mon, 18 Apr 2022 23:31:03 -0700 (PDT)
Received: from [192.168.0.217] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id j2-20020a056402238200b0041f351a8b83sm7940834eda.43.2022.04.18.23.31.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 23:31:03 -0700 (PDT)
Message-ID: <aa54cc23-e479-688c-6a3c-b9c73babd9b4@linaro.org>
Date:   Tue, 19 Apr 2022 08:31:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH RESEND v2 1/9] dt-bindings: clk: qcom: msm8996-apcc: Add
 CBF
Content-Language: en-US
To:     Yassine Oudjana <yassine.oudjana@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Rob Herring <robh@kernel.org>
References: <20220416025637.83484-1-y.oudjana@protonmail.com>
 <20220416025637.83484-2-y.oudjana@protonmail.com>
 <813f4a3d-255b-0ec1-cc3e-a1280e4d74ae@linaro.org>
 <VOUJAR.IJKRF5T1P4ZE@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <VOUJAR.IJKRF5T1P4ZE@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/04/2022 21:12, Yassine Oudjana wrote:
> 
> On Mon, Apr 18 2022 at 18:04:08 +0200, Krzysztof Kozlowski 
> <krzysztof.kozlowski@linaro.org> wrote:
>> On 16/04/2022 04:56, Yassine Oudjana wrote:
>>>  Add CBF clock and reg.
>>>
>>>  Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
>>>  Acked-by: Rob Herring <robh@kernel.org>
>>>  ---
>>>   .../devicetree/bindings/clock/qcom,msm8996-apcc.yaml   | 10 
>>> ++++++----
>>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>>
>>>  diff --git 
>>> a/Documentation/devicetree/bindings/clock/qcom,msm8996-apcc.yaml 
>>> b/Documentation/devicetree/bindings/clock/qcom,msm8996-apcc.yaml
>>>  index a20cb10636dd..325f8aef53b2 100644
>>>  --- a/Documentation/devicetree/bindings/clock/qcom,msm8996-apcc.yaml
>>>  +++ b/Documentation/devicetree/bindings/clock/qcom,msm8996-apcc.yaml
>>>  @@ -10,8 +10,8 @@ maintainers:
>>>     - Loic Poulain <loic.poulain@linaro.org>
>>>
>>>   description: |
>>>  -  Qualcomm CPU clock controller for MSM8996 CPUs, clock 0 is for 
>>> Power cluster
>>>  -  and clock 1 is for Perf cluster.
>>>  +  Qualcomm CPU clock controller for MSM8996 CPUs, clock 0 is for 
>>> Power cluster,
>>>  +  clock 1 is for Perf cluster, and clock 2 is for Coherent bus 
>>> fabric (CBF).
>>>
>>>   properties:
>>>     compatible:
>>>  @@ -19,7 +19,9 @@ properties:
>>>         - qcom,msm8996-apcc
>>>
>>>     reg:
>>>  -    maxItems: 1
>>>  +    items:
>>>  +      - description: Cluster clock registers
>>>  +      - description: CBF clock registers
>>
>> This breaks the ABI (which might be okay or might be not, but was not
>> mentioned in the commit) and breaks existing DTSes. Please fix them
>> before this patch.
> 
> This is only documenting changes made in an earlier patch[1] this
> series depends on,

So this other patch breaks the ABI. Was it accepted? The patch you wrote
here should go together with the clock change.

>  and the DTSes are fixed in another patch[2] that
> is also listed as a dependency in the cover letter (both patches
> aren't applied yet). Shouldn't the ABI changes should be mentioned in
> those patches instead?

They should be mentioned in the clock driver or here, because usually
they come together. :)

Best regards,
Krzysztof
