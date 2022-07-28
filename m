Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC73B583A65
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 10:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234743AbiG1IeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 04:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233818AbiG1IeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 04:34:10 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A216A5C363
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 01:34:09 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id i8-20020a056e020d8800b002d931252904so902309ilj.23
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 01:34:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=19OyPJxsPjdv5l9iNTOwwnPJSRBINlHZjRwq/IHeTVY=;
        b=XT57JX3D24HGg1phpQnJRqBwmHyoh78O9raldAD6GIkwNOQQsKeDIaZfZid3JCTJpp
         QLxEfQ9RH7o5v0Q6w5ThG1yBlXX2w/v4ZrQFRH4X4otpFmx3i5A0QTmxNV6twp2Fys9f
         CfmIsLI7pu8FYdKgt7JSshe+CyFGnILC3DECFWtRrLIpXbwNEE5/Rcug2JRtvcjrhRFu
         KxUJmKzaqW0NqjHkiBTWhJ4OgeX2YVYvLqs/EmnzQ+GmblagyVF79uFUxlODXoclbbl/
         USzqc2L8+s99hzzU1g1+Dk1jmZ4wPl/SXJjqscEN3q/o1+kZMhexkY0dLWpyVY+vmiMs
         Ri7w==
X-Gm-Message-State: AJIora9DkmsWu/DrQe5rxKkd6kHf6Sz1ptJW8t6+eipQv4cDOOLJSzW/
        1cV3qNNC40dZHAHKJJgaEFO199I6XCi3KwcIf0022tYfO1a2
X-Google-Smtp-Source: AGRyM1thERD9kvvVX+EetMDk7+VvuqgQm0ZnKQ2G61ESdLegOt0RLGBZA39OLi7GRcvaBBYMB1Q5h0XDFozmKbr4RrLgtaW+PCs8
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2486:b0:33f:85cb:f387 with SMTP id
 x6-20020a056638248600b0033f85cbf387mr10214483jat.247.1658997249055; Thu, 28
 Jul 2022 01:34:09 -0700 (PDT)
Date:   Thu, 28 Jul 2022 01:34:09 -0700
In-Reply-To: <20220728081331.805-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b6a04805e4d96537@google.com>
Subject: Re: [syzbot] INFO: rcu detected stall in net_tx_action
From:   syzbot <syzbot+3ba0493d523d007b3819@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+3ba0493d523d007b3819@syzkaller.appspotmail.com

Tested on:

commit:         6e7765cb Merge tag 'asm-generic-fixes-5.19-2' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12d263ee080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1eedaa77654417d0
dashboard link: https://syzkaller.appspot.com/bug?extid=3ba0493d523d007b3819
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
