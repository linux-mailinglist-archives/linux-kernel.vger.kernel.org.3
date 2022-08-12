Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0775911B1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 15:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239053AbiHLNmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 09:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239051AbiHLNmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 09:42:43 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8F19FA8F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 06:42:42 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id w15so1001227ljw.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 06:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=E4Pg30doPvdVeGQvtCtboZjqaFRUOqRz10bPbmMhTH0=;
        b=k2WP5Q8EiXoM0UV+CAz2nOK4C9X9xG99qfdfJUJ6Szswwpp7yQuhrDkAO8M3RmdMqP
         z5V0tzoIbjICD+6IgxXk6TUL5CvugAkJIMO13vZ0TvjkBbXrGTv5/e0d+qLUbOujwJDQ
         wJb0cGjzVXHL//fx0EnLVdhHichHIsJR0lF0taLrrJJXl5tQJoyR8+DIDqs/YomAs5AV
         BywXICwyIv3NWSvwciddJf0oVjYbrIDMPQsmyBZi/Z+5lQl80iZ34Xpb0BeYuNWrWWFc
         A4T3zNVmlvGlo1ZSyg96nlXUcQFdR1AugMh34YKkIETdyHGqApKLHx7NS1DM/yycG4JO
         Jizg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=E4Pg30doPvdVeGQvtCtboZjqaFRUOqRz10bPbmMhTH0=;
        b=fZ8wctrYWFT+gD49PXdXwyrACAn7ToGEzVr4DkP9z0jznpMclnCMd6Y+LcR8cqog9p
         KRTuDOr8ekiTFk6ypg9eaLPh46g4fmoo6W8B1RCuwTOKoxH+exi07kOGo0mm6aISnmLM
         gwzdPd2/6OOwSz2dfHu9iU8xqeJx+8MWA7fIEMw5aIAB7uglqmG8/W8pp6tZ/CdAemY8
         lJbC4rtxIsR8oguiZX1tEYze+DZGYf/tNkZMcEeF29bdcZwqkRRUWlfvlokjKzwhoHTe
         Kl9i0TrF26mT9dvocjmo7h6zEtZxULO7nh/SvL7hy8iTcwdwRU+zTMgHmduAoBQipnz+
         et7w==
X-Gm-Message-State: ACgBeo2TSfuliq9yGHMNci6Onc9ill3anyX4T3wzJVVIrWvIbl/6klj1
        wIYS81foHx5oqyn9hcfXXszUdg==
X-Google-Smtp-Source: AA6agR5WKO4cNO5LSwR4p7rSjt3eXEu9RHC8dN/CpQFXoYBWuJHzEo5d6g/ieTaaW4mi6XPqHcxmdQ==
X-Received: by 2002:a05:651c:1241:b0:25d:5484:75d3 with SMTP id h1-20020a05651c124100b0025d548475d3mr1278012ljh.45.1660311761060;
        Fri, 12 Aug 2022 06:42:41 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id 18-20020a2eb952000000b0025ec44d1371sm365108ljs.80.2022.08.12.06.42.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 06:42:40 -0700 (PDT)
Message-ID: <15ddd798-873e-d90d-11e9-c6dd46ca03f4@linaro.org>
Date:   Fri, 12 Aug 2022 16:42:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v4 2/2] arm64: dts: imx8mp-msc-sm2s: Add device trees for
 MSC SM2S-IMX8PLUS SoM and carrier board
Content-Language: en-US
To:     Martyn Welch <martyn.welch@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     kernel@collabora.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220812084120.376042-1-martyn.welch@collabora.com>
 <20220812084120.376042-2-martyn.welch@collabora.com>
 <8962b7ed-a21c-0b7f-7a6d-5db3db84e4cb@linaro.org>
 <65a094d5d03ad8f7b35196c9dff6ffc6cf0ea151.camel@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <65a094d5d03ad8f7b35196c9dff6ffc6cf0ea151.camel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/08/2022 14:35, Martyn Welch wrote:
> On Fri, 2022-08-12 at 12:47 +0300, Krzysztof Kozlowski wrote:
>> On 12/08/2022 11:41, Martyn Welch wrote:
>>> Add device trees for one of a number of MSC's (parent company,
>>> Avnet)
>>> variants of the SM2S-IMX8PLUS system on module along with the
>>> compatible
>>> SM2S-SK-AL-EP1 carrier board. As the name suggests, this family of
>>> SoMs use
>>> the NXP i.MX8MP SoC and provide the SMARC module interface.
>>>
>>> Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
>>> ---
>>>
>>> Changes in v2
>>>   - Added compatibles
>>>   - Removed underscores from node names
>>>   - Make node names more generic
>>>   - Reorder properties
>>>   - Fix issues found by dtbs_check in these files
>>>
>>> Changes in v3:
>>>   - Switched to avnet vendor string in compatibles
>>>   - Corrected patch description
>>>
>>> Changes in v4:
>>>   - Switched from phy-reset-gpios to reset-gpios, removing
>>> duplication
>>>   - Removed unneeded sdma1 node
>>>
>>>  arch/arm64/boot/dts/freescale/Makefile        |   1 +
>>>  .../freescale/imx8mp-msc-sm2s-14N0600E.dts    |  72 ++
>>>  .../dts/freescale/imx8mp-msc-sm2s-ep1.dts     |  53 ++
>>>  .../boot/dts/freescale/imx8mp-msc-sm2s.dtsi   | 812
>>> ++++++++++++++++++
>>>  4 files changed, 938 insertions(+)
>>>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-
>>> 14N0600E.dts
>>>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-
>>> ep1.dts
>>>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-msc-
>>> sm2s.dtsi
>>>
>>> diff --git a/arch/arm64/boot/dts/freescale/Makefile
>>> b/arch/arm64/boot/dts/freescale/Makefile
>>> index 8bf7f7ecebaa..139c8b95c9c9 100644
>>> --- a/arch/arm64/boot/dts/freescale/Makefile
>>> +++ b/arch/arm64/boot/dts/freescale/Makefile
>>> @@ -83,6 +83,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mn-venice-
>>> gw7902.dtb
>>>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-dhcom-pdk2.dtb
>>>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-evk.dtb
>>>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-icore-mx8mp-edimm2.2.dtb
>>> +dtb-$(CONFIG_ARCH_MXC) += imx8mp-msc-sm2s-ep1.dtb
>>>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-rdk.dtb
>>>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-tqma8mpql-mba8mpxl.dtb
>>>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-venice-gw74xx.dtb
>>> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-
>>> 14N0600E.dts b/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-
>>> 14N0600E.dts
>>> new file mode 100644
>>> index 000000000000..9e976e8baaee
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-14N0600E.dts
>>> @@ -0,0 +1,72 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Copyright (C) 2022 Avnet Embedded GmbH
>>> + */
>>> +/dts-v1/;
>>> +
>>> +#include "imx8mp-msc-sm2s.dtsi"
>>> +
>>> +/ {
>>> +       model = "MSC SM2S-IMX8PLUS-QC6-14N0600E SoM";
>>> +       compatible = "avnet,sm2s-imx8mp-14N0600E", "avnet,sm2s-
>>> imx8mp",
>>> +                    "fsl,imx8mp";
>>
>> This does not match your bindings. Please test your DTS.
>>
> 
> Hi Krzysztof,
> 
> I'm not sure I follow. This is the DTS for the SoM. 

SoMs usually do not have DTSes because they cannot be run on their own.
SoMs almost always require a baseboard/carrier. Therefore this should
not be DTS, but that was not my comment.

> The only way I can
> test the SoM at the moment is on combination with the "EP1" carrier
> board. 

... so you basically say it cannot be a DTS.

> That has been tested. The strings match those specified in the
> bindings unless I'm being blind to something.

Test the DTS - make dtbs_check (there are several
variations/arguments/helpers):
Documentation/devicetree/bindings/writing-schema.rst

> 
> I guess I can build the DTB for just the SoM 

But you just did it, didn't you? This is a DTS.

> and boot with that or
> thinking about it, rename this as a .dtsi, given that it's unlikely
> that anyone is going to have a carrier barebones enough that it could
> be considered just the SoM?

Anyway, I wanted DT bindings tests for DTS. Not actual tests on
hardware, because the compatibles do not matter in that aspect.

Best regards,
Krzysztof
