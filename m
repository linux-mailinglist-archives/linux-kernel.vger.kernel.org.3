Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2494577F17
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 11:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbiGRJzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 05:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiGRJzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 05:55:19 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA1F1A068
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 02:55:19 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id f2-20020a056e020b4200b002dca33f6243so7265262ilu.15
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 02:55:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=sVvRetvU66viZg03zt42J481swUWQOVgkFgrLPfYY/8=;
        b=baqXk1ScZV/V9xyIEMLgAOQrmR8wJ+PdWDO10WU0LoM6rmU+dWY/S7gFPk/1NU2Gzt
         XRI1eaAss/FFrurV1BM7eCIzdJ+fKLYnepRFnt7Flh42v6HilytpDGRPmLvfOSb2njAs
         +thRJw7Ss0q/zC9mW9QiEXIRvi3vRjOLlKX3aRQzHOS6tABtT+8ie9gqIH+XtfhMY7mu
         Vl5pZfdgGPBmUIUjfGWiEK5UlgIW0Q+tvUK7kP1Yi8DRSTkkX6jWuiuTMVGFUjBKPRrO
         ydHoJMWUJ9iW03I4j2tWvy0Qfkj3dh5VMPBxF+iegU0i2hffPIe6D3sewx2Ohb3VLkJY
         SghQ==
X-Gm-Message-State: AJIora+ACMerNz5zVZSg90xbfRm2VWHK72kARVlI0VizET/XLsm5bNwF
        FRa5xFjhRwoY6tIIbyVr8zIGNYyrgxr2LqGIXk4uPhC5+izS
X-Google-Smtp-Source: AGRyM1tjOLfBvvm7nGTYCcVlW2HANOvFx8kR+Gn8j61DGN7YaKfh74Nt6ZRq1hi82IY4dVO7cApfVF28nSoYzuFHZ/AVd95wggA5
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1407:b0:67b:c2ca:f8ef with SMTP id
 t7-20020a056602140700b0067bc2caf8efmr12012882iov.38.1658138118388; Mon, 18
 Jul 2022 02:55:18 -0700 (PDT)
Date:   Mon, 18 Jul 2022 02:55:18 -0700
In-Reply-To: <000000000000b960c00594598949@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008901a605e4115d97@google.com>
Subject: Re: KASAN: use-after-free Read in tc_chain_fill_node
From:   syzbot <syzbot+5f229e48cccc804062c0@syzkaller.appspotmail.com>
To:     davem@davemloft.net, gregkh@linuxfoundation.org, jiri@mellanox.com,
        lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        stable-commits@vger.kernel.org, stable@vger.kernel.org,
        syzkaller-lts-bugs@googlegroups.com, vladbu@mellanox.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
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
