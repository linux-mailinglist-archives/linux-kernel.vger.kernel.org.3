Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C105048FC6D
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 12:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234997AbiAPLzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 06:55:13 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:39426 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbiAPLzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 06:55:13 -0500
Received: by mail-io1-f69.google.com with SMTP id p65-20020a6bbf44000000b00604c0757591so8645248iof.6
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 03:55:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=pcqghOLmFHQd4kNv1nK4ZF7/rBgU1CFGoN8hBRKSd1Q=;
        b=bou41jS0iTHNOhdZxT6lP0xyBmQ5dgSPbNspow5GMwF7E3tI9XTvSmZ5ix0ct903U7
         /ZWdk4tMb8vRLeReuOFOKYHOc/LWMgLGJOkJu9AjBXtaUucTkJhhHok3KuGrbnPCNNtM
         nuFmWOL6tBimDE9/6GZZH5Xz4WvTsmfCmXIbohrDnOwUC4RYuNdpZQs0Qnaow6q+lLQc
         DabIXWTVsJhviWw3h3kwxXM9zY+nWu0O6/PwydOaUxTaUjcn6IpMn5uWwMwRaTtkwNYM
         TSuKl0WigC4Lfr7cpsNxbCT76OdCh668Cnm2qC2rTewXQgqvomSb4IZs3ug7vcqdkbK1
         1ZTA==
X-Gm-Message-State: AOAM531RhK04Xjb+kcDINdTe7pd3160EMngx7wVxlA97N94RNlHzEJx2
        DYBkvUVA4c8/pseiQxNLSce28bWZ0mLq2pN6E0P0NtXP2Bwz
X-Google-Smtp-Source: ABdhPJyNE1UXBXOaJSv3x38kfUBkh6qf2pgvHb9ayYaWHoon7Wy48IkgOgp4MvqbPEA+S/toakjHMjXjn7ZqV3S9AeIh3XGkCmeF
MIME-Version: 1.0
X-Received: by 2002:a02:856a:: with SMTP id g97mr3746783jai.199.1642334112626;
 Sun, 16 Jan 2022 03:55:12 -0800 (PST)
Date:   Sun, 16 Jan 2022 03:55:12 -0800
In-Reply-To: <20220116114236.2135-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000062bd0405d5b1b5ef@google.com>
Subject: Re: [syzbot] general protection fault in nfc_alloc_send_skb
From:   syzbot <syzbot+7f23bcddf626e0593a39@syzkaller.appspotmail.com>
To:     hdanton@sina.com, krzysztof.kozlowski@canonical.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        nixiaoming@huawei.com, paskripkin@gmail.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+7f23bcddf626e0593a39@syzkaller.appspotmail.com

Tested on:

commit:         4d66020d Merge tag 'trace-v5.17' of git://git.kernel.o..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4d92848a46d5895
dashboard link: https://syzkaller.appspot.com/bug?extid=7f23bcddf626e0593a39
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11b7cc60700000

Note: testing is done by a robot and is best-effort only.
