Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECEA51511F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 18:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379286AbiD2QuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 12:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377185AbiD2QuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 12:50:22 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7BD03A1456
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:47:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 269BC1063;
        Fri, 29 Apr 2022 09:47:03 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.45.33])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD6B23F774;
        Fri, 29 Apr 2022 09:47:00 -0700 (PDT)
Date:   Fri, 29 Apr 2022 17:46:54 +0100
From:   Mark Rutland <mark.rutland@arm.com>, catalin.marinas@arm.com
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Chengming Zhou <zhouchengming@bytedance.com>, mingo@redhat.com,
        will@kernel.org, tglx@linutronix.de, dave.hansen@linux.intel.com,
        broonie@kernel.org, ardb@kernel.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com,
        zhengqi.arch@bytedance.com
Subject: Re: [PATCH v5 1/2] ftrace: cleanup ftrace_graph_caller enable and
 disable
Message-ID: <YmwWfsgiIDo9eoPw@FVFF77S0Q05N>
References: <20220420160006.17880-1-zhouchengming@bytedance.com>
 <YmZvF9jXQ6jRCkQn@FVFF77S0Q05N>
 <20220425212707.378fb699@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425212707.378fb699@gandalf.local.home>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 09:27:07PM -0400, Steven Rostedt wrote:
> On Mon, 25 Apr 2022 10:51:19 +0100
> Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > Steve, are you happy if this goes via the arm64 tree along with patch 2?
> 
> Yeah, go ahead.
> 
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Thanks!

Catalin, could you please pick these two?

Thanks,
Mark.
