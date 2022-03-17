Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479014DCA74
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 16:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236148AbiCQPvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 11:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236168AbiCQPur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 11:50:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60EF7173360;
        Thu, 17 Mar 2022 08:49:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 12BB1B81EF8;
        Thu, 17 Mar 2022 15:49:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C16C340E9;
        Thu, 17 Mar 2022 15:49:25 +0000 (UTC)
Date:   Thu, 17 Mar 2022 11:49:24 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Zhang Qiao <zhangqiao22@huawei.com>
Cc:     <paulmck@kernel.org>, <josh@joshtriplett.org>,
        <mathieu.desnoyers@efficios.com>, <jiangshanlai@gmail.com>,
        <joel@joelfernandes.org>, <rcu@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rcu: Use printk_deferred when holding rtp->cbs_gbl_lock
Message-ID: <20220317114924.791c6500@gandalf.local.home>
In-Reply-To: <20220317084726.77336-1-zhangqiao22@huawei.com>
References: <20220317084726.77336-1-zhangqiao22@huawei.com>
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

On Thu, 17 Mar 2022 16:47:26 +0800
Zhang Qiao <zhangqiao22@huawei.com> wrote:

> This patch tries to avoid this issue by using printk_deferred().

Isn't the new printk work suppose to resolve this?

If so, can we have another way to quiet these splats if that work is not in
yet?

-- Steve
