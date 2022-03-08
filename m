Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47BA4D1F5C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348631AbiCHRqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:46:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbiCHRq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:46:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80AB053E3A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 09:45:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3375FB815E0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 17:45:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDC4BC340F4;
        Tue,  8 Mar 2022 17:45:28 +0000 (UTC)
Date:   Tue, 8 Mar 2022 12:45:27 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alexander Sverdlin <alexander.sverdlin@nokia.com>
Cc:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Abel Vesa <abelvesa@linux.com>, Rabin Vincent <rabin@rab.in>,
        Colin Cross <ccross@android.com>
Subject: Re: ftrace bug
Message-ID: <20220308124527.0ef9ca63@gandalf.local.home>
In-Reply-To: <1dec8992-b924-7ea2-8e45-a6bbc10a6086@nokia.com>
References: <9a86b2c9-1009-1683-442e-61c5a7dc8cf3@broadcom.com>
        <20220307082450.641ed866@gandalf.local.home>
        <62c01368-b67f-66af-2e31-d62f4df75b61@broadcom.com>
        <20220308102007.6c6618e7@gandalf.local.home>
        <1dec8992-b924-7ea2-8e45-a6bbc10a6086@nokia.com>
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

On Tue, 8 Mar 2022 17:02:53 +0100
Alexander Sverdlin <alexander.sverdlin@nokia.com> wrote:

> This problem is addressed by:
> 
> commit 8113e622926ef6590771ede0f7f64821e1751b67
> Author: Alex Sverdlin <alexander.sverdlin@nokia.com>
> Date:   Mon Sep 27 14:02:45 2021 -0700

Thanks Alex. I knew it was a good idea not to try to figure this out on my
own ;-)

-- Steve
