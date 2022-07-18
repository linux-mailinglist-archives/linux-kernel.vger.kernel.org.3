Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3771257833A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 15:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235021AbiGRNJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 09:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235384AbiGRNJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:09:52 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0227D12ACF
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 06:09:51 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id u19so10390385lfs.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 06:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PhK1b8reBUV699VXSqYLQPHF1tp+dIwcIa0DcdvJTNw=;
        b=HZ9YTB0b7sxmG8a9XikFipR9NlM9c5Wrl/9w9h6Nh4NdJlf0Z/IESC2JrFD2b5JRXV
         065Xmoxpx+zxUYcN9enVUBt3bOZ35t7LaOB/1WDQ6nEaaziJPbZzpj1mcnlSClZ10nuc
         mgbOZ1tRGJVmNmeMy0c/dqaBfM36zBYLFbe7G3SHBXl9kKHyyvKN/3ezEMVqh7QfkCIZ
         JoR6pkqmQdTqw/qFVhqccq0QFyX+fSVU90iGcyTxmcz/VgFzStKIwS3Tdtmtm0Uz1PD+
         EL71wszSMscE+Tkkqt4NQDczdTS5w8ROv7LZCj87/XwvZX4i7I9txCH6idDraPMD1oja
         zbVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PhK1b8reBUV699VXSqYLQPHF1tp+dIwcIa0DcdvJTNw=;
        b=rrAvDpi4ac1Ig75HCDYgBPHfoHIHhT33OX+OkOQxwYsVcyIe3ELcW9iV050loPsRjc
         ZMCDxlvVYYtd/wyMJe0Hjv285adKWnSGe+uj0FrowsyFKpIbxlHpag8NwjqJpviC+Huo
         nCEb5pHQEKCPQB5SZ3egz7+e2GPoKcr1//N/QoQwNwnSdreQrd+ylJ5U5JQR/eMpS3bW
         EQPBKgnbHKPWE1aJ4l7XPJ46HZwvgn/vOqyJgJqF72iQsLf0tU6K4vMj2HOkPcHtKZwV
         6YgN7LISf2SBxFO0FsyjmxwbEW0Rnou6bhClRAfAF5+Pdeg0gL49sFQLctLEf+9GrdpT
         9z4g==
X-Gm-Message-State: AJIora8Ea8suAkDO5/ttVSSEHZLsojSYeTNA2bMWsRh9aB+z7+RNAnUd
        RYyk8FtkLm/LYMItJdxzskS5Sg==
X-Google-Smtp-Source: AGRyM1ub7C1wNFUUzclp8W82PDBUt5OBAdhZ5vBkZnyH93vEyNyrtqqNhg9fpJ+lfNDYfchWjlRWUg==
X-Received: by 2002:a05:6512:22c8:b0:488:e69b:9311 with SMTP id g8-20020a05651222c800b00488e69b9311mr14113807lfu.564.1658149789113;
        Mon, 18 Jul 2022 06:09:49 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id c28-20020ac25f7c000000b0047f750ecd8csm2596389lfc.67.2022.07.18.06.09.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 06:09:48 -0700 (PDT)
Message-ID: <78160db4-eef2-ce8b-caf7-4df5bc0a8e94@linaro.org>
Date:   Mon, 18 Jul 2022 15:09:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RESEND PATCH 1/4] dt-bindings: qcom: Document bindings for new
 msm8916-samsung-e2015 devices
Content-Language: en-US
To:     "Lin, Meng-Bo" <linmengbo0689@protonmail.com>,
        devicetree@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20220715102055.3844-1-linmengbo0689@protonmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220715102055.3844-1-linmengbo0689@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/07/2022 12:21, Lin, Meng-Bo wrote:
> Document the new samsung,e5/e7/grandmax device tree bindings used in their
> device trees.
> 
> Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 3 +++

If this is resend of v1, why I cannot find this patch in v1?


Best regards,
Krzysztof
