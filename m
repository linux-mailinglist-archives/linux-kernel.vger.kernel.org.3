Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E62B532F93
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 19:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239841AbiEXRYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 13:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234115AbiEXRYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 13:24:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430E67CB55
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 10:24:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF6336140D
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 17:24:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC463C34100;
        Tue, 24 May 2022 17:24:35 +0000 (UTC)
Date:   Tue, 24 May 2022 13:24:34 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yuntao Wang <ytcoode@gmail.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing: Deal with error return code of the
 ftrace_process_locs() function
Message-ID: <20220524132434.3cf03936@gandalf.local.home>
In-Reply-To: <20220120065949.1813231-1-ytcoode@gmail.com>
References: <20220119095741.1fff2305@gandalf.local.home>
        <20220120065949.1813231-1-ytcoode@gmail.com>
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

On Thu, 20 Jan 2022 06:59:49 +0000
Yuntao Wang <ytcoode@gmail.com> wrote:

> The ftrace_process_locs() function may return -ENOMEM error code, which
> should be handled by the callers.
> 
> Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
> ---
> Changes since v1:
> - Deal with error return code instead of just removing it
> 
> 

Thanks, I added this to my queue. Note, I renamed the subject to start with
"ftrace:" instead of "tracing:" as this is specific to ftrace (the function
hook infrastructure).

-- Steve
