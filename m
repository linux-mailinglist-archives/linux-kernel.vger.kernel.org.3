Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAB1591AE2
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 16:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239618AbiHMOXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 10:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239445AbiHMOXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 10:23:33 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8BF220FD
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 07:23:30 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id s11-20020a1cf20b000000b003a52a0945e8so1766734wmc.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 07:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=zXLI7lVM/yGaQM+ipIyUuHnVFPM6tjGTsAy6QU3E1Cg=;
        b=PUO1hWJdiDKtzCpu0CyqmGKiuWjtXlKQQnRraSzE4Ak3kXH7seuBaipSUnC6bcJXzH
         TrTkLo6RKwfucOlWOJJtJf/uFSc4a1ydliUAyg4dvBF66eatlcHHXfxJ9pHR3XwBn7W7
         spU/gxIWAJ0Ui0r4ZLCWivrURD/GiDE7LzsiF+vGAnIxL7AhOxdcG7iLD1oFhfxZQjCE
         GyJhcdQ2kUgV3rZ8SBW52EUKx8grpwVQ9TMnDXSeCYB7y7qwxLpZEyje11YJmjCN7pWb
         f7is/ZrzlNMxrA63DIYL01JtFelrD/qBaWSZGTDRkPy4dTtV81qGHnUYqg8aKRKrYnIt
         cwOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=zXLI7lVM/yGaQM+ipIyUuHnVFPM6tjGTsAy6QU3E1Cg=;
        b=1iyKy6t/P6fi13V/IO0gNrxe8REZicmahiO8ghw4N0eZ/kA/m9apVsOfCADDg4p6gV
         /EooLBmdlCCSy3wNoadN/3+whAV4uBHkVWvtgGxD335iHrr1EfT97lkn+q1E+SaTBurj
         HboUnHwn6d4PResIOhVV/Omd3mn7r7xJrf4v5znGl92aDsMPdjy3oQkQf7O3KWJhDEOf
         5RjSe3Ibg7B8deELYOdeP21oVZfHBTPJUS9Iehf8fQCNdG59rL7sWNRDfZAiopTVC9s+
         1J27nJHMi2CQPzu5DN3D0YSN5KRr3ga4bpZfFWm8xnyzgW8Xj44y/STgKwRbNcLQIFKY
         bI+A==
X-Gm-Message-State: ACgBeo2UHGrm85vigmEApYZXSPG0FqXSJQgQmMoI9N+POeEtXJ2AQfOc
        BK8BRY6w4BTT0X+aBiI9UVSFnA==
X-Google-Smtp-Source: AA6agR6stw9SsC7wnvyfz/yYO+fUxPfEvU4bLProVHWPfvCSEo9WY85AwZJMDajIUsyLnh25UxX/eg==
X-Received: by 2002:a1c:f716:0:b0:3a1:8f0e:66b4 with SMTP id v22-20020a1cf716000000b003a18f0e66b4mr5468290wmh.140.1660400609202;
        Sat, 13 Aug 2022 07:23:29 -0700 (PDT)
Received: from [192.168.1.12] ([81.178.197.238])
        by smtp.gmail.com with ESMTPSA id j11-20020adfe50b000000b00224f67bfc95sm1050855wrm.62.2022.08.13.07.23.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Aug 2022 07:23:28 -0700 (PDT)
Message-ID: <3cb611a1-590a-673f-99a8-d5da0c5f5790@linaro.org>
Date:   Sat, 13 Aug 2022 15:23:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] mfd: qcom-spmi-pmic: Add more PMIC SUBTYPE IDs
Content-Language: en-US
To:     Luca Weiss <luca.weiss@fairphone.com>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-kernel@vger.kernel.org
References: <20220813114806.102466-1-luca.weiss@fairphone.com>
From:   Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20220813114806.102466-1-luca.weiss@fairphone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/08/2022 12:48, Luca Weiss wrote:
> Add more IDs that are found in the downstream msm-4.19 kernel under the
> path include/linux/qpnp/qpnp-revid.h.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
> I've noticed that some hex numbers in this list have uppercase letters,
> some have lower case ones.
> If wanted I can add a patch converting all to either upper- or lower
> case. Anyone have a preference here?
I think(?) uppercase is the standard for Qualcomm stuff.
> 
>   include/soc/qcom/qcom-spmi-pmic.h | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/include/soc/qcom/qcom-spmi-pmic.h b/include/soc/qcom/qcom-spmi-pmic.h
> index 72398ff44719..bcb8e95d5dab 100644
> --- a/include/soc/qcom/qcom-spmi-pmic.h
> +++ b/include/soc/qcom/qcom-spmi-pmic.h
> @@ -26,18 +26,32 @@
>   #define PM8901_SUBTYPE		0x0f
>   #define PM8950_SUBTYPE		0x10
>   #define PMI8950_SUBTYPE		0x11
> +#define PMK8001_SUBTYPE		0x12
> +#define PMI8996_SUBTYPE		0x13
>   #define PM8998_SUBTYPE		0x14
>   #define PMI8998_SUBTYPE		0x15
> +#define SMB1381_SUBTYPE		0x17 >   #define PM8005_SUBTYPE		0x18
>   #define PM660L_SUBTYPE		0x1A
>   #define PM660_SUBTYPE		0x1B
> +#define SMB1355_SUBTYPE		0x1C
The SHIFT6mq uses this and schematics suggest it doesn't support SPMI. Does it 
make sense to include these secondary charger chips here?
>   #define PM8150_SUBTYPE		0x1E
>   #define PM8150L_SUBTYPE		0x1f
>   #define PM8150B_SUBTYPE		0x20
>   #define PMK8002_SUBTYPE		0x21
> +#define SMB1390_SUBTYPE		0x23
>   #define PM8009_SUBTYPE		0x24
> +#define PMI632_SUBTYPE		0x25
>   #define PM8150C_SUBTYPE		0x26
> +#define PM6150_SUBTYPE		0x28
>   #define SMB2351_SUBTYPE		0x29
> +#define PM8008_SUBTYPE		0x2C
> +#define PM6125_SUBTYPE		0x2D
> +#define PM7250B_SUBTYPE		0x2E
> +#define PMK8350_SUBTYPE		0x2F
> +#define PMR735B_SUBTYPE		0x34
> +#define PM6350_SUBTYPE		0x36
> +#define PM2250_SUBTYPE		0x37
>   
>   #define PMI8998_FAB_ID_SMIC	0x11
>   #define PMI8998_FAB_ID_GF	0x30

-- 
Kind Regards,
Caleb (they/he)
