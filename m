Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C014E1E82
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 01:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343934AbiCUAij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 20:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232714AbiCUAih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 20:38:37 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59AB011DD31
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 17:37:13 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id s14-20020a0566022bce00b00645e9bc9773so9564251iov.20
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 17:37:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=zgQUKqyjG4aGGBf8aCK0jtXa3zTm/bs6XHOzG16Y64g=;
        b=hJYuLJgpUT21SF0DeLEmlOh+CAqSUym+leeo96pjLcJEVKy/jNVp/8Md+AogDsdJfM
         wq9lYY8pe+WKdE5dLi+6XFbkeYE8QN7S2dwrWoAZ/ZZR63rHCXZJ7Z2IF11CxK5MBBiU
         KK9OMQcLvOg+YK0mBRPoryQyMVnoDAlQBkNFzfPwWEYCcIH+DdyBJuCKEYkqxiQMJgNM
         c+6EJmRidefh8AsjdCchk82iSgphPy/LhIP+VxrX2vlOokQ+l9rXu1uoSph27oNa83ai
         y+XWK6twUL16fGfb/wA34QoMqJy4Mz9y44o4YosZ+Hnn73i/u6imUfuSPIWI3SlYSpyo
         p9oQ==
X-Gm-Message-State: AOAM530/ADkkSJy5ItpjURxq+bvJQO2RAdnva0KVeaeRwbVHZkB+HRKy
        9WZweNr5CkCFSBcfSDyaCQLaXWYCqcRFkV54nNHDpaExu6WW
X-Google-Smtp-Source: ABdhPJxkPgs0tx4NlXWqryXWzrsSRNeM6gWcKie3TCOArNOa+x8br18/TslqhGJfC+5n4nMaQDV/e/qutgSevhp+scAl6t8Zy7Wh
MIME-Version: 1.0
X-Received: by 2002:a02:85e2:0:b0:317:2edb:46cb with SMTP id
 d89-20020a0285e2000000b003172edb46cbmr8963902jai.118.1647823032735; Sun, 20
 Mar 2022 17:37:12 -0700 (PDT)
Date:   Sun, 20 Mar 2022 17:37:12 -0700
In-Reply-To: <1821968.CQOukoFCf9@leap>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000084e0cf05daafb25f@google.com>
Subject: Re: [syzbot] KASAN: null-ptr-deref Read in __free_pages
From:   syzbot <syzbot+d55757faa9b80590767b@syzkaller.appspotmail.com>
To:     christophe.jaillet@wanadoo.fr, dhowells@redhat.com,
        fmdefrancesco@gmail.com, linux-kernel@vger.kernel.org,
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

Reported-and-tested-by: syzbot+d55757faa9b80590767b@syzkaller.appspotmail.com

Tested on:

commit:         f443e374 Linux 5.17
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=19ca6f72fd444749
dashboard link: https://syzkaller.appspot.com/bug?extid=d55757faa9b80590767b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15ec554d700000

Note: testing is done by a robot and is best-effort only.
