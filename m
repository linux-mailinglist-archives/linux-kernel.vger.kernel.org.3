Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1E451810E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 11:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233412AbiECJde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 05:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbiECJdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 05:33:31 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1C6369D5
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 02:29:56 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id t5so8563294edw.11
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 02:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zB5e/Eye7NKTiR0iDf6A/QHPDIG8VOEpDlGbZQKTb30=;
        b=BR6BitziOi0WXcjIJLa6fbzR99D1RO1QuZQlrMCVfu5IezrVdh94Je492bhD3tuePW
         Vblf0IULaKsW3hkFdtR/JnR7P830V9R0yRz7ZsYDIngTVZA0O/Re1G+Q9y7ET6yAgTPX
         tRpx+VIlUGwMeQHSYoyDWAm1BwalfVQyq3/DGy1iy+qaFlcLfCbGxL81eKnPmG/8w7Ww
         n+lrtGmFl+HBIYtq5rWpKLfTU++lasaMTHN0TscdXYkcLRRcfbtXZSmhXwtOXKFR4/Rl
         MbRT/oQFm7HNGHtoFhLEKxL95g0ZoNIAxQ7e8M2SdHtOBJvZKT/01Zcej5S4gQ6VnPN7
         REUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zB5e/Eye7NKTiR0iDf6A/QHPDIG8VOEpDlGbZQKTb30=;
        b=2mgg7nJG8LQtsLK0iciZ8ZzDEW24hsapDaKSNXx19xpcj/OMkCwCkirtZBGrxlTa7K
         vC98U/3GIHfuvoLqq390atKtqic+4Z6I5Q28HMIAx0Z00xE2FziXN55aZneHzMnDxBBY
         L1MtElYdQKFr+UG/i+WYabRgUZ8cRmSaYMaKI10hOQXSKiTBOv6WcbkmHKpMuy+4eRb9
         2E2+9uy/H7tr/OZIDoAi2Vvt30b4BbT2AQIbMvJvNjw1+IFzDC5XVYWgOiV8OW1ZtHEn
         808y7fQotNX1v15AF3JUbKBEPd4aFvv0u3SWxoj3iWGW4lpgX5CD96/Wpsk5DMAe7Q0v
         h1yQ==
X-Gm-Message-State: AOAM530razN6jV0CRzN4GoET+jH8kSZ4LZPDLnBDfI6kF0PAvHhaYIHz
        3i8DDFIFWayt9IXZAkNB/DI7Mw==
X-Google-Smtp-Source: ABdhPJw0CvtF1J8tlcNgNaOLoUi82bOqMVPxdlnIrx9IBPryH5dVXVAGmSZQkuKIy+RfCoXWk/K6Rw==
X-Received: by 2002:a50:9f06:0:b0:425:c1ba:5037 with SMTP id b6-20020a509f06000000b00425c1ba5037mr17363890edf.285.1651570194908;
        Tue, 03 May 2022 02:29:54 -0700 (PDT)
Received: from [192.168.0.201] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id og13-20020a1709071dcd00b006f3ef214e3fsm4398405ejc.165.2022.05.03.02.29.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 02:29:54 -0700 (PDT)
Message-ID: <5a89e9bf-1004-500a-75e1-995732629937@linaro.org>
Date:   Tue, 3 May 2022 11:29:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v5 2/6] dt-bindings: PCI: renesas,pci-rcar-gen2: Add
 device tree support for r9a06g032
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Herve Codina <herve.codina@bootlin.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
References: <20220429134143.628428-1-herve.codina@bootlin.com>
 <20220429134143.628428-4-herve.codina@bootlin.com>
 <29ba3db6-e5c7-06d3-29d9-918ee5b34555@linaro.org>
 <CAMuHMdWN_ni_V+e3QipWH2qKXeNPkEcVpHpb5iBYw1YQSAnCDA@mail.gmail.com>
 <YnA0id1rXlNHNz+N@robh.at.kernel.org>
 <CAMuHMdWktaRAw8Y6TR93_rH8v4mPR2yt3wGqeXeTA2p_Dh--wA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAMuHMdWktaRAw8Y6TR93_rH8v4mPR2yt3wGqeXeTA2p_Dh--wA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/2022 08:51, Geert Uytterhoeven wrote:
>>>> This should not be a reason why a property is or is not required. Either
>>>> this is required for device operation or not. If it is required, should
>>>> be in the bindings. Otherwise what are you going to do in the future?
>>>> Add a required property breaking the ABI?
>>>
>>> The problem is that there are no bindings for the reset controller
>>> (actually the reset controller feature of the system-controller) yet.
>>> Yeah, we can just add #reset-cells = <1> to the system-controller
>>> device node, but we cannot add the actual resets properties to the
>>> consumers, until the actual cell values are defined.
>>
>> Sounds like you should implement providers first. Or just live with the
>> warning as a reminder to implement the reset provider?
> 
> I'd go for the latter. The upstream r9a06g032.dtsi is still under active
> development. Until very recently, the only device supported was the
> serial console.

For clocks we use in such cases fixed-clock placeholders or empty
phandles. Maybe something like that would work here as well?

Best regards,
Krzysztof
