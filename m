Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C103F589012
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 18:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238047AbiHCQUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 12:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235741AbiHCQUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 12:20:42 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E282A276
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 09:20:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E6787CE23C2
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 16:20:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E1FC433C1;
        Wed,  3 Aug 2022 16:20:34 +0000 (UTC)
Date:   Wed, 3 Aug 2022 12:20:32 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Li kunyu <kunyu@nfschina.com>, Li zeming <zeming@nfschina.com>,
        Linyu Yuan <quic_linyyuan@quicinc.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Slark Xiao <slark_xiao@163.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Xiang wangx <wangxiang@cdjrlc.com>,
        Zheng Yejian <zhengyejian1@huawei.com>,
        Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        sunliming <sunliming@kylinos.cn>
Subject: Re: [GIT PULL] tracing: Updates for 5.20 / 6.0
Message-ID: <20220803122032.3eae792a@gandalf.local.home>
In-Reply-To: <20220803112014.7ffed04e@gandalf.local.home>
References: <20220803112014.7ffed04e@gandalf.local.home>
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

On Wed, 3 Aug 2022 11:20:14 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> - Added __vstring() helper to the TRACE_EVENT() macro to replace several
>   vstring() usages that were all doing it wrong.

That was suppose to be "vsprintf() usages that were all doing it wrong".

-- Steve
