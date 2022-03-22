Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E9E4E3584
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 01:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234295AbiCVAcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 20:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233828AbiCVAcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 20:32:08 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7ED383550
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 17:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647909041; x=1679445041;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=MxIe4PGTTft2J960yldrK0fqL+jHfZA6g3WPcxrTYBs=;
  b=DCZg1b3/H1+KwDoriPsvBuRBn13Zn5Ks8VxutGdb9JkSi2Vg5OSvsJez
   PuCV/ldAzsFES2lToeFH/BQhmCPeH982ETwmcL45+EEcPBqm5p4hLfc3y
   H8225u0WXRFqqC6Opx/vNEIVNbW6gfdigWId5Ph3wS3a/nQxwED2MNijN
   GrqQbaIXNZaj8XvkEjSwEHCMUHl7oKW3cYrzZqQsycMF+iwMxJdRRTmRs
   z7LD6u0/RKPgPjKFmgoC9w80t7AqwFmIhBUOPL498T8bY1ZZQKduVU7Lo
   6YcAoRW9gOWEW6jDDXLem3jU8I/dltmbBdaiwvQlE2IGJgQPviUB/Iswg
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="320886408"
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; 
   d="scan'208";a="320886408"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 17:30:41 -0700
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; 
   d="scan'208";a="716701467"
Received: from jwu59-mobl1.ccr.corp.intel.com (HELO [10.255.30.60]) ([10.255.30.60])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 17:30:40 -0700
Subject: Re: [kbuild-all] Re: arch/arm/mach-ixp4xx/common-pci.c:143:5:
 warning: no previous prototype for 'ixp4xx_pci_write'
To:     Linus Walleij <linus.walleij@linaro.org>,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <202203200849.3dFXVKxt-lkp@intel.com>
 <CACRpkdaorR-mhZ9g2SraJJJ3sVw9yR5PgzGZOP16scQTC8+D8Q@mail.gmail.com>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <1252951b-cb9d-0d76-09f1-37d2b364b02c@intel.com>
Date:   Tue, 22 Mar 2022 08:30:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdaorR-mhZ9g2SraJJJ3sVw9yR5PgzGZOP16scQTC8+D8Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/21/2022 11:34 PM, Linus Walleij wrote:
> On Sun, Mar 20, 2022 at 1:07 AM kernel test robot <lkp@intel.com> wrote:
> 
>> FYI, the error/warning still remains.
> 
> As I have repeated three times, this file goes away in the next merge window.
> 
> I suppose I am talking to an AI, because the hammering seems pretty dumb.

Hi Linus,

Sorry for the noise, the report is repeated almost once a month until 
issue fixed, we'll ignore the reports about commit d5d9f7ac58 to avoid
disturbing you.

Best Regards,
Rong Chen

> 
> Linus Walleij
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org
> 
