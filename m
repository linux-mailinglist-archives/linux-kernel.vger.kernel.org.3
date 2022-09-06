Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78675AF31C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 19:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiIFRuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 13:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiIFRuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 13:50:09 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40EB13CF3
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 10:50:07 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id bt10so18561798lfb.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 10:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=PlneHbhh81xts+BhwSSO/bVYfamT6d9aGmPbAoBs+Vc=;
        b=oU8zne1PuAsGYTK92vBce5Sl3SAp4gnqtlqz7Dnz5qyx2mq6rB1Acs2o9mrdyalbyo
         jdFajEVxePigd0oL58M2dpQ1B5CQvLRnDTOgjhXY4GNLRBSNuKDVaR20EluRS2JVviNt
         WgHpCuo6EMnyZb3UzD2wCPkw9xngn5Ena7wTzvWr/pkScoO2VdASwDZqc5OiSeJ9t7kQ
         yehgAdUkhNUNcT1/rhE5RL6xv4WCtfPs/oHdegVKj2sdbTLqnOqiiX9/kZ1EXA2UhrA4
         J9QW3ud3vgKmcGnqqjgzxBQpHYE66ejwuoI3s5+KWnWsHnwoxUZ5AUCLKc0uFtiavzqs
         wK/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=PlneHbhh81xts+BhwSSO/bVYfamT6d9aGmPbAoBs+Vc=;
        b=Cxw8BCsYBj47zv4fMPEMSWgXcxG2q3+IN50/NfJQZVn3aJ2+XM4boSF0F2PHaHcc8n
         b5WC+9AyuOI2ffWXMmMbhNrhakErEeJ3La5bx8i/FD3ouiMKkBHMAnsNb+y52j8SU8qq
         HWlAQ/626KP9DuV+4ZCKnkSQN8zdu0Yt4gOWoKu1MvMiVYIzL7y2cfKv+ouURimtDYAv
         Wm/wjTZ4C6PZt7Mrrq3aNKX9/6ZsisWOjX6HOKbUeNNbV9+rfdAp+YvBw/X6ub38mOvS
         HXePIYPJEhzEErMJ7UX+P+2fmO8CUEEFAyQ5VHII9OCcyPpaq9Xkko3NBy17VoPFZeKu
         Yu3g==
X-Gm-Message-State: ACgBeo37RKpaz/W/Ntu9mghln30jWX+CBd4C68yrN5w5fmWenwi6u3Jl
        K1v65uA9Pc53dsnVLnnfimLS0g==
X-Google-Smtp-Source: AA6agR4eNuH4iEsDzOrIOC2WXOhHLUljsfP8KbsWI1cXvuZNk0fYC7d8Jv8zbKtdt4PMuM4bIeaD5g==
X-Received: by 2002:a05:6512:1507:b0:492:b9ae:5d51 with SMTP id bq7-20020a056512150700b00492b9ae5d51mr17554595lfb.14.1662486605258;
        Tue, 06 Sep 2022 10:50:05 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id p1-20020a05651238c100b00492cfecf1c0sm1873604lft.245.2022.09.06.10.50.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 10:50:04 -0700 (PDT)
Message-ID: <68ff1b7e-51e1-f1e5-dac7-5419472e396a@linaro.org>
Date:   Tue, 6 Sep 2022 19:50:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 0/8] Support for NVDEC on Tegra234
Content-Language: en-US
To:     Mikko Perttunen <cyndis@kapsi.fi>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Mikko Perttunen <mperttunen@nvidia.com>,
        Ashish Mhetre <amhetre@nvidia.com>,
        Sameer Pujar <spujar@nvidia.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220906132823.2390953-1-cyndis@kapsi.fi>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220906132823.2390953-1-cyndis@kapsi.fi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/2022 15:28, Mikko Perttunen wrote:
> From: Mikko Perttunen <mperttunen@nvidia.com>
> 
> Hi all,
> 
> this series adds support for the HW video decoder, NVDEC,
> on Tegra234 (Orin). The main change is a switch from Falcon
> to RISC-V for the internal microcontroller, which brings along
> a change in how the engine is booted. Otherwise it is backwards
> compatible with earlier versions.

You need to describe the dependencies, otherwise I would be free to go
with applying memory controllers part.

Best regards,
Krzysztof
