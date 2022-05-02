Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15C5517717
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 21:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387041AbiEBTHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 15:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387034AbiEBTHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 15:07:43 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28766B871;
        Mon,  2 May 2022 12:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651518253; x=1683054253;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Rv8nCiwQdv7yIXAs22Fv6R6p/0NJiIKyzQb1x5PxAoo=;
  b=KJcT7zLHymXhh2n8mDfcbmwfF9ZiIkCjtDbbeURvamBzko3hSnmrV+CK
   JPYDmfIwcBLohr6fciSITW+/UmE8ELXj6OlyG6mWtqBa9USGSHIDep9CP
   Toq4B6rp757kxcXYWMMsPfSDkG110jozM6wGDd/v5EayEK9u34Aj25PYt
   VNuRwIsaeS3fJWVkNzPhx+5jbPynJEiJPIZbOzcCpJoBdlAVbPME1zRM3
   HrHhCrT1U9T0inpVyuEKxfX9T8+B36EB7VnvbJQDyqhLABq/2i7Sw857R
   vL4/f88nB7c/MqdBirogbmxB5cZ8VZQIeolVMd68hArtQrJFuIoEP9iA7
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="247212925"
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; 
   d="scan'208";a="247212925"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 12:04:13 -0700
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; 
   d="scan'208";a="620040688"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 12:04:12 -0700
Date:   Mon, 2 May 2022 12:04:05 -0700 (PDT)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     Rob Herring <robh@kernel.org>
cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, dinguyen@vger.kernel.org,
        robh+dt@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH] arm64: dts: intel: add device tree for n6000
In-Reply-To: <CAL_JsqKwr7Je51X=OVd5Mfxe=Ztvp7jY2WcTu+treB3x7QBxfA@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2205021157040.65759@rhweight-WRK1>
References: <20220502165818.4002157-1-matthew.gerlach@linux.intel.com> <CAL_JsqKwr7Je51X=OVd5Mfxe=Ztvp7jY2WcTu+treB3x7QBxfA@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 2 May 2022, Rob Herring wrote:

> On Mon, May 2, 2022 at 11:58 AM <matthew.gerlach@linux.intel.com> wrote:
>>
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
>>                                 socfpga_agilex_socdk_nand.dtb \
>> +                               socfpga_agilex_n6000.dtb \
>
> Alphabetical order.

Got it.
>
>>                                 socfpga_n5x_socdk.dtb
>>  dtb-$(CONFIG_ARCH_KEEMBAY) += keembay-evm.dtb
>> diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex_n6000.dts b/arch/arm64/boot/dts/intel/socfpga_agilex_n6000.dts
>> new file mode 100644
>> index 000000000000..07f5a5983e5c
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/intel/socfpga_agilex_n6000.dts
>> @@ -0,0 +1,77 @@
>> +// SPDX-License-Identifier:     GPL-2.0
>> +/*
>> + * Copyright (C) 2021-2022, Intel Corporation
>> + */
>> +#include "socfpga_agilex.dtsi"
>> +
>> +/ {
>> +       model = "SoCFPGA Agilex n6000";
>> +
>> +       aliases {
>> +               serial0 = &uart1;
>> +               serial1 = &uart0;
>> +               ethernet0 = &gmac0;
>> +               ethernet1 = &gmac1;
>> +               ethernet2 = &gmac2;
>> +       };
>> +
>> +       chosen {
>> +               stdout-path = "serial0:115200n8";
>> +       };
>> +
>> +       memory {
>> +               device_type = "memory";
>> +               /* We expect the bootloader to fill in the reg */
>> +               reg = <0 0 0 0>;
>> +       };
>> +
>> +       soc {
>> +               clocks {
>> +                       osc1 {
>> +                               clock-frequency = <25000000>;
>> +                       };
>> +               };
>> +               agilex_hps_bridges: bridge@80000000 {
>> +                       compatible = "simple-bus";
>> +                       reg = <0x80000000 0x60000000>,
>> +                               <0xf9000000 0x00100000>;
>> +                       reg-names = "axi_h2f", "axi_h2f_lw";
>> +                       #address-cells = <0x2>;
>> +                       #size-cells = <0x1>;
>> +                       ranges = <0x00000000 0x00000000 0xf9000000 0x00001000>;
>> +
>> +                       uio_cp_eng@0xf9000000 {
>
> Unit addresses shouldn't have '0x' and the address is wrong as it
> should match the child address (0). dtc will tell you this though you
> need 'W=1'. Run this and schema checks and don't add new warnings.

Thanks for the pointers.  I will run with W=1 and run schema checks and 
submit a v2.

>
>> +                               compatible = "generic-uio";
>
> NAK. Not documented and that's because this is not a h/w device.

Got it.  I will create a meaningful name for the h/w device and submit 
documentation.

>
>> +                               reg = <0x00000000 0x00000000 0x00001000>;
>> +                               status = "okay";
>
> That's the default.

I will remove redundant status field.

>
>> +                       };
>> +               };
>> +       };
>> +};
>> +
>> +&uart0 {
>> +       status = "okay";
>> +};
>> +
>> +&uart1 {
>> +       status = "okay";
>> +};
>> +
>> +&spi0 {
>> +       status = "okay";
>> +
>> +       spidev: spidev@0 {
>> +               status = "okay";
>> +               compatible = "linux,spidev";
>> +               spi-max-frequency = <25000000>;
>> +               reg = <0>;
>> +       };
>> +};
>> +
>> +&watchdog0 {
>> +       status = "okay";
>> +};
>> +
>> +&fpga_mgr {
>> +       status = "disabled";
>> +};
>> --
>> 2.25.1
>>
>
