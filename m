Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C601D4F681E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239828AbiDFR7Z convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Apr 2022 13:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239903AbiDFR6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 13:58:41 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0CC3BCB7B;
        Wed,  6 Apr 2022 09:18:38 -0700 (PDT)
Received: from [213.70.33.226] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nc8MP-0007f5-Ur; Wed, 06 Apr 2022 18:18:22 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        zhangqing@rock-chips.com, Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: clock: convert rockchip,rk3188-cru.txt to YAML
Date:   Wed, 06 Apr 2022 18:18:20 +0200
Message-ID: <14123901.uLZWGnKmhe@phil>
In-Reply-To: <4b7af0ed-c5e1-7523-0abc-4204596edeb9@linaro.org>
References: <20220329111323.3569-1-jbx6244@gmail.com> <0eed395b-ca02-2308-a5c6-7c4a72720175@gmail.com> <4b7af0ed-c5e1-7523-0abc-4204596edeb9@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 2. April 2022, 18:01:11 CEST schrieb Krzysztof Kozlowski:
> On 02/04/2022 14:20, Johan Jonker wrote:
> > 
> > 
> > On 4/2/22 14:16, Krzysztof Kozlowski wrote:
> >> On 02/04/2022 13:45, Johan Jonker wrote:
> >>>
> >>>
> >>> On 4/2/22 13:41, Krzysztof Kozlowski wrote:
> >>>> On 01/04/2022 09:55, Heiko Stübner wrote:
> >>>>> Hi Stephen,
> >>>>>
> >>>>> Am Freitag, 1. April 2022, 00:51:32 CEST schrieb Stephen Boyd:
> >>>>>> Quoting Johan Jonker (2022-03-29 04:13:22)
> >>>>>>> diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3188-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rk3188-cru.yaml
> >>>>>>> new file mode 100644
> >>>>>>> index 000000000..ddd7e46af
> >>>>>>> --- /dev/null
> >>>>>>> +++ b/Documentation/devicetree/bindings/clock/rockchip,rk3188-cru.yaml
> >>>>>>> @@ -0,0 +1,78 @@
> >>>>>>> +# SPDX-License-Identifier: GPL-2.0
> >>>>>>> +%YAML 1.2
> >>>>>>> +---
> >>>>>>> +$id: http://devicetree.org/schemas/clock/rockchip,rk3188-cru.yaml#
> >>>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>>>>>> +
> >>>>>>> +title: Rockchip RK3188/RK3066 Clock and Reset Unit (CRU)
> >>>>>>> +
> >>>>>>> +maintainers:
> >>>>>>> +  - Elaine Zhang <zhangqing@rock-chips.com>
> >>>>>>> +  - Heiko Stuebner <heiko@sntech.de>
> >>>>>>> +
> >>>>>>> +description: |
> >>>>>>> +  The RK3188/RK3066 clock controller generates and supplies clocks to various
> >>>>>>> +  controllers within the SoC and also implements a reset controller for SoC
> >>>>>>> +  peripherals.
> >>>>>>> +  Each clock is assigned an identifier and client nodes can use this identifier
> >>>>>>> +  to specify the clock which they consume. All available clocks are defined as
> >>>>>>> +  preprocessor macros in the dt-bindings/clock/rk3188-cru.h and
> >>>>>>> +  dt-bindings/clock/rk3066-cru.h headers and can be used in device tree sources.
> >>>>>>> +  Similar macros exist for the reset sources in these files.
> >>>>>>> +  There are several clocks that are generated outside the SoC. It is expected
> >>>>>>> +  that they are defined using standard clock bindings with following
> >>>>>>> +  clock-output-names:
> >>>>>>> +    - "xin24m"    - crystal input                 - required
> >>>>>>> +    - "xin32k"    - RTC clock                     - optional
> >>>>>>> +    - "xin27m"    - 27mhz crystal input on RK3066 - optional
> >>>>>>> +    - "ext_hsadc" - external HSADC clock          - optional
> >>>>>>> +    - "ext_cif0"  - external camera clock         - optional
> >>>>>>> +    - "ext_rmii"  - external RMII clock           - optional
> >>>>>>> +    - "ext_jtag"  - external JTAG clock           - optional
> >>>>>>
> >>>>>> I'd expect all these clks here to be inputs to this node.
> >>>>>
> >>>>> The optional clocks are all part of a circular dependency.
> >>>>>
> >>>>> So for example xin32k normally is generated by the pmic and fed
> >>>>> back into the system, so to get xin32k, we need the pmic to probe,
> >>>>> which needs i2c, which in turn already needs the clock controller.
> >>>>
> >>>> Are you sure that xin32k (RTC) clock should be input to the clock
> >>>> controller? I would expect it is the input to the SoC RTC block, so
> >>>> there is no circular dependency.
> >>>
> >>> clk-rk3188.c:
> >>>
> >>> PNAME(mux_pll_p)		= { "xin24m", "xin32k" };
> >>
> >> Thanks, but that's not the answer whether it is an input to the clock
> >> controller. It's the answer how the driver implements this. :)
> > 
> > PX2 == rk3066
> > 
> > Rockchip PX2 TRM V1.0.pdf
> > 
> > page 30
> > 
> > Chip Clock Architecture Diagram 1
> 
> I found it, thanks. That's the answer, so indeed this is an input.
> 
> Answering partially to Heiko/Stephen, this could be still modeled in DTS
> as a fixed-frequency clock going as input to the clock-controller. The
> trouble with that approach is that it would actually duplicate the
> definition (another one coming from PMIC).

And it has the issue that the pmic doesn't necessarily has the clock
enabled at boot. Also this would combat one issue by introducing
a different one, as this would be modelling a clock in a way that is
not reflected by hardware at all.


