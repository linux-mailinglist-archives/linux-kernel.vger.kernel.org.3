Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8F25A3428
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 05:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbiH0DnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 23:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiH0DnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 23:43:13 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E065FD83FC
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 20:43:12 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id i1-20020a056e0212c100b002e9fda30fbdso2425520ilm.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 20:43:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=eg/0057SGkW34f+W57nK/E8zdj2dLy5MUcOKQQZn8g0=;
        b=HKhdL/IJz3IO6YBe/2MoiErDqy9BtK+h04fYj7UruKs2P+FH6GQViE02sxR3i8qdo6
         325yEoGgvPyuRB5u3euH6NsxFqibg/h9OUCyiv1k1M6LWkH9h5onCcxQSVhP1Yy9nwOB
         o9c2oio71admVZme0jje+NqBmykCC2XFgAVwno2J6T8Wl+JV0pnx7VDECKHrLdK1jooH
         SOxxzQbSJWdLAminXCzBkC804TwnfnboXdnUKi1eDhBSmVzOc/m7mpj7SCYSUig4Yw+/
         ZCbRFRt6rAbh3JX/ChpgX7kRdgyuuiJK5WADhnqB2tT25owU0DvLKxkIyG3LdWPYHqcY
         UwGA==
X-Gm-Message-State: ACgBeo1TlF1lAthcaLKz7NhbWIZ3rHc1iyrrsIUT2wlLRfxd/c5uo5/K
        tWHBwZACZTdJplhoIUbLqUVMIYuQEAGhzRS4CGWW7HD3+b7l
X-Google-Smtp-Source: AA6agR5BSyT+A3ozeV7Nis16VVVL65SPSjmK7ksWdmDQXVWGxa8/mMU1zhqOq6OyKkkaR2dm9WTKnRepMgJNERwFHjPZsK8Q2sOt
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:168d:b0:2ea:3f77:a91 with SMTP id
 f13-20020a056e02168d00b002ea3f770a91mr5427297ila.223.1661571792280; Fri, 26
 Aug 2022 20:43:12 -0700 (PDT)
Date:   Fri, 26 Aug 2022 20:43:12 -0700
In-Reply-To: <20220827034201.2669-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000072a45605e730d4fb@google.com>
Subject: Re: [syzbot] BUG: corrupted list in efivar_entry_remove
From:   syzbot <syzbot+1902c359bfcaf39c46f2@syzkaller.appspotmail.com>
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

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git on commit 680fb5b009e8: failed to run ["git" "checkout" "680fb5b009e8"]: exit status 1
error: pathspec '680fb5b009e8' did not match any file(s) known to git



Tested on:

commit:         [unknown 
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git 680fb5b009e8
dashboard link: https://syzkaller.appspot.com/bug?extid=1902c359bfcaf39c46f2
compiler:       
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=105025bd080000

