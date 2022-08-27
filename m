Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E555A33DD
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 04:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345475AbiH0Cm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 22:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232623AbiH0Cm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 22:42:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF27CB1B9A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 19:42:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5DBF3B83372
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 02:42:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5B13C433D7;
        Sat, 27 Aug 2022 02:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1661568143;
        bh=BzQgisio9PtGCcXkP6DuXkomBdR80sxgQAzQlaTAU1Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sHwFlZW4Ka4JJJ0qfqwkfreNN7W0RFrnXYD8Aqg5cH8sTz5s65bTLdABtIV90ChZa
         dtKyubBf2GQVRkWcOwJRge7WRXG8vf02EbKITDgSFPmA5QYa5piHJ+GnJnbWi49Ak5
         IphbDCWqw6jVrqt0WuBENJC/jb0AGRXOjA6sWiCw=
Date:   Fri, 26 Aug 2022 19:42:22 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Hawkins Jiawei <yin31149@gmail.com>
Cc:     Anton Altaparmakov <anton@tuxera.com>, chenxiaosong2@huawei.com,
        linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        syzbot+5f8dcabe4a3b2c51c607@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] ntfs: change check order in ntfs_attr_find
Message-Id: <20220826194222.862bead1ae0a2483951884d3@linux-foundation.org>
In-Reply-To: <20220826123257.3826-1-yin31149@gmail.com>
References: <20220826122735.2690-1-yin31149@gmail.com>
        <20220826123257.3826-1-yin31149@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Aug 2022 20:32:57 +0800 Hawkins Jiawei <yin31149@gmail.com> wrote:

> > syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> >
> > Looks like it is improper check order that causes this bug.

um, what bug?

> Sorry for wrong command.
> #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

Please prepare a full changelog for the next version?  Describe the
user-visible runtime effects of the bug, describe what the code does
wrong and how the patch repairs it.

