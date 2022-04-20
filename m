Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728E350939A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 01:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383219AbiDTXa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 19:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234304AbiDTXa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 19:30:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580812D1C5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 16:28:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1D36617ED
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 23:28:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9015AC385A1;
        Wed, 20 Apr 2022 23:28:08 +0000 (UTC)
Date:   Wed, 20 Apr 2022 19:28:07 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     YueHaibing <yuehaibing@huawei.com>, mingo@redhat.com,
        xiaowei66@huawei.com, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH sysctl-next] ftrace: fix building with SYSCTL=n but
 DYNAMIC_FTRACE=y
Message-ID: <20220420192807.75a70b44@gandalf.local.home>
In-Reply-To: <YlnpfHuZGC8H0iNZ@bombadil.infradead.org>
References: <YlnpfHuZGC8H0iNZ@bombadil.infradead.org>
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

On Fri, 15 Apr 2022 14:54:04 -0700
Luis Chamberlain <mcgrof@kernel.org> wrote:

> Steven,
> 
> As with the other fixes I can take this in through sysctl-next if you
> are OK with that, please let me know.

Honestly I would love to just nuke the ftrace_enabled sysctl, it's totally
obsolete. Perhaps I should have it trigger some kind of warning message
that it will be going away soon, and perhaps we can remove it?

Anyway, yeah, take this through your tree.

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
