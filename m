Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7353C4FA6E5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 12:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241448AbiDIKvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 06:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237139AbiDIKvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 06:51:47 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3BE25C70
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 03:49:41 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id c64so501041edf.11
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 03:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=muScinBv1GmldoKzsDwhuMpvbwmu4+at/kThR4eyc1M=;
        b=CkNi0LPtfGTiHIFpc1N++yAaHU0GCuVtnNEKEzr3vCwarlDxHWv9uvBApze+oa+mD4
         dbdeYHqF083r+UXcog+akAfAf9ZcXgx6FvHQzN2ib9lg9V7Wn0hNw5Dn7yp4uVCouy69
         G9sRDaMh2xLVAKKbHiZK2jdyF8Oec+4JVoUKrBHxOta5ycqmjhF2MMUNBJ0v888g+y4U
         CIRgNL07H+vPI8yRz+8h1BqltJkHNWvuDsD6Vy0wXoS11wCTBrplZcinnc88vO+9hYaY
         61JPfYxz91eYCPqYmeb4pIfJ3QDpo0Hk+m9af9RkTs/r5Fm1pgIPZdKyKWAg/whgGI8t
         rSRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=muScinBv1GmldoKzsDwhuMpvbwmu4+at/kThR4eyc1M=;
        b=aNabBRfOtA2T8p7wE+H73JQCdSl/3WxwBtfH1nbbjlrKEl6imcDJhbtI/dq2NPxHhZ
         srlX84PqtKZVhKqKxZ/RNRDmS1az1t9TCazIEcSNHOqBqLY1FWcxMwo1i7s36nlvUzLP
         z+fkCSpSMF4lrgT3HIp709N84XPeFGombRPI2H9kagCcOpxKEUwDxd6ZvdztlZHFkvjP
         LiEW8qnPgrI/22fB0EFOJGAIPbD0bUiKRe1Fd1cGSom1MzIjtEMJ7EqSNpnBd7xRgAEX
         BJI8Q3HKG/GmOxdZiVM1k+i2wIbfuBRWMi85kaefxgzb8xVZVqDAewncFIG8gqLKC/CN
         GkiQ==
X-Gm-Message-State: AOAM5309lSItol9lHl4EeeqGqShC6CD3vrLT3anE9Sq6MIEV1a+BXnhd
        WeXAUu01HMsy4uVwqOZ4arHJbQ==
X-Google-Smtp-Source: ABdhPJxKGpLHKGO6w4WfIykNZa64gCbw9VUp2pirEQbHv3Iuvv9XCvyryopSgIuiJRYE12kKxu4UPA==
X-Received: by 2002:a05:6402:50d0:b0:419:7df9:55c8 with SMTP id h16-20020a05640250d000b004197df955c8mr23122070edb.79.1649501379816;
        Sat, 09 Apr 2022 03:49:39 -0700 (PDT)
Received: from [192.168.0.188] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id g20-20020a170906539400b006e838916ea5sm2591192ejo.72.2022.04.09.03.49.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Apr 2022 03:49:39 -0700 (PDT)
Message-ID: <4557c5fe-6c39-2014-65a4-c14dac98f902@linaro.org>
Date:   Sat, 9 Apr 2022 12:49:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] dt-bindings: interrupt-controller: arm,gic-v3: Make the
 v2 compat requirements explicit
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
References: <20220409101617.268796-1-maz@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220409101617.268796-1-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/2022 12:16, Marc Zyngier wrote:
> A common mistake when writing a device tree for a platform that is using
> GICv3 with ancient CPUs is to overlook the MMIO frames that implement
> the GICv2 compatibility feature, because this feature is implemented by
> the CPUs and not by the GIC itself.
> 
> The compatibility feature itself is optional (all the modern
> implementations have dropped it), but is present in all the ARM Ltd
> implementations of the ARMv8.0 architecture (A3x, A53, A57, A72, A73),
> and many others from various implementers.
> 
> Make it explicit that GICC, GICH and GICV are required for these CPUs.
> Also take this opportunity to update my email address, as people keep
> sending them to the wrong place...
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> ---
>  .../bindings/interrupt-controller/arm,gic-v3.yaml         | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
