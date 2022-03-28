Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAFBE4E91B9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 11:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239923AbiC1JuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 05:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239920AbiC1JuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 05:50:03 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A970A1F634
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 02:48:22 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id y7-20020a92d207000000b002c7f55e413bso7460749ily.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 02:48:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=sVvRetvU66viZg03zt42J481swUWQOVgkFgrLPfYY/8=;
        b=WubhmctCDjgAktRHergqhedIEZnqKdGlIMkAcH6fLa1LcNWnmqLbX5q9C8OXT+DIDS
         my2e2bOZkpc+rIJXqIK4Hhzt8LPFMEJXqP3eb988RO7jONQpwYHo6g7LfW8YTMXab6z7
         m4Q6e8S423fcqktd66z7KGf3BFY5JPRox/Sm+YXcg2nBzPcJgGSuUu6H4mLng52wqwYP
         RLgYFo0pMn3tbIyUvqGlX4zlkT4nfKNvTxuYCwrSA7ANZYLxknVbFdlWAU2iUtV1J3Yq
         ymSKB+bIHQTB6b+YvwIGZBrzQStbBWiDWR8QeGvO0nkTfrZMA5R3TvJz1JPtJZv/+tku
         Rtqw==
X-Gm-Message-State: AOAM5320lkNiH+hiz6ZWdSAqEQZlOTT6nAjN+0tj9bmelvlqCmugZC3U
        UQv2MATkIxj6J0wyUPnly987G9AChGQ8mYbyj6hqT5mE8dsg
X-Google-Smtp-Source: ABdhPJyzeX1qMoACO2pA8AueYO+lQlS5AXFOjsBz6huoRNJY9WSpaqdZ/pIq6qMIvI2Gw8vV55QNG/qPhoKV9A85R2g/iU+ap6CW
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1561:b0:2c8:3d92:ed52 with SMTP id
 k1-20020a056e02156100b002c83d92ed52mr5163039ilu.132.1648460902011; Mon, 28
 Mar 2022 02:48:22 -0700 (PDT)
Date:   Mon, 28 Mar 2022 02:48:22 -0700
In-Reply-To: <000000000000b960c00594598949@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007d99f705db443685@google.com>
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
