Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0B759E4D5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 16:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238320AbiHWOEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 10:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244606AbiHWOCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 10:02:16 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9443888DDC
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 04:10:33 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id l15-20020a0566022dcf00b00688e70a26deso7185197iow.12
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 04:10:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=Owuo97PjQ6IqN5nnDnXto1MWa8iee+gPMJsJz7pxwt0=;
        b=aHF7NKe9BMXLkyuV0xPDWP0ScjFl2yFrPa3NymM17a5fPkWx8ijkwQZHdCzM0gHhd9
         4W27+jeRpC6VKQ4Xsk7B2OiRkZ8Sik60/Cs8T3Ku+Ynl8Lye0pn6f13+DVKe4PDxUHJX
         ql5AzBT8wubdjRljzQkDyjc3CU2fopGDg2JiLFeVS/qJmIri5a80RzUa9DKuMkI4AiM0
         KXVh/gPSq5QakA81z0FJieoP6aE7MD7HcnhFMC3DqwXRSa3gX4OuUo3JfaRhzGA8wOtL
         XvmPIsxwWfuMRXSeXjsLI6decNvfU40ZmsuSqF6O31tZhvToQD4rgWngpg1UXduTVtkO
         fL8w==
X-Gm-Message-State: ACgBeo26R3jITzbeiEHNFiveMCbcLVeNwyPOnqXK3P0tjBivkgUGzj8N
        XvO7ysvYef3XIrtrBOZm7EJvStRM1YIf73bo4kEiIqCjq9jG
X-Google-Smtp-Source: AA6agR6BIU5uMrxeIjQH7oWm38wwmSgKTj6Ale7fSOWFmiJGRFVmUv/DZ0Wv9c1lPolo+npOcd0H3iMGxs1m8xFBx9T8EadjPVZ+
MIME-Version: 1.0
X-Received: by 2002:a05:6638:45:b0:349:b71c:af7d with SMTP id
 a5-20020a056638004500b00349b71caf7dmr7073777jap.181.1661252953729; Tue, 23
 Aug 2022 04:09:13 -0700 (PDT)
Date:   Tue, 23 Aug 2022 04:09:13 -0700
In-Reply-To: <20220823105218.2270-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000306f3905e6e69820@google.com>
Subject: Re: [syzbot] KASAN: vmalloc-out-of-bounds Read in blocking_notifier_chain_unregister
From:   syzbot <syzbot+2fd9312f3ff65d22d06f@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+2fd9312f3ff65d22d06f@syzkaller.appspotmail.com

Tested on:

commit:         7ebfc85e Merge tag 'net-6.0-rc1' of git://git.kernel.o..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11aafb47080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=924833c12349a8c0
dashboard link: https://syzkaller.appspot.com/bug?extid=2fd9312f3ff65d22d06f
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10e11a3d080000

Note: testing is done by a robot and is best-effort only.
