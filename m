Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96CA459CB14
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 23:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238333AbiHVVpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 17:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbiHVVpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 17:45:15 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2E6564EC
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 14:45:14 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id d6-20020a056e020be600b002dcc7977592so9175797ilu.17
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 14:45:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=lvDv3fY56hvUDqlCuuOa5TsCeohcojRJoetuEGrJWa8=;
        b=aJ+y3LbS/2t/bqh3i85H0xfHir/6UJVR8TmodDHvRWQBkFsb8Dh0EU26ojpPsFh8Iq
         C9hFLnz7vdrANlNoIjwCWd4UTAgjn+R+GwOEIe2Vz+lJ9DrUGBt/cKh7RY+bYEaqRHSf
         69ghHm3C8VgTYERM4uHfSdnZ0lpMDLGqOvSEImLcPiKQq+CwepoOSYWiEWgobKhsz3BI
         7nSuBDRp+zSEaL0cd6h7DotNmOzW8NGhOF+vyEugdL3XR6d+0+cJYzPi8SHYedVBhpdU
         IY7qstpsgY2PD8E+zYPkOTj4jHcHzCJvXfh8y5LXchtTnWF1U28XcZfxSyRHSWqohXjS
         ZmUw==
X-Gm-Message-State: ACgBeo3ZLhIv6xHnpbfFYuN9O0DAyCl2gHoiR070s14I8xTAqyFvoEit
        2cssE3Rs9JBHwwtlYEUPiDWGXhHabMEFfWxvxSJsKx89TmuX
X-Google-Smtp-Source: AA6agR4GSvl30pCUuBFcCvh7OLuPyo1OmiddCog13EloqJ5x5ueeFfVOzeBAN4jTBuX2js5urmqVvfypiZhWEPbz3OyDt+YvHOrE
MIME-Version: 1.0
X-Received: by 2002:a05:6602:29d1:b0:669:428e:8c59 with SMTP id
 z17-20020a05660229d100b00669428e8c59mr9434201ioq.85.1661204713833; Mon, 22
 Aug 2022 14:45:13 -0700 (PDT)
Date:   Mon, 22 Aug 2022 14:45:13 -0700
In-Reply-To: <3eb3867b-9bd5-3de0-b00e-de77d724636e@acm.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000de0b4205e6db5ce8@google.com>
Subject: Re: [syzbot] INFO: task hung in scsi_remove_host
From:   syzbot <syzbot+bafeb834708b1bb750bc@syzkaller.appspotmail.com>
To:     bvanassche@acm.org, jejb@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        martin.petersen@oracle.com, syzkaller-bugs@googlegroups.com
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

Reported-and-tested-by: syzbot+bafeb834708b1bb750bc@syzkaller.appspotmail.com

Tested on:

commit:         0fe8e010 scsi: core: Revert "Make sure that targets ou..
git tree:       https://github.com/bvanassche/linux.git scsi-for-next
console output: https://syzkaller.appspot.com/x/log.txt?x=100c7465080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=312be25752c7fe30
dashboard link: https://syzkaller.appspot.com/bug?extid=bafeb834708b1bb750bc
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
