Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD7951C5EC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 19:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382617AbiEERUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 13:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244119AbiEERUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 13:20:37 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A4C5C767;
        Thu,  5 May 2022 10:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651771017; x=1683307017;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=PxnyMBD8J7Ko5aqaji0GRDRAx0pTIu0hTbfyHUGWdLI=;
  b=PhVTGMlx6ac5fJdUa433bnUj+GGVLJtTuzW0TmLi4ELSZMJcGpgnl2t4
   08NyFq7W65R3OTTKdT07uBKq7hhyN+ytIcFOdb1buFaG9xI+xlSbwi+QU
   CihpA6RxuVvWJBxDhkT8rgCDUTPx/aDvoeicCUer+iYISW38feLLP/lcH
   CNUsngchkBvpSKVRbMUeFWdaoSeNV8U0V7OIgB3DYLan8jJsHrDgZnLcP
   tcq7VP5psapbK7ChirgU2e9C3wTKf6PS4/ePex6NJslCx3dfuSsVQ10Zu
   Rr65a6G2ZN/wRNurPylXGzWAT7RSBPsJQtSLWov10p5hNGf/LpYc48/KI
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="267788952"
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="267788952"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 10:16:57 -0700
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="585453058"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 10:16:57 -0700
Date:   Thu, 5 May 2022 10:16:50 -0700 (PDT)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
cc:     dinguyen@kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH v2 3/3] arm64: dts: intel: add device tree for n6000
In-Reply-To: <316d2e11-a12a-3a73-0d07-a606005df159@linaro.org>
Message-ID: <alpine.DEB.2.22.394.2205051016190.3669830@rhweight-WRK1>
References: <20220503194546.1287679-1-matthew.gerlach@linux.intel.com> <20220503194546.1287679-4-matthew.gerlach@linux.intel.com> <608ba746-9116-3f36-d640-07eb8b5d793e@linaro.org> <alpine.DEB.2.22.394.2205041415420.2669897@rhweight-WRK1>
 <316d2e11-a12a-3a73-0d07-a606005df159@linaro.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 5 May 2022, Krzysztof Kozlowski wrote:

> On 04/05/2022 23:22, matthew.gerlach@linux.intel.com wrote:
>>
>>
>> On Wed, 4 May 2022, Krzysztof Kozlowski wrote:
>>
>>> On 03/05/2022 21:45, matthew.gerlach@linux.intel.com wrote:
>>>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>>>
>>>> Add a device tree for the n6000 instantiation of Agilex
>>>> Hard Processor System (HPS).
>>>>
>>>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>>
>>>> +
>>>> +	soc {
>>>> +		agilex_hps_bridges: bus@80000000 {
>>>> +			compatible = "simple-bus";
>>>> +			reg = <0x80000000 0x60000000>,
>>>> +				<0xf9000000 0x00100000>;
>>>> +			reg-names = "axi_h2f", "axi_h2f_lw";
>>>> +			#address-cells = <0x2>;
>>>> +			#size-cells = <0x1>;
>>>> +			ranges = <0x00000000 0x00000000 0xf9000000 0x00001000>;
>>>> +
>>>> +			hps_cp_eng@0 {
>>>
>>> No underscores in node names.  dtc W=1 should complain about it.
>>
>> I will remove the underscores in the name.  I didn't see a complaint when
>> I compiled it with "make W=1" in the kernel tree.
>>
>>> The node name should be generic, matching class of a device. What is
>>> this exactly?
>>
>> The component is a specialized IP block instantiated in the FPGA directly
>> connected to the HPS.  In one sense the IP block is a simple DMA
>> controller, but it also has some registers for hand shaking between the
>> HPS and a host processor connected to the FPGA via PCIe.  Should I call
>> the node, dma@0?
>
> Then maybe the closest is dma-controller.

OK, I will call it dma-controller@0.


Thanks,
Matthew
>
>
> Best regards,
> Krzysztof
>
