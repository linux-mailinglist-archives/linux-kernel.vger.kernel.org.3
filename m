Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4113C4CD0D5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 10:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236468AbiCDJKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 04:10:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236459AbiCDJKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 04:10:03 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D99A13FAC4
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 01:09:14 -0800 (PST)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2D5BE3F5F9
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 09:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646384953;
        bh=RTZPALBXRdkEKxlmwBNBI927r6kcbqzn0JImmuscASw=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=g2SviGZfMtfmvWGXnBkFDitDyKKO/kMOLXzjCznCqd3TqS70fI507KbuXDWpwfSfU
         0kFpNFB5H75zsYss2Zflew/kkKpWPUd4tI9q+yibNykuN4iFh3pLwnMXbgqZ6LCWZT
         /Qrzdt174JlC5/ye+4YCY13QC5SkO+gn1dBmt+BOa6KUFDOLbjSAt+TGGWHBWXvivy
         2TxEFC0g7hFA0feXyogND31NIHu85D/bIac1k3zROjd1tqG+PHFnp7QPuQ0BpOkgHA
         pU2hasod23K2Wkeugz37j6E00gPanxPvyrj8uWU4AVBCC8dfFbCCOnP+k6SJ7aVGfP
         WbQxUKL5NR0Fw==
Received: by mail-ej1-f72.google.com with SMTP id r18-20020a17090609d200b006a6e943d09eso4096012eje.20
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 01:09:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RTZPALBXRdkEKxlmwBNBI927r6kcbqzn0JImmuscASw=;
        b=4ZudSZJY2cphtjrfWLhm4s5W8i4pKWgJRNaGzrwWRUzvXGsXFRCpcPYfP79QUmC24g
         W4PRIZtKpyaA2dMS70FqeClmKkHhxjKAMFLREcC8t0i+2nsMA1frENorTWrmBzlgRW79
         7SSyuoBTHEcR9vTkE27l7hugAqLaV0H+a4eFMmFlFf1+n1GD0ipF2H0MC1NbTpMleHmQ
         Q4ZElNoqRNSPWG0xyMFsoWpUaQCXEcu2PuDkvIKRhPHZJqnGgUrt4g/Xv+O5tXC8bbnz
         bMU+Qs7xoYVJmoCTzI6XYbS/LHLULzClqJdBbZpHFq5IgPhobR5XEUoZDcicIM5slTXh
         cV9Q==
X-Gm-Message-State: AOAM530p8jGEJg6P/D/Ze7QpTOcl6Oig4imIZT6Ytl8szggc3jcxpSeU
        UdjbUE+yxh7vVOJFesfbuH3QiIXh5CXekYZiTE35V0LmtnDMG3mKcDKsIpmlpKf/zyxqZlw2/fb
        H0Ghs7VmtZOkGwWNrivXcZuVAFkbujdPiAFR+396MBQ==
X-Received: by 2002:a05:6402:42c9:b0:415:e324:c211 with SMTP id i9-20020a05640242c900b00415e324c211mr6137379edc.234.1646384952687;
        Fri, 04 Mar 2022 01:09:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxXgyrNgfR/FnZmmPxYM01MW37vjWNK7AzoWWi8OQyY16xhXHNchbX5Jg3tWX4OAVkVq58unA==
X-Received: by 2002:a05:6402:42c9:b0:415:e324:c211 with SMTP id i9-20020a05640242c900b00415e324c211mr6137362edc.234.1646384952492;
        Fri, 04 Mar 2022 01:09:12 -0800 (PST)
Received: from [192.168.0.138] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id l9-20020a170906078900b006dac5f336f8sm137442ejc.124.2022.03.04.01.09.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Mar 2022 01:09:11 -0800 (PST)
Message-ID: <1664de3d-8e33-596e-19ff-4fb174f2a178@canonical.com>
Date:   Fri, 4 Mar 2022 10:09:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v6 1/3] dt-bindings: Add dma-channels property and modify
 compatible
Content-Language: en-US
To:     Zong Li <zong.li@sifive.com>, robh+dt@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, conor.dooley@microchip.com,
        geert@linux-m68k.org, bin.meng@windriver.com, green.wan@sifive.com,
        vkoul@kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     Palmer Dabbelt <palmer@rivosinc.com>, Rob Herring <robh@kernel.org>
References: <cover.1646383150.git.zong.li@sifive.com>
 <12cff3b68de1bd02a8915bd70999bb4edafaca1b.1646383150.git.zong.li@sifive.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <12cff3b68de1bd02a8915bd70999bb4edafaca1b.1646383150.git.zong.li@sifive.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/03/2022 09:42, Zong Li wrote:
> Add dma-channels property, then we can determine how many channels there
> by device tree, rather than statically defining it in PDMA driver.
> In addition, we also modify the compatible for PDMA versioning scheme.
> 
> Signed-off-by: Zong Li <zong.li@sifive.com>
> Suggested-by: Palmer Dabbelt <palmer@rivosinc.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
>  .../bindings/dma/sifive,fu540-c000-pdma.yaml  | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 

Can you add subystem/driver prefix to the subject? In current form it
looks generic, but it is actually specific, so:

dt-bindings: dma-engine: sifive,fu540:

Best regards,
Krzysztof
