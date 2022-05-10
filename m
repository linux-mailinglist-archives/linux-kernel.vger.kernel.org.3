Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855215226CC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 00:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235663AbiEJWXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 18:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235616AbiEJWXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 18:23:31 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B09428ED08;
        Tue, 10 May 2022 15:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652221410; x=1683757410;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=fFKXzESxvsckrnSihPh7hKxX+lZggcsIEk5hewcJB7I=;
  b=dTMY2kSYlBH+efWkhZAXbfxpfm34C6+MLyW375b0feGhSxP30BWMC85b
   U6EjLhjDQVnI3oEeZiKWVCsBzW10Xa/SpiWb9pVibfq6cNBRmQMp0GX1c
   fbTvrE0FQrK7cZ7wgB5sqsOOz9Dxe2SMQ2KY1dDNrAxWaMn6c6CDYzkSb
   ikRulYhLYB09pK06AkMhbqpUHUqPSsmmYFNYk2UafbQ2R9hvezLrx9m8g
   Ct7k2nRK8leljYWtwh0HD5lwV+i9MCpjpeB+CjYbkQZ9dRJlQtz4vg9zW
   Q0flAmSVk9dbylPGu6v8aPWIPSB62FTdS2Qesj/m2TdB7xPTiSF0PDiY4
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="269183447"
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="269183447"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 15:23:29 -0700
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="895080950"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 15:23:29 -0700
Date:   Tue, 10 May 2022 15:23:23 -0700 (PDT)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     Rob Herring <robh@kernel.org>
cc:     dinguyen@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH v4 1/3] dt-bindings: soc: add bindings for Intel HPS Copy
 Engine
In-Reply-To: <Ynq52E93mcTXcw9H@robh.at.kernel.org>
Message-ID: <alpine.DEB.2.22.394.2205101452530.885823@rhweight-WRK1>
References: <20220508142624.491045-1-matthew.gerlach@linux.intel.com> <20220508142624.491045-2-matthew.gerlach@linux.intel.com> <Ynq52E93mcTXcw9H@robh.at.kernel.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 10 May 2022, Rob Herring wrote:

> On Sun, May 08, 2022 at 07:26:22AM -0700, matthew.gerlach@linux.intel.com wrote:
>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>
>> Add device tree bindings documentation for the Intel Hard
>> Processor System (HPS) Copy Engine.
>>
>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>> ---
>> v4:
>>   - move from soc to soc/intel/
>>
>> v3:
>>   - remove unused label
>>   - move from misc to soc
>>   - remove 0x from #address-cells/#size-cells values
>>   - change hps_cp_eng@0 to dma-controller@0
>>   - remote inaccurate 'items:' tag
>> ---
>>  .../soc/intel/intel,hps-copy-engine.yaml      | 51 +++++++++++++++++++
>>  1 file changed, 51 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/soc/intel/intel,hps-copy-engine.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/soc/intel/intel,hps-copy-engine.yaml b/Documentation/devicetree/bindings/soc/intel/intel,hps-copy-engine.yaml
>> new file mode 100644
>> index 000000000000..8634865015cd
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/soc/intel/intel,hps-copy-engine.yaml
>> @@ -0,0 +1,51 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +# Copyright (C) 2022, Intel Corporation
>> +%YAML 1.2
>> +---
>> +$id: "http://devicetree.org/schemas/soc/intel/intel,hps-copy-engine.yaml#"
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
>> +    const: intel,hps-copy-engine
>> +
>> +  '#dma-cells':
>> +    const: 1
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
>> +    bus@80000000 {
>> +        compatible = "simple-bus";
>> +        reg = <0x80000000 0x60000000>,
>> +              <0xf9000000 0x00100000>;
>> +        reg-names = "axi_h2f", "axi_h2f_lw";
>
> A simple-bus doesn't have regs because it is simple. If you have
> registers, then you need a specific compatible. You can have
> 'simple-bus' as a fallback if the bus is completely setup by firmware
> and the OS never needs to configure/manage it.

The hardware I'm trying to describe above is the connection from the 
HPS/SOC to the FPGA.  There are two ranges of physical addresses with this 
connection referred to as the "HPS to FPGA bridge" and the "Lightweight 
HPS to FPGA bridge".  Device tree subnodes of bus@80000000 are IP 
blocks in the FPGA.  The IP blocks may be connected to one or both of the
physical address ranges.  Since these physical address ranges are not registers
of the bus@80000000, the field names, reg and reg-names, are probably 
wrong.  Should the reg field above really be ranges?

>
> It also looks odd that ranges only has 4K of bus space and the bus
> registers are 1.5GB of space.

The intent of the ranges field below is to show the ranges of actual 
registers associated subnodes of bus@80000000.  This is probably incorrect 
as well.

>
> That's all kind of outside of the scope of this binding and you should
> just drop that part.

I agree that discussion of bus@80000000 is outside the scope of this 
binding.  I will resubmit this binding with only the dma-controller@0 node 
as the example.


>
>> +        #address-cells = <2>;
>> +        #size-cells = <1>;
>> +        ranges = <0x00000000 0x00000000 0xf9000000 0x00001000>;
>> +
>> +        dma-controller@0 {
>> +            compatible = "intel,hps-copy-engine";
>> +            reg = <0x00000000 0x00000000 0x00001000>;
>> +            #dma-cells = <1>;
>> +        };
>> +    };
>> --
>> 2.25.1
>>
>>
>
