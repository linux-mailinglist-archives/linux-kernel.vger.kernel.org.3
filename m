Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAE74843A2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 15:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234353AbiADOps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 09:45:48 -0500
Received: from kylie.crudebyte.com ([5.189.157.229]:48523 "EHLO
        kylie.crudebyte.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232956AbiADOpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 09:45:47 -0500
X-Greylist: delayed 1425 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Jan 2022 09:45:46 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=WwK65ni++ZGQq053J7LdvQiiamQQFfjhXrULcJgBdc8=; b=GzVQUQZcKWO03I/MOO+y53hJye
        yyyzH+qYi8Hx7z5v+ngiE2osdz5J+DZ07BDoPxkgL/mqtQk90O2Sz2YQcarq/Zau0Wf2P3OhwJA1S
        iR+Hp4ruMal3wyETnhL2OmevVbFQtxywtxr36HFresyimnZNbzLUwdnAdjlhbtcjwsc4izNe13XO2
        weO5OIC1a/Ag3qew+d/fq3dncCmNN01GRt3cSuVmZ3569shieFO8cmVqo4FWWR1w4yJjDD5zIzywl
        1JpIQgO8jxDz5R9Up4N0oWRz4wHrxMWLWHI6piplzias56i74gvuYAy5ziSiHZtdf/F1cBobzOx40
        mB85YWcl8rKdMz3MOzPR1QBG0IthE/7D3zKvnHxkxPsTbcrgu5Q5zXMeUDHFM9D7alPt6sHPaj652
        XLJUjZKtEHTbt4kE4H2tYDI2bqXxjCJrBTTE+4rnsEmuogWeWEM8MCdBtnT3ZgwQh56s4j+ZRd183
        bt39jPxazQ5Tu+GtXwSJar1LviQxZ+kCym6k2rnUFnBPeOgjNsmulXFR3ThOh2IaM8Txl8G3ubirW
        U9kzN7AAg1czIzKxS8NaDRnGjvP9TdQGsWFu9DP2fzNoCrHEYxhH/cVX8IM25jKjB2FP8/rpqNM9K
        AHB8G6KMcXL85QJF2oguVBPuukFEAg4dq4Ka+dvyg=;
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>, Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] 9p: add myself as reviewer to MAINTAINERS
Date:   Tue, 04 Jan 2022 15:21:57 +0100
Message-ID: <2284086.ouBcKq9vr7@silver>
In-Reply-To: <YdRQWtQNO/DA02VW@codewreck.org>
References: <E1n4jXv-000445-GK@lizzy.crudebyte.com> <YdRQWtQNO/DA02VW@codewreck.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Dienstag, 4. Januar 2022 14:49:14 CET Dominique Martinet wrote:
> Christian Schoenebeck wrote on Tue, Jan 04, 2022 at 01:53:59PM +0100:
> > Volunteering as reviewer for 9p patches. As I am quite familiar with the
> > 9p code base in the Linux kernel already, plus being current maintainer
> > of 9p in QEMU this move probably makes sense.
> 
> There honestly isn't much coming in, but it'll be a pleasure to have you
> help when you can, I'll push this to Linus with other 5.17 changes in a
> couple of weeks :)

I know, it is the same with 9p on QEMU side. But I felt you were currently the 
only person providing service at this end, so I thought a bit of help might 
not hurt.

> I didn't reply to your series for bigger msize, I doubt I'll have time
> to do any useful tests for it this round but I'm thinking of taking the
> first patch first now as it makes sense independantly.

Sure!

> I feel that the rest needs more attention and will be for next cycle,
> sorry for the delay

Yeah, that code definitely still needs some decantation time. No rush. Maybe 
some other people find some time for review or testing in the meantime.

Thanks Dominique!

Best regards,
Christian Schoenebeck


