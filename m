Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 192DA476895
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 04:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233316AbhLPDTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 22:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbhLPDTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 22:19:01 -0500
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1725C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 19:19:00 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 044F6C009; Thu, 16 Dec 2021 04:18:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1639624738; bh=s+fx+bruXJeydL1QTb8IGZ53fz9mTnNGIB/hREZpEfg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QACN2gvY3gayoXy4lRNyGvIemPv+PqDgYi/Lk9C98I1f2N7iGRXdevfYVBfJpb/pZ
         UoIQndOzEhyUma34O8KDnWLegn5//6qC2CfwuDXEIk+kxfguyUKXQaKn+uNJOlwn3+
         Nk0zktONnkVk0AcO0i1aUsrXeResyNNqaaDxFSG9b18pg0UeGqQ3OrwrWyiuR6X0Je
         p67GdVuizD8TeLp4J53fMDCPN13u4PjhbijM8VnXd61MFg9PWc76n9QjWYkFyOfzw8
         areWfw9gVoPvF4ywPc5Vqw8JE+1+XqOyuty/+hYALRUtvjRtiJbj+lZeJxRE3rFADq
         XnS2E66Yb1JpQ==
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on nautica.notk.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=UNPARSEABLE_RELAY
        autolearn=unavailable version=3.3.2
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 33519C009;
        Thu, 16 Dec 2021 04:18:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1639624737; bh=s+fx+bruXJeydL1QTb8IGZ53fz9mTnNGIB/hREZpEfg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l/infRQJ2MJQpAhi+Qt7jII0AAYTQUP0GRZVKfCWSFPdXuBuA9LDw3xW80PXzRvl2
         Fcm3BuRGNLwxxXlFR8P1kXlgNTNJh6WQmhUveppjLlCyipZv40M+TEJ8aYNMgbX8dX
         L+/EPusQataVT0xNLR5iTGey8ArPw7MYfbVoKPKi4c503TydT5MLml8D7jkuIIoG9l
         cMk3BaTUTWzh3ZpIXbQkRWQWQDI5pQGxf6vf6pooQSc29F3DTbWKxVJfcRHyOAuGD0
         jwwpwxC93bDAM0sgH55ZCS9yZMG55EMJvczf2czeMj4G/sPpN8p6nAn0YPFe39L6Yx
         JufPIobzZG0Uw==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id c0a18cb1;
        Thu, 16 Dec 2021 03:18:51 +0000 (UTC)
Date:   Thu, 16 Dec 2021 12:18:36 +0900
From:   asmadeus@codewreck.org
To:     zhuxinran <zhuran@mail.ustc.edu.cn>
Cc:     ericvh@gmail.com, lucho@ionkov.net, davem@davemloft.net,
        kuba@kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio: fix spelling error
Message-ID: <YbqwDPjapugTakhZ@codewreck.org>
References: <20211216030836.81989-1-zhuran@mail.ustc.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211216030836.81989-1-zhuran@mail.ustc.edu.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks for the patch.

A few comments below:
zhuxinran wrote on Thu, Dec 16, 2021 at 11:08:36AM +0800:
> Subject: virtio: fix spelling error

"virtio" is much more than this.
Have a look at previous commit messages for this file, something like
'9p/trans_virtio' would make a better component name.

(`git log net/9p/trans_virtio.c` to get git history for a single file)

> start my first kernel patch commit

This is not particularly useful for someone reading the git log, I'd
just remove this line.


I can do both changes on my end, but since you're learning it can also
be a good time to also see how to send a v2 (setting subject as [PATCH
v2], sending patch with in-reply-to)

I don't really mind either way, please let me know if you won't resend.

-- 
Dominique
