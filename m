Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5A84E6968
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 20:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244054AbiCXTnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 15:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244039AbiCXTmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 15:42:50 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B1C931A2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 12:41:18 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id m20-20020a92c534000000b002c83ed01909so3387328ili.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 12:41:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=vl8oYt9u/S2NELS20YxXTXret0U916Fn/WJch6RJmnA=;
        b=x/lREiIUYcENPfdm3EK6JxAtmxxWrxAZ/lYl2CXwLLxKzeIg017ZYiJWwD2E280JGA
         xT1P4hqq64wGk9Q8IX4owxVJf8Z/SyyefiVHl1RG9tqnJvjqG/qmNrOuvqCbG29tibFh
         8n6Y8g+0BJrX/K88gwu65v9mJsHSX5eQGD8THqfr2WAu6A+WnAn/8spiCA1dvccxbcki
         PA2LMAsAoe5EHIpyinRR0ZIMEd7m+yezmsB4dRSD1Qg7FvW4B/4n9h6kHfkXtPv6GG4M
         62t3elh3eF2e/TrbDhLxv3Qb++AGL7hwttOa6fAvIx1ofw8quwos2pWKXp+u4D8Z84Oq
         cv0g==
X-Gm-Message-State: AOAM530Av95hgLkMYrXoBv+J5R4YN3UOT3lr2rkcKtdESUcOHvb8EGWk
        VE0BR+5s96mNa9moJLLM13+nvspp9zYD6nqJGlohSvRRi0sG
X-Google-Smtp-Source: ABdhPJwNXzAi7DPPgLwi45+FpOvK+ASA00oOQls6tYlkIZ094AvEpaV5Skm02sf9UPU1uA7pizTXavg3SrkhG7H5tNk5UG/kY3+v
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17ce:b0:2c7:f428:9dfd with SMTP id
 z14-20020a056e0217ce00b002c7f4289dfdmr3733983ilu.36.1648150877633; Thu, 24
 Mar 2022 12:41:17 -0700 (PDT)
Date:   Thu, 24 Mar 2022 12:41:17 -0700
In-Reply-To: <CAMZfGtUr6V5pTrPhZukD2_KbB7BLPoKvF6H63HP4pykY36Ou9A@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009901d505dafc07b3@google.com>
Subject: Re: [syzbot] general protection fault in list_lru_add
From:   syzbot <syzbot+f8c45ccc7d5d45fc5965@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, dvyukov@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        songmuchun@bytedance.com, syzkaller-bugs@googlegroups.com,
        torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+f8c45ccc7d5d45fc5965@syzkaller.appspotmail.com

Tested on:

commit:         ed464352 Merge tag 'arm-dt-5.18' of git://git.kernel.o..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git master
kernel config:  https://syzkaller.appspot.com/x/.config?x=113ff5d072bc15d6
dashboard link: https://syzkaller.appspot.com/bug?extid=f8c45ccc7d5d45fc5965
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1208043d700000

Note: testing is done by a robot and is best-effort only.
