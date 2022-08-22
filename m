Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B326759C1EE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 16:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235511AbiHVOw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 10:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbiHVOw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 10:52:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2B237FB3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 07:52:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2730860BCB
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 14:52:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2061FC433D7;
        Mon, 22 Aug 2022 14:52:24 +0000 (UTC)
Date:   Mon, 22 Aug 2022 10:52:40 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH v2 0/3] Adding support for trace events to habanalabs
Message-ID: <20220822105240.3cb3002c@gandalf.local.home>
In-Reply-To: <20220821080608.27486-1-ogabbay@kernel.org>
References: <20220821080608.27486-1-ogabbay@kernel.org>
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

On Sun, 21 Aug 2022 11:06:05 +0300
Oded Gabbay <ogabbay@kernel.org> wrote:

> Thanks for your comments. We have fixed the patches according to them.
> 
> You wrote the first patch is r-b, but I took the liberty to add your r-b to
> all three patches, I hope you don't object.

I usually only add the r-b to the patches that add TRACE_EVENT(), and
sometimes to those that modify them. Because that's what I know best. The
usage of the trace events is usually subsystem specific and I tend not to
add a r-b for them because people might think I understand how they are
being used ;-)

But in this case, since I did recommend some tricks in those extra patches,
you can keep the tag for them.

Here's my disclaimer for all these patches:

***

Reviewed only from the tracing point of view, I have no idea if the content
held in the trace is correct or not.

***

;-)

-- Steve
