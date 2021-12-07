Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B452746BE04
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 15:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238104AbhLGOrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 09:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbhLGOrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 09:47:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D67BC061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 06:43:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0356CB817E9
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 14:43:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48F7DC341C3;
        Tue,  7 Dec 2021 14:43:32 +0000 (UTC)
Date:   Tue, 7 Dec 2021 09:43:30 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     John Keeping <john@metanate.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] tracing: make trace_marker{,_raw} stream-like
Message-ID: <20211207094330.578be88d@gandalf.local.home>
In-Reply-To: <20211207142558.347029-1-john@metanate.com>
References: <20211207142558.347029-1-john@metanate.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  7 Dec 2021 14:25:58 +0000
John Keeping <john@metanate.com> wrote:

> Resending as requested at [1].
> 
> [1] https://lore.kernel.org/all/20211207090347.15822d87@gandalf.local.home/

Thanks for resending. I added it to my queue so I will not forget it this
time. Expect it to show up in linux-next sometime this week or next, if it
doesn't fail any of my tests.

-- Steve
