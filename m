Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48DA599E9C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 17:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349809AbiHSPhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 11:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349778AbiHSPhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 11:37:16 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73232E7278
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 08:37:15 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id l20-20020a056e02067400b002dfa7256498so3442735ilt.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 08:37:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=94x0AlTYME7JTO0C9915l6NdfFJ2DgOCgcBChltqQWQ=;
        b=DfRTs/AiqFTjISArTZqnXOppAUbBhDTDT6gWbgVsBZiVpmntFRu0QdqWaJ8b2AHuQr
         0G5PbdxM3F8Urr83IdaO4NIY1i4KqbEwFQpWIHH2ecHz9JPDnu38UkTIO6+PSk+qcMQL
         sOFcxltrS5m2y4ZVU4oeQChSAUUMhX6s1F3LnHrlWCJJAESw4x/TeYgKDqchjUD6GHq8
         JP5YkHlgNfXJd8aA1Z9UV4K8wSL5qY4Tgklc3rVzpFQaznh8arfwKwZLn+XvByGid8up
         ZAG+Cn8VtEl9DAPk5yjsE4TKoI66wpShufMbsZDXSh8JWcKaKi//u3szhMo/5cdhwrKg
         27aA==
X-Gm-Message-State: ACgBeo2ECyQBqA9B3d9rLdkOnzebVYAH/6rVISKsK4k9fa/L2FeDamdc
        g8G0oVrXISoeKXG/DOcmSyUaVosAWWbTBZBKf+ey9pwa1556
X-Google-Smtp-Source: AA6agR6REEtECibZlVkEcLW2dWMbYRRJEN7GzrH1VDNE6U1RZW/iX20V98CfBnA8jKHQNaBk0P/h0urd5PvrgC7OEU7xMZb0Mt6I
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3897:b0:346:83f6:9609 with SMTP id
 b23-20020a056638389700b0034683f69609mr3684945jav.40.1660923434842; Fri, 19
 Aug 2022 08:37:14 -0700 (PDT)
Date:   Fri, 19 Aug 2022 08:37:14 -0700
In-Reply-To: <20220819110950.1479-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005544bd05e699dfe5@google.com>
Subject: Re: [syzbot] WARNING: ODEBUG bug in __cancel_work
From:   syzbot <syzbot+83672956c7aa6af698b3@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+83672956c7aa6af698b3@syzkaller.appspotmail.com

Tested on:

commit:         6c8f4797 Add linux-next specific files for 20220809
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=104e8e5b080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a5ae8cfa8d7075d1
dashboard link: https://syzkaller.appspot.com/bug?extid=83672956c7aa6af698b3
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=106ced2d080000

Note: testing is done by a robot and is best-effort only.
