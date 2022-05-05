Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E8951C5D2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 19:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382456AbiEEROS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 13:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382454AbiEEROP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 13:14:15 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4864556C32
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 10:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651770636; x=1683306636;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=R1klEn3mIJKBtGxC0s/2URpewCZFaeKDRLeugxCsMpk=;
  b=A1bVqGKUSyWDFRY8kEZRsiLBgi1MjytALr3Ia75XuNKGYaM/x7LfbNUZ
   zH0yXr8jd69bVxO/V5Kq5a0hmkInXDzlpzwopQCW6xnzraKTYLYxJg8LG
   epzXzW/a9sutVv6lEMFiNVfhuyRms0dTaEHaRUPJ2SqJyVtpEZnNupBdH
   kqE0V8B+FxYXQtMJogdPVz+rUwYB2QvcbjB7TPZzzxPb5Z50izp0Jzs7e
   fLX276gcCKDrl6yaXAZjzNwaft2xl40Cb1SmoVAKd3rQmytp6ZMFCD6B3
   IaGar1+Nz4TYb+PKylIAFE+fpmOyBRbjIKLKzumLq5PF3AzT2p8g1+7/8
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="250174634"
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="250174634"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 10:10:35 -0700
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="694755909"
Received: from evegaag-mobl1.amr.corp.intel.com (HELO [10.209.187.127]) ([10.209.187.127])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 10:10:34 -0700
Message-ID: <ce377229-06ee-7f68-ca55-361a8986a7e7@intel.com>
Date:   Thu, 5 May 2022 10:10:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 3/3] x86: Fix comment for X86_FEATURE_ZEN
Content-Language: en-US
To:     Wyes Karny <wyes.karny@amd.com>, linux-kernel@vger.kernel.org
Cc:     Lewis.Carroll@amd.com, Mario.Limonciello@amd.com,
        gautham.shenoy@amd.com, Ananth.Narayan@amd.com, bharata@amd.com,
        len.brown@intel.com, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, peterz@infradead.org, chang.seok.bae@intel.com,
        keescook@chromium.org, metze@samba.org, zhengqi.arch@bytedance.com,
        mark.rutland@arm.com, puwen@hygon.cn, rafael.j.wysocki@intel.com,
        andrew.cooper3@citrix.com, jing2.liu@intel.com,
        jmattson@google.com, pawan.kumar.gupta@linux.intel.com
References: <20220505104856.452311-1-wyes.karny@amd.com>
 <20220505110429.453279-1-wyes.karny@amd.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220505110429.453279-1-wyes.karny@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/5/22 04:04, Wyes Karny wrote:
> The feature X86_FEATURE_ZEN implies that the CPU supports Zen
> microarchitecture. Call this out explicitly in the comment.

Is "supports" the best word here?

A CPU is based on a microarchitecture, it doesn't really support it.  I
guess we could say the CPU supports a microarchitecture's *features*,
but that's a bit wordy for a tiny comment.

Maybe:

#define X86_FEATURE_ZEN			(7*32+28) /* "" CPU based on Zen uarch */

or spell out "microarchitecture" if there's room.
