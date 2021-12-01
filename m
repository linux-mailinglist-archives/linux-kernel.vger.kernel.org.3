Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3CA1464F87
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243406AbhLAOY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:24:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbhLAOY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:24:26 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87480C061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 06:21:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D4EAECE1EDF
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 14:21:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83747C53FCC;
        Wed,  1 Dec 2021 14:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638368462;
        bh=Ouevf41jT2iUhXaxxBH4RNXRVn5ISJXvg6IvzTtexgU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZRAdIxPQ921S/OTObPZ4b6Xkc7hoWpbufQWdwET4xF61NCLjWBpJsMpZyCQdoBzE9
         dtKxQvf+r3K0/jmDDtINvRxXOYbVhx9hZFyVNZpeCLT7T61OnJ2FuxWdI3SENy3Zuk
         KG1SHKCdnl0m5LFQ71neGYNP72zKwU2nBZMblqxo=
Date:   Wed, 1 Dec 2021 15:20:59 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Peter Hurley <peter@hurleysoftware.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] tty: vt: make do_con_write() no-op if IRQ is disabled
Message-ID: <YaeEy2xZ9D0qm6iQ@kroah.com>
References: <20211116144937.19035-1-fmdefrancesco@gmail.com>
 <1825634.Qa45DEmgBM@localhost.localdomain>
 <44d83e9c-d8c9-38bf-501c-019b8c2f7b5e@i-love.sakura.ne.jp>
 <1701119.OD4kndUEs1@localhost.localdomain>
 <1d05e95c-556a-a34c-99fd-8c542311e2dd@i-love.sakura.ne.jp>
 <3add7ade-9c9b-2839-5a0c-0a38c4be0e34@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3add7ade-9c9b-2839-5a0c-0a38c4be0e34@i-love.sakura.ne.jp>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 10:40:38PM +0900, Tetsuo Handa wrote:
> What do you think? Can we apply this?

It would be great to get others to review it, but it's still in my
queue, I'll get to it "soon"...

thanks,

greg k-h
