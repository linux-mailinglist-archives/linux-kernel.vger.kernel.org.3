Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765E14C6DBB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 14:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235158AbiB1NRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 08:17:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235438AbiB1NRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 08:17:30 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1685D7463D;
        Mon, 28 Feb 2022 05:16:38 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a8so24679754ejc.8;
        Mon, 28 Feb 2022 05:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=gLyji2lXIIBrJ7pS+hjvr2Fre28Lj40SpMAVpenGsu8=;
        b=NQivf7OXRQw+/i2egcr1EYrZDOZzyJNpvwK6BB9CNMapN0ed+78zUcES21XNm/6/15
         d+cUKMhv164xKNmhA74yZgGrvzZ+TfV14EIToEsRkDR820pkFJppFqlpvs08WPqkTAvq
         svdldf+LPmBq3dH78qbAfWRTiESmQ70EGMRzB3U1DhJQZughkbm7pMvrCgUVPNB0tNJP
         dcRkPIjLqCNtOezB1lY++uK7dsceyM8uPGB3SM0CaeUTSkEN0bpLtLOw+enu1S5B6QvB
         cUOxArA4suelgxAX/5FsZ0NvxYqDnmkQXmYp3VV/YzPoU1vMzKz+pzCd6WDqvUlUvZdY
         qRYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gLyji2lXIIBrJ7pS+hjvr2Fre28Lj40SpMAVpenGsu8=;
        b=6GA9lzrxs28RWC9uIKew4O+mFPkAJL7OUsw3YF+2OCDWNR1GmQHzysJtac6vD/D3HZ
         /VY7g6QI/rVfGey4jm7zFS0HRfU7eTmM63L83Elr97ZdUlh2C7Z1XmiuYesDM5Kuj1R1
         VFDo5R84tGcUc3zKvheDP+pfGUViL5kW1JmODN6IGlemELNvS8SkilZMtsDsCY4NzfO5
         f5ZxKgv4vdzfAZjf5TLUnFrgHtiSBC9Fc60yBM1euHHKscYDBLUGOeC8EG+W2X+0D4dO
         XtAk4NYGLbdqJ+7FyQJeMYq5DNZvk1mOMu97AUJvt/gF3e8umExraoQozF2zzCnhEljp
         IbLQ==
X-Gm-Message-State: AOAM531hWbTEATcAxTo374zvukJp1W6qVzRfYX73mf+lFegqVYO2Ya//
        9BCop5sO6qzxQziOuXg5mm8=
X-Google-Smtp-Source: ABdhPJyeE6XZT50xZ7y3mqQRvl3/GTUleK/YA6H91A0QUoKL4Yy5/MFnFHsrJRca/gyd1Af+YZ1keg==
X-Received: by 2002:a17:906:9509:b0:6d0:fbc5:eb4a with SMTP id u9-20020a170906950900b006d0fbc5eb4amr15101640ejx.228.1646054196450;
        Mon, 28 Feb 2022 05:16:36 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id ju22-20020a17090798b600b006ce70fa8e4fsm4337983ejc.187.2022.02.28.05.16.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 05:16:36 -0800 (PST)
Message-ID: <ab72daa6-9b8b-a435-82c3-93a9018a0bfa@gmail.com>
Date:   Mon, 28 Feb 2022 14:16:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 5/7] arm64: dts: rockchip: add rk356x dwc3 usb3 nodes
Content-Language: en-US
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Heiko Stuebner <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220227153016.950473-1-pgwipeout@gmail.com>
 <20220227153016.950473-6-pgwipeout@gmail.com>
 <7b20fccd-4394-da3c-6556-4732d67cde3d@gmail.com>
 <CAMdYzYp8x_mKffm1WkHD4D1Fx_tVJ8WdBc=u-j+j_zRbJmyaCQ@mail.gmail.com>
 <3ac3cdf9-17c0-654f-b204-c5b4b0436c98@gmail.com>
 <CAMdYzYrxQUhFNog1hvwme=V-3xptE6C9Se09FxEoEQm9bPdEEQ@mail.gmail.com>
From:   Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <CAMdYzYrxQUhFNog1hvwme=V-3xptE6C9Se09FxEoEQm9bPdEEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/28/22 14:02, Peter Geis wrote:
> On Mon, Feb 28, 2022 at 4:10 AM Johan Jonker <jbx6244@gmail.com> wrote:
>>
>>
>>
>> On 2/27/22 23:44, Peter Geis wrote:
>>> On Sun, Feb 27, 2022 at 12:50 PM Johan Jonker <jbx6244@gmail.com> wrote:
>>>>
>>>>
>>>>
>>>> On 2/27/22 16:30, Peter Geis wrote:
>>>>> Add the dwc3 device nodes to the rk356x device trees.
>>>>> The rk3566 has one usb2 capable dwc3 otg controller and one usb3 capable
>>>>> dwc3 host controller.
>>>>> The rk3568 has one usb3 capable dwc3 otg controller and one usb3 capable
>>>>> dwc3 host controller.
>>>>>
>>>>> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
>>>>> ---
>>>>>  arch/arm64/boot/dts/rockchip/rk3566.dtsi | 11 ++++++++
>>>>>  arch/arm64/boot/dts/rockchip/rk3568.dtsi |  9 ++++++
>>>>>  arch/arm64/boot/dts/rockchip/rk356x.dtsi | 35 +++++++++++++++++++++++-
>>>>>  3 files changed, 54 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3566.dtsi b/arch/arm64/boot/dts/rockchip/rk3566.dtsi
>>>>> index 3839eef5e4f7..0b957068ff89 100644
>>>>> --- a/arch/arm64/boot/dts/rockchip/rk3566.dtsi
>>>>> +++ b/arch/arm64/boot/dts/rockchip/rk3566.dtsi
>>>>> @@ -6,6 +6,10 @@ / {
>>>>>       compatible = "rockchip,rk3566";
>>>>>  };
>>>>>
>>>>> +&pipegrf {
>>>>> +     compatible = "rockchip,rk3566-pipe-grf", "syscon";
>>>>> +};
>>>>> +
>>>>>  &power {
>>>>>       power-domain@RK3568_PD_PIPE {
>>>>>               reg = <RK3568_PD_PIPE>;
>>>>> @@ -18,3 +22,10 @@ power-domain@RK3568_PD_PIPE {
>>>>>               #power-domain-cells = <0>;
>>>>>       };
>>>>>  };
>>>>> +
>>>>> +&usb_host0_xhci {
>>>>> +     phys = <&usb2phy0_otg>;
>>>>> +     phy-names = "usb2-phy";
>>>>> +     extcon = <&usb2phy0>;
>>>>> +     maximum-speed = "high-speed";
>>>>> +};
>>>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3568.dtsi b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
>>>>> index 5b0f528d6818..8ba9334f9753 100644
>>>>> --- a/arch/arm64/boot/dts/rockchip/rk3568.dtsi
>>>>> +++ b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
>>>>> @@ -99,6 +99,10 @@ opp-1992000000 {
>>>>>       };
>>>>>  };
>>>>>
>>>>> +&pipegrf {
>>>>> +     compatible = "rockchip,rk3568-pipe-grf", "syscon";
>>>>> +};
>>>>> +
>>>>>  &power {
>>>>>       power-domain@RK3568_PD_PIPE {
>>>>>               reg = <RK3568_PD_PIPE>;
>>>>> @@ -114,3 +118,8 @@ power-domain@RK3568_PD_PIPE {
>>>>>               #power-domain-cells = <0>;
>>>>>       };
>>>>>  };
>>>>> +
>>>>> +&usb_host0_xhci {
>>>>> +     phys = <&usb2phy0_otg>, <&combphy0 PHY_TYPE_USB3>;
>>>>> +     phy-names = "usb2-phy", "usb3-phy";
>>>>> +};
>>>>> diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
>>>>> index 7cdef800cb3c..072bb9080cd6 100644
>>>>> --- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
>>>>> +++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
>>>>> @@ -230,6 +230,40 @@ scmi_shmem: sram@0 {
>>>>>               };
>>>>>       };
>>>>>
>>>>> +     usb_host0_xhci: usb@fcc00000 {
>>>>
>>>>> +             compatible = "snps,dwc3";
>>>>
>>>> compatible = "rockchip,rk3568-dwc3", "snps,dwc3";
>>>>
>>>> compatible strings must be SoC orientated.
>>>> Add binding like you did before.
>>>
>>> Okay, should this go in the core yaml, since it's not really handled
>>> by of-simple?
>>
>> Nothing to change in core.c, because the fall back string does the
>> trick, so we don't have to change the driver for every new SoC.
>> Change the node compatible here and add the binding.
>> That's it. The rest comes later if needed.
> 
> It's the binding I'm referring to here.
> snps,dwc3.yaml seems the logical place, but I want to make sure you
> concur first.

rockchip,dwc3.yaml is the place be!
Hurry up!

Use Michael's patch, because his commit message is better.(no reference
to rk3399)

https://lore.kernel.org/linux-rockchip/20220225131602.2283499-3-michael.riesch@wolfvision.net/

vs.

https://lore.kernel.org/linux-rockchip/20220226184147.769964-4-pgwipeout@gmail.com/

> 
>>
>>> Also, should I add in the compatible for rk3328 as well?
>>
>> No, same story the fall back string does the trick in core.c
> 
> Same thing here, since I'm in snps,dwc3.yaml anyways I can add the
> rk3328 binding in and silence that error in one go.

It's been done already:

[PATCH v5 6/8] dt-bindings: usb: dwc3: add description for rk3328

https://lore.kernel.org/linux-rockchip/20210209192350.7130-6-jbx6244@gmail.com/


> 
>>
>>
>>>
>>>>
>>>>> +             reg = <0x0 0xfcc00000 0x0 0x400000>;
>>>>> +             interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
>>>>> +             clocks = <&cru CLK_USB3OTG0_REF>, <&cru CLK_USB3OTG0_SUSPEND>,
>>>>> +                      <&cru ACLK_USB3OTG0>;
>>>>> +             clock-names = "ref_clk", "suspend_clk",
>>>>> +                           "bus_clk";
>>>>> +             dr_mode = "host";
>>>>> +             phy_type = "utmi_wide";
>>>>> +             power-domains = <&power RK3568_PD_PIPE>;
>>>>> +             resets = <&cru SRST_USB3OTG0>;
>>>>> +             snps,dis_u2_susphy_quirk;
>>>>> +             status = "disabled";
>>>>> +     };
>>>>> +
>>>>> +     usb_host1_xhci: usb@fd000000 {
>>>>
>>>>> +             compatible = "snps,dwc3";
>>>>
>>>> compatible = "rockchip,rk3568-dwc3", "snps,dwc3";
>>>>
>>>>> +             reg = <0x0 0xfd000000 0x0 0x400000>;
>>>>> +             interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
>>>>> +             clocks = <&cru CLK_USB3OTG1_REF>, <&cru CLK_USB3OTG1_SUSPEND>,
>>>>> +                      <&cru ACLK_USB3OTG1>;
>>>>> +             clock-names = "ref_clk", "suspend_clk",
>>>>> +                           "bus_clk";
>>>>> +             dr_mode = "host";
>>>>> +             phys = <&usb2phy0_host>, <&combphy1 PHY_TYPE_USB3>;
>>>>> +             phy-names = "usb2-phy", "usb3-phy";
>>>>> +             phy_type = "utmi_wide";
>>>>> +             power-domains = <&power RK3568_PD_PIPE>;
>>>>> +             resets = <&cru SRST_USB3OTG1>;
>>>>> +             snps,dis_u2_susphy_quirk;
>>>>> +             status = "disabled";
>>>>> +     };
>>>>> +
>>>>>       gic: interrupt-controller@fd400000 {
>>>>>               compatible = "arm,gic-v3";
>>>>>               reg = <0x0 0xfd400000 0 0x10000>, /* GICD */
>>>>> @@ -297,7 +331,6 @@ pmu_io_domains: io-domains {
>>>>>       };
>>>>>
>>>>>       pipegrf: syscon@fdc50000 {
>>>>> -             compatible = "rockchip,rk3568-pipe-grf", "syscon";
>>>>>               reg = <0x0 0xfdc50000 0x0 0x1000>;
>>>>>       };
>>>>>
