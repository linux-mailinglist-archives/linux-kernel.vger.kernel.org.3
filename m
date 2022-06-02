Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4EB053B4AD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 10:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbiFBICT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 04:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbiFBICQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 04:02:16 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF83FD2
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 01:02:14 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id u7-20020a05660229a700b006657df613cbso2314789ios.14
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 01:02:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=BdTFyl38wlUHGpfUGvq4bL2WXHORmkewreP2zdXwMPg=;
        b=zq2b/zrYAIbi/cRzFA/8fIRTX65OPRWISoU/s6dnP+7Gv4j1FgBAMe08gPDi9EY/Y2
         3yTsi7aWXQVYSAfI4ZPjJQl9vng7S2gpDBGkT75VfIsglidAs13z4ReDP+RFx9F+eL9a
         iuNfcM39hfAJ4BxbAmnXasYzUUsrWE1w9ZsSOGuf4SiWT5n16QCuFAePlKXQci77NdcW
         JTs5g/FNlT7pe0bGDAQYmkFi4oyQv4tof0mw3mRXGqRJnX8yvJkNztdZ4CRGRo7RbgZE
         n+x5hfaBwSe/CwzDordTDjo3ZCunXM59veHfgIBZOF2RncOiFv8ZVcQMsOO4hfSmnUKA
         o/Bw==
X-Gm-Message-State: AOAM5302Xuz7Eh54Njc+uReuoSsuinTZMu3T2zZVIwnk1q+7LFkkWbM0
        wUv+Kz4kppibzy20LXibGacOP+r6OhRyH5Jmh0I/27YdISvy
X-Google-Smtp-Source: ABdhPJxQ5bhhGvNu9d4sgOniNJEK5Ut+yKZQTbh0o4I8BCOIs6fAKas3rGiDdrZlIRuYjlsW0YhdfrL5g12Rv1XoSyxcZbO7fclm
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1646:b0:2d3:789a:58a with SMTP id
 v6-20020a056e02164600b002d3789a058amr2488584ilu.197.1654156934291; Thu, 02
 Jun 2022 01:02:14 -0700 (PDT)
Date:   Thu, 02 Jun 2022 01:02:14 -0700
In-Reply-To: <20220602080034.4886-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000078a81b05e0726c2a@google.com>
Subject: Re: [syzbot] INFO: task hung in hci_power_on
From:   syzbot <syzbot+8d7b9ced2a99394b0a50@syzkaller.appspotmail.com>
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

failed to apply patch:
checking file net/bluetooth/hci_core.c
checking file net/bluetooth/hci_sync.c
Hunk #1 FAILED at 2675.
1 out of 1 hunk FAILED



Tested on:

commit:         9d004b2f Merge tag 'cxl-for-5.19' of git://git.kernel...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
dashboard link: https://syzkaller.appspot.com/bug?extid=8d7b9ced2a99394b0a50
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16f9bfedf00000

