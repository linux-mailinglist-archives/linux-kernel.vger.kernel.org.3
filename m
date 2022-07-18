Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91226577A38
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 06:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbiGRE67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 00:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbiGRE6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 00:58:54 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1134F25D7;
        Sun, 17 Jul 2022 21:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=W66coHcVdjK50SJBSuDMbFx2/ta/bas/nj0lKOZUgsY=; b=sxiN0G5WAm3RnA2kEZVH04D2/t
        DavaD2WsQTBonXYIWFGQjiaPXjOpXRsxV+w/bIwwt/6TftC+UPgA0h1AgCxkIVfumzVyb6HeMgCkd
        vK3sMcUBVvp3n9AQqit0pg6on0jZWA3cZ9K1DiXAhLD6BG1z3spqVLq4IAjQXOZ6+wQlKiynodZxi
        knQ8OBOhVJ+ojPaZ2O97N9pclF7/EilHOaNSf+Nwx5cFBGkESXQYtItEy+HeQSOTSdL8ogqtuSsvQ
        MqIHfHVunxzMoBGETmnemA/vxJZwwgnzRXvvFTGwF4XOU6TbKbcye70lZaxpLDC2BjykZL/0fy2IC
        99nB/5Iw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oDIq4-00D8QI-9b;
        Mon, 18 Jul 2022 04:58:36 +0000
Date:   Mon, 18 Jul 2022 05:58:36 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the block tree with the vfs tree
Message-ID: <YtTofKIkWU4eXvoK@ZenIV>
References: <20220714120840.1e1f8c63@canb.auug.org.au>
 <0904ae71-972f-f183-f295-bce3b8518fcf@kernel.dk>
 <YtC6SUmyaCSKe2HX@ZenIV>
 <YtC9AgqezKXuUoy6@ZenIV>
 <20220718125932.1ab89122@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220718125932.1ab89122@canb.auug.org.au>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 12:59:32PM +1000, Stephen Rothwell wrote:
> Hi Al,
> 
> On Fri, 15 Jul 2022 02:04:02 +0100 Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Fri, Jul 15, 2022 at 01:52:25AM +0100, Al Viro wrote:
> > 
> > > Ones from Keith's branch - #alignment-fixes-rebased in there.  Looks like
> > > one of the commits in it got changed since then - the difference in
> > > __bio_iov_iter_get_pages() (unsigned int i initialization).
> > > 
> > > Sigh...  I'll rebase on top of that.  
> > 
> > Rebased and pushed out (with copy_pipe_to_iter() fix folded in as well)
> 
> BTW, these still cause a conflict.  As long as you are sharing patches
> (and then adding changes to the same areas), there will be conflicts.
> You need to share commits i.e. a shared branch.

Sigh...  That was (and is) a branch form Keith's tree.  Commits in block
tree are, AFAICS, cherry-picked from it, with lore links and Jens' s-o-b
added.

I'm fine with using that, just tell me how to refer to the branch in
question.  Jens?
