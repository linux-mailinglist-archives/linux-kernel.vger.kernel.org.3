Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE5E54A1F1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 00:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234939AbiFMWLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 18:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbiFMWLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 18:11:47 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C28B205DF
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 15:11:45 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id D6197C009; Tue, 14 Jun 2022 00:11:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1655158302; bh=Ux/4hT39c14afeoew7+c9hXnBH4Wop2/T43c8QUzsXE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=3MtmjjnW/1Y+i6EFALMsGOv6GfF2dSqFOyZoeJvzGxVBIvRudwj8YIKRzJveL5GMu
         2MAy7S+5LT9dNvm0JsDLy0iO5CANeWwe1wlnhuqR9/Gd++UEQTmj2znYka9o/BS/ca
         FbJsQIPh4aGwFjELvjZOm/pDVBHLktrC8GgQvfxQhGN2fT9PO5TY6RMJo1TBXavJlm
         0docKaQFwaFt0b4KJx2yOWpEtENC6Bj+H9XL/tez/m1kcErCGO16xmor3nJlRW6+PS
         J0IOIRsX+RdgA482DF7/leFBggU79O8ywcTh3S0m5Fzz7BP+3EX6kYVMX2ZsZ8avhl
         ZucXbIv1ioS1Q==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 8156BC009;
        Tue, 14 Jun 2022 00:11:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1655158302; bh=Ux/4hT39c14afeoew7+c9hXnBH4Wop2/T43c8QUzsXE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=3MtmjjnW/1Y+i6EFALMsGOv6GfF2dSqFOyZoeJvzGxVBIvRudwj8YIKRzJveL5GMu
         2MAy7S+5LT9dNvm0JsDLy0iO5CANeWwe1wlnhuqR9/Gd++UEQTmj2znYka9o/BS/ca
         FbJsQIPh4aGwFjELvjZOm/pDVBHLktrC8GgQvfxQhGN2fT9PO5TY6RMJo1TBXavJlm
         0docKaQFwaFt0b4KJx2yOWpEtENC6Bj+H9XL/tez/m1kcErCGO16xmor3nJlRW6+PS
         J0IOIRsX+RdgA482DF7/leFBggU79O8ywcTh3S0m5Fzz7BP+3EX6kYVMX2ZsZ8avhl
         ZucXbIv1ioS1Q==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 5e5af06f;
        Mon, 13 Jun 2022 22:11:36 +0000 (UTC)
Date:   Tue, 14 Jun 2022 07:11:21 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: bad commits in the v9fs tree
Message-ID: <Yqe2CT0whmf8mYLj@codewreck.org>
References: <20220614075223.5c2ea764@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220614075223.5c2ea764@canb.auug.org.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell wrote on Tue, Jun 14, 2022 at 07:52:23AM +1000:
>   04608d78b66c ("Linux 5.19-rc1")
>   9383b9134c66 ("fix the breakage in close_fd_get_file() calling conventions change")
> 
> look like they were rebased or cherry-picked from Linus' tree.from
> Linus' tree.  From commits f2906aa86338 and 40a1926022d1 respectively.

Ugh, thank you for noticing.
I had an overly eager `rebase -i` that are usually noop and don't touch
the top patches if left alone, but that only works if no merge is
involved and that wasn't the case here -- I'll be more careful with my
rebase root from now on so it hopefully won't happen again.

Fixed my 9p-next branch so these two should be gone next time you
update.


Thanks,
-- 
Dominique

