Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3AF652CF7F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 11:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236179AbiESJgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 05:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236155AbiESJgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 05:36:07 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9533983A
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 02:36:04 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id t25so8099563lfg.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 02:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=onybpRz7wsYWveJovLHOrWhVwS59mEc1/1KqKRSfSM8=;
        b=olD6VpysjkH0jLBOwKjjLej//tuHVwkIXXvAbGNnkujihoM1hth00fHiy4HmnOqNz5
         NurMeKarjQ4KzGRViIgyAzi5Zk/wL2z6jKZ9zBzmX3bRmP4WD59B3/rBulhbLuq4l9Ud
         VpvxatVl+qtrBoAguRV04PA8ETpuSwLaxmnQuxAyU5sfk0ILo5BMwn2SAUUljJMXbKUc
         DLPQa2FbCUKLE1RGq39iGIZvCPgv4D9vLYptATyWeLzJJg4Dq4/tC7D2Ra/x4uw67gMa
         5VF+imrYYgwcuqyZjksGQ0UHackcL+i3IEl9XQ1bnqU3fDXW0d+ACJW8CtXn7kZePN4e
         gdxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=onybpRz7wsYWveJovLHOrWhVwS59mEc1/1KqKRSfSM8=;
        b=eW6lJNI8N45kV9C1lXTpFZojD58VMQiAD4GxpteXkx3ryA/uyVTxAnekLYz52hbg54
         guxenfe6Jlsxa3aqa7iadveU43egJj0Z3jkBrjsGZKuP5VXkfUJAgEn/AYSQi9DyZAbp
         mo2Gvr5JTOxDd+df/rffWlcQcfZIL1jVWhLH1Y/qd4hrDNfOxAkP6lHEWS2s6/0MfQr5
         D4CIXZDen9V6b/Vkqk53DmUU9xGoUytpmMhRnE4qgcbdrylOoGU2JyjVuZi5t3jvVJTj
         ND72cxa14FuyV6cw0jokGlZFW7EzPOEtwI/GYSu/ZOSD5SUQsr77RweUsQjS/IODFwgW
         45mA==
X-Gm-Message-State: AOAM530E9dNoOxR0fRJ+mVzDObhvQuwOEAU5RJYXWRD/Kg21Ra1N7z98
        5lmnebR1SZRTcI74SzACL3Udmg==
X-Google-Smtp-Source: ABdhPJxntgUVPNj76bvSLwp38vj4ad1KYCyoyK/YGXfzgWo8T9TlfdVXZQL9W1xLmskk+oq6gg6EgQ==
X-Received: by 2002:ac2:4c51:0:b0:473:ab19:87d9 with SMTP id o17-20020ac24c51000000b00473ab1987d9mr2679623lfk.634.1652952962883;
        Thu, 19 May 2022 02:36:02 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id o25-20020ac25e39000000b0047255d21153sm226325lfg.130.2022.05.19.02.36.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 02:36:02 -0700 (PDT)
Message-ID: <9425835f-1674-225e-9558-7b2ba1952879@linaro.org>
Date:   Thu, 19 May 2022 11:36:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/2] dt-bindings: arm: qcom: Document xiaomi,natrium board
Content-Language: en-US
To:     Alec Su <ae40515@yahoo.com.tw>, agross@kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sboyd@codeaurora.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, y.oudjana@protonmail.com
References: <20220519074112.25600-1-ae40515@yahoo.com.tw>
 <20220519074112.25600-3-ae40515@yahoo.com.tw>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220519074112.25600-3-ae40515@yahoo.com.tw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/05/2022 09:41, Alec Su wrote:
> Document Xiaomi Mi 5s Plus (xiaomi-natrium) smartphone which is based on
> Snapdragon 821 SoC.
> 
> Signed-off-by: Alec Su <ae40515@yahoo.com.tw>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
