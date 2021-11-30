Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5F7C462D85
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 08:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239045AbhK3Hek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 02:34:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232892AbhK3Hej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 02:34:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8943C061574;
        Mon, 29 Nov 2021 23:31:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 58549B80945;
        Tue, 30 Nov 2021 07:31:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC3E6C53FC1;
        Tue, 30 Nov 2021 07:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638257478;
        bh=Dzz5UOtIm6Dh1nxD0GKk8TkTHLgg6OhYd8STS3fq+aM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fHiU5guF8Vbl2DYexIdx8KdPWiEMIxuNY7iUY3yuapb3+PRkvWwC3Ow1w7sKpPoIA
         3Uwdc3jF3iiai4HeDIK8Iaj7CCCSl8x3KDCsnaC2AowI8/ubXxqfx8KBLlR4Jje9UK
         jB7zMtZcp+Zsjutze0RrRAyEtvzAHNhnE1+KhGkaYSpy6Bosv6nDS8FTvZpfQ10vuJ
         +/f3or2gvLtjC5ccNYsopoN+oP4h8VFbg/5FXOJaSYclKf0lcwYFGJz2mQdhK1U2Hk
         lOiQLrxCRfP16szJwZsV8lpdrx9e07C4D6earwfi/r9vvZ4hozlOxDAeur1u9alYv5
         OgOOOrP1s+Ifw==
Date:   Mon, 29 Nov 2021 23:31:16 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-mmc@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v2 3/3] blk-crypto: show crypto capabilities in sysfs
Message-ID: <YaXTRJO9Wbsh8n05@sol.localdomain>
References: <20211130040306.148925-1-ebiggers@kernel.org>
 <20211130040306.148925-4-ebiggers@kernel.org>
 <YaXPIYHg8Xnk1Lbh@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YaXPIYHg8Xnk1Lbh@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 08:13:37AM +0100, Greg Kroah-Hartman wrote:
> >  Documentation/block/queue-sysfs.rst |  30 +++++
> 
> Same objection as before.  Please add these to Documentation/ABI/

As I said before, this is where all the blk-sysfs stuff is documented currently.
If you consider this a hard requirement, then I'll get started on a patch that
moves all of queue-sysfs.rst into Documentation/ABI/, as it's silly to change it
for just this one and not the 23 other blk-sysfs attributes with exactly the
same issue.

> otherwise when running 'scripts/get_abi undefined' will show these new
> sysfs files you are adding as having no documentation :(

Perhaps this should be part of checkpatch?

- Eric
