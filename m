Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D26530D7D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 12:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbiEWJwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 05:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233552AbiEWJwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 05:52:15 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D301B34655
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 02:52:14 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id z10-20020a056e0217ca00b002d1a8674f81so1793959ilu.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 02:52:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=sVvRetvU66viZg03zt42J481swUWQOVgkFgrLPfYY/8=;
        b=EADydLnNT/nrZC9gxVjvw50Ccu3WtQ4Ytas2xxlbDWzRnphR+I/oCxNGH1o4Z42nJZ
         8/p6G+0GsXrmQ4i1jPmzcsDaJB+JnBemgFfk0Lxmt+4MdzOY4JIf0aujICpPoIUOe/du
         VsrT1IfOCnHMfvABi4rTScLcyfGzST1wbmDXjVz/819qAXlJ1dLkHpiPYaPekiR14NzF
         9IulDVQ9YAda6oVMCu8IyztstPxi5x+NYkuEohC88GyeaYafY2EE9qmAtpu2163X2ipG
         6ap/3AgofEAfdekZQorDVF/3VujfqZxv7BVSwHvsufomwSY1sqO5xOurfLi9WqJIRyb2
         KIBg==
X-Gm-Message-State: AOAM531B1lDKS3GCoo7ussAkqMdZbO47mvyIISq3aO0SnX7s2KgVtOTT
        LSQpgN8eVdFCf/ll5Jd54725vueWGzeXWTVh0TdfwBdDa3pJ
X-Google-Smtp-Source: ABdhPJyBawQvEWj+lTvgzmvc4lAf6KnVY19vIJFpJz7USDyprdxNu8Vi1MmNjhxvac1AWz6gU1x4Q9cbsnNbmF4BtY1R8C9sXxo+
MIME-Version: 1.0
X-Received: by 2002:a05:6638:218b:b0:32e:9612:109e with SMTP id
 s11-20020a056638218b00b0032e9612109emr8554181jaj.192.1653299534264; Mon, 23
 May 2022 02:52:14 -0700 (PDT)
Date:   Mon, 23 May 2022 02:52:14 -0700
In-Reply-To: <000000000000b960c00594598949@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000727d7305dfaacb8d@google.com>
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
