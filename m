Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6F75066EE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 10:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245543AbiDSIco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 04:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350070AbiDSIcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 04:32:42 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69881147
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 01:30:00 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id g20so20268705edw.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 01:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=XQftwS5jTO7nQbaexhc4a2se6cgFVs3k/WKfwFEA5wk=;
        b=ErwjlGI+eExpbE4D+E0aCP+vxoDr2H740QnFUtgyakgPgBYH8RLPccoi+CS2ht/QRk
         BivHxAOcoNMNbDaZ76qUA9FJk3TaE2EfgIV16fIgM7BbreTFYDqqslK6bb2ifVtgLqht
         Erpw9b+UNUiuDoyxzwzSlRh2zlf46R2ZxmQXpo/T/X4GfvPdOHF0iIihTeEuAKZDMhrr
         XuinRGvlWEymzlo171sqJjMmyiEcgPRxCmy1f9OtTdBHkqOb4beJVZyUJAS17xkFzuX1
         LTc7NTkMRLQeQWI1iyWcfFWr7PcWmsNJK97ZoI/b+Y0qeVOI+I4cDAwRyMFkx+eT4Z+n
         dyLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XQftwS5jTO7nQbaexhc4a2se6cgFVs3k/WKfwFEA5wk=;
        b=WDU/uYqaB6HJkigLbD99x4QDujRnshV+VXIjm9QM0nwQZQ5qGPJPpDv2QsFxL2DfPY
         /bbmQAg6oKSQP0ZwCOnv57RsoEfiUGliz4J5VrLNP2tx/vPoWNhQ134TR29OezMiXjtX
         meCAnc35nTfadP4VRD2JnqCzCgEwz1WPNOsgjv6iIrChjPpma0YScXVXQ1fs0J4xXZlA
         rxSp/Pljk2A4R3gx5SnYEIg1Ew6tqLR27VkRUMU30RNUtLip/eXPywRo4qSvKPR7iHWb
         oiaEItMQsCfpI7dSHAWzemnMIZEHw4yBGfDgEhAEVGNsrUEtyyOkAYlFukDwD91mE7sS
         OtjQ==
X-Gm-Message-State: AOAM531MuC5tz0x15gOCnc3Kgrpn9huziOafpuCseAzBzd2iK85bD10r
        +ZY9wIrMNkfGiNr4uwwpCY0qYiCp4U/jQw==
X-Google-Smtp-Source: ABdhPJyD0kkJKwAgGN2/vfoLZWAVTTfrv/Pj/IJP0GiuDnQzJxM+jmT0cvu27OCtotk/E08L4rKikA==
X-Received: by 2002:a05:6402:350d:b0:41d:675f:ea96 with SMTP id b13-20020a056402350d00b0041d675fea96mr16199110edd.297.1650356999353;
        Tue, 19 Apr 2022 01:29:59 -0700 (PDT)
Received: from [192.168.0.217] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id c2-20020a170906170200b006efe7be5f10sm215737eje.185.2022.04.19.01.29.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 01:29:58 -0700 (PDT)
Message-ID: <3dafc432-849b-0a78-f3dd-954d88c74a61@linaro.org>
Date:   Tue, 19 Apr 2022 10:29:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] extcon: ptn5150: add usb role class support
Content-Language: en-US
To:     Jun Li <jun.li@nxp.com>
Cc:     "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>,
        "cw00.choi@samsung.com" <cw00.choi@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Li <frank.li@nxp.com>, Xu Yang <xu.yang_2@nxp.com>
References: <1649238142-27564-1-git-send-email-jun.li@nxp.com>
 <4ad9e733-7d8b-a73b-c59e-d9b6d5e58498@linaro.org>
 <VI1PR04MB4333FE5742667FBE8AAACD2789E79@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <VI1PR04MB4333585DED292C3AC920B21E89F29@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <CAGE=qro_cWtZe1xVz0MrKXaKnhN_RU+kVPwtLdVj1wsjpSDMjA@mail.gmail.com>
 <VI1PR04MB43330369E23F47E26248853989F29@VI1PR04MB4333.eurprd04.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <VI1PR04MB43330369E23F47E26248853989F29@VI1PR04MB4333.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/2022 10:23, Jun Li wrote:
> 
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: Tuesday, April 19, 2022 3:57 PM
>> To: Jun Li <jun.li@nxp.com>
>> Cc: myungjoo.ham@samsung.com; cw00.choi@samsung.com;
>> linux-kernel@vger.kernel.org; Frank Li <frank.li@nxp.com>; Xu Yang
>> <xu.yang_2@nxp.com>
>> Subject: Re: [PATCH] extcon: ptn5150: add usb role class support
>>
>> On Tue, 19 Apr 2022 at 09:53, Jun Li <jun.li@nxp.com> wrote:
>>>>>> @@ -132,6 +132,7 @@ config EXTCON_PTN5150
>>>>>>   tristate "NXP PTN5150 CC LOGIC USB EXTCON support"
>>>>>>   depends on I2C && (GPIOLIB || COMPILE_TEST)
>>>>>>   select REGMAP_I2C
>>>>>> + select USB_ROLE_SWITCH
>>>>>
>>>>> You do not need to select it. Driver will work without role
>>>>> switch, won't it? If it works, then probably it should be just imply.
>>>>
>>>> Okay, usb role class provider should enable this for me, will drop it.
>>>
>>> A second check on this and I think I still need this, there maybe some
>>> usb controller driver without usb role switch
>>> + ptn5150 via extcon, so no need USB_ROLE_SWITCH, I need
>>> select it to avoid build break.
>>
>> What build problem exactly? Aren't there stubs for !USB_ROLE_SWITCH case?
> 
> Mostly cases USB_ROLE_SWITCH is enabled, but I cannot 100% ensure
> that, at least I can via make menuconfig change by removing some
> controllers drivers to create a config to generate a build break:
> 
> /opt/fsl-imx-internal-xwayland/5.15-honister/sysroots/x86_64-pokysdk-linux/usr/bin/aarch64-poky-linux/aarch64-poky-linux-ld: drivers/extcon/extcon-ptn5150.o: in function `ptn5150_work_sync_and_put':
> extcon-ptn5150.c:(.text+0x20): undefined reference to `usb_role_switch_put'

This is some old kernel - v5.15. Please test your changes on mainline. I
don't see such issue can happen on a recent kernel - there is an EXPORT
and a stub. Maybe your driver misses proper headers?

Best regards,
Krzysztof
