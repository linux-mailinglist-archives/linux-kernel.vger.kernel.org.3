Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3237A50EE15
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 03:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240954AbiDZBaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 21:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236263AbiDZBaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 21:30:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DEC2120100
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 18:27:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4555D6171B
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 01:27:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E670BC385A7;
        Tue, 26 Apr 2022 01:27:08 +0000 (UTC)
Date:   Mon, 25 Apr 2022 21:27:07 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Chengming Zhou <zhouchengming@bytedance.com>, mingo@redhat.com,
        catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        dave.hansen@linux.intel.com, broonie@kernel.org, ardb@kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        songmuchun@bytedance.com, zhengqi.arch@bytedance.com
Subject: Re: [PATCH v5 1/2] ftrace: cleanup ftrace_graph_caller enable and
 disable
Message-ID: <20220425212707.378fb699@gandalf.local.home>
In-Reply-To: <YmZvF9jXQ6jRCkQn@FVFF77S0Q05N>
References: <20220420160006.17880-1-zhouchengming@bytedance.com>
        <YmZvF9jXQ6jRCkQn@FVFF77S0Q05N>
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

On Mon, 25 Apr 2022 10:51:19 +0100
Mark Rutland <mark.rutland@arm.com> wrote:

> Steve, are you happy if this goes via the arm64 tree along with patch 2?

Yeah, go ahead.

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
