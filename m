Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4DE51B033
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 23:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356777AbiEDVSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 17:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbiEDVRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 17:17:52 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37264D60D;
        Wed,  4 May 2022 14:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651698855; x=1683234855;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Cj2D+b59wkw3CToYcJa5g3cc4lPf7xHjm9JCn4zgTJs=;
  b=nYad37At3y0c/94d/Vf9l9ky1fp6ql2aBTdOLpDzvj/GyZV/GvmcJHYM
   3fBrtRwNeJGVDt9FoTLVT4u3tswqnyFQLFYXztBwRiUnioVPK2QhxIvvc
   lQPvpGnhoqmNCYR/jZFg6kMUGweNlEvc53pAP+6KIBxzfAFxHoaEnObPY
   Cya9L5cla5vyUrKMiWZkjcK4iQ+HHUiPKunVcFzGZLQNtYZ7tJba28qMP
   Rmc+qLXziZVuAPpW3kPj+Q9O+/nypkq2xp3AeKp6A6AcnEIaDcWcGxO2c
   RbyH2jf8scvr2RrUxJSs5g0f+3t8h3hJPGkCNAHi8KMsDSPVcQBoqlTxF
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="354339092"
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="354339092"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 14:14:15 -0700
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="664653734"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 14:14:15 -0700
Date:   Wed, 4 May 2022 14:14:15 -0700 (PDT)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
cc:     dinguyen@kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH v2 3/3] arm64: dts: intel: add device tree for n6000
In-Reply-To: <d9608f47-e70b-43bd-14a1-d03b2ca3b1a9@linaro.org>
Message-ID: <alpine.DEB.2.22.394.2205041413190.2669897@rhweight-WRK1>
References: <20220503194546.1287679-1-matthew.gerlach@linux.intel.com> <20220503194546.1287679-4-matthew.gerlach@linux.intel.com> <d9608f47-e70b-43bd-14a1-d03b2ca3b1a9@linaro.org>
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
>> Add a device tree for the n6000 instantiation of Agilex
>> Hard Processor System (HPS).
>>
>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>> +
>> +&spi0 {
>> +	status = "okay";
>> +
>> +	spidev: spidev@0 {
>> +		status = "okay";
>> +		compatible = "linux,spidev";
>> +		spi-max-frequency = <25000000>;
>> +		reg = <0>;
>
> You should see big fat warnings - from checkpatch and when you boot your
> device. This compatible is not accepted.

I must have missed the warning for the compatible string.  I see it now, 
and I remove the node in the v3 patch set.

Thanks for the feedback.
>
> Please be sure you run checkpatch on your patches. Using reviewers time
> instead of automated tool for the same job is discouraged...
>
>
> Best regards,
> Krzysztof
>
