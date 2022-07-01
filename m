Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC9D562C14
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 08:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234920AbiGAG5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 02:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234969AbiGAG50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 02:57:26 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BAE0599FE
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 23:57:25 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id fi2so2297623ejb.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 23:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=YfRTFJ02bj0rSle4oHFbCTtD3AzfJegzrCINfxa5z78=;
        b=ra+Quhh0Thq+O+pDwNGVWGKshm6dhVQrA0NwUrQk6urw1fww60IgrAdq9TctmVZtI0
         9imy4vadKzymt3zTc60EZMX1KXg9q2LMthU8xJZHjMxTE5m39ZOWIM3rtl78U/J2X4BF
         pD9xQ9wMQlrdVi+wPN6oQTdbOxrmfjY4+21nFMchj4H7MxbCTcqCKGuTBpNLtU+CmN/t
         iO2zwcbO0+w7nX86aEa++YAzE0FWu1M19jqSjdt2MBhqQL9DANsEMgtZ4joZUZCIU2kf
         xY13fWzGhi/kPQ2VSBPCfF7ttILfcPilh9iht6+fTep2c6fiiTI70OghAIjJeYgFbl4n
         S74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YfRTFJ02bj0rSle4oHFbCTtD3AzfJegzrCINfxa5z78=;
        b=h0DhlURuPQBNQVEQCpTlJNQPClrwFm5NHuAfFPJS1kCv8d6tVZBZtlmZkIxuYJLr3+
         3i+KEi3t3bJ6BPdytk8M/oFiEUrLWFBOFN35NBlmjot5LENsG3FyYk00pPG27JYxAWeo
         GhjCH3JKJEIXJptx8+CUs6TYuTnxlr1g60vv5NMFSZwFT43fzxe+adWKkUziH4XIEwfQ
         qWKbxXAP2IWHVXyiZM8S/SsmnYPV5V+nAaLlLyR/LhDDYa3TO+WEFKM9N06g4Z54tsj8
         aecNC2IVOhc2PSh0nmh1packuJZXvtVNoNkMvRXYnTSl8FDdgdmXH4SJNCpH6rrjnkDo
         DslA==
X-Gm-Message-State: AJIora+H4t6Av06+4eciBigTb6SwgIgrazK8NaDvqV54LHg0XBj200Gk
        PluS2xn0fqewywvpPFV2eYjmA0UUX+0vJg==
X-Google-Smtp-Source: AGRyM1vgSY+Q1bs04Xt3yu0XBbUlCmbact+Ael9eMXAwrEsdruB+WC8BJiTeqcT4uqf0qSDYsUmcnA==
X-Received: by 2002:a17:907:9686:b0:71b:6f0a:c724 with SMTP id hd6-20020a170907968600b0071b6f0ac724mr12435861ejc.138.1656658644129;
        Thu, 30 Jun 2022 23:57:24 -0700 (PDT)
Received: from [192.168.0.190] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id x10-20020a170906298a00b00705cd37fd5asm10106858eje.72.2022.06.30.23.57.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 23:57:23 -0700 (PDT)
Message-ID: <628a7302-1409-81f7-f72b-6b1645df9225@linaro.org>
Date:   Fri, 1 Jul 2022 08:57:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RFC] Correct memory layout reporting for "jedec,lpddr2" and
 related bindings
Content-Language: en-US
To:     Julius Werner <jwerner@chromium.org>
Cc:     Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jian-Jia Su <jjsu@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Nikola Milosavljevic <mnidza@outlook.com>
References: <CAODwPW9E8wWwxbYKyf4_-JFb4F-JSmLR3qOF_iudjX0f9ndF0A@mail.gmail.com>
 <CAODwPW8fiFSNehZbZDdR9kjHxohLGiyE7edU=Opy0xV_P8JbEQ@mail.gmail.com>
 <3bb0ffa0-8091-0848-66af-180a41a68bf7@linaro.org>
 <CAODwPW89xZQZiZdQNt6+CcRjz=nbEAAFH0h_dBFSE5v3aFU4rQ@mail.gmail.com>
 <8f51aed8-956b-ac09-3baf-2b4572db1352@linaro.org>
 <CAODwPW9MvYJo8QbKOoVcUAKJ8Hxon2MCv_H5qpv=yaSTLLc+ug@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAODwPW9MvYJo8QbKOoVcUAKJ8Hxon2MCv_H5qpv=yaSTLLc+ug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/07/2022 02:52, Julius Werner wrote:
>> How the asymmetric SDRAMs report density? This is a field with
>> fixed/enum values, so does it mean two-rank-asymmetric module has two
>> registers, one per each rank and choice of register depends on chip select?
> 
> Yes, each rank has a completely separate set of mode registers.

Then I would assume that all lpddr properties can differ between ranks,
including the timings. But probably some SDRAM memory expert should
clarify that.

> 
>> Manufacturer ID is taken from compatible. LPDDR3 has it deprecated.
> 
> Oh! Oh no, I only just saw that. I wish you had CCed us on that patch. :/
> 
> That really doesn't work for our use case, we can't generate a
> specific compatible string for each part number. This may work when
> your board is only using a single memory part and you can hardcode
> that in the DTB blob bundled with the kernel, but we are trying to do
> runtime identification between dozens of different parts on our
> boards. The whole point of us wanting to add these bindings is that we
> want to have the firmware inject the raw values it can read from mode
> registers into the device tree (with just the compatible string
> "jedec,lpddr3"),

You cannot have jedec,lpddr3 alone. You need specific compatible.

> so that we can then delegate the task of matching
> those values to part numbers to a userspace process. 

Constructing a vendor from mode registers is like 10 lines of C code, so
this is not a problem. Trouble would be with device part of compatible.

> We don't want to
> hardcode long tables for ID-to-string matching that have to be updated
> all the time in our constrained firmware space.

I understand.

> Can we please revert that deprecation and at least keep the property
> around as optional?

Yes, we can. You still would need to generate the compatible according
to the current bindings. Whether we can change it I am not sure. I think
it depends how much customization is possible per vendor, according to
JEDEC spec. If we never ever have to identify specific part, because
JEDEC spec and registers tell us everything, then we could skip it,
similarly to lpddr2 and jedec,spi-nor.

Best regards,
Krzysztof
