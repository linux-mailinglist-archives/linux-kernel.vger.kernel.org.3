Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7FF25A33A0
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 03:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345187AbiH0BvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 21:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbiH0BvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 21:51:12 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F337D8B2B
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 18:51:11 -0700 (PDT)
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id 6506340D403D;
        Sat, 27 Aug 2022 01:51:08 +0000 (UTC)
MIME-Version: 1.0
Date:   Sat, 27 Aug 2022 04:51:08 +0300
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/5] x86: Add resolve_cmdline() helper
In-Reply-To: <YwiwCgIoIPnsyanu@zn.tnic>
References: <cover.1653471377.git.baskov@ispras.ru>
 <7eb917aeb1fa9f044f90ec33c8bf33bb6aee62a5.1653471377.git.baskov@ispras.ru>
 <YwiwCgIoIPnsyanu@zn.tnic>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <0cb45c3090293039fb32e47b4fa181dc@ispras.ru>
X-Sender: baskov@ispras.ru
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-26 14:35, Borislav Petkov wrote:
> On Wed, May 25, 2022 at 01:10:10PM +0300, Evgeniy Baskov wrote:
>> Command line needs to be combined in both compressed and uncompressed
>> kernel from built-in and boot command line strings, which requires
>> non-trivial logic depending on CONFIG_CMDLINE_BOOL and
>> CONFIG_CMDLINE_OVERRIDE.
>> 
>> Add a helper function to avoid code duplication.
>> 
>> Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
>> 
> 
> You have some weird configuration to your git send-email which doesn't
> add the "---" to split the patch commit message from the diffstat.

Thanks, apparently "--summary" removes that.

...
> 
> So that has been switched to strscpy() in the meantime:
> 
> 8a33d96bd178 ("x86/setup: Use strscpy() to replace deprecated 
> strlcpy()")

I did already replace strlcpy() in v5, but since there are new changes
needed, I will send v6 with those changes applied soon.
So, please, ignore v5 then.

> 
> Please redo your set ontop of latest tip/master.

Will do.

Thanks,
Evgeniy Baskov
