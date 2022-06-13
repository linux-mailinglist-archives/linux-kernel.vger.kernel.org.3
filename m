Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A82CB54A13A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 23:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352031AbiFMVTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 17:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352015AbiFMVSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 17:18:06 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8C147060
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 14:00:45 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 39565C01D; Mon, 13 Jun 2022 23:00:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1655154043; bh=hbjlIsPkm7Pdw1vKt/fEMjXNUukRrKqZfsATzfBGdhI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aUclKhe0qUUXxJVj3as+72ZyUR2Mdt4qSYLf9TJPdVbqDzlPkitddPgzPxxC7T4M0
         ILx6q0v/NOVegp1C4dD/nxABDGhU7MqoFue+UZALvKJZdzBC6WGWdx0Ho9EdsuRlqr
         ptXjp7XPNwomOPNtQyaM/N+Otti4b6vZDbcbpxfx+5rG3zDVXWBkrsmfXixReV3O4b
         Lp7KEN2/IlVOcNN6fCCfdqpShAD1oNqcrVgK3v7oTfyBsEJrXzO1tEM/v3OrbXa8yg
         GZN6OtHSlkFBfikloQO/9d5m3ZgQgYlZRg+pgCdl5fk+JJ25YRLeGo+4RXbrtrX3iR
         cNPTTOPtWZYlQ==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 67266C009;
        Mon, 13 Jun 2022 23:00:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1655154042; bh=hbjlIsPkm7Pdw1vKt/fEMjXNUukRrKqZfsATzfBGdhI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xFktnS+NHA+NVGMei1DidQmfBeYBsl1yQecTuPCUxTmkNTgCiGsnrsFDvr9LVfBWJ
         qZ8gR8rqIdPe9IPllqYo9KS3S8+pLDE8m/KKH/RFrp4DPKaE7+J4syA2zJV7lRDY/Z
         byYBoa5nMq3LE7oHKCEO8bosF5fSAwoh9yNv2evr3hs8LC0/1euxRhBb2EKi5UZWQx
         VsE5pxM77qWoZn34VzKH91rX/5J2pBuHeSt5XNMvtVN2TCLv2MzNPPOpfwn5bmrQ90
         GDUhj2w7DdmFtWphQCJUAuFVU0oTUBnwaxN09sw0w3jqAx5GVL7hzxhu89Bf+vWiUS
         KCEx2zDqREJow==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id d2cce1e8;
        Mon, 13 Jun 2022 21:00:36 +0000 (UTC)
Date:   Tue, 14 Jun 2022 06:00:21 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     Christian Schoenebeck <linux_oss@crudebyte.com>,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/06] fid refcounting improvements and fixes
Message-ID: <YqelZWe4BJfDkYEd@codewreck.org>
References: <20220612085330.1451496-1-asmadeus@codewreck.org>
 <20220613202053.GI7401@sequoia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220613202053.GI7401@sequoia>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tyler Hicks wrote on Mon, Jun 13, 2022 at 03:20:53PM -0500:
> On 2022-06-12 17:53:23, Dominique Martinet wrote:
> > @@ -222,7 +221,8 @@ static struct p9_fid *v9fs_fid_lookup_with_uid(struct dentry *dentry,
> >                  * We need to hold rename lock when doing a multipath
> >                  * walk to ensure none of the patch component change
> >                  */
> > -               fid = p9_client_walk(old_fid, l, &wnames[i], clone);
> > +               fid = p9_client_walk(old_fid, l, &wnames[i],
> > +                                    old_fid == root_fid /* clone */);
> 
> This is no problem at all. The rebased patches look good to me. Squash
> your fix to my fix and it should be ready to go.

Thanks for all your reviews :)
I've rebased my branch if you want to check:
https://github.com/martinetd/linux/commits/9p-next

We've just started a cycle so I'll submit the first three patches (fixes
to stable) next week, and the rest for when 5.20 cycle starts.
Feel free to remind me if it looks like I forgot.
-- 
Dominique
