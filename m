Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97820563502
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 16:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbiGAOV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 10:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiGAOV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 10:21:56 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0890521E1E
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 07:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656685316; x=1688221316;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lUrti5DzUcLoSfCzCbzJ7wtawMRCS/X3VGtpsrE0y0M=;
  b=ip+S/09bIpf6lcMNQDDv5uEab/kHMaPcFysvSv8pEfxlO7T6Ihz0u7uG
   ATu/3KJ8e+vstmwyI3Wbi2XMIa3YZ8lhuQBgU9c7rzXBtXXKJrxzUlA+9
   bY8EOkQsbpEvz7wMFFc/qZF/ic5rdsgi3HyXOlBjoRFJqXetCAPsWDfiw
   fEWrwmN0GUopzb/RROtX5a9EnIpbTvdxMkBAiSLhLsqryb2GyE8AfHCfD
   e+s9Hx3uaHBti/Bq9dswj53+zEHdtKa6J9M+hwTYOmXUiJNHt2Bhk9Hfu
   AexrqP2hJXAT+Q0KOsdrZ/lt3xOOtmJEd52waeFHqNYp+Z6HJt8RqwDIz
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="281425251"
X-IronPort-AV: E=Sophos;i="5.92,237,1650956400"; 
   d="scan'208";a="281425251"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 07:21:55 -0700
X-IronPort-AV: E=Sophos;i="5.92,237,1650956400"; 
   d="scan'208";a="694523981"
Received: from nkamathe-mobl.amr.corp.intel.com (HELO [10.209.98.74]) ([10.209.98.74])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 07:21:55 -0700
Message-ID: <e333c40a-13da-8def-56db-9b61ef46e296@intel.com>
Date:   Fri, 1 Jul 2022 07:20:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] x86/split_lock: Enable the split lock detect feature on
 Raptor Lake P and Alder Lake N CPUs
Content-Language: en-US
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Tony Luck <tony.luck@intel.com>
Cc:     x86 <x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
References: <20220701131958.687066-1-fenghua.yu@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220701131958.687066-1-fenghua.yu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/1/22 06:19, Fenghua Yu wrote:
> These CPU models support the split lock detect feature. Add them to
> the x86_cpu_ids match table.

When is there going to be architectural detection for this feature?  Or,
is the plan to just keep adding CPUs to this table as they are available.
