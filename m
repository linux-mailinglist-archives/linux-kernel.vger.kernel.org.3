Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4536157F0A0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 19:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237964AbiGWRbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 13:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbiGWRbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 13:31:02 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9844B95A5
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 10:31:00 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id j26so8725642lji.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 10:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=NwXY0N3ia870DKBFXdMsvyV5G8+2NN2/0Nx14ff2i6w=;
        b=NUnerMw44DEc/thSO6wahnasD5dE71ViQdh9mj7j60TuCHPPt5W6f32HasYWWZzIj6
         QHcN4C++tkgxzSouy7EjsQ8RTKOtBVATkrK7sdHcSbCz2wk09W/Cn5c6hCZfPuOy0X1N
         rFA+hFpgcu0hhvZwhUEqyCro1ZKFdkZUj/ex/y27rP6ywLQl/JeGJUKBlxko89xfBU+v
         swFSmJUmdhu1BHLvvL0dVhFFtFgxLjW8eJuqJWDhLLfmLuJxzIVIjNf2Vo4JOxteK/Wd
         wX8/3Nv9RvufRI0AOjniGwFkW8+VTUtm4/2gLsRfDTuhuq91XDK76/Y1tSaO3aur37+n
         4tFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NwXY0N3ia870DKBFXdMsvyV5G8+2NN2/0Nx14ff2i6w=;
        b=p95OzTQ0VSVYxxMU6GgJzDQDhwBhWC9PQT6ss3r5f/4cJbgNRRc8yOpaDx8m6CLlVc
         V77HIQPy7f1SwSow00NQoP42UstBs58POsQc78vfvybSraW95LP+gvy1rF1c6eNFypyp
         ZBq36eZ7nZJ9eVcXCxFP/WheJDqmVrhHdZt4OuMb0u1cfF8NAbZ4YNQ0wRWGRxQH+9JQ
         dd2W+3K6SAQBNLlujkrxQFA/LNAjrX73dx44vJ73roWVi6kKmOtMm1n+wwpp6evz8WU4
         9vNj8/dsc6W5nOLFiG+zzAfbnCQwUzMGKIfDMMLC7WxqBq8z4OWF+vru0OyUsB2ZbM9z
         +vZQ==
X-Gm-Message-State: AJIora+4VsLCo1c4/tpW9K7UjGNCiKZvWgYlvO/G42LrOJx6B4KsutXJ
        nfwUszLClHqw1MHwVeBDS6GkTg==
X-Google-Smtp-Source: AGRyM1vw2FYnl57qhzK69hNDYpE+hX71B3RjCa5OIg4mIHP+lZ6vqnQt/1cP/CeZnVeTs9zquMs+sQ==
X-Received: by 2002:a2e:910d:0:b0:25d:f7e7:8cce with SMTP id m13-20020a2e910d000000b0025df7e78ccemr1129856ljg.252.1658597458949;
        Sat, 23 Jul 2022 10:30:58 -0700 (PDT)
Received: from [192.168.10.173] (93.81-167-86.customer.lyse.net. [81.167.86.93])
        by smtp.gmail.com with ESMTPSA id 8-20020ac25f08000000b0047f65b60323sm1040110lfq.3.2022.07.23.10.30.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Jul 2022 10:30:58 -0700 (PDT)
Message-ID: <53f7f16e-e2a3-d6f5-edfe-6aadb59713e5@linaro.org>
Date:   Sat, 23 Jul 2022 19:30:56 +0200
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
 <20220721155356.248319-4-krzysztof.kozlowski@linaro.org>
 <12020386.O9o76ZdvQC@g550jk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <12020386.O9o76ZdvQC@g550jk>
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

On 23/07/2022 11:58, Luca Weiss wrote:
> Hi Krzysztof,
> 
> On Donnerstag, 21. Juli 2022 17:53:56 CEST Krzysztof Kozlowski wrote:
>> Run savedefconfig and order the entries, without removing or adding
>> anything.  This reduces conflicts, as new entries should not be added to
>> the end, and makes it easier to spot differences against actual config.
> 
> Could you also add a commit that regenerates it completely?
> 
>  rm .config; make qcom_defconfig; make savedefconfig; mv defconfig arch/arm/
> configs/qcom_defconfig
> 
> There's a bunch of options not present in mainline anymore, most significant 
> QCOM_ADSP_PIL and QCOM_Q6V5_PIL which are now CONFIG_QCOM_Q6V5_MSS and 
> CONFIG_QCOM_Q6V5_PAS. 
> 
> See also 
> https://lore.kernel.org/linux-arm-msm/20191104210943.101393-1-luca@z3ntu.xyz/
> (never applied for some reason)

No, I cannot, because it is wrong method and should never be used. Each
of such options needs careful investigation not to remove user-visible
symbols.


Best regards,
Krzysztof
