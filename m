Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2F350A8CA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 21:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391786AbiDUTL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 15:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378558AbiDUTL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 15:11:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB354CD45
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 12:09:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 19B67B82870
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 19:09:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B79DC385A7;
        Thu, 21 Apr 2022 19:09:03 +0000 (UTC)
Date:   Thu, 21 Apr 2022 15:09:01 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     mingo@redhat.com, YueHaibing <yuehaibing@huawei.com>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ftrace: fix building with SYSCTL=y but DYNAMIC_FTRACE=n
Message-ID: <20220421150901.002a0083@gandalf.local.home>
In-Reply-To: <YmGo/TcNVzOK4Bjn@bombadil.infradead.org>
References: <YmGo/TcNVzOK4Bjn@bombadil.infradead.org>
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

On Thu, 21 Apr 2022 11:57:01 -0700
Luis Chamberlain <mcgrof@kernel.org> wrote:

> Ok so hopefully this is the last of it. 0day picked up a build
> failure [0] when SYSCTL=y but DYNAMIC_FTRACE=n. This can be fixed
> by just declaring an empty routine for the calls moved just
> recently.
> 
> [0] https://lkml.kernel.org/r/202204161203.6dSlgKJX-lkp@intel.com
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: f8b7d2b4c192 ("ftrace: fix building with SYSCTL=n but DYNAMIC_FTRACE=y")
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
