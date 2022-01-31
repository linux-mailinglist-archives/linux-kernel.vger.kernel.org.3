Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8621D4A4D02
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 18:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380858AbiAaRTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 12:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241643AbiAaRTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 12:19:16 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F64C061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 09:19:16 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d18so13008425plg.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 09:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Hx6TH2V2Xf2UjSWOsTZZ6odBJt3j58eeTOeYnmI2onk=;
        b=ZUoF9QrSJSC7VABDAeUcpREISLFdzZbzr815n8t1kCZvQh0UWJ7RqxHqAbectE6iSB
         Jav+47/50aomFac/w7dyQXaZ0jQZtb/e1Myea++ZMldgaLOymZLKbQeFXiPkePFEYD8f
         xlrf3gRNOhh1+xKV7dEUzHnLa2vJbNMyLwYad30cRE2B5ek+nUpXQo3wtpVpI3EAqlqY
         4IeYEYZMVgt7eZkBcmG/jGRhOCOYLbGE7nvI5w4vl0Ad1s77Ez7v7PxioGjwkFzWtDFl
         lcGQbmywG6c8vyxPzR4dwygpm4N8HoGxaGuLV/NMnJlN/O15MaYSx+NOg5dVKQ538+O7
         uOPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Hx6TH2V2Xf2UjSWOsTZZ6odBJt3j58eeTOeYnmI2onk=;
        b=yk45ORrq2cYlK7X9DMsgdwtbhkReT/RbszktOtOo1ukt2olEywvdFtcsRKa953yt0e
         ysE/2FDnndp0Vaepr1tLypJmKw5mZ20DPWwiUs2ztGsL9Ngwl+eniOGFY7DKfihSlyEK
         cALTLvW94g5U5v+qJE0HcueL7oQq1EvKE/45MOoy4vBaAH9kYaSrv5ES7WEAHw8cUoIY
         08l5+qTwKwtCe3Ym9GMNlL2ULCoNY7gfItSRU62D7tUsi9IGl+bI2+GJvK3KNjjhqYEc
         TE03v2UDCb3n/JiL6Rt9mHt9R+BGSYeQ0AIRc5WxKPPy8O+JqEXPFfTB5G0k3BO9vGTI
         5HoA==
X-Gm-Message-State: AOAM531EM+omhn/O6FvSUhYK9CwS+ImOIo8KiJ2Jdz2Jr2z6WKQUd8Sh
        Cco8ykZECaDvtU1WXAbBLOzGxw==
X-Google-Smtp-Source: ABdhPJyHcqvv4VH4GOQ/VKJzF0Psuj4eZMbZ1SQIRWaFtSjpT+JQaxOIKcHzXOJmYqgfwz4YGGH1tg==
X-Received: by 2002:a17:902:6b4b:: with SMTP id g11mr21570386plt.109.1643649555570;
        Mon, 31 Jan 2022 09:19:15 -0800 (PST)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id h6sm19371067pfc.35.2022.01.31.09.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 09:19:14 -0800 (PST)
Date:   Mon, 31 Jan 2022 10:19:12 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Hari Nagalla <hnagalla@ti.com>
Cc:     bjorn.andersson@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: remoteproc: k3-m4f: Add bindings for K3
 AM64x SoCs
Message-ID: <20220131171912.GA2404841@p14s>
References: <20220110040650.18186-1-hnagalla@ti.com>
 <20220110040650.18186-2-hnagalla@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110040650.18186-2-hnagalla@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Hari,

On top of Rob's comments about warning, please see below.

On Sun, Jan 09, 2022 at 10:06:49PM -0600, Hari Nagalla wrote:
> K3 AM64x SoC has a Cortex M4F subsystem in the MCU volatge domain.
> The remote processor's life cycle management and IPC mechanisms are
> similar across the R5F and M4F cores from remote processor driver
> point of view. However, there are subtle differences in image loading
> and starting the M4F subsystems.
> 
> The YAML binding document provides the various node properties to be
> configured by the consumers of the M4F subsystem.
> 
> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
> ---
>  .../bindings/remoteproc/ti,k3-m4f-rproc.yaml  | 121 ++++++++++++++++++
>  1 file changed, 121 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.yaml
> new file mode 100644
> index 000000000000..8db9a3f6256e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.yaml
> @@ -0,0 +1,121 @@
> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/remoteproc/ti,k3-m4f-rproc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI K3 M4F processor subsystems
> +
> +maintainers:
> +  - Hari Nagalla <hnagalla@ti.com>
> +
> +description: |
> +  Some K3 family SoCs have  Arm Cortex M4F cores. AM64x is a SoC in K3
> +  family with a M4F core. Typically safety oriented applications may use
> +  the M4F core in isolation with out an IPC. Where as some Industrial and

s/"with out"/without

s/Industrial/industrial

> +  home automation applications, may use the M4F core as a remote processor
> +  with IPC communications.
> +
> +properties:
> +  $nodename:
> +    pattern: "^m4fss(@.*)?"
> +
> +  compatible:
> +    enum:
> +      - ti,am64-m4fss
> +
> +  power-domains:
> +    description: |
> +      Should contain a phandle to a PM domain provider node and an args
> +      specifier containing the M4FSS device id value.
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 2
> +
> +  "#size-cells":
> +    const: 2
> +
> +  reg:
> +    items:
> +      - description: Address and Size of the IRAM internal memory region
> +      - description: Address and Size of the DRAM internal memory region
> +
> +  reg-names:
> +    items:
> +      - const: iram
> +      - const: dram
> +
> +  resets:
> +    description: |
> +      Should contain the phandle to the reset controller node managing the
> +      local resets for this device, and a reset specifier.
> +    maxItems: 1
> +
> +  firmware-name:
> +    description: |
> +      Should contain the name of the default firmware image
> +      file located on the firmware search path
> +
> +  mboxes:
> +    description: |
> +      OMAP Mailbox specifier denoting the sub-mailbox, to be used for
> +      communication with the remote processor. This property should match
> +      with the sub-mailbox node used in the firmware image.
> +    maxItems: 1
> +
> +  memory-region:
> +    description: |
> +      phandle to the reserved memory nodes to be associated with the
> +      remoteproc device. There should be at least two reserved memory nodes
> +      defined. The reserved memory nodes should be carveout nodes, and
> +      should be defined with a "no-map" property as per the bindings in
> +      Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> +    minItems: 2
> +    maxItems: 8
> +#    items:
> +#      - description: region used for dynamic DMA allocations like vrings and
> +#                         vring buffers
> +#      - description: region reserved for firmware image sections
> +    additionalItems: true
> +
> +    unevaluatedProperties: false
> +
> +
> +required:
> +  - compatible
> +  - power-domains

There is no "power-domains" in the example below.

> +  - "#address-cells"
> +  - "#size-cells"
> +  - reg
> +  - reg-names
> +  - ti,sci
> +  - ti,sci-dev-id
> +  - ti,sci-proc-ids

The above 3 are not described in this document. 

> +  - resets
> +  - firmware-name
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    cbass_main:  bus@f4000 {
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +      mcu_m4fss: m4fss@5000000 {
> +        compatible = "ti,am64-m4fss";
> +        reg = <0x00 0x5000000 0x00 0x30000>,
> +              <0x00 0x5040000 0x00 0x10000>;
> +        reg-names = "iram", "dram";
> +        ti,sci = <&dmsc>;
> +        ti,sci-dev-id = <9>;
> +        ti,sci-proc-ids = <0x18 0xff>;
> +        resets = <&k3_reset 9 1>;
> +        firmware-name = "am64-mcu-m4f0_0-fw";
> +        mboxes = <&mailbox0_cluster6 &mbox_m4_0>;
> +        memory-region = <&mcu_m4fss_dma_memory_region>,
> +                        <&mcu_m4fss_memory_region>;
> +      };
> +    };
> +
> +...
> -- 
> 2.17.1
> 
