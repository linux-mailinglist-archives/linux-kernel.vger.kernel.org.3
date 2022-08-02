Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAECA588435
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 00:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236225AbiHBW10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 18:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236103AbiHBW1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 18:27:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FD94D4F0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 15:27:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A16596027A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 22:27:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB00EC433C1;
        Tue,  2 Aug 2022 22:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659479241;
        bh=wummr1yc3t+WGHLllB14nPXUwVQfhdK2VDwX170BN28=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G3UymtLLWvAGmiesQ7iTGvUK+cIOcQqKNkgfP92e5TQwlHDx67uwyY2mmcKXExaH4
         KvcNHmyEBowwTjOxFWqQEoYltftHfR/+9XyU3mCE3RF2IpF/ycCEE1az9aOarLC7o2
         2CIcpQS20FvPKNZbB3TX4ioulrgMCDBqc3Y8stVo/VzkX7BCjzZTTfbt3vsaKBfD6p
         G3eo68VZfY3kqSzpczukzzztBJi0klIYzVY6QkJMAMHyNVsJrp2J7c5/J0PpnLu4CV
         f/B8KUhuusEBYrsznz1qnSVwCSI6kf0oU3Z3iEXnv0EzWjQHxjOIQvL8x8WHovEAa7
         QTymMsDksFtRw==
Date:   Tue, 2 Aug 2022 15:27:19 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     syzbot <syzbot+c70d87ac1d001f29a058@syzkaller.appspotmail.com>
Cc:     code@siddh.me, hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KASAN: use-after-free Read in post_one_notification
Message-ID: <Yumkx4Nc5ZyPGYMz@sol.localdomain>
References: <20220801103533.972-1-hdanton@sina.com>
 <000000000000c7a83905e52bd127@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000c7a83905e52bd127@google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2022 at 03:54:09AM -0700, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch and the reproducer did not trigger any issue:
> 
> Reported-and-tested-by: syzbot+c70d87ac1d001f29a058@syzkaller.appspotmail.com
> 
> Tested on:
> 
> commit:         3d7cb6b0 Linux 5.19
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> console output: https://syzkaller.appspot.com/x/log.txt?x=14066d7a080000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=70dd99d568a89e0
> dashboard link: https://syzkaller.appspot.com/bug?extid=c70d87ac1d001f29a058
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Note: no patches were applied.
> Note: testing is done by a robot and is best-effort only.

It appears this was already fixed, so no need for any more activity on this bug:

#syz fix: watchqueue: make sure to serialize 'wqueue->defunct' properly

- Eric
