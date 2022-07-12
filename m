Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109C6570F26
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 03:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbiGLBAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 21:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiGLBAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 21:00:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43880286C9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 18:00:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D148761515
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 01:00:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69516C34115;
        Tue, 12 Jul 2022 01:00:02 +0000 (UTC)
Date:   Mon, 11 Jul 2022 21:00:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     sunliming <sunliming@kylinos.cn>, ast@kernel.org, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, kelulanainsley@gmail.com,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] fprobe/samples: make sample_probe static
Message-ID: <20220711210000.72f33dad@gandalf.local.home>
In-Reply-To: <20220606234310.b0f893ee35c0106e414bd67f@kernel.org>
References: <20220606075659.674556-1-sunliming@kylinos.cn>
        <20220606234310.b0f893ee35c0106e414bd67f@kernel.org>
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

On Mon, 6 Jun 2022 23:43:10 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Looks good to me. Thanks for the fix!
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Applied, thanks sunliming and Masami!

-- Steve
