Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A11521D2F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 16:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244362AbiEJO5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 10:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345551AbiEJO4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 10:56:41 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380FC24E03B;
        Tue, 10 May 2022 07:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652192280; x=1683728280;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=o6mrScaTX48VqjqKd2MFL8TBr/caM2QD+9ZIRpnBWTc=;
  b=CnE/M+LOlGlA+zvUHDlYXQHKTV2Qbkd4zet4k2MK7XbUjU6mBwkNHxMh
   /L9V6DOhhZEpPqR7bzKhgH9vunMP+oEqDT7xkEsPykI85m6eTHKEA9CmT
   mxYvLJzgD7ZeaTjNo3yVK9gsgBg8L7sFnVrrJn2Jh4JUU5GHHJms3zJQn
   DvziNTokJIa8gXI9PRbsd1yKFlfN+xn9vPsjcQRKuhb3en+Few4KdmANJ
   Ow4qfQIvXQbGWrDvbu6jzPH5T3A7Z97E1P3hwqHqdIR4vL4t5mI+xgJO5
   izCYATVp26zRfBykcuWGWevZgKAqljrWauwCLYAtmAEMl6AwUnbvQdnps
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="269049663"
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="269049663"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 07:17:59 -0700
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="570692613"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 07:17:59 -0700
Date:   Tue, 10 May 2022 07:17:59 -0700 (PDT)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
cc:     dinguyen@kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH v4 3/3] arm64: dts: intel: add device tree for n6000
In-Reply-To: <eee2d4f6-703d-d3bb-3949-493f9d65f676@linaro.org>
Message-ID: <alpine.DEB.2.22.394.2205100717170.612063@rhweight-WRK1>
References: <20220508142624.491045-1-matthew.gerlach@linux.intel.com> <20220508142624.491045-4-matthew.gerlach@linux.intel.com> <eee2d4f6-703d-d3bb-3949-493f9d65f676@linaro.org>
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



On Mon, 9 May 2022, Krzysztof Kozlowski wrote:

> On 08/05/2022 16:26, matthew.gerlach@linux.intel.com wrote:
>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>
>> Add a device tree for the n6000 instantiation of Agilex
>> Hard Processor System (HPS).
>>
>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>
>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Hi Kryzysztof,

Thanks for the Acked-by.  I will add your tag to a v5 patch set 
submission.

Matthew
>
>
> Best regards,
> Krzysztof
>
