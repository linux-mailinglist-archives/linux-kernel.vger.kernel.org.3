Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5BC54FA92A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 17:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242388AbiDIPN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 11:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiDIPN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 11:13:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C33329A7;
        Sat,  9 Apr 2022 08:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=j64UWVGLACOcUBS02FLv/L/l+9fAVMmfjcXAezhW5FY=; b=HeY5lvhxJDGexvXt4qVZBrH08D
        QS38P6lzFmxWtI4U8z2gh66SUFYV9rHnO5xp1tB4mCGnVUmRUmSt0kd/WvtW7NcdI0xF7n6Y9w28L
        /XIEO9wYLALdWjOK7I3bLJx3TLbjQlT4fqDowLcbaLDqjkghmBCFAhDjISzvoCySU5juO3SdI3fu2
        4uaGQU5H7u5TrONzn+I40JJJntQ4eJwoaOwej/w/30pMWFAKxVLz8ODD2hkrbopUDyDI2w4gZiVI4
        dnbwUoGCwNFACRiTInYixCxydCjno6Qf5OvG/ytawFkhfNCKh9R7NjM/Ps5hwEIciflNl8FqGknV1
        ts3PGGGA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ndCkY-00AmG0-Ms; Sat, 09 Apr 2022 15:11:43 +0000
Message-ID: <ea594b7a-22d5-ba39-6e83-921f98fa76a5@infradead.org>
Date:   Sat, 9 Apr 2022 08:11:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] sparc: cacheflush_32.h needs <linux/mm.h>
Content-Language: en-US
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org
References: <20220409060215.19890-1-rdunlap@infradead.org>
 <YlE54Cs0mi0WDPo7@ravnborg.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <YlE54Cs0mi0WDPo7@ravnborg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/9/22 00:46, Sam Ravnborg wrote:
> Hi Randy,
> 
> On Fri, Apr 08, 2022 at 11:02:15PM -0700, Randy Dunlap wrote:
>> Add <linux/mm.h> to cacheflush_32.h just as in cacheflush_64.h.
> 
> Just add a forward declaration like this to fix it:
> 
> struct page;
> 
> No need to pull in a header file when a forward is enough.

Sure, will do.

> Maybe we could simplify sparc64 in a similar way, but that is another
> patch and it may require extra work in other files anyway.
> 
> 	Sam

-- 
~Randy
