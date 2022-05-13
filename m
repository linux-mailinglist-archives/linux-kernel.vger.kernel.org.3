Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D66526543
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 16:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381469AbiEMOxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 10:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380904AbiEMOxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 10:53:09 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA1412AAD
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 07:53:07 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id g11-20020a056e021a2b00b002cf48b48824so5288512ile.21
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 07:53:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=7H0qJwccz26dzfND8qlLgtRHfjrbwIU4SUmx+OhmOw0=;
        b=GN8WPowgUyHkExg816qirJqUTySB7hJiwuXum0CVKmyZ1PzcWOoA512c+MySLihLfi
         bszJzjVW1y167gKh3L6ZJ3Fd4XNFHxkBDd8sl5Ftgw89t+gLcgX1Ghm0MT15lRUV1Yyk
         A/i6M1DS0hhTxjagg+7bKvsf713j7LvOoRyPnfF4hpTniwNqGxoONL09h3u/FQMxyjvg
         JH6x5bCAZyfk2GO0yqWFogMnivWKzX11aAxqUaY5ctZ3RVrXXdTDGyeHze/7VhSob6zT
         X3qsWIl0fhGRPstc5MAlsdRrHuOzYme+sxB23FKZdRMZIVDUTPlQ7sPQRuui1TpMtRoP
         lZ7w==
X-Gm-Message-State: AOAM5324T+MRVBUzCjVZvzKxaHXYyYbHrg/k02SXyYJrQ2fA6apVR4Wq
        boOs5DIrUqGi+pOBU1YQn0YyvzgKzakEATyWAQvWnL4VD8Cr
X-Google-Smtp-Source: ABdhPJzfdFoA38oG5zq2whww/w36LTBhTSTIV1Z1pEThUzuc+n5pc4T2YlW1YMJdW1TZDt+s1F6yzrWWxYGaK7O+npk4fYuRP9t8
MIME-Version: 1.0
X-Received: by 2002:a02:a68d:0:b0:32a:f755:821f with SMTP id
 j13-20020a02a68d000000b0032af755821fmr2685468jam.185.1652453587275; Fri, 13
 May 2022 07:53:07 -0700 (PDT)
Date:   Fri, 13 May 2022 07:53:07 -0700
In-Reply-To: <20220513142522.6514-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000013e6e505dee5d50d@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in anon_vma_interval_tree_remove
From:   syzbot <syzbot+dae32a647a56f4d153da@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+dae32a647a56f4d153da@syzkaller.appspotmail.com

Tested on:

commit:         187b9ac8 Add linux-next specific files for 20220512
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/
kernel config:  https://syzkaller.appspot.com/x/.config?x=1dcd4f4a77ca98a9
dashboard link: https://syzkaller.appspot.com/bug?extid=dae32a647a56f4d153da
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14a61221f00000

Note: testing is done by a robot and is best-effort only.
