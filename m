Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167415514EE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 11:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240363AbiFTJxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 05:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240520AbiFTJxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 05:53:18 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011E313E0A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 02:53:17 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id l7-20020a6b7007000000b00669b2a0d497so5886951ioc.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 02:53:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=sVvRetvU66viZg03zt42J481swUWQOVgkFgrLPfYY/8=;
        b=8JGZ8yVGyboTezioSluMTbHnTqiQ2vxE7GMERtM0Di+NHFbMc5FLUfBmkKReU0+Dm3
         1Bd/2/6HmWa/HsD46ur9c30NLfG8RVAhxfNRnUY4j8V4toY+eYk8Uygage+1e4wF197z
         pbdww0ZzlxB3/cgK35R1Efjflb8pxDBS8OrDl+Rard0U3rHH4JlxYJzCs9sDQo8od34+
         ya/fQQodDm2fv7y0FPeXVJL3Zf96nyBP9k/JK8WSqnYX9d6gOJFJQ7te+B1jkbA+naD4
         dm3iwrBzvsESVRP/e3mSnCXpRFhhJhdEz7YpLTPvWZTlG09ueoK3j/fyuSjVfdpS4kzR
         hwrQ==
X-Gm-Message-State: AJIora8kKSqTpH8LXXjU1zM2ASNc5ewBvsmmXXn5HCuINs+t/BnqwkgN
        L0p4/urhZ80x5WDYYqAhBUfwcn/lqjjAluFUa9qmpC5MsjvZ
X-Google-Smtp-Source: AGRyM1vNey1loZwui/9Tq4aWwQQLOriKBW5i8qao0kEqs7NYzyrA4LorjllZjbLpixAZkKEO66/vWR9A9eXPcRJkU41H3fEiqgUD
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1ba3:b0:2d8:d74b:8ff6 with SMTP id
 n3-20020a056e021ba300b002d8d74b8ff6mr10483467ili.264.1655718796419; Mon, 20
 Jun 2022 02:53:16 -0700 (PDT)
Date:   Mon, 20 Jun 2022 02:53:16 -0700
In-Reply-To: <000000000000b960c00594598949@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b5681705e1de1219@google.com>
Subject: Re: KASAN: use-after-free Read in tc_chain_fill_node
From:   syzbot <syzbot+5f229e48cccc804062c0@syzkaller.appspotmail.com>
To:     davem@davemloft.net, gregkh@linuxfoundation.org, jiri@mellanox.com,
        lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        stable-commits@vger.kernel.org, stable@vger.kernel.org,
        syzkaller-lts-bugs@googlegroups.com, vladbu@mellanox.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
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
