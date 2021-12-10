Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFED470736
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 18:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241246AbhLJRfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 12:35:19 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:44918 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236018AbhLJRfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 12:35:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9DE32B8291B
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 17:31:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DAFFC00446;
        Fri, 10 Dec 2021 17:31:39 +0000 (UTC)
Date:   Fri, 10 Dec 2021 12:31:37 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jeff Xie <xiehuan09@gmail.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, mingo@redhat.com,
        Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH v6 0/5] trace: Introduce objtrace trigger to trace
 the kernel object
Message-ID: <20211210123137.004df316@gandalf.local.home>
In-Reply-To: <CAEr6+EDZ5vZyTkA3XCO3u76sY7SpZEV2nhLiY4MPL_BuFQDi0A@mail.gmail.com>
References: <20211129164951.220511-1-xiehuan09@gmail.com>
        <CAEr6+EDZ5vZyTkA3XCO3u76sY7SpZEV2nhLiY4MPL_BuFQDi0A@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Dec 2021 00:55:31 +0800
Jeff Xie <xiehuan09@gmail.com> wrote:

> hi Steve and Masami,
> 
> I really don't know what else I can do to enhance this patchset, if
> this idea is really valuable and
> can play its role, it may need the help of you or other developers ;-)

Hi Jeff,

I've been very busy with other things, but I may have time soon to look at
your patch set. After I get a chance to play with it, I'm certain I will be
coming back with some more comments ;-)

Sorry about the delay, but my day job got in the way :-p

-- Steve
