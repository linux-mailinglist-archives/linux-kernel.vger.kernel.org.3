Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E337951B064
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 23:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344938AbiEDV00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 17:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbiEDV0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 17:26:22 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05ED74E38C;
        Wed,  4 May 2022 14:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651699366; x=1683235366;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=NkTA3HMEWfESPnZ0nYN+T6PFiddUsLSTX8ks8Cl1R+8=;
  b=L3CmojO2yuFTKvX88+YRKeCuWBV1o9sxgap7+V/Kj94DzfARPdh69y4k
   H5qppoIqm7CBHyQr1FpeeBBhLO6kBsG5jYx6poTRm2BzVn3v4JvVFJwxG
   3WAuUzB6NdOIwTDkiAfJ9Evdtq77MGbFXpzpqo9yA4a12vq5NrE/DIdh2
   cdWaW2EK3yfGthN99vurTPA3LlhCuVYeJs/SN7S/ghjeyvsXruxXI/kz5
   4kJw2nrS53j4yI8qsChhPZEHhynn2wOC+T2C9vUyf+rQOVU2fS5HLzKg0
   POdzGHHBXQjwMIxYj7EjZKRtpKq8xCltFOUm/Genk72ks3WOH98odjjJs
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="328442996"
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="328442996"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 14:22:45 -0700
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="620990041"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 14:22:44 -0700
Date:   Wed, 4 May 2022 14:22:44 -0700 (PDT)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
cc:     dinguyen@kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH v2 3/3] arm64: dts: intel: add device tree for n6000
In-Reply-To: <608ba746-9116-3f36-d640-07eb8b5d793e@linaro.org>
Message-ID: <alpine.DEB.2.22.394.2205041415420.2669897@rhweight-WRK1>
References: <20220503194546.1287679-1-matthew.gerlach@linux.intel.com> <20220503194546.1287679-4-matthew.gerlach@linux.intel.com> <608ba746-9116-3f36-d640-07eb8b5d793e@linaro.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
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
>> Add a device tree for the n6000 instantiation of Agilex
>> Hard Processor System (HPS).
>>
>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>
>> +
>> +	soc {
>> +		agilex_hps_bridges: bus@80000000 {
>> +			compatible = "simple-bus";
>> +			reg = <0x80000000 0x60000000>,
>> +				<0xf9000000 0x00100000>;
>> +			reg-names = "axi_h2f", "axi_h2f_lw";
>> +			#address-cells = <0x2>;
>> +			#size-cells = <0x1>;
>> +			ranges = <0x00000000 0x00000000 0xf9000000 0x00001000>;
>> +
>> +			hps_cp_eng@0 {
>
> No underscores in node names.  dtc W=1 should complain about it.

I will remove the underscores in the name.  I didn't see a complaint when 
I compiled it with "make W=1" in the kernel tree.

> The node name should be generic, matching class of a device. What is
> this exactly?

The component is a specialized IP block instantiated in the FPGA directly 
connected to the HPS.  In one sense the IP block is a simple DMA 
controller, but it also has some registers for hand shaking between the 
HPS and a host processor connected to the FPGA via PCIe.  Should I call 
the node, dma@0?

Thanks for your review,
Matthew

> > Best regards,
> Krzysztof
>
