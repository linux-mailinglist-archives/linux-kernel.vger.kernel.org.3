Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1518D587B50
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 13:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236782AbiHBLE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 07:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236766AbiHBLEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 07:04:20 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750BA4F6B3
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 04:04:18 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id t1so21392698lft.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 04:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0smktc1i0A3Xsq8E5SsJkGwUEry38DF9VxbACT8dluE=;
        b=ffxwRc38XQqx/D5KKVUner6cIm1BVZ4NuRd9atFW7wVvoRk+2bs5638y7vfXxHmAKC
         qQINIHs+kojYYFWq3OTO4S9wqqYIyh+f8PTg2fV2p36dgjCSseYGLmxlAzPTQx9xC49w
         TsmHRQ4saWQZTA9cGjljZ4yTZxtSjeiLtw199h8y/g2+Q8vNy7NSID5ILtl0yRJqTrLk
         jw7KHGFNAVO9fDU9kJSeXBS6+Zec8aJquGLtDGnjOO53J9FWjiBVY76UnpmlW9tgb2wi
         Is7vnnyfnleCsXLUS/qsC5doA2bfS9B1tezSF8lJ6qwtSP0gUqJIqmW7FLDpk72GOZ0n
         dhsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0smktc1i0A3Xsq8E5SsJkGwUEry38DF9VxbACT8dluE=;
        b=XO3CkvfxkCQ6M8eShHxcdmxtS6Pmy+VsPn+ZHyRz70qrF6IeZhfj98YVBDTn0YfD2X
         rEf7VfiL1GNdnnJMbikrs0KUlZgO65Ic2p7Kr71k8+0YnN34qeL7pANzAuIKhV0ecbvn
         XGV7AS8ZsMHC2Zl6mycxszkOH9DPsecPP99e3yGUxp/ZElMO2trb7S6V5J1RFjoR2iCl
         zzXgr28BCmxJCgrvXY2QyYQjEFxRCq7SJvJ604maVRpHrl0a5x7TAnOy1oiz5jyKuoa2
         2v8cqO6TQvAiy1czMIokJl7dmiwR1npIMh7Bqjb5Zy6Hu8Ypd2mykvTh7B7upt2YO6Ac
         NZ0g==
X-Gm-Message-State: ACgBeo248lxt99MeFpnV4mnvOGn8MLAtxdOV4ZBCPMIeg6iGhnWdu7WN
        h49zBhEpq13KXy2LrwSNZeGXCg==
X-Google-Smtp-Source: AA6agR5b9oU2xoKju8HeD8PuauS95yIhWJVqMShOIbOv0jkeRvynBug8ZRAnKAqZU2/J1Yg0izSVFA==
X-Received: by 2002:a05:6512:128f:b0:48b:b0:8da9 with SMTP id u15-20020a056512128f00b0048b00b08da9mr2709627lfs.377.1659438256687;
        Tue, 02 Aug 2022 04:04:16 -0700 (PDT)
Received: from [192.168.1.6] ([213.161.169.44])
        by smtp.gmail.com with ESMTPSA id 10-20020ac25f0a000000b0048a27abcc34sm1777993lfq.202.2022.08.02.04.04.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 04:04:16 -0700 (PDT)
Message-ID: <8f04b8c8-620c-3b32-ce4a-2d4b1aa484d9@linaro.org>
Date:   Tue, 2 Aug 2022 13:04:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 3/3] dt-bindings: bus: Add Freescale i.MX8qxp pixel link
 MSI bus binding
Content-Language: en-US
To:     Liu Ying <victor.liu@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, saravanak@google.com,
        gregkh@linuxfoundation.org, geert+renesas@glider.be
References: <20220802071310.2650864-1-victor.liu@nxp.com>
 <20220802071310.2650864-4-victor.liu@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220802071310.2650864-4-victor.liu@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/2022 09:13, Liu Ying wrote:
> Freescale i.MX8qxp pixel link MSI bus is a simple memory-mapped bus.
> It is used to access peripherals in i.MX8qm/qxp imaging, LVDS, MIPI
> DSI and HDMI TX subsystems, like I2C controller, PWM controller,
> MIPI DSI controller and Control and Status Registers (CSR) module.
> 
> Reference simple-pm-bus bindings and add Freescale i.MX8qxp pixel
> link MSI bus specific bindings.
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
>  .../bus/fsl,imx8qxp-pixel-link-msi-bus.yaml   | 84 +++++++++++++++++++
>  1 file changed, 84 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/bus/fsl,imx8qxp-pixel-link-msi-bus.yaml
> 
> diff --git a/Documentation/devicetree/bindings/bus/fsl,imx8qxp-pixel-link-msi-bus.yaml b/Documentation/devicetree/bindings/bus/fsl,imx8qxp-pixel-link-msi-bus.yaml
> new file mode 100644
> index 000000000000..24f50535f5c2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/bus/fsl,imx8qxp-pixel-link-msi-bus.yaml
> @@ -0,0 +1,84 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bus/fsl,imx8qxp-pixel-link-msi-bus.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale i.MX8qxp Pixel Link Medium Speed Interconnect (MSI) Bus

Shouldn't this be interconnect, not a bus? Not only located in
interconnect directory but actually being proper interconnect? Although
you mentioned that the firmware controls it, so maybe that would explain
this being only a resource provider.

You should be sure of it, because later if you want to add proper
interconnect properties (e.g. bandwidth voting, paths) *you will not be
able*. Ever.

> +
> +maintainers:
> +  - Liu Ying <victor.liu@nxp.com>
> +
> +description: |
> +  i.MX8qxp pixel link MSI bus is used to control settings of PHYs, I/Os
> +  sitting together with the PHYs.  It is not the same as the MSI bus coming
> +  from i.MX8 System Controller Unit (SCU) which is used to control power,
> +  clock and reset through the i.MX8 Distributed Slave System Controller (DSC).
> +
> +  i.MX8qxp pixel link MSI bus is a simple memory-mapped bus. Two input clocks,
> +  that is, MSI clock and AHB clock, need to be enabled so that peripherals
> +  connected to the bus can be accessed. Also, the bus is part of a power
> +  domain. The power domain needs to be enabled before the peripherals can
> +  be accessed.
> +
> +  Peripherals in i.MX8qm/qxp imaging, LVDS, MIPI DSI and HDMI TX subsystems,
> +  like I2C controller, PWM controller, MIPI DSI controller and Control and
> +  Status Registers (CSR) module, are accessed through the bus.
> +
> +  The i.MX System Controller Firmware (SCFW) owns and uses the i.MX8qm/qxp
> +  pixel link MSI bus controller and does not allow SCFW user to control it.
> +  So, the controller's registers cannot be accessed by SCFW user. Hence,
> +  the interrupts generated by the controller don't make any sense from SCFW
> +  user's point of view.
> +
> +allOf:
> +  - $ref: simple-pm-bus.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - fsl,imx8qxp-display-pixel-link-msi-bus
> +          - fsl,imx8qm-display-pixel-link-msi-bus
> +      - {} # simple-pm-bus, but not listed here to avoid false select

simple-pm-bus must be here. You need to sort out the select instead,
just like we do it for other devices (e.g. primecell).

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: master gated clock from system
> +      - description: AHB clock
> +
> +  clock-names:
> +    items:
> +      - const: msi
> +      - const: ahb
> +
> +required:

compatible and reg as well.

> +  - clocks
> +  - clock-names
> +  - power-domains
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/imx8-lpcg.h>
> +    #include <dt-bindings/firmware/imx/rsrc.h>
> +    bus@56200000 {
> +        compatible = "fsl,imx8qxp-display-pixel-link-msi-bus", "simple-pm-bus";
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        reg = <0x56200000 0x20000>;

put reg just after compatible.

> +        interrupt-parent = <&dc0_irqsteer>;
> +        interrupts = <320>;
> +        ranges;
> +        clocks = <&dc0_disp_ctrl_link_mst0_lpcg IMX_LPCG_CLK_4>,
> +                 <&dc0_disp_ctrl_link_mst0_lpcg IMX_LPCG_CLK_4>;
> +        clock-names = "msi", "ahb";
> +        power-domains = <&pd IMX_SC_R_DC_0>;
> +    };


Best regards,
Krzysztof
