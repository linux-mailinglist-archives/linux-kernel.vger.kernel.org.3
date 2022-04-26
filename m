Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78DD9510294
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 18:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352822AbiDZQKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 12:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352823AbiDZQKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 12:10:19 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BCE4C68F91
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 09:07:11 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88BB323A;
        Tue, 26 Apr 2022 09:07:11 -0700 (PDT)
Received: from lakrids (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A4EF3F73B;
        Tue, 26 Apr 2022 09:07:10 -0700 (PDT)
Date:   Tue, 26 Apr 2022 17:07:08 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Alexander Popov <alex.popov@linux.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
        catalin.marinas@arm.com, luto@kernel.org, will@kernel.org
Subject: Re: [PATCH 0/8] stackleak: fixes and rework
Message-ID: <YmgYrFHC0o8O1WcX@lakrids>
References: <20220425115603.781311-1-mark.rutland@arm.com>
 <202204251551.0CFE01DF4@keescook>
 <91238500-61a6-1e2e-1dc2-931c0a23cca8@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91238500-61a6-1e2e-1dc2-931c0a23cca8@linux.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 06:51:04PM +0300, Alexander Popov wrote:
> On 26.04.2022 01:54, Kees Cook wrote:
> > On Mon, Apr 25, 2022 at 12:55:55PM +0100, Mark Rutland wrote:
> > > This series reworks the stackleak code. The first patch fixes some
> > > latent issues on arm64, and the subsequent patches improve the code to
> > > improve clarity and permit better code generation.
> > 
> > This looks nice; thanks! I'll put this through build testing and get it
> > applied shortly...
> > 
> > > While the improvement is small, I think the improvement to clarity and
> > > code generation is a win regardless.
> > 
> > Agreed. I also want to manually inspect the resulting memory just to
> > make sure things didn't accidentally regress. There's also an LKDTM test
> > for basic functionality.
> 
> Hi Mark and Kees!
> 
> Glad to see this patch series.
> 
> I've looked at it briefly. Mark, I see your questions in the patches that I
> can answer.
> 
> Please give me some time, I'm going to work on your patch series next week.
> I'll return with review and testing.

Sure thing, thanks!

FWIW, I spotted a couple of issues in my patches today while testing,
and if you're happy I can post a v2 later this week with those fixed, so
you don't need to waste time with those.

Thanks,
Mark.
