Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578FE524EC0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 15:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354668AbiELNuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 09:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354649AbiELNuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 09:50:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7255C18C5BD
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 06:50:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 01902B82834
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 13:50:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49A66C385B8;
        Thu, 12 May 2022 13:50:12 +0000 (UTC)
Date:   Thu, 12 May 2022 09:50:10 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Wang ShaoBo <bobo.shaobowang@huawei.com>,
        cj.chengjian@huawei.com, huawei.libin@huawei.com,
        xiexiuqi@huawei.com, liwei391@huawei.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will@kernel.org, zengshun.wu@outlook.com,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [RFC PATCH -next v2 3/4] arm64/ftrace: support dynamically
 allocated trampolines
Message-ID: <20220512095010.7b34fc78@gandalf.local.home>
In-Reply-To: <20220512210231.f9178a98f20a37981b1e89e3@kernel.org>
References: <YmFXrBG5AmX3+4f8@lakrids>
        <20220421100639.03c0d123@gandalf.local.home>
        <YmF0xYpTMoWOIl00@lakrids>
        <20220421114201.21228eeb@gandalf.local.home>
        <YmGF/OpIhAF8YeVq@lakrids>
        <20220421130648.56b21951@gandalf.local.home>
        <YmJ/l4vJoEpFt68l@FVFF77S0Q05N>
        <20220422114541.34d71ad9@gandalf.local.home>
        <YmLlmaXF00hPkOID@lakrids>
        <20220426174749.b5372c5769af7bf901649a05@kernel.org>
        <YnJUTuOIX9YoJq23@FVFF77S0Q05N>
        <20220505121538.04773ac98e2a8ba17f675d39@kernel.org>
        <20220509142203.6c4f2913@gandalf.local.home>
        <20220510181012.d5cba23a2547f14d14f016b9@kernel.org>
        <20220510104446.6d23b596@gandalf.local.home>
        <20220511233450.40136cdf6a53eb32cd825be8@kernel.org>
        <20220511111207.25d1a693@gandalf.local.home>
        <20220512210231.f9178a98f20a37981b1e89e3@kernel.org>
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

On Thu, 12 May 2022 21:02:31 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> BTW, "what register is saved" can be determined statically, thus I think
> we just need the offset for checking (for fprobe usecase, since it will
> set the ftrace_ops flag by itself.)

I'm not against that API, but I guess it would be useful to see how it
would be used.

-- Steve
