Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936E858273F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 15:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbiG0NAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 09:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233490AbiG0NAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 09:00:45 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40EE6248E5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 06:00:44 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id z25so27070202lfr.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 06:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xt/iFa0Gww8PQ4QvOwKstYasksWx1xQKZXD7icliRMg=;
        b=nbUaUiRllsTbFH3Eus9e9UO4svt+vu8pCbP4kZQ1WT8glgkQh76sC4B6uwYKBgcsgG
         2xahkgtvpatCU6uSb9gtnePlK6Yaz5GKnH6PKRHc6yDcDaGHo03vfdwj4nZv0/8H+FtS
         CAqLBZnrGAx5Vb/z1k+kaPvbI7xZhQb9pS8F1ppy/zdpq+qLjsh18zolWqj3H6y+LOdL
         XFimzwZKqd7dJET7E5G85tNvJdiBYQDp3yiBGcDez1HrYZVoJWsIXhuWf8vRghlK/Qcf
         5GLPT8J4ljVPbZ0xp1W3lNkz83IcNq+ejVOUgUaQsWBDfZeKmb5EGtrEsTR+63o2+VUD
         D5qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xt/iFa0Gww8PQ4QvOwKstYasksWx1xQKZXD7icliRMg=;
        b=8FGg/ZyaIJchJqwxraUZlXS2/Prpy6fpmJO74PnruxQkb0/qF5f6VnclSialXNCiHV
         I4eQ79uUluSjabiWzmREH0US8KsXGLiAxplIv2hZMw/W4bVwjEU87w1TJBlwJf164mZD
         CPEeNk1BpAPhbsp75NpVr0Aq7odeMNNclCea1IYVa09Ut60zfbpY97QKC0wLmXpt+rol
         oOvyNujvmOO31AkBsMikX1vrF+aEFtEdPApQMKz3jIPd6m4WLo9DztWisl9QK79UdcdD
         yMQcKV5keio57MBEKAH/U8bu7HUIcrK9rKJ4XH2R1MW//6fXVHMxWc2znS2tS7old6sF
         1+AQ==
X-Gm-Message-State: AJIora91I3Eieylzo1Sq0RWU2i26yNGUOQwiMsJea+pFQGZqUVroOPPH
        QSAIe6x/bYD8hoISlAKyaNNn2Q==
X-Google-Smtp-Source: AGRyM1um+pnIbZzevQmvuQYPA79p7q3V9/eshGhbnk08XsshNMDjZQ3pVxUN/3rrgAfllb5kV38jFg==
X-Received: by 2002:a05:6512:1050:b0:48a:2319:59bc with SMTP id c16-20020a056512105000b0048a231959bcmr7964312lfb.665.1658926842477;
        Wed, 27 Jul 2022 06:00:42 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id z20-20020a056512309400b0048a93325906sm1438931lfd.171.2022.07.27.06.00.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 06:00:41 -0700 (PDT)
Message-ID: <75e5ace3-3255-2302-65f5-9fbef9cb1147@linaro.org>
Date:   Wed, 27 Jul 2022 15:00:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 4/6] dt-bindings: riscv: Add DT binding documentation for
 Renesas RZ/Five SoC and SMARC EVK
Content-Language: en-US
To:     Biju Das <biju.das.jz@bp.renesas.com>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220726180623.1668-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220726180623.1668-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <636e9214-4b36-e9a6-3c6b-b6edb944335e@linaro.org>
 <CA+V-a8sTw1qzuTeD2vb7RgDmmNdEP5qEcxXCjrFgkyrBrLrt5Q@mail.gmail.com>
 <e64cc15e-b31e-876d-b3cf-b60d255c495b@linaro.org>
 <CA+V-a8u1VW9xaj2KjySyMuegpisLVENO_6uJOpAFZGbKziYLYw@mail.gmail.com>
 <e31e0c1f-4755-704e-8428-93970877d8f5@linaro.org>
 <CA+V-a8sX=Frs_cds9MriauTFRvcZUNCvoeZ+SaC0GUpL7L6qhg@mail.gmail.com>
 <9f32a4a9-66b4-ba2e-1713-436103c2faf8@linaro.org>
 <OS0PR01MB5922763582B836DA45CDFF0886979@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <80f08089-e3bb-983e-313b-45613364829e@linaro.org>
 <OS0PR01MB5922FDF8CFFE44A611D3783886979@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <OS0PR01MB5922FDF8CFFE44A611D3783886979@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/2022 14:56, Biju Das wrote:
>>
>> Then it is not the same SoC! Same means same, identical. CPU
>> architecture is one of the major differences, which means it is not the
>> same.
> 
> Family SoC(R9A07G043) is at top level. Then it has different SoCId for taking care of
> differences for SoC based on ARMV8 and RISC-V which has separate compatible like
> r9a07g043u11 and r9a07g043f01?

This does not answer the concern - it's not the same SoC. The most
generic compatible denotes the most common part. I would argue that
instruction set and architecture are the most important differences.
None of ARMv8 SoCs (SoCs, not CPU cores) have "arm,armv8" compatible and
you went even more - you combined two architectures in the most generic
compatibles.

> 
>>
>>> Using same SoM and Carrier board?
>>
>> It's like saying PC with x86 and ARMv8 board are the same because they
>> both use same "PC chassis".
> 
> What I meant is board based on Family SoC(R9A07G043) that is either based on ARMv8 or
> RISC-V cpu architecture.

I don't see this related to the topic at all. What board do you use,
does not matter. The board does not change the fact these SoCs have
entirely different architecture - ARMv8 and RISC-V.


Best regards,
Krzysztof
