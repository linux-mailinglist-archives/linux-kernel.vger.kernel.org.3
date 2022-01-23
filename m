Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2F1E496F96
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 02:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbiAWB5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 20:57:40 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:58448 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiAWB5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 20:57:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A7CD2CE0ACE;
        Sun, 23 Jan 2022 01:57:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BC61C004E1;
        Sun, 23 Jan 2022 01:57:34 +0000 (UTC)
Date:   Sat, 22 Jan 2022 20:57:32 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        linux-trace-devel@vger.kernel.org,
        Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: Re: [PATCH] docs: Hook the RTLA documents into the kernel docs
 build
Message-ID: <20220122205732.00053cd0@rorschach.local.home>
In-Reply-To: <877dau555q.fsf@meer.lwn.net>
References: <877dau555q.fsf@meer.lwn.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jan 2022 17:00:33 -0700
Jonathan Corbet <corbet@lwn.net> wrote:

> The RTLA documents were added to Documentation/ but never hooked into the
> rest of the docs build, leading to a bunch of warnings like:
> 
>   Documentation/tools/rtla/rtla-osnoise.rst: WARNING: document isn't included in any toctree
> 
> Add some basic glue to wire these documents into the build so that they are
> available with the rest of the rendered docs.  No attempt has been made to
> turn the RTLA docs into proper RST files rather than warmed-over man pages;
> that is an exercise for the future.

Looks fine to me.

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
