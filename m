Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B95A4EB93A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 06:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242480AbiC3ELD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 00:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242487AbiC3EK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 00:10:58 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D998E21C05D
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 21:09:12 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id u15-20020a92da8f000000b002c863d2f21dso10301849iln.15
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 21:09:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=0RPEO2suw8hCtQY4MwNTKJlXJ4Qb3Pj0WPd6BRZnMYg=;
        b=0/duv297FTZ52lPiVlK10MD9CsernwOfweAV1+E6EmYwaF2jjrZ8eIfxEy1JnIxwJn
         bar2/qcF0cxE2fDytbZjFqrFKIsixNbqID89F605fs0c9VfpPYhxTAfz13HGMUE/LebQ
         pHbijtkFos7ft3B3vu20OaDPJWL68IlILRR9VMn0KdC4+M4fCYCazPY/EYBpHFGCx8u1
         dUS9brssoKHwyojtAqbn+jwNvh0v60N/FtwowuBNG2A8F2dUQVOrGRFjm0EAXXjSoc4S
         aMAA8U9so9OKFUU+5GZ/0t+22PxINnNSACCGy/qW9WGNUbBpwdFWjB6je3Jn8/l+b/Fj
         eEfA==
X-Gm-Message-State: AOAM531fHCEV2HDU5Phv65J371NpLzT+BtsY89ebzX58joFfGlwmCPMT
        x1ay8tbFZDU7Esq5320JXN7X0Txc2quYcK3yGTpEdXuvzH6n
X-Google-Smtp-Source: ABdhPJxXpwiMqLVbaDzZmTL9KLIbPDr0eCcMlwntUXfHaAcG8V8HN5A/5AeZ6BTVvX+eD2pS1L8GNYFFHQD1SYBeRnEr94Vgv8Nz
MIME-Version: 1.0
X-Received: by 2002:a02:a98f:0:b0:315:19db:27a3 with SMTP id
 q15-20020a02a98f000000b0031519db27a3mr16974405jam.184.1648613352169; Tue, 29
 Mar 2022 21:09:12 -0700 (PDT)
Date:   Tue, 29 Mar 2022 21:09:12 -0700
In-Reply-To: <20220330035418.4426-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003a665405db67b509@google.com>
Subject: Re: [syzbot] possible deadlock in __snd_pcm_lib_xfer
From:   syzbot <syzbot+6e5c88838328e99c7e1c@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+6e5c88838328e99c7e1c@syzkaller.appspotmail.com

Tested on:

commit:         8515d05b Add linux-next specific files for 20220328
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/
kernel config:  https://syzkaller.appspot.com/x/.config?x=530c68bef4e2b8a8
dashboard link: https://syzkaller.appspot.com/bug?extid=6e5c88838328e99c7e1c
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11994b07700000

Note: testing is done by a robot and is best-effort only.
