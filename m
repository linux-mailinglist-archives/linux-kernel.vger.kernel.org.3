Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9156F488C8B
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 22:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237106AbiAIVZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 16:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232039AbiAIVZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 16:25:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7D4C06173F;
        Sun,  9 Jan 2022 13:25:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CEA3A60DBF;
        Sun,  9 Jan 2022 21:25:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2889C36AE3;
        Sun,  9 Jan 2022 21:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641763553;
        bh=L/paTrcUsrXaeUe0V0GPEPrSSn2bsBSIX9D3COqKh2Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dFQnUDMBv9ya2R9Lnp2kK3kp1OUjhyyBPE5n4LorweT7FgaUNta/9YBteBE2iRXGP
         tJv9CNMJu+pDhdG27sab2KqJbdoAWPd4PzFxajnIR/pRscps/Im6vEWNlirIN2WJJn
         e9+ntVAwwNDMFrAESH65beReVM9k9Q01WQ3hKmDbHxTzqI6CZMQM6MDmV4sd4PlYCb
         mfn8Ye5wn3LwJ3xU6Y1oBySQr+7fAGgQboQcEfHT75cYHe01BNsvAdnVRRtnrbMjSM
         VuDLfUfYMp2t/1qIK6AVjgbvR//XQ2kyXt4SxOPl6FKDYhG9pO8zW62meFYB4b1diU
         OdP+4D4CSYqEQ==
Date:   Sun, 9 Jan 2022 13:25:51 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/8] docs: consolidate sysfs-block into
 Documentation/ABI/
Message-ID: <YdtS3x0M1qFcN3R1@sol.localdomain>
References: <20211209003833.6396-1-ebiggers@kernel.org>
 <YcH1uxfdTRHIwl7Y@quark>
 <YdMQ6rfSZWSOLptA@quark>
 <YddiJFr+ba7Veh82@sol.localdomain>
 <65376e36-579b-76c4-0642-4582d6679914@acm.org>
 <ef487b83-a1cc-d8a5-8a45-d0fec5eed94b@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef487b83-a1cc-d8a5-8a45-d0fec5eed94b@kernel.dk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 09, 2022 at 10:01:11AM -0700, Jens Axboe wrote:
> On 1/7/22 1:58 PM, Bart Van Assche wrote:
> > On 1/6/22 13:41, Eric Biggers wrote:
> >> Jens, any reason you haven't applied this series yet?  It looks like you've been
> >> applying other patches.  To be clear, I've been expecting that this would go in
> >> through the block tree, rather than the docs tree.
> > 
> > We are close to the v5.17 merge window so this is not a good time for a maintainer to
> > apply a large patch series. If Jens does not reply I propose to repost this patch
> > series after the v5.17 merge window has closed (three weeks from now?).
> 
> I'm fine with it, but it should probably just go through the doc tree.

I think it makes much more sense for subsystems to be responsible for their own
documentation; that's why patch 8 in this series adds the block layer
documentation to the block layer MAINTAINERS entry.  Do you disagree with that?

- Eric
