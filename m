Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC6950BBE1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 17:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449491AbiDVPpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 11:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449520AbiDVPo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 11:44:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355D55DA39
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 08:41:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C794761F5C
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 15:41:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5979AC385A4;
        Fri, 22 Apr 2022 15:41:55 +0000 (UTC)
Date:   Fri, 22 Apr 2022 11:41:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <mingo@redhat.com>, <yj.chiang@mediatek.com>
Subject: Re: [PATCH v3 0/2] tracing: make tracer_init_tracefs initcall
 asynchronous
Message-ID: <20220422114153.113f4dac@gandalf.local.home>
In-Reply-To: <20220422092751.19386-1-mark-pk.tsai@mediatek.com>
References: <20220323152257.7871-1-mark-pk.tsai@mediatek.com>
        <20220422092751.19386-1-mark-pk.tsai@mediatek.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Apr 2022 17:27:51 +0800
Mark-PK Tsai <mark-pk.tsai@mediatek.com> wrote:

> Could you please help to review this patch?
> Sorry to disturb you, I just want to make sure it has not been
> forgotten.

No problem. Sorry for not getting to it, but my queue is rather deep :-p

Hopefully I can get to it by next week. Feel free to remind me again in a
week in case you do not hear back from me. But it is in my local patchwork,
but so is a lot of other patches I need to review :-/

-- Steve
