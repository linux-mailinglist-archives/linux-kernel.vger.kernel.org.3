Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7694F7782
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 09:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241816AbiDGHcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 03:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241808AbiDGHcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 03:32:47 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB67541BF
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 00:30:47 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id l26so9027378ejx.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 00:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vzjb8OyiiJYotEV8kvXDCXjnvHrz6uwgs9bvhbzeeU8=;
        b=yIFq6xd4Us4NfmlSY+xqeSRHONBiPyZLWbCarpHyPpReRoGd6kSu06rKWHp1jpqdoa
         zoGYlLLNT7zerPP9VWMVmqpxagQULEn7bTQs2EKcn5Wi0IExnueM52SIxDVTqTktUZAv
         AZQeKuRYrd/6m53+D2CQw3aOLWbMMMxfIh/Dd4+pbvcF8BSEk4h9pQZTAtpG1/5EubLf
         u/5dDUQOsdlqiFKhxH9o3qGMLCUIZkUgmsOkYlzLCbNQOI2BaV30HrWV2lMPE/8t69ZG
         wQPsn31BXGDT9t3DN/F3u0F9/5o1TPP1giyGa04SlfHT+Cre5agB3rkctxDP3ieizILF
         9CRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vzjb8OyiiJYotEV8kvXDCXjnvHrz6uwgs9bvhbzeeU8=;
        b=lrh/i2nOBwqzB9P4qf3FAxkttZP90qwRFCdVK1FnzrsxylARZtippVAxBb0JFpQ/6l
         yArhYOiEo1KHqqNCvQ+QcoqqazBFoIZ5r3ufTzOmLGxWDNFJDzua8Kh5/ZhVZDgpJ4mN
         zqi8PJhGVUVNYmtX52ytfrTo9IK0YrYaaFiHc++Udamc1A6ySaRI+s/h633+3u2H0nDy
         ++ZEltR2Jy2Tv5T2NytGqEx0nx7XfegqTEFEGhoyyln9lGbsvX6DIkcZ8VfU0x+uvQBv
         Gi+otZJpSduWRBqHsYTuhDcvANIBdQHNpIfvodL1/oAlpRLcmGNfV3xvCkq97K5u6qMG
         sTqg==
X-Gm-Message-State: AOAM530SsaEnlPCztHHzvzip2F9HlfU9viOy8Szilj8gbvHWdq0wWCv5
        /8NmKpXkzoMU0MSUwkY7vyMv5w==
X-Google-Smtp-Source: ABdhPJwIqsvcbUoRf0jzTstI6QI8oC/35Ywl3gLGRtqyMNt7EWPp/vRrxhy1pCRr0jaF/uXfo7s0qQ==
X-Received: by 2002:a17:907:2d89:b0:6df:b7d1:a365 with SMTP id gt9-20020a1709072d8900b006dfb7d1a365mr12892115ejc.386.1649316645845;
        Thu, 07 Apr 2022 00:30:45 -0700 (PDT)
Received: from [192.168.0.185] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id t1-20020a170906178100b006e7edb2c0bdsm4704390eje.15.2022.04.07.00.30.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 00:30:45 -0700 (PDT)
Message-ID: <ad6605e5-a8e4-1906-43cf-eb2d4420dab8@linaro.org>
Date:   Thu, 7 Apr 2022 09:30:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 09/12] ARM: s3c: enable s3c24xx multiplatform support
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Hubert Feurstein <hubert.feurstein@contec.at>,
        Lukasz Majewski <lukma@denx.de>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, patches@opensource.cirrus.com
References: <20220405091750.3076973-1-arnd@kernel.org>
 <20220405091750.3076973-10-arnd@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220405091750.3076973-10-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/04/2022 11:17, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> With the custom ISA I/O and the missing sparse-irq support
> out of the way, s3c24xx can now be built into the same
> kernel as all other ARM9 based platforms.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/Kconfig                  | 18 ------------------
>  arch/arm/mach-s3c/Kconfig.s3c24xx | 23 ++++++++++++++++++++++-
>  2 files changed, 22 insertions(+), 19 deletions(-)
> 

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
