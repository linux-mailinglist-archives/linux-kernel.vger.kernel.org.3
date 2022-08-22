Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6DA559C1FD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235710AbiHVO7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 10:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235560AbiHVO7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 10:59:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5381C275DE
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 07:59:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C678F60FB4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 14:59:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6264C433C1;
        Mon, 22 Aug 2022 14:59:50 +0000 (UTC)
Date:   Mon, 22 Aug 2022 11:00:07 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Chen Zhongjin <chenzhongjin@huawei.com>,
        linux-kernel@vger.kernel.org, jpoimboe@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com
Subject: Re: [PATCH v2] x86/unwind/orc: unwind ftrace trampolines with
 correct orc
Message-ID: <20220822110007.0d94aa45@gandalf.local.home>
In-Reply-To: <YwIHAvSGOmDLZ42k@gmail.com>
References: <20220819084334.244016-1-chenzhongjin@huawei.com>
        <20220819132812.391619d2@gandalf.local.home>
        <YwIHAvSGOmDLZ42k@gmail.com>
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

On Sun, 21 Aug 2022 12:20:50 +0200
Ingo Molnar <mingo@kernel.org> wrote:

> > Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > 
> > Would someone from the tip tree care to pull this in?  
> 
> Picked it up into tip:x86/urgent with minor edits to the changelog - will 
> push it out after some testing.

Thanks Ingo!

-- Steve
