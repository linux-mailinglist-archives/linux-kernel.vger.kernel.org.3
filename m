Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3EC542395
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiFHEqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 00:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbiFHEpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 00:45:13 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EEB541BCD5
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 19:37:14 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id k4-20020a6b4004000000b006697f6074e6so1760373ioa.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 19:37:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=tu6aa+xwVDffbv/lJ0S+vousZDYtDSyBdQaifN5ohVA=;
        b=2B0Fah4CzRK2CIH1oessyva8EfU8VOa7g9taT/oD17YSTdmCGMRA/VetwW+yrcO2fH
         +yrUTi8Fn5K5q55vofgNDw8sE2jgd8bkI3nI4eHtfoXdavZXzM/6nfbBqNzbRTSLm5wi
         E4HI/97Nromjtc4JqeqB2Lzz6IsCgck0VoutvTnYmTGyBIQda5q/jdWDUbn3GKLfrPOu
         l7MQA3QLKeoCNHwFisLyyDxwUgYVcw4GhISnyFJ3NHjEACCy3S6OoDPNke2eWSf09pzz
         2Ro1w+AKOYLgAKYm4GCKjmWUd/PFT8W7AL6/3797KC1dX56/yop6zGnRuWEQpaOaXxpx
         KqoQ==
X-Gm-Message-State: AOAM531mgzEo2hq4f2nLiIrKKpnpRl4FyPhKZBghDdRi3ouQTmLnz3XM
        Qy1U1rCWHxGCL5YlLFqyoMa8qqgSyaFYAfxuNq1xPFa4zUqA
X-Google-Smtp-Source: ABdhPJwE6wCMlR17Kr99xZePUjVywNYrOFDkYbtuMs+ujjOcBdMnZ59NcK8fKjjsuQWikkqtEx1wq/n+YETlrRFEx6PJqAf+NEDy
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2513:b0:32e:5298:8264 with SMTP id
 v19-20020a056638251300b0032e52988264mr18072303jat.178.1654655833392; Tue, 07
 Jun 2022 19:37:13 -0700 (PDT)
Date:   Tue, 07 Jun 2022 19:37:13 -0700
In-Reply-To: <CACGkMEt_e59wRotUo9D1UqubAhe+txy0GF=r1BYBVdND8-uKbA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002cccbd05e0e69570@google.com>
Subject: Re: [syzbot] INFO: task hung in add_early_randomness (2)
From:   syzbot <syzbot+5b59d6d459306a556f54@syzkaller.appspotmail.com>
To:     herbert@gondor.apana.org.au, jasowang@redhat.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@dominikbrodowski.net, mpm@selenic.com, mst@redhat.com,
        syzkaller-bugs@googlegroups.com, xuanzhuo@linux.alibaba.com,
        yuehaibing@huawei.com
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

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file drivers/char/hw_random/virtio-rng.c
patch: **** unexpected end of file in patch



Tested on:

commit:         bd8bb9ae vdpa: ifcvf: set pci driver data in probe
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
dashboard link: https://syzkaller.appspot.com/bug?extid=5b59d6d459306a556f54
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15f814cff00000

