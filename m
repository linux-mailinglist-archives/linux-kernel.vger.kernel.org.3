Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31733467937
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 15:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381383AbhLCOSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 09:18:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352612AbhLCOSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 09:18:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F095C06173E
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 06:14:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0C958B8272C
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 14:14:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 394A6C53FC7;
        Fri,  3 Dec 2021 14:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638540873;
        bh=v59ThzrQR/E+1jWqDwNoI8yFOz1/2zQOK8rBUFsUf78=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EXwfjp8IaVILiahinc6Cg76eh0RncqnxmNtFczEj858OKdZBfHHdDuIa3hkwxf9j+
         RedHdhVJyAj01SjTWy0ldmNPjz+5X7Wpq5/fNxF9uKEVyP0gqFO6Qvq8ChQMc+7quU
         NxP6cvPflcs4B9HhQMTnli8Qd1SAEOlZnXe+EFFg=
Date:   Fri, 3 Dec 2021 15:14:31 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Martin Kaiser <martin@kaiser.cx>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: r8188eu: use a delayed worker for led updates
Message-ID: <YaomR72ytUd9jmAt@kroah.com>
References: <20211125162513.25039-1-martin@kaiser.cx>
 <20211126114135.18228-1-martin@kaiser.cx>
 <20211129110427.GQ6514@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211129110427.GQ6514@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 02:04:27PM +0300, Dan Carpenter wrote:
> This was confusing becuase it should have been [PATCH 4/4 v2].  These
> days I think the prefered way is to just resend the whole series as a
> new thread.
> 
> Greg doesn't use patchwork, but these rules especially apply for
> subsystems which use patchwork.  People say that patchwork gets confused
> when people use the --in-reply-to option and I guess it's hard to
> apply individual patches in patchwork?  Anyway, just always start a new
> thread and resend everything.
> 
> Send a reply to the original thread to say "Don't apply this one, it has
> sleeping in atomic bugs", otherwise it might get applied by mistake.

I had already reverted that patch from my tree, so I would not have
applied it again :)

thanks,

greg k-h
