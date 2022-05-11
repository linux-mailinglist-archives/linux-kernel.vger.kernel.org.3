Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4718952348A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 15:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244040AbiEKNo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 09:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239724AbiEKNoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 09:44:24 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61ED0217FDC
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 06:44:23 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id n5-20020a056602340500b0065a9f426e7aso1215047ioz.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 06:44:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=erT/t/juAQcbBOTyFnqWzQMRhm/5cnnswBIuM+fpu5Y=;
        b=Af+Le0IrvPF9skmlqWBjP+WhyE7uRdsAuKC8FV7F5jsJko+t0KYA1kXlB//FAK6cQh
         C32wTxS3j3xG16QTzmvWd+4Sf1lZTEmfaYQ2Hw/8ISupDiNZcMkhdDg4Q04/rHry2OwC
         AU9/vRRW2rwXM4GmcmLaCLJtBthfcyzJGOigLSsSC1/Zx8ZgoMqZeHv6QyshfvzSYgaC
         3S6WJARwlAK2wVFUX0SLgbjC2TGtkq3yRqY98tbPwP+cBmGn5HyXgmiEDy5djfMxPRfT
         ug9hJDf+NkdriJFfwdrhbAS+lhh6UtKl7BG++8ajeHEH2JAnprDTuxnPD8HGqP43szGH
         Fmkw==
X-Gm-Message-State: AOAM532pCHxRWsJ4p0BfcQb912wPlBUbiELBUnFFj/BzwVUhhZbo/1rm
        ZWTEXGXFX4jYru1QsBbQouUSkjHLo12RPnilDQozEZLGZ7XK
X-Google-Smtp-Source: ABdhPJwGUXG396YxiOh7vyGBgcQC6MrxCDc/f85IpX3qsXxxqAh79ndEliGsQzPHaAph95WCGbPdj9Pb2YLYu9ne16I8BZUcgis1
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c5:b0:2cf:8aaa:454d with SMTP id
 i5-20020a056e0212c500b002cf8aaa454dmr10594507ilm.219.1652276662769; Wed, 11
 May 2022 06:44:22 -0700 (PDT)
Date:   Wed, 11 May 2022 06:44:22 -0700
In-Reply-To: <20220511132050.5868-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008e20a005debca377@google.com>
Subject: Re: [syzbot] INFO: task hung in synchronize_rcu (3)
From:   syzbot <syzbot+0c6da80218456f1edc36@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+0c6da80218456f1edc36@syzkaller.appspotmail.com

Tested on:

commit:         4fa640dc Merge tag 'vfio-v5.8-rc7' of git://github.com..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
kernel config:  https://syzkaller.appspot.com/x/.config?x=c8387e9c623864db
dashboard link: https://syzkaller.appspot.com/bug?extid=0c6da80218456f1edc36
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=163b1869f00000

Note: testing is done by a robot and is best-effort only.
