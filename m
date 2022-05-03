Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD65E5186E7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 16:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237191AbiECOmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 10:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235833AbiECOma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 10:42:30 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFB83585B;
        Tue,  3 May 2022 07:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651588737; x=1683124737;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=N2zi+YIjSNLlSlsGyRm3N+vojMMVHkuZGiENMvXNw4o=;
  b=VytaN1algBuJI9mZEfb9VquNk9cbFKm56rHbfZlzOBmpghGDMqirpurc
   A0icsd0Vz7MectDZFkJw99HdW62g8cmw9XaQuktEv4P8ICqsSnpmY3H8W
   A+eklRgUXWRPoPwwsgV1t6aUxuovy8yrCuU9v3Z27tHh1FNyydvlOCE13
   9apPv5rdQyBkz/zvyX8lu5RL1TTmHnlXEWi+h+LmMEXaIwuzrk7DJ2zif
   1tpm8+a9V+dbKTnQcLdlH+EyuTjBZBTEpmpqOvovzUXUYExPv76G+uF6E
   2+u2PORAP4Fm+CCdQ2IP3XIFa5LS6Ug3druyscuN26fBFYFvh1+VMb34G
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="267084742"
X-IronPort-AV: E=Sophos;i="5.91,195,1647327600"; 
   d="scan'208";a="267084742"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 07:38:57 -0700
X-IronPort-AV: E=Sophos;i="5.91,195,1647327600"; 
   d="scan'208";a="536357275"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 07:38:57 -0700
Date:   Tue, 3 May 2022 07:38:57 -0700 (PDT)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dinguyen@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH] arm64: dts: intel: add device tree for n6000
In-Reply-To: <896ea19b-6dc1-a635-0dd6-c7f9494487e8@linaro.org>
Message-ID: <alpine.DEB.2.22.394.2205030737190.244936@rhweight-WRK1>
References: <20220502165818.4002157-1-matthew.gerlach@linux.intel.com> <896ea19b-6dc1-a635-0dd6-c7f9494487e8@linaro.org>
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



On Tue, 3 May 2022, Krzysztof Kozlowski wrote:

> On 02/05/2022 18:58, matthew.gerlach@linux.intel.com wrote:
>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>
>> Add a device tree for the n6000 instantiation of Agilex
>> Hard Processor System (HPS).
>
> Please also use scripts/get_maintainer.pl to get the addresses. You
> cc-ed here several wrong emails, so no one would pick up this patch.
>
> Actually only my email is correct (except lists)...

I did run scripts/get_maintain.pl, but I still managed to mangle Dinh's 
and Rob's email addresses.  I will be extra, extra careful on the v2 
submission.

Matthew

>
> Best regards,
> Krzysztof
>
