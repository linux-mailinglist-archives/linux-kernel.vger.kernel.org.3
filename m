Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C37855232C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 19:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244312AbiFTRyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 13:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243937AbiFTRyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 13:54:10 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C290D12D19;
        Mon, 20 Jun 2022 10:54:09 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 73-20020a17090a0fcf00b001eaee69f600so10991580pjz.1;
        Mon, 20 Jun 2022 10:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=vvYwGTN1mv6KRM8evjtGeBVcR/hVSGHUSirnlfpYNSI=;
        b=MrZRgulrKcrhZPdL4iJPDrk1+6DPkml+Du/oglRIXCe67XkNfA+iWIZ44Cxyvf6oPc
         J40ky23bgI7PIC7BNBYyY6UnXeskP8dVdcI4DEsAvWxEP1PzYhUrafUANTXniFUoABf3
         4GZxSAv9yr2Q8i0V+HUFR6RmoueOhF++6m0Cpbsy5WDZ5GAj9BOHEb8ajl1S2H4UnzA6
         Jahzd1GXIw67g6jVNzizpfvSypMNP8NDgfP35OCNy+fnuAMQlQFo8WaOQmou71436Ier
         k8H9xyL648qN8VSF8+qyXLNJczt+t/rhoXN6tL9Wd1ysBM+ZLgYUDuW2K/noFE39xv61
         sJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vvYwGTN1mv6KRM8evjtGeBVcR/hVSGHUSirnlfpYNSI=;
        b=cxSnk/8EonpfX8uzfMOKSv4VvEEHGZyasYKgZ6JlDXiGxkgsC/mieH/gXcOcfbAxN0
         pyfKskfkSW62OzkIUPVDpCCvRwJfp/KIqMp0M6HB98PH2+9wb2ktwoKIU93hvA64NIY/
         +KugxwYv32TpAZLlJP7cFi5e10T8SSUi84HfBWEOOvCuHNOwTy+jDfnurv7kNgyqBw/a
         NkXJenj9/dQH1AGfCtIrFWs4EHonbnL55ZCsYeLt8UL0jH2/hEtOz4XldGbSYykwpwiq
         9wlvAMvye/Wl96E9ErX+BUjxQjLuRBZEY/R8tO5Kbo1cw5+xBtpVM/JZhJkKO2gSk3Sj
         C2kg==
X-Gm-Message-State: AJIora9qNeiS4KuSKNeh0Z7yd9kUDqmuGsP+hZVsYH7gR0MXKQuJ5g2T
        uPpDGei4YCsC5C8ypxYwEQs=
X-Google-Smtp-Source: AGRyM1tlLrOM217sQcFarNtDI2AH+jdKcMQ1cvHAomWQ8A0Qih/n2gY7V/bD34rJLanMJd/5kcRQ5Q==
X-Received: by 2002:a17:902:f544:b0:16a:2b62:ef77 with SMTP id h4-20020a170902f54400b0016a2b62ef77mr4049696plf.134.1655747649291;
        Mon, 20 Jun 2022 10:54:09 -0700 (PDT)
Received: from [192.168.0.131] ([194.183.54.57])
        by smtp.gmail.com with ESMTPSA id k198-20020a636fcf000000b003fd1111d73csm9364949pgc.4.2022.06.20.10.54.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 10:54:08 -0700 (PDT)
Message-ID: <2b8fb3a4-5d61-ddfc-ed90-18da7225bc2d@gmail.com>
Date:   Mon, 20 Jun 2022 19:54:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 0/3] leds/arm: dts: leds on Samsung Galaxy S3
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
References: <20220620175033.130468-1-krzysztof.kozlowski@linaro.org>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
In-Reply-To: <20220620175033.130468-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 6/20/22 19:50, Krzysztof Kozlowski wrote:
> Hi,
> 
> Merging
> =======
> 1. Bindings patch: via leds tree.
> 2. DTS patches: I will take them via Samsung SoC tree.
> 
> Changes since v1
> ================
> 1. Drop the label from example and DTS, per discussions with Jacek.
> 
> Best regards,
> Krzysztof
> 
> Krzysztof Kozlowski (3):
>    dt-bindings: leds: skyworks,aat1290: convert to dtschema
>    ARM: dts: exynos: align aat1290 flash LED node with bindings in Galaxy
>      S3
>    ARM: dts: exynos: add function and color to aat1290 flash LED node in
>      Galaxy S3
> 
>   .../devicetree/bindings/leds/leds-aat1290.txt | 77 ---------------
>   .../bindings/leds/skyworks,aat1290.yaml       | 95 +++++++++++++++++++
>   arch/arm/boot/dts/exynos4412-galaxy-s3.dtsi   |  6 +-
>   3 files changed, 99 insertions(+), 79 deletions(-)
>   delete mode 100644 Documentation/devicetree/bindings/leds/leds-aat1290.txt
>   create mode 100644 Documentation/devicetree/bindings/leds/skyworks,aat1290.yaml
> 

For the whole set:

Acked-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>

-- 
Best regards,
Jacek Anaszewski
