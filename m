Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE414DAE9A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 12:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355236AbiCPLCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 07:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355228AbiCPLCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 07:02:37 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4813B6007E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 04:01:23 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id w25so2195744edi.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 04:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=j3v7DktL3ddi9374noY82uKNTdAF/kxo3zK0ti9poTo=;
        b=ag7rpmGq64Dt2m4x/ymb15hq8v9NNthzmlkesTFljZKC6Ypood6gIx6dYZCWxeJP3k
         JCtG3cwF7IlErSUsSfhLXzB/rJffvX6r6t6axGZOErm8S+MWL2lVc9OpQUWVCLSWx6AC
         752064Wc2Ox33hA96YTm4ibav3fN/3yFjapfUYJMNLUuBkw7lh4uAQLtIY+blEBMMHzl
         ewj67LXPPOueqoE6OASpoHHRfaVTiiZjTaX6nX9EuLIrKyPNfGgPXzrG9ApNQf09bFje
         BW3hcNWGfbehsQYVacaD1UnbMVTWX9BL/5n5iSsz6JDG7Ub7H+rVc8tmswrWhVmGb+eM
         lxyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=j3v7DktL3ddi9374noY82uKNTdAF/kxo3zK0ti9poTo=;
        b=wDCa4y4HClWdM9+DX3ousfIh8F+3vdMeFyenNBlN5t5dCGj1pMaHZiOf/pTKm/wJt/
         Bn0DNFngBYpyocZUWZQLrdNwZjCJP18L8mBbeUHHXkvaQH1wl0pGHo9OdVXaodS/y8yi
         dau0pzS9oAO+AYEHRyubC8+cMvDQSneP2GXqFYtFe+WJqywoh72Cbma3kSGl/w8OWHHE
         Iz0tjo3/R3X5W1uxxA3F1Kw2EWGFZRfawJsFatUaKce4/dD+T+tT1xODTyB6OFhrjK14
         II2jW3CK8t5/tEMDk80ds9DOq241lWoMOG/sCsm5zkK6rSMgdzRZvj4ikwuCnXKyL3+B
         GM3w==
X-Gm-Message-State: AOAM531B6lseEakA+mBc6+eRfICl7p7zbvdGAe/X9B4gltWO4qAaZl8V
        wRE3G7anGKJLBR5W8t7gEx5zIa72bbmvfzWio8hjjw==
X-Google-Smtp-Source: ABdhPJz9uTMpP8wIRwICJOsdbaUoqk6CQS0ySWvzyFknprjpuA3rI9gkHi+NCH4oiFpKv6T8LV0ikDt+M87WhwMLTY0=
X-Received: by 2002:aa7:d789:0:b0:418:673a:7f24 with SMTP id
 s9-20020aa7d789000000b00418673a7f24mr18134428edq.333.1647428481584; Wed, 16
 Mar 2022 04:01:21 -0700 (PDT)
MIME-Version: 1.0
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Wed, 16 Mar 2022 12:01:10 +0100
Message-ID: <CAN5uoS9F1cjN+WLks1S=GzA1SHw=o-ibFbu-VsUzJ4NydAkAdw@mail.gmail.com>
Subject: Re: [Linux-stm32] [PATCH v2 12/13] ARM: dts: stm32: enable optee
 firmware and SCMI support on STM32MP13
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Gabriel FERNANDEZ <gabriel.fernandez@foss.st.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Etienne Carriere <etienne.carriere@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ahmad,

> Helo Gabriel,
>
> On 03.03.22 14:09, Gabriel FERNANDEZ wrote:
>>
>> On 2/25/22 16:13, Ahmad Fatoum wrote:
>>> Hello Gabriel,
>>>
>>> On 25.02.22 14:31, gabriel.fernandez@foss.st.com wrote:
>>>> From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
>>>> +    firmware {
>>>> +        optee {
>>>> +            method = "smc";
>>>> +            compatible = "linaro,optee-tz";
>>>> +        };
>>>> +
>>>> +        scmi: scmi {
>>>> +            compatible = "linaro,scmi-optee";
>>> This compatible doesn't seem to be documented upstream. I am looking at v5.17-rc5.
>>> Do you have a reference detailing the difference between this conduit and
>>> plain arm,scmi-smc (as used with TF-A on the STM32MP151).
>>>
>>> Cheers,
>>> Ahmad
>>
>> Hi
>>
>> Ahmad,
>>
>> it's on going.
>>
>> https://lore.kernel.org/linux-arm-kernel/20211029102118.GG6526@e120937-lin/T/#mf46c83f0aadce3061ee93fa22159405f38d881a0
>
> I've found that thread in the meantime and got some clarification on why a new
> transport for OP-TEE was added. One question I still have though is why make
> this transport the default for STM32MP13x instead of using SCMI over SMC like
> you do for STM32MP15x. OP-TEE could still be made to service SCMI over SMC
> and it would allow people employing TF-A as SCMI provider an easier migration
> to the newer SoC.
>

Just to rephrase a bit what's being said in the referred mail thread:
On STM32MP13x, there are SCMI messages that must be processed inside a
thread execution context in the SCMI server. There is no standard SMC
function ID defined that the SCMI/SMC transport could use for that
purpose. OP-TEE provides such a threaded context. Therefore STM32MP13x
explicitly expects SCMI services based on SCMI/OP-TEE transport, not
SCMI/SMC transport.

Best regards,
etienne

> Cheers,
> Ahmad

>
>>
>>> +            #address-cells = <1>;
>>> +            #size-cells = <0>;
>>> +            linaro,optee-channel-id = <0>;
>>> +            shmem = <&scmi_shm>;
>>> +
>>> +            scmi_clk: protocol@14 {
>>> +                reg = <0x14>;
>>> +                #clock-cells = <1>;
>>> +            };
>>> +
>>> +            scmi_reset: protocol@16 {
>>> +                reg = <0x16>;
>>> +                #reset-cells = <1>;
>>> +            };
>>> +        };
>>> +    };
>>>       clocks {
>>>           clk_axi: clk-axi {
>>>               #clock-cells = <0>;
>>
>


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
