Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1842551F940
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 12:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233685AbiEIKD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 06:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238310AbiEIKA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 06:00:27 -0400
Received: from mail-io1-xd46.google.com (mail-io1-xd46.google.com [IPv6:2607:f8b0:4864:20::d46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B665E25EBE
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 02:56:33 -0700 (PDT)
Received: by mail-io1-xd46.google.com with SMTP id l3-20020a05660227c300b0065a8c141580so9589000ios.19
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 02:56:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=sVvRetvU66viZg03zt42J481swUWQOVgkFgrLPfYY/8=;
        b=zu1ePDW/3wtkNfLnNSE6fSwY/5pxpttmdu0be6efBBZ8PjB8Ugbt2PlYr1Mze8xBZs
         tW+FEINSsPFfIdA4vfFs2LMqJnkGzxx89xQgirTCmI7R/lev1sj5w0GZ7OrEHXgFKrgs
         N9VFGzBJV88ne65GwhHtaYAtoSw4CsllA4lHSZ08TpaYcuwY1KQtFDk/Ce56X6xK2yID
         RvBrHVbl77kc/wXvClQUgfoe509VF7wgF/htVNk/qciYMLKot7sqYDJqMP+3BUOnm8ai
         2LkRacFM6m5x+uCXzVnegDJ0WH7M8pPxVTm/mS0toR79lrtbr50lfEFx4JSVa6g7A14U
         0bKw==
X-Gm-Message-State: AOAM5300gWMTlpdO4GmvezjgdFDOX8IwkrPzP+9kNSILZ6ohuhrvpZyH
        55o7gIE4dLAYyyD7xvf2O5QjMZ2z+oqYcgKjou6k81+Q/c5z
X-Google-Smtp-Source: ABdhPJwC5VBYSGI1OjMKdjkjOz+1Jf91KSyPmT4fLRxn5GNtpWlrQsK1xGMcgqF/AQB1egQn9AWvukxzu2EVwgWTWtrdUyckeO2k
MIME-Version: 1.0
X-Received: by 2002:a92:bf06:0:b0:2c9:b21d:6db7 with SMTP id
 z6-20020a92bf06000000b002c9b21d6db7mr6241391ilh.222.1652089884479; Mon, 09
 May 2022 02:51:24 -0700 (PDT)
Date:   Mon, 09 May 2022 02:51:24 -0700
In-Reply-To: <000000000000b960c00594598949@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b3983c05de912629@google.com>
Subject: Re: KASAN: use-after-free Read in tc_chain_fill_node
From:   syzbot <syzbot+5f229e48cccc804062c0@syzkaller.appspotmail.com>
To:     davem@davemloft.net, gregkh@linuxfoundation.org, jiri@mellanox.com,
        lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        stable-commits@vger.kernel.org, stable@vger.kernel.org,
        syzkaller-lts-bugs@googlegroups.com, vladbu@mellanox.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This bug is marked as fixed by commit:
net: core: netlink: add helper refcount dec and lock function
net: sched: add helper function to take reference to Qdisc
net: sched: extend Qdisc with rcu
net: sched: rename qdisc_destroy() to qdisc_put()
net: sched: use Qdisc rcu API instead of relying on rtnl lock
But I can't find it in any tested tree for more than 90 days.
Is it a correct commit? Please update it by replying:
#syz fix: exact-commit-title
Until then the bug is still considered open and
new crashes with the same signature are ignored.
