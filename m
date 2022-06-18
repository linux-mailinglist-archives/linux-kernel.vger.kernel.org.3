Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804EC5501D9
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 04:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383794AbiFRCDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 22:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiFRCDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 22:03:10 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DEE735241
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 19:03:09 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id h34-20020a17090a29a500b001eb01527d9eso4720282pjd.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 19:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qwlUdxIoCVnThND7GL7EJBgqVc6c184xvlOa5SGWFRw=;
        b=zUKJFW3uNIeFzfhBIbRELphodAkZL00DL7SE8WSe6tMUeHWHKQIR4oVczHQ08jMkfu
         O4P4wjxyKOM8vmdqYKTjTRRPmk/WeTnnT+zIY58Oa+rkb/mVYSFyM1xKvggpscYnTCbT
         ClZtx42yKDXejXsTsNWYPm+LzyUWgG+OZOt61kQ8nre/unYTUZPf1W31mClkbIGfiIN/
         20eeSUbxcajf7Y50pcINOuCA1ZFbIQWJZzq0xhzUhlyE/0KRBxUVq9aovqZHRXxDqirN
         HWzlllsKCNWx6AN8fniH1f2WHJAUfzPiAT7Od4JWzPkrwwFILLXy20HDzESoi0AZj3HQ
         WUZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qwlUdxIoCVnThND7GL7EJBgqVc6c184xvlOa5SGWFRw=;
        b=WJmGxXZSiYOoc45YmVMxy4Glzix20BO8V1WOJzyIddskgq2h88JOxtk1deDn8GuPGW
         v8WB1knNWJK5yv8+pm87ZEv4SPD2taxRd29rsgFyYl9cKyBSIi5jjgl/aZfFRtvaanAu
         4zDR7unXk935mn6eDm8XypE7+icu4iuJiLSg1PKru1VmL4s7GegcoRbc94dEJVje36QB
         D5Yxzs+ewdjBSwlY9LpX33LztTpM1tBiJHSo6QEc5cC+aT6Z/RYs9mqmJ5ktH8EevEU6
         V+Ef01hxW+MojQmfmOH6PCbsVVHAWhAupwQxpyPpZeY0C7oTwPRQeJvocX+vS3wKif8Z
         LLmg==
X-Gm-Message-State: AJIora9sQJeYlnCaASe15BirTOhJrgoOyJhhrZK+lLwMXiTlTZo5aGGK
        dFAbYlFg/KtNdtX3Cgxng5E1fg==
X-Google-Smtp-Source: AGRyM1s1TUhyyqdjIqUErRKmjCL+6Q7MKTjRuw/cil0e7K4+kStLBI/fSDyz+N8VeKIW13+8hiYDyw==
X-Received: by 2002:a17:90a:66c1:b0:1e8:43ae:f7c0 with SMTP id z1-20020a17090a66c100b001e843aef7c0mr13859865pjl.245.1655517788567;
        Fri, 17 Jun 2022 19:03:08 -0700 (PDT)
Received: from [172.31.235.92] ([216.9.110.6])
        by smtp.gmail.com with ESMTPSA id z18-20020a62d112000000b0051bbc198f3fsm4530229pfg.13.2022.06.17.19.03.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 19:03:08 -0700 (PDT)
Message-ID: <d5139e0c-d301-01b7-3500-90e9526c04f2@linaro.org>
Date:   Fri, 17 Jun 2022 19:03:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] arm64: dts: qcom: starqltechn: add initial device tree
 for starqltechn
Content-Language: en-US
To:     Dzmitry Sankouski <dsankouski@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220617091025.2288817-1-dsankouski@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220617091025.2288817-1-dsankouski@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/06/2022 02:10, Dzmitry Sankouski wrote:
> New device support - Samsung S9 (SM-G9600) phone
> What works:
> - simple framebuffer
> - storage (both main and sdcard)
> - ramoops
> 
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  .../dts/qcom/sdm845-samsung-starqltechn.dts   |  45 ++
>  .../dts/qcom/sdm845-samsung-starqltechn.dtsi  | 448 ++++++++++++++++++
>  3 files changed, 494 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dtsi
> 

Same comments as with your other patches.


Best regards,
Krzysztof
