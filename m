Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A3251B021
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 23:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378501AbiEDVMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 17:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235258AbiEDVMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 17:12:46 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87932517FC;
        Wed,  4 May 2022 14:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651698549; x=1683234549;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=T0JUGY/mbcJez9N2jqbH9/PfYjcazcXJqwVpET3qd60=;
  b=dTFC6+CS/Ra7RAG4Q6Nx/eigAUrIBrxrhs8+DtIwM5hyqHmVTLGAMWof
   uuJ6M4fODqvoI57qEmIKPudTv4y4XhdDkWqtHFZ/8oJSupY1nCprPlgC0
   6nU9ghgYmg+CcGkF7gs/Vj01HfudBbQ4yzpfnvIQmjprNhS9XiDCjPGJj
   qlrNCtDOE0BkUYaQWdaYxIpFYEgxJtzt2W2yY+2pfPFDmHjtex62uR9Rq
   GAw4bcg5dnEofa0xUJPksuH2oLR8b7OFvDimgsFiQUqPS+Ic/6pxIkupp
   0D0FK/3Q4bhhf7ry+KhnS8v8AySR6uIyqCFuZXRgy2srLx4eNPLFP13+E
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="247808559"
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="247808559"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 14:09:09 -0700
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="620985186"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 14:09:09 -0700
Date:   Wed, 4 May 2022 14:09:02 -0700 (PDT)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
cc:     dinguyen@kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH v2 2/3] dt-bindings: intel: add binding for Intel n6000
In-Reply-To: <45e55d3e-f29a-81ee-6673-a05da377e798@linaro.org>
Message-ID: <alpine.DEB.2.22.394.2205041408230.2669897@rhweight-WRK1>
References: <20220503194546.1287679-1-matthew.gerlach@linux.intel.com> <20220503194546.1287679-3-matthew.gerlach@linux.intel.com> <45e55d3e-f29a-81ee-6673-a05da377e798@linaro.org>
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



On Wed, 4 May 2022, Krzysztof Kozlowski wrote:

> On 03/05/2022 21:45, matthew.gerlach@linux.intel.com wrote:
>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>
>> Add the binding string for the Agilex based Intel n6000 board.
>>
>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thank you for your time and the Acked-by. I will add it to my v3 patch 
set.

Matthew
>
>
> Best regards,
> Krzysztof
>
