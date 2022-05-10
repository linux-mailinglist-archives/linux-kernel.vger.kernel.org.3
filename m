Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61DF5226D5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 00:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236401AbiEJW2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 18:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236227AbiEJW0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 18:26:30 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B5D2E093;
        Tue, 10 May 2022 15:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652221587; x=1683757587;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=gNzJdhqt+WiiUYoxXT+s5t8Ab2l5lEsh0t1yVfIMzAA=;
  b=UsTM/+qwLfRGh0z/gwPl9NZOibyGNoyA+oWiBWMH1LQ8Xg4F9DNVZQ+b
   GS7CroOHU277lUEolCtSUFGT++nNcZ8mSiJTxRreHn1EQMmubBsT/uRK3
   jZlOGGjHyo0Lyjizu/k/nNpmpUSLDUdBuvpb1PkiidQHJaJwnjdb55PKC
   BQCQ/eeGOOTMKRqTV5SSac0VQGHj+5uhjS7mQ5QMRrLLZ1qH6L2lhp96L
   Kz3TqPIpvrO2YtcqJvbndVno1Wjgkkt9n0NC2sVTtrbcTcjzge6qrrnbI
   EqzefobUuYs8uq5gJdVIzQaPa5iTJaf6M4UDKKMKjXA5JaiM8wucNXA9x
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="267111214"
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="267111214"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 15:26:27 -0700
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="814200324"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 15:26:26 -0700
Date:   Tue, 10 May 2022 15:26:26 -0700 (PDT)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     Rob Herring <robh@kernel.org>
cc:     dinguyen@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH v4 1/3] dt-bindings: soc: add bindings for Intel HPS Copy
 Engine
In-Reply-To: <20220510191730.GA2427587-robh@kernel.org>
Message-ID: <alpine.DEB.2.22.394.2205101523440.885823@rhweight-WRK1>
References: <20220508142624.491045-1-matthew.gerlach@linux.intel.com> <20220508142624.491045-2-matthew.gerlach@linux.intel.com> <20220510191730.GA2427587-robh@kernel.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
>
> Also, this should go under bindings/dma/

I will move .../soc/intel/intel,hps-copy-engine.yaml to 
.../dma/intel,hps-copy-engine.yaml unless you think I should start a intel 
subdirectory of bindings/dma.

>
>>  1 file changed, 51 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/soc/intel/intel,hps-copy-engine.yaml
>
