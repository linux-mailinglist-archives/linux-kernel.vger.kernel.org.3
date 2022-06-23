Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74AD0557DFC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 16:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbiFWOiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 10:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbiFWOiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 10:38:08 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3485F13D5A
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 07:38:08 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id l4-20020a056e021c0400b002d92232d76dso5970588ilh.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 07:38:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=pwvjluaI/Hc63nVi7tgL5FwnEjIO9aeZBn9jjiMJHtY=;
        b=nSZx+PH36s9M6nhlQGaPPk8flxA9wHzomtno3cm+kfQIv9K70PQtDGRd/jwExQ68yn
         Okwhq0dQYLsk/qMGCWw3yd7YP3jLTFBscdyzDEP77OPnJ2xmTzIoNcBzb3ux2bTb5lQq
         wTII3uK5XrjYPK9CSSGun6FLevG3rHeOXZsssSWVBsd/HdUegs2U31EATxxi/g+y7AP3
         dNBjJFa+MD0NWZgRNs3zDauvFvQLcDi9JKH21bfYa7JJCnvY5eEv/FV5VIGvsu015pH3
         Bh2rvMd63K9eMrx9bD8AM2JSCwFivGdM2GYCA/NMhX7ckRUhQ1rx/opE4MdxF63UvnyO
         jXJQ==
X-Gm-Message-State: AJIora84GoA1DzOrsxGYvIDE41LjXnj4n4PmPElxOF+hiHyHc+2wxZo8
        Y0AACndUoK5fHlIeWfs6FYjjQ5T9BZvgWE4zAbhm4C+YsSo3
X-Google-Smtp-Source: AGRyM1u6Ae4mzjm75hcqlzrSvA6D49PR69zzrvmFKDLEOszj/95BXddLBOIsTw8ZMDbD9VHNuoL54eB8w4wJO4F3antyB5THGOQK
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2481:b0:331:df8f:95e0 with SMTP id
 x1-20020a056638248100b00331df8f95e0mr5368032jat.280.1655995087414; Thu, 23
 Jun 2022 07:38:07 -0700 (PDT)
Date:   Thu, 23 Jun 2022 07:38:07 -0700
In-Reply-To: <20220623110941.566-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ef6d0c05e21e666a@google.com>
Subject: Re: [syzbot] general protection fault in do_mpage_readpage
From:   syzbot <syzbot+dbbd022e608bb122cf4e@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+dbbd022e608bb122cf4e@syzkaller.appspotmail.com

Tested on:

commit:         34d1d360 Add linux-next specific files for 20220621
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11096f7ff00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b24b62d1c051cfc8
dashboard link: https://syzkaller.appspot.com/bug?extid=dbbd022e608bb122cf4e
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15d4eb1ff00000

Note: testing is done by a robot and is best-effort only.
