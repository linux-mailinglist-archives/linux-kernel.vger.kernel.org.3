Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD92457C568
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 09:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbiGUHhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 03:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbiGUHg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 03:36:58 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B8D7C1B4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 00:36:56 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id j26so845923lji.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 00:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=INIrz+WDj0ZvQHcz9TnBkLHSMLRDg1voDl7d6lVEzy4=;
        b=XuwHynZZccr+ihJjF+6M8WbwngkPw/sUIZTTN6Y/xf8Jz9I6G7qe61XakhiWCodkXB
         WMHqiTeIL0IbF+IGWXlCRF7qTO9W1RwL61FPdVJ9bNGGNvXw4NkF9YhaF9+DWDNxugIU
         fyKK0Ws8XA0eHWHZmJnOdipZfy7kWJJ2bdl/bkC+Y+95HpNAgyGfEQXwzCjLHGtDr2Lg
         rFGPG9gC8+BumsYcKTToqT8sEP+hF08WY3amq2X8lnII5RcT2T7wsOtfWRoQI2aKvSl+
         +Gw0i9xZbHhNrCl/NfvaZ15vGJmPTzzMlHJ4VqATS9GJ1cMd8VED74Ly9i4zIPFZQwI/
         P4xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=INIrz+WDj0ZvQHcz9TnBkLHSMLRDg1voDl7d6lVEzy4=;
        b=blZbWI/jugvFAr5u69ZtrM/RR23AmpS8pdyVuUkmj2DTWtUid3EubHpEzwouo3Ai4u
         H1LKPMglUz+IQUXYkm0O6oCgqBOuC3D/MGvGZGzcoxGJZJU2WXQzoYZURNIntKRaRXF/
         TZ7hXbCGtKGqLTJjunrq/ib2cV1CPcnHyNp4THWLd3TjxsSe+nF1UAUku6vO+btsPf9p
         qt5px8JzwMPX3FGWITmnzaNPxbusCZWXtfS9tHfCoe85UMC/IPEdnFt0k1M9aoNawOW7
         6Jcw92pO+On9VCin7IPd5FZRhh9AbEHMb9UOf7+RWNAuOzVrmT9AfK956297hoH+KfTV
         DfzA==
X-Gm-Message-State: AJIora/4uyHn4JXrRIozGKLom5iY8Elkrir7qXsxmqt8DX039BptWsEt
        g4tdtK7gr+wJlq7HlGUoXWO4ag==
X-Google-Smtp-Source: AGRyM1vmHIZvYb5hQiGX+8TA1O0aR9NSdv6+VJidFvgFxA/LZZxBMKynm3UyxFXXWa1or5c1+APrtg==
X-Received: by 2002:a2e:a990:0:b0:25d:5e37:1746 with SMTP id x16-20020a2ea990000000b0025d5e371746mr18898124ljq.34.1658389015350;
        Thu, 21 Jul 2022 00:36:55 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id cf3-20020a056512280300b0048a71ff9c04sm115644lfb.254.2022.07.21.00.36.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 00:36:54 -0700 (PDT)
Message-ID: <c5b37e68-dc1f-cdae-83e4-23aa0216db69@linaro.org>
Date:   Thu, 21 Jul 2022 09:36:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RESEND PATCH 2/9] dt-bindings: arm64: bcmbca: Update BCM4908
 description
Content-Language: en-US
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Cc:     William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>,
        joel.peshkin@broadcom.com, dan.beygelman@broadcom.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Anand Gore <anand.gore@broadcom.com>,
        Kursad Oney <kursad.oney@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220721000658.29537-1-william.zhang@broadcom.com>
 <a635754e-bf41-4058-5fbb-57ead36b7128@linaro.org>
 <883c2ad4c36220b488519a8902ad72bc@milecki.pl>
 <193845cb-6149-1ae6-5eb6-6b01ffcf763b@linaro.org>
 <4b5100e4a6e9e581f4b8ab58e5ca4927@milecki.pl>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <4b5100e4a6e9e581f4b8ab58e5ca4927@milecki.pl>
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

On 21/07/2022 09:13, Rafał Miłecki wrote:
>> That's better argument. But what's the benefit of adding generic
>> compatible? Devices cannot bind to it (it is too generic). Does it
>> describe the device anyhow? Imagine someone adding compatible
>> "brcm,all-soc-of-broadcom" - does it make any sense?
> 
> OK, I see it now. I can't think of any case of handling all devices
> covered with suc a wide brcm,bcmbca binding.

Maybe there is some common part of a SoC which that generic compatible
would express?

Most archs don't use soc-wide generic compatible, because of reasons I
mentioned - no actual benefits for anyone from such compatible.

But there are exceptions. I fouun socfpga and apple. The apple sounds as
mistake to me, because the generic "apple,arm-platform" compatible looks
like covering all possible Apple ARM platforms. I think Apple ARM
designs in 20 years will not be compatible at all with current design,
so such broad compatible is not useful... but that's only my opinion.

> 
> This leads me to another question if we should actually totally drop
> brcm,bcmbca from other SoCs bindings, see linux-next's
> Documentation/devicetree/bindings/arm/bcm/brcm,bcmbca.yaml

This would be tricky as it was already accepted, unless all sit in
linux-next and did not make to v5.19-rc1.

Best regards,
Krzysztof
