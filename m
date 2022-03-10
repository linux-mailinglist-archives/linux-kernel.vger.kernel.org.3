Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEC54D4A0F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 15:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242812AbiCJObn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 09:31:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243704AbiCJO0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 09:26:12 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9EAA1390F8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 06:22:17 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id r16-20020a92ac10000000b002c1ec9fa8edso3313111ilh.23
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 06:22:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=pt6H2yEOvbchK2G/mDFNXqaD9NNW74OxNiZGPSNIUtM=;
        b=OI0NOsjzrpVu91ftMRMTk+vMZoojOevoOIyQqNHn+etkLkojmjoe7G5M6YIjzLXV1s
         fNI7OaFHVR5+JJMkfGIm8jBLdDX9RJp3Z8ZfcGQKAaXA9qLF4dTtkkA8c/pzSXuJPH31
         ISkeQO/KRHp6bcdgXOCCkq8Kt/oHCrwZ+EVkBp2BICJsEBskGt/VvoWSbNeWHO2/8GM6
         qip/3WqxoBcP0FVZ+K+vg5qLzQ2/4yNjh/RIM94fgN3z3EzLca46s7JDP5uAr7i1B5yt
         KI8rSNhcQuXUVL1gHh6lZqMQpC7T1Zo12NaJzNABbGDCT7Z9XIBEcx73Oko3AB2vQEa9
         N7Mw==
X-Gm-Message-State: AOAM530gb5byGMcw/xI3Sex88QR7Sa4AjSsrjqMPgBR9mjFkxNloHCHA
        J5TZ0w9rR6tX16J1D3iqf2E5t3RUUWgG+TFEHLjXhdLU9xXu
X-Google-Smtp-Source: ABdhPJxO5gO8RMGycxaiSjpAHPo/WwHF1PocT7lXNL6skBMH8eWBmrdKDQXngaT1plEH6LU71jfsudv/ZUBdL904rx77l8dJrn1D
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2192:b0:2bf:e954:5588 with SMTP id
 j18-20020a056e02219200b002bfe9545588mr3904031ila.101.1646922130772; Thu, 10
 Mar 2022 06:22:10 -0800 (PST)
Date:   Thu, 10 Mar 2022 06:22:10 -0800
In-Reply-To: <20220310084247.1148-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000093d7ec05d9ddf04f@google.com>
Subject: Re: [syzbot] INFO: task hung in port100_probe
From:   syzbot <syzbot+abd2e0dafb481b621869@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

Reported-and-tested-by: syzbot+abd2e0dafb481b621869@syzkaller.appspotmail.com

Tested on:

commit:         1db333d9 Merge tag 'spi-fix-v5.17-rc7' of git://git.ke..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=16438642a37fea1
dashboard link: https://syzkaller.appspot.com/bug?extid=abd2e0dafb481b621869
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
