Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C74570C4A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 23:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbiGKVCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 17:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbiGKVCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 17:02:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849245246F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 14:02:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 251ABB81214
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 21:02:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E87CC34115;
        Mon, 11 Jul 2022 21:02:47 +0000 (UTC)
Date:   Mon, 11 Jul 2022 17:02:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Li kunyu <kunyu@nfschina.com>, mingo@redhat.com,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] trace: atomic64_read(&ioc->vtime_rate) is assigned an
 extra semicolon
Message-ID: <20220711170245.34c0a7bb@gandalf.local.home>
In-Reply-To: <d7358d95-b187-ca7b-7337-d22dcd0ff254@kernel.dk>
References: <20220629030013.10362-1-kunyu@nfschina.com>
        <20220711165532.10476a0b@gandalf.local.home>
        <d7358d95-b187-ca7b-7337-d22dcd0ff254@kernel.dk>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jul 2022 14:57:51 -0600
Jens Axboe <axboe@kernel.dk> wrote:

> On 7/11/22 2:55 PM, Steven Rostedt wrote:
> > Jens,
> > 
> > Want to take this one? Or I can if you don't.  
> 
> You can just include it in the trace commits, that's fine. Thanks!
> 

Will do. I'm working on something to push for Linus this week, I'll include
it with that. I don't think this needs to wait till the merge window.

-- Steve
