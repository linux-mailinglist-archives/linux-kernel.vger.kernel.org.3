Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40DC551B214
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 00:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379049AbiEDWpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 18:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376474AbiEDWo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 18:44:59 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD79548893;
        Wed,  4 May 2022 15:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651704081; x=1683240081;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=vo98koW8xOZpXvkfJZ26bs6YvtqqcceUyFD7sOeeXGI=;
  b=QARAiMKcBxMxlkyw4T73MEiVXW+ANS56eY0oZYG5t9YP1XT2TTUe6dpD
   2XHKLbJsb8/bjbZhpw335BBAcRuArgCbzriJwBTrmj7fseynGcnhRZYVW
   5s0J06AUDha6sKC2sY/6nxP+Xm5yM3v1g47NFDB3Tw+DozxXdJEyKPJGs
   veh0F0MmYzYJODxOoUncxVx+G2fBkVykNqBtYu+JV7zGGAuYDWhB6m8R3
   2i7mMujC/D8SnNNTOlNmTkYh1zRgl1wZdn1D+ejq/02I8KgCErrMQwLcZ
   2+AyNQaiMTAZsuldSHLdPU7a8U/MdZ64tEs6Sz+x/23z2QKfkpVMYuHQJ
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="267803170"
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="267803170"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 15:41:20 -0700
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="549071723"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 15:41:20 -0700
Date:   Wed, 4 May 2022 15:41:20 -0700 (PDT)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
cc:     dinguyen@kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH v2 1/3] dt-bindings: misc: add bindings for Intel HPS
 Copy Engine
In-Reply-To: <17407fe7-b11d-2ba8-acca-3e71cf1a3b2f@linaro.org>
Message-ID: <alpine.DEB.2.22.394.2205041425230.2669897@rhweight-WRK1>
References: <20220503194546.1287679-1-matthew.gerlach@linux.intel.com> <20220503194546.1287679-2-matthew.gerlach@linux.intel.com> <17407fe7-b11d-2ba8-acca-3e71cf1a3b2f@linaro.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 4 May 2022, Krzysztof Kozlowski wrote:

> On 03/05/2022 21:45, matthew.gerlach@linux.intel.com wrote:
>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>
>> Add device tree bindings documentation for the Intel Hard
>> Processor System (HPS) Copy Engine.
>>
>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>> ---
>>  .../bindings/misc/intel,hps-copy-engine.yaml  | 48 +++++++++++++++++++
>>  1 file changed, 48 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/misc/intel,hps-copy-engine.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/misc/intel,hps-copy-engine.yaml b/Documentation/devicetree/bindings/misc/intel,hps-copy-engine.yaml
>> new file mode 100644
>> index 000000000000..74e7da9002f4
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/misc/intel,hps-copy-engine.yaml
>
> Please find appropriate directory matching this hardware, not "misc". As
> a fallback SoC related bindings end up in "soc".

I thought misc seemed appropriate because it is a very specific IP block 
in the FPGA connected to the HPS.  It does perform a simple DMA function; 
so I considered putting it in the dma directory, but it also has some
hand-shaking registers between the HPS and a host processor connected to the
FPGA via PCIe; so I thought misc.  Since the HPS "soc" accesses the 
component, I can put it in the "soc" directory, unless there is a better 
suggestion.

>
>> @@ -0,0 +1,48 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +# Copyright (C) 2022, Intel Corporation
>> +%YAML 1.2
>> +---
>> +$id: "http://devicetree.org/schemas/misc/intel,hps-copy-engine.yaml#"
>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>> +
>> +title: Intel HPS Copy Engine
>> +
>> +maintainers:
>> +  - Matthew Gerlach <matthew.gerlach@linux.intel.com>
>> +
>> +description: |
>> +  The Intel Hard Processor System (HPS) Copy Engine is an IP block used to copy
>> +  a bootable image from host memory to HPS DDR.  Additionally, there is a
>> +  register the HPS can use to indicate the state of booting the copied image as
>> +  well as a keep-a-live indication to the host.
>> +
>> +properties:
>> +  compatible:
>> +    items:
>
> No "items", you have just one item.

Got it.  I will change it in v3.
>
>> +      - const: intel,hps-copy-engine
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    agilex_hps_bridges: bus@80000000 {
>
> Unused label...

I will remove unused label in v3.

>
>> +        compatible = "simple-bus";
>> +        reg = <0x80000000 0x60000000>,
>> +              <0xf9000000 0x00100000>;
>> +        reg-names = "axi_h2f", "axi_h2f_lw";
>> +        #address-cells = <0x2>;
>
> $ git grep address-cell
> Do not use inconsistent coding. The same applies to your DTS.

Is the inconsistency the use of '0x' in the values of #address-cells and 
#size-cells, or is the consistency having different values for 
#address-cells and #size-cells or both?

>
>> +        #size-cells = <0x1>;
>> +        ranges = <0x00000000 0x00000000 0xf9000000 0x00001000>;
>
> Why do you even need the simple-bus above and cannot put the device
> directly on the bus?

On an Agilex chip, the HPS is connected to the FPGA via two bridges, 
referred as the "HPS to FPGA bridge" and the "Lightweight HPS to FPGA 
bridge".  An IP block in the FPGA could be connected to one or both of 
these bridges.  I am anticipating device tree overlays being applied for 
other IP blocks instantiated in the FPGA.

>
>> +
>> +        hps_cp_eng@0 {
>
> No underscores in node names. Generic node name.

I understand.  I am considering dma@0 for the generic node name.

>
>> +            compatible = "intel,hps-copy-engine";
>> +            reg = <0x00000000 0x00000000 0x00001000>;
>> +        };
>> +    };
>
>
> Best regards,
> Krzysztof
>

Thank you for the review,
Matthew
