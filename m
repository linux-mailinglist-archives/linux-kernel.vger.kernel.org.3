Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF88B4F0C4A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 21:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376310AbiDCTbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 15:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240851AbiDCTbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 15:31:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94EF2340F2
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 12:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=bZAhRcIOOOLC+VgZTfuvVfGGPL1m/gc99oSv6CrjBKU=; b=sXzpe90qC4SGFWTm7hreBmqnKY
        M0zkFb13fJzW2jUlAMXU7h6yopiF7j3TD7PG25rZqTIBn3x2bSWv7nRf5TKFKq+iwwjwQMjA3v7VX
        xqePqOMRsZ39GZZhAMoZJk3pxx8lVGsVm1h2SPwiczfg9wICdBNQ/C9DuF5SpJm1JfJMz7zjxaVCA
        AfcS35HbweKeq5WgTsplx6AHodTFfuIsBIZKHDslcSGwkoCexXDsbBQ8c9+uJkQBTCavaHyHxFg8W
        /ZmfswgAOT2mfbw2dtMcBkYwjtWRbYYmC1497SFSmZ4W9QEQq2SQ0310eIH/kh8jd/KM5eIlH2HrB
        YmlzKFYA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nb5uL-0057oh-Nq; Sun, 03 Apr 2022 19:29:06 +0000
Message-ID: <e4d381f0-bafc-771b-7298-cfc6685776f0@infradead.org>
Date:   Sun, 3 Apr 2022 12:29:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: drivers/cxl/pci.c:439:7: warning: Local variable 'rc' shadows
 outer variable [shadowVariable]
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <202204021950.bTbpM2Gy-lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <202204021950.bTbpM2Gy-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi lkp/ktr,

On 4/2/22 04:26, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   88e6c0207623874922712e162e25d9dafd39661e
> commit: 523e594d9cc03db962c741ce02c8a58aab58a123 cxl/pci: Implement wait for media active
> date:   7 weeks ago
> compiler: alpha-linux-gcc (GCC) 11.2.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> 
> cppcheck warnings: (new ones prefixed by >>)
>>> drivers/cxl/pci.c:439:7: warning: Local variable 'rc' shadows outer variable [shadowVariable]
>      int rc;
>          ^
>    drivers/cxl/pci.c:431:6: note: Shadowed declaration
>     int rc, i;
>         ^
>    drivers/cxl/pci.c:439:7: note: Shadow variable
>      int rc;
>          ^
> 
> cppcheck possible warnings: (new ones prefixed by >>, may not real problems)
> 
>>> drivers/cxl/port.c:63:1: warning: There is an unknown macro here somewhere. Configuration is required. If __stringify is a macro then please configure it. [unknownMacro]
>    MODULE_ALIAS_CXL(CXL_DEVICE_PORT);
>    ^
> --

Can you provide a cppcheck config file and command line
for this, please?

My naive testing does not see any of these warnings --
although I can easily spot the problems in the source file.

thanks.
-- 
~Randy
