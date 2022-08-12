Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6ADF590C98
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 09:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233593AbiHLHe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 03:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbiHLHez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 03:34:55 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3827A61C6
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 00:34:52 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id by6so134594ljb.11
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 00:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=/0za9YUjlCWR21SNkhMiDN3IDAZyQAT6AQCAzmrddpE=;
        b=VVrjuOUNW/QU9Hyq7AfSOklgFQwWn6UP6bxTIRkljjoWCpC8QQLG9DC0P/t1Oll7mL
         kzTOzeEaUrvcGu/3YoXWafwJlEUumZAELskM1pAYKtQsFAW3CQQv8Utl6uLjJ933ATii
         e4V/vTszQiTuYATPbenDeaWd1TKFpa7GP1ra0QgapKOW6gSjw+q/J9jdAErQczA1KCvt
         /z7jVeVK/iMdP6S/ct64eiKm/cWReCD6aBvTUozAb1KMH4e0QudMAxz2XxFMW9Uvkcp8
         rUKrS+g9jTpKaoP7rgYriKkkMlUHUFz3ivGkmqmgO8YHeZf7fvPqVEwkIRJclCqm9VzK
         8CDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=/0za9YUjlCWR21SNkhMiDN3IDAZyQAT6AQCAzmrddpE=;
        b=QY8/618cpX+xdQt/dDLNhmX3PDt+5C2L8Bm3lGp5IqBO8VFItCXmjJy9x352+pNDSt
         S2JWXzgaZCqrOu2mOY0rZqxGqYIlPGuSJndPFslsm3h8RQeni1Qba9/3X9Dz6yZMn2fn
         bDk2pzG73aMnpcQYKDfh2twzSihOeuFFVcFtOwMcJfVuKA/AOf89FNfoqv8TfakPdU81
         QhUBs/wOUSc/zmxp/n6GWC8sV7G2DqNtb9xzrQE7rGuuhC0v6bBOECUlJU5NOG5UyBUS
         NTliW5afwvzYdJsgeS4q7yI5+rgW6OENwiLEI1RQkThgvOdpXD+3SYC7jBxUsFXe5Igj
         1JIA==
X-Gm-Message-State: ACgBeo3gTDo9vqBXT0usKMyswWWpPSE6Z2rnqJKojL2d7ivlCeoj9HRF
        YXiixp1tOBKG6EB33TDO7pO6vA==
X-Google-Smtp-Source: AA6agR6znqORoYJxRfGm+Kmi2onxatlXLgKKjqviuP7ROeF5zZKHdK1k0rlZjV8xnPXrXDRmjs5bWQ==
X-Received: by 2002:a2e:3515:0:b0:25e:7139:345f with SMTP id z21-20020a2e3515000000b0025e7139345fmr773042ljz.129.1660289691141;
        Fri, 12 Aug 2022 00:34:51 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id 11-20020a05651c128b00b0025e4a8a8038sm258775ljc.88.2022.08.12.00.34.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 00:34:50 -0700 (PDT)
Message-ID: <f636ad9d-5e9c-f703-221a-3c09f31ed105@linaro.org>
Date:   Fri, 12 Aug 2022 10:34:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/4] dt-bindings: PCI: fu740-pci: fix missing clock-names
Content-Language: en-US
To:     Conor Dooley <mail@conchuod.ie>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20220811203306.179744-1-mail@conchuod.ie>
 <20220811203306.179744-2-mail@conchuod.ie>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220811203306.179744-2-mail@conchuod.ie>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/08/2022 23:33, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> The commit in the fixes tag removed the clock-names property from the

Instead:
The commit b92225b034c0 ("dt-bindings: PCI: designware: Fix
'unevaluatedProperties' warnings")....

> SiFive FU740 PCI Controller dt-binding,

No, it did not do it... At least I cannot see it. Where is the removal
exactly in that patch? The commit removed clock-names from required, not
from properties.

 but it was already in the dts
> for the FU740. dtbs_check was not able to pick up on this at the time
> but v2022.08 of dt-schema now can:
> 
> arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dtb: pcie@e00000000: Unevaluated properties are not allowed ('clock-names' was unexpected)
>         From schema: linux/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
> 
> The Linux driver does not use this property, but outside of the kernel
> this property may have users. Re-add the property and its "clocks"
> dependency.
> 


Best regards,
Krzysztof
