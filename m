Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40CA751E7D6
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 16:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443040AbiEGOho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 10:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347909AbiEGOhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 10:37:42 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418B61EC7A;
        Sat,  7 May 2022 07:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651934035; x=1683470035;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=jcAC5rTiCdduYvVDjmq2CvszqCfWR5sKFeDCa5R7ZAE=;
  b=aevUnakpE14B7e2flYCr90Y9RJupRnljoWiF8uOMlrSy+tSZRqR24dQ9
   j9jYbeX6JLQWSFAuqEUqGIyXIQEnI1as73y8j8FuzxJyU18uYr/KE4ne/
   14da3uJ5GfhKXckg7w90Kg7+pWvPZJnIdvlswuCaqHyey/sllfsDFyrCm
   /jvOi0p42iV+F1Ld68Rbdeii/2qemU1sT3Q3AixIX5RfoLa1lyMqWgfHM
   bQgGb5e+zjJJNxOmDp7CoH4SBJyMAkn7BuVot+2O4uqx4ebrpSlD3Wvfu
   YavdcZkXdpIrqHKjhXUWixooi55iDfaByGFmfy4fSKQfbms3Po1KvUs/F
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10340"; a="248621661"
X-IronPort-AV: E=Sophos;i="5.91,207,1647327600"; 
   d="scan'208";a="248621661"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2022 07:33:54 -0700
X-IronPort-AV: E=Sophos;i="5.91,207,1647327600"; 
   d="scan'208";a="736203246"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2022 07:33:54 -0700
Date:   Sat, 7 May 2022 07:33:48 -0700 (PDT)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
cc:     dinguyen@kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH v3 1/3] dt-bindings: soc: add bindings for Intel HPS Copy
 Engine
In-Reply-To: <a5b88103-16e2-1dda-3469-78887f91c88c@linaro.org>
Message-ID: <alpine.DEB.2.22.394.2205070732470.423460@rhweight-WRK1>
References: <20220506154116.365235-1-matthew.gerlach@linux.intel.com> <20220506154116.365235-2-matthew.gerlach@linux.intel.com> <a5b88103-16e2-1dda-3469-78887f91c88c@linaro.org>
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



On Sat, 7 May 2022, Krzysztof Kozlowski wrote:

> On 06/05/2022 17:41, matthew.gerlach@linux.intel.com wrote:
>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>
>> Add device tree bindings documentation for the Intel Hard
>> Processor System (HPS) Copy Engine.
>>
>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>> ---
>> v3:
>>   - remove unused label
>>   - move from misc to soc
>>   - remove 0x from #address-cells/#size-cells values
>>   - change hps_cp_eng@0 to dma-controller@0
>>   - remote inaccurate 'items:' tag
>> ---
>>  .../bindings/soc/intel,hps-copy-engine.yaml   | 51 +++++++++++++++++++
>>  1 file changed, 51 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/soc/intel,hps-copy-engine.yaml
>
> There are no files laying around in bindings/soc. Each is in its own
> vendor subdirectory, so let's don't introduce inconsistencies. Intel
> should not be different/special.

I certainly don't want to be different or special.  I will move the file 
to an intel subdirectory.

Thanks for the feedback,
Matthew

>
> Best regards,
> Krzysztof
>
