Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4512C4F8704
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 20:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346819AbiDGSUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 14:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233337AbiDGSUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 14:20:11 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3C599EE4;
        Thu,  7 Apr 2022 11:18:10 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id o20so5721600pla.13;
        Thu, 07 Apr 2022 11:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=xQii1eP+D129OOmmEFUPFi+428VvVe2npW0nOtHi0v8=;
        b=WBsYEqJ7FltBHsC6oK/iY4SdWSX6yl+D4SwDFOBtZLxKw67+b4LuB50h908ertO7zg
         Dcthrade36ld2as5TY3PkMw329X2qDnHvylK/N1Cm7ykcJ0GqY14WgfySksy1AbU3YEg
         MIUV5fDNgM+qHqrcjk2DAQGR8aK8ykfQAnzRzMNSi5lB12PEpl88ZQQ+9+EYRgR0RRu2
         h6S2Nsb+l9LAz89Ti8lc3kVHcyaGi+ODPZc3kby0R1R2bWeyY4ARzw3DPTQwAZdDDmPD
         ZVzK3JEOi1ZtBUoP+TnwA5n6kS5WJNPYPbZJo11rKNyviTip8uEfe7fgqm5v/JQhYF1J
         A4Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xQii1eP+D129OOmmEFUPFi+428VvVe2npW0nOtHi0v8=;
        b=y2oMTYOY/h35qRgaP7W6tH8Pesx9+YszHj1HwcdXhQUzy3ctqxS0O32sKiKVdEu5fZ
         4C9mJp3c09PVtcdtK+J9kBEL3xBFytKD2iLqSZzvqFQoJZrfc22vs8s5/GxfoFSdNpH0
         W0J4s3OemM8YN/dA83HfET0OaLZTCd8ulnamJh2SBGZEnv/e2nCQmFA/y3/3U8L53AdZ
         k5D9VKspoMeQtqyLwOdEjIGgn4whvgkbKO8/n5e8YxuWVOoeRWf2Jn6VvxMsAvOP7sfv
         QODXvVizbNIEuNlqJLgLfcH3MalUtv/zvtnLUrrJHjAr9OfGquGRfxTzGBN1YpRE1Iek
         mXpw==
X-Gm-Message-State: AOAM533ZE3aTwHbv/R2TQybdHxltZdQpuQmlvOgWdi6VdhULu4vOObJK
        Mv2QHcC8Z5wuwb3nmcAZvmvGYDCGMPU=
X-Google-Smtp-Source: ABdhPJyXdHfHZMxDow5pG2bx+mSyl30fIzwXdgKyuiWLg9v6EURe8ej5jtVSOTdU4b4I9EDVWhfFEg==
X-Received: by 2002:a17:903:41c3:b0:157:1e3b:ee66 with SMTP id u3-20020a17090341c300b001571e3bee66mr867050ple.41.1649355490155;
        Thu, 07 Apr 2022 11:18:10 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id j13-20020a056a00130d00b004f1025a4361sm24726271pfu.202.2022.04.07.11.18.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 11:18:09 -0700 (PDT)
Message-ID: <55800b61-bdb7-9e93-7d2c-b5a34c1e5cd0@gmail.com>
Date:   Thu, 7 Apr 2022 11:18:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] MIPS: dts: align SPI NOR node name with dtschema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220407143328.295762-1-krzysztof.kozlowski@linaro.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220407143328.295762-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/22 07:33, Krzysztof Kozlowski wrote:
> The node names should be generic and SPI NOR dtschema expects "flash".
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   arch/mips/boot/dts/brcm/bcm97358svmb.dts                   | 2 +-
>   arch/mips/boot/dts/brcm/bcm97360svmb.dts                   | 2 +-
>   arch/mips/boot/dts/brcm/bcm97425svmb.dts                   | 2 +-

For the above:

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
