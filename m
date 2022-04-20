Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F515509332
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 00:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383005AbiDTWxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 18:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356355AbiDTWxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 18:53:05 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244EE140EE;
        Wed, 20 Apr 2022 15:50:17 -0700 (PDT)
Received: (Authenticated sender: joao@overdrivepizza.com)
        by mail.gandi.net (Postfix) with ESMTPA id BD6BD60003;
        Wed, 20 Apr 2022 22:50:13 +0000 (UTC)
MIME-Version: 1.0
Date:   Wed, 20 Apr 2022 15:50:13 -0700
From:   Joao Moreira <joao@overdrivepizza.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        peterz@infradead.org, jpoimboe@redhat.com,
        andrew.cooper3@citrix.com, samitolvanen@google.com,
        mark.rutland@arm.com, hjl.tools@gmail.com,
        alyssa.milburn@linux.intel.com, ndesaulniers@google.com,
        gabriel.gomes@linux.intel.com, rick.p.edgecombe@intel.com
Subject: Re: [RFC PATCH 00/11] Kernel FineIBT Support
In-Reply-To: <202204191937.2720E7E@keescook>
References: <20220420004241.2093-1-joao@overdrivepizza.com>
 <202204191937.2720E7E@keescook>
Message-ID: <94c61936a0fd339430ef24dcaded759f@overdrivepizza.com>
X-Sender: joao@overdrivepizza.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I think it'd be good to get kCFI landed in Clang first (since it is
> effectively architecture agnostic), and then get FineIBT landed. But
> that doesn't mean we can't be working on the kernel side of things at
> the same time.

FWIIW, I'm effectively taking some time away from work for the next 3 
months. I'll be around to answer this and that, help reviewing KCFI and 
maybe send small fixes around, but I'm not planning to land FineIBT in 
clang anytime before that (specially now that I have a direction to look 
into the linker approach as per the other thread e-mails). This should 
give KCFI the time it needs to squeeze in.

> 
> And just thinking generally, for other architecture-specific stuff,
> I do wonder what an arm64 PAC-based CFI might look like. I prefer 
> things
> be hard-coded as kCFI is doing, but it'd be nice to be able to directly
> measure performance and size overheads comparing the various methods.

There are other important bullets to this list, I think, like power 
consumption, robustness and collateral gains (like IBT's side-channel 
hardening). But yeah, this is probably a good list to keep in mind for 
us to discuss during plumbers :)
