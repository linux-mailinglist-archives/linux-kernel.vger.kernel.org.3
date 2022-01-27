Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8844B49EEFE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 00:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343529AbiA0XvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 18:51:01 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:54846 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239508AbiA0Xu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 18:50:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AC9D7B82406
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 23:50:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7949C340E4;
        Thu, 27 Jan 2022 23:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643327457;
        bh=xIdvFp3LBwgn4wJ9GDWHiR4IU9aueEb48dg7lbkhzho=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=dmN9YxRRf1cpAqFdSFaYBGwExZH7CJX6e3YP5HOmkgtJna3lC8BQWJpVT6OxcRR9i
         7PAvJo/P0A/ft9e4WxsZbZd2C7BCzuSq+vUrCs7/U0RWXlB6ub1TmrTqRJuJnLBZtz
         pPZNfyinNdLIusKCgqvqjDqC5Xxc63wHqb3ihzHaIY17WtMIAwv1wIXHLpfvJyL+WB
         5QrODokx2OBAF/2D+VcvjYOXgImRoElucwCbo35OW4zZOVzIse42Cw0If0izjpmZcc
         y16QYAhUgfh2OTTyPD0npPA9OC5KfoJ6Mi8Nr7eK2Noy4N2picodkT8WlHeV2quwjE
         9/zBgOvhoslOw==
Message-ID: <69cc939a8e410a700cbeca67ab9a31339830d22a.camel@kernel.org>
Subject: Re: [PATCH 0/7]  tracing: Misc bugfixes
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 27 Jan 2022 17:50:54 -0600
In-Reply-To: <20220127182616.10a0db27@gandalf.local.home>
References: <cover.1643319703.git.zanussi@kernel.org>
         <20220127182616.10a0db27@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-01-27 at 18:26 -0500, Steven Rostedt wrote:
> On Thu, 27 Jan 2022 15:44:14 -0600
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > Hi Steve,
> > 
> > This is an assorted bunch of bugfixes addressing a bugzilla bug,
> > smatch warnings, and related things I found while fixing those.  In
> > particular, when looking at the bugzilla bug,
> > https://bugzilla.kernel.org/show_bug.cgi?id=215513, I noticed that
> > the
> > err_log output looked truncated and looking further into it found
> > that
> > it was, because the hist trigger command was very long, exceeding
> > the
> > 256 character limit.
> > 
> > Obviously that's too short, and the final 3 patches remove that
> > limitation.
> 
> Thanks Tom,
> 
> I'm going to run all of them through my tests, but I'm only going to
> push
> the first 4 to Linus for rc, and the limitation limit can wait till
> the
> merge window.
> 

OK, sounds good, thanks.

Tom

> -- Steve

