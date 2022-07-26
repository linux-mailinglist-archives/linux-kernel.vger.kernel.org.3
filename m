Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63AB0580BE3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 08:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238013AbiGZGrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 02:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237983AbiGZGrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 02:47:51 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0FB21253
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 23:47:50 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id b16so8768279lfb.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 23:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=s9ZmYUyCnBVCgn8I0a4gHlUL2QkHakLsoQIE+4rbZIU=;
        b=VGpYbF8dlaX9HMAQSkAseu3FRNIClR63M+fO6slYmLoTG1/XrAc4OVO6vPaPwU8Cz4
         jMKYSrZ4mMcPXmgsKZ0aLZCBkVbQLSKSyJz0JqHB/hMhX+MJhvT9r1kAuFDEMEQlt03B
         wqeqOPwzFIfHTqFV7On6t/vhxbGdpA2255fCzKYTekoXIVPpX6NXG8K8Lgf2M3Jo0Hvy
         3Ymk2Qaj2mEG6CwkKIqVj7+zG5DnhA1ilLjRQIZrY5bXyQaMRgKLk1AYqEiPbnrdrYSe
         9hQGy+JRVPHXQg50KbpBmZlk+s2axwmcqBazGYw0wq6TT7IE1EzasLE8EiFXRieT2Iol
         pPPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=s9ZmYUyCnBVCgn8I0a4gHlUL2QkHakLsoQIE+4rbZIU=;
        b=bcpAM+725Us7A+L3dl/VB/yIfAnwuidWZBnR7iNDh3lbssg9AofcZc9utiHrG7ptbR
         jxfhfJp7ZffEyYyVCK4vI6uYwo+NJJzWm/s5IcWJi/BcPq97SltHsxuGOjv+ZJV6mzv9
         nGdm6I5aGrP3F1/C+uLyXJu8XRL2pqliYbrz09RMgBtJJ8dVfS6AUaBqerFWufxMF2yr
         g6R8Kxiu+SFNgiMGwKUmmDC+DKhjKerKQGPEWl2Xy1O4fkfN6yn0ic5ubY+0haPvcPBW
         aR+34nSzqgRvO27T2IBqn2aBQa1Za39zBD8xetQW3LDP07Y1envBa1Tv2NPBAiI+d2IZ
         weNg==
X-Gm-Message-State: AJIora/15K/Dc9fXInMgiKVvMKp6KqsJrFND/zImiTc/VUNEhwFLwxck
        awVwpmSl8lkka1zMRXJXoAHSNw==
X-Google-Smtp-Source: AGRyM1uiEyJ1nP5zh3TphkWCCynKG5URODiPVpMQc+i4JRYaf/DzC3PAuI3BhnUAkzvZF+62ssNM1Q==
X-Received: by 2002:a05:6512:3501:b0:48a:712b:a99 with SMTP id h1-20020a056512350100b0048a712b0a99mr5735515lfs.608.1658818069063;
        Mon, 25 Jul 2022 23:47:49 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id k15-20020a0565123d8f00b0048aab0259c0sm28716lfv.107.2022.07.25.23.47.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jul 2022 23:47:48 -0700 (PDT)
Message-ID: <13697702-20fc-5fef-e335-b6765f93d1a0@linaro.org>
Date:   Tue, 26 Jul 2022 08:47:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 2/4] firmware: Samsung: Add secure monitor driver
Content-Language: en-US
To:     dj76.yang@samsung.com,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "lars.persson@axis.com" <lars.persson@axis.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>
Cc:     "javierm@redhat.com" <javierm@redhat.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "linux-arm-kernel@axis.com" <linux-arm-kernel@axis.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Moon-Ki Jun <moonki.jun@samsung.com>,
        Sang Min Kim <hypmean.kim@samsung.com>,
        Wangseok Lee <wangseok.lee@samsung.com>
References: <aec4ffd0-368d-e71a-06e4-a084138fbab9@linaro.org>
 <20220713045516epcms1p86b3f6a8795d767faac65eb947405f911@epcms1p8>
 <CGME20220713045516epcms1p86b3f6a8795d767faac65eb947405f911@epcms1p6>
 <20220726000429epcms1p6c32018733b1cf87c9f138f76f5c1bdd4@epcms1p6>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220726000429epcms1p6c32018733b1cf87c9f138f76f5c1bdd4@epcms1p6>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/07/2022 02:04, Dongjin Yang wrote:
> 
> On 14/07/2022 04:28, Krzysztof Kozlowski wrote:
>> On 13/07/2022 06:55, Dongjin Yang wrote:
>>>  Introduce a driver to provide calls into secure monitor mode.
>>>  This driver is used for SoCs produced by Samsung Foundry to provide
>>>  SMC call. This patch supports register read/write request to secure
>>>  monitor. Also, SMC call request which uses shared memory to exchange
>>>  the data between kernel and secure monitor.
>>>  
>>>  Signed-off-by: Dongjin Yang <dj76.yang@samsung.com>
>>>  ---
>>>   MAINTAINERS                              |   2 +
>>>   drivers/firmware/Kconfig                 |  11 +++
>>>   drivers/firmware/Makefile                |   1 +
>>>   drivers/firmware/samsung-smc-svc.c       | 154 +++++++++++++++++++++++++++++++
>>>   include/linux/firmware/samsung-smc-svc.h |  59 ++++++++++++
>>>   5 files changed, 227 insertions(+)
>>>   create mode 100644 drivers/firmware/samsung-smc-svc.c
>>>   create mode 100644 include/linux/firmware/samsung-smc-svc.h
>>>  
>>>  diff --git a/MAINTAINERS b/MAINTAINERS
>>>  index 6763746c349f..d173043ffb46 100644
>>>  --- a/MAINTAINERS
>>>  +++ b/MAINTAINERS
>>>  @@ -1868,8 +1868,10 @@ F:        arch/arm/boot/dts/artpec6*
>>>   F:        arch/arm/mach-artpec
>>>   F:        drivers/clk/axis
>>>   F:        drivers/crypto/axis
>>>  +F:        drivers/firmware/samsung-smc-svc.c
>>>   F:        drivers/mmc/host/usdhi6rol0.c
>>>   F:        drivers/pinctrl/pinctrl-artpec*
>>>  +F:        include/linux/firmware/samsung-smc-svc.h
>>
>> Same as for bindings - not related to Artpec platforms. Either add
>> dedicated entry or put it under Samsung SoC.
>>
> 
> This patch is for Artpec8 SoC.

This does not answer my comment at all.


> 


Best regards,
Krzysztof
