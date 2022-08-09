Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2DC558E043
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 21:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343697AbiHITeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 15:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343769AbiHITeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 15:34:10 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF9023163
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 12:34:07 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id h203-20020a6bb7d4000000b006804b1617f2so6798083iof.17
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 12:34:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=zzEeAyO5XNdispcrLmThTVHXYAzdUmPo4XOGr5Nx8TA=;
        b=JcE2dzIVz484IMWO10FwdF4bhEP+A4lA4xJoiPTuhlxdMOtsxstjIlEYF6xQdj7mG5
         L8bTBvyVUczczAj0XTflN8yiCRvLaxa55vBFADP9lljcyrSdafDYtK6YskEqIXCLEn43
         8/4wA7MctXT51+WlITNyX8H7oGGZzZ00VmUi2RoTCB8yWFpFYlsKEVIL2B1MkkpWGH/i
         fUGL9BcpxSGCaAq8evUw6o93KrUZ47OY4aVuje0SnPj8qG5czF3Sj4pn3xSydluNUEhN
         Bk+4F24v+jy/PUYT7Hah/aDag4FQc8B2yx1ZBEIYmGdECGJROXcMaikyfSypWo2t1kzO
         nRHQ==
X-Gm-Message-State: ACgBeo1abWUy5dLruwHXtKGoCrpqh5xNi1BcSYzo58Y6HBNMmc/kBEDF
        s1qOrNJ91MFdEsIbuKo0yDJMXy9y74E650e9T8ItFeII2hYy
X-Google-Smtp-Source: AA6agR4d8kKdDF9am7Lfxb8qrTbcYFHzwcZgOfiFH+iPAo6oqJpgGxJ4jRFE/FQ5bUe/C7HASu0ODcGhCNqi4kxssh5C06gdShHe
MIME-Version: 1.0
X-Received: by 2002:a05:6602:13d5:b0:67c:9149:fe0f with SMTP id
 o21-20020a05660213d500b0067c9149fe0fmr10500631iov.114.1660073646568; Tue, 09
 Aug 2022 12:34:06 -0700 (PDT)
Date:   Tue, 09 Aug 2022 12:34:06 -0700
In-Reply-To: <20220809105321.2309-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000013bb605e5d40423@google.com>
Subject: Re: [syzbot] possible deadlock in p9_req_put
From:   syzbot <syzbot+50f7e8d06c3768dd97f3@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+50f7e8d06c3768dd97f3@syzkaller.appspotmail.com

Tested on:

commit:         ca688bff Add linux-next specific files for 20220808
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=147d0be1080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4c20e006003cdecb
dashboard link: https://syzkaller.appspot.com/bug?extid=50f7e8d06c3768dd97f3
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=142dbea9080000

Note: testing is done by a robot and is best-effort only.
