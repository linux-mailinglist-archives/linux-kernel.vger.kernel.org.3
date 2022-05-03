Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEC855186CD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 16:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237113AbiECOj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 10:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237109AbiECOj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 10:39:27 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C0329C89;
        Tue,  3 May 2022 07:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651588554; x=1683124554;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=iEMij0314cRDkFEerNR1vqQNbKVw2VWoGw9pFP2/TyI=;
  b=ISU4yUTW0ZYdkCtn8BWxxmSk7oDZCybfpSD9ybMfKHUAqlG6E7CUGEN9
   EiubGNFjYPgUpjQJesJqz/1VHmp6mkcslesLCEek7pmFoNQokhjoFU28X
   L2+AYUJTPVToFOhNghjcy792fJr1h9zNuyLgvl8SDKNq5cKBmdcX93Wu0
   P/sU5QrnzhMGJAKJdm+JPGScI42qWfx2zHwakVy2/RTHKbRJqLzPMt7Xw
   xZVRiAx7qRRBRhEyUfciDYUxn5IesyHaCcYifcu9sU0XVJ0NjAUd1mcbA
   ZlvfryS77c4KZIRqwjAGkMCQ8HpH4tLA1rfVNF6Ca7zAIJN1q+uAO+y6V
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="267369535"
X-IronPort-AV: E=Sophos;i="5.91,195,1647327600"; 
   d="scan'208";a="267369535"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 07:35:53 -0700
X-IronPort-AV: E=Sophos;i="5.91,195,1647327600"; 
   d="scan'208";a="733937049"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 07:35:53 -0700
Date:   Tue, 3 May 2022 07:35:46 -0700 (PDT)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dinguyen@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH] arm64: dts: intel: add device tree for n6000
In-Reply-To: <e549b689-4043-e689-d0b0-f274ed08a665@linaro.org>
Message-ID: <alpine.DEB.2.22.394.2205030727310.244936@rhweight-WRK1>
References: <20220502165818.4002157-1-matthew.gerlach@linux.intel.com> <e549b689-4043-e689-d0b0-f274ed08a665@linaro.org>
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



On Tue, 3 May 2022, Krzysztof Kozlowski wrote:

> On 02/05/2022 18:58, matthew.gerlach@linux.intel.com wrote:
>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>
>> Add a device tree for the n6000 instantiation of Agilex
>> Hard Processor System (HPS).
>>
>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>> ---
>>  arch/arm64/boot/dts/intel/Makefile            |  1 +
>>  .../boot/dts/intel/socfpga_agilex_n6000.dts   | 77 +++++++++++++++++++
>>  2 files changed, 78 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex_n6000.dts
>>
>> diff --git a/arch/arm64/boot/dts/intel/Makefile b/arch/arm64/boot/dts/intel/Makefile
>> index 0b5477442263..1425853877cc 100644
>> --- a/arch/arm64/boot/dts/intel/Makefile
>> +++ b/arch/arm64/boot/dts/intel/Makefile
>> @@ -1,5 +1,6 @@
>>  # SPDX-License-Identifier: GPL-2.0-only
>>  dtb-$(CONFIG_ARCH_INTEL_SOCFPGA) += socfpga_agilex_socdk.dtb \
>>  				socfpga_agilex_socdk_nand.dtb \
>> +				socfpga_agilex_n6000.dtb \
>>  				socfpga_n5x_socdk.dtb
>>  dtb-$(CONFIG_ARCH_KEEMBAY) += keembay-evm.dtb
>> diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex_n6000.dts b/arch/arm64/boot/dts/intel/socfpga_agilex_n6000.dts
>> new file mode 100644
>> index 000000000000..07f5a5983e5c
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/intel/socfpga_agilex_n6000.dts
>> @@ -0,0 +1,77 @@
>> +// SPDX-License-Identifier:     GPL-2.0
>
> Except what Rob said: remove the indentation before license.

Indentation will be removed.  I noticed my checkpatch.pl execution was 
failing due to missing python module, git.  I installed the git module, 
but the script didn't report an error.

>
>> +/*
>> + * Copyright (C) 2021-2022, Intel Corporation
>> + */
>> +#include "socfpga_agilex.dtsi"
>> +
>> +/ {
>> +	model = "SoCFPGA Agilex n6000";
>> +
>> +	aliases {
>> +		serial0 = &uart1;
>> +		serial1 = &uart0;
>> +		ethernet0 = &gmac0;
>> +		ethernet1 = &gmac1;
>> +		ethernet2 = &gmac2;
>> +	};
>> +
>> +	chosen {
>> +		stdout-path = "serial0:115200n8";
>> +	};
>> +
>> +	memory {
>> +		device_type = "memory";
>> +		/* We expect the bootloader to fill in the reg */
>> +		reg = <0 0 0 0>;
>> +	};
>> +
>> +	soc {
>> +		clocks {
>> +			osc1 {
>> +				clock-frequency = <25000000>;
>
> This does not look like SoC property... If it is part of Soc, why it is
> not provided by clock controller? Where compatible?
>
> If you intended to override nodes, override by label, not by path.

I will make this change.

>
> Best regards,
> Krzysztof
>

Thank you for the review.

Matthew
