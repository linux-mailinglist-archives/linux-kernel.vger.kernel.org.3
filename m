Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491EF5334C4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 03:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243245AbiEYBej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 21:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbiEYBeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 21:34:36 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBB253B55
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 18:34:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A6CC0CE1D85
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 01:34:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 155DAC34116;
        Wed, 25 May 2022 01:34:28 +0000 (UTC)
Date:   Tue, 24 May 2022 21:34:27 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Wang ShaoBo <bobo.shaobowang@huawei.com>
Cc:     <cj.chengjian@huawei.com>, <linux-kernel@vger.kernel.org>,
        <liwei391@huawei.com>, <mhiramat@kernel.org>, <acme@redhat.com>,
        <yuehaibing@huawei.com>
Subject: Re: [PATCH 0/2] tools libtraceevent fixes
Message-ID: <20220524213427.1b0b837c@gandalf.local.home>
In-Reply-To: <20220513023308.2400381-1-bobo.shaobowang@huawei.com>
References: <20220513023308.2400381-1-bobo.shaobowang@huawei.com>
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

On Fri, 13 May 2022 10:33:06 +0800
Wang ShaoBo <bobo.shaobowang@huawei.com> wrote:

> tools libtraceevent fixes
> 
> Wang ShaoBo (2):
>   libtraceevent: fix memleak in make_bprint_args()
>   libtraceevent: fix free NULL pointer in parse_arg_add()

These fixes need to be sent to linux-trace-devel@vger.kernel.org, and
applied against libtraceevent:

  https://git.kernel.org/pub/scm/libs/libtrace/libtraceevent.git/

Arnaldo,

libtraceevent is now in most distros. Can we now deprecate the version in
the kernel as it is no longer actively maintained?

-- Steve


> 
>  tools/lib/traceevent/event-parse.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 

