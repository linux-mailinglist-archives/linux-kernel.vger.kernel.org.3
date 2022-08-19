Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 838CA599FC8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 18:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352332AbiHSQWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 12:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352518AbiHSQQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 12:16:58 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5572B117772
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 09:00:14 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id h25-20020a056e021d9900b002e069b96119so3484285ila.14
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 09:00:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=PEvbQwuqkPIOqGz2U2biiCtJ1u8u1Jgg6b0aF9rPmO8=;
        b=V5lJiosYLgU6XR/Dh2ZKTYH2m6jiWZRWCXRWYI0j6WV2CT+0VJfmRh02ma65IoRDv2
         Sl2PvOq0l+etXTHbU1v+i3CtvaiELCZ3R4IW93rAThRvl5CYWvG35Cuz9w+OvtKC3VUy
         GPr7UMujfDWY5rrCR+S6rJg74C/Ec1ivgXLyN3zyZG0IvLsCaL9K2B0ZBoGIe6yaSAJv
         UZGZ6F36ozpdBJOaG0eHQCijZXc75vutd/GwuTdXb8OWiIp7VKh8n+YYAOAbOGQh8eUr
         vK78jxMl80SGQITC+zZJmx+iIznImSuLzyQz8Z0eNAodNRDl4rw5hfHkzvPTYKmI1C9B
         qzBw==
X-Gm-Message-State: ACgBeo0160Kp0GovORdmspHKDvhkxbllDLAyuUoZv250jogAHIFiTuzS
        DSePzwto/ZL0lgfAcdBs8epczcQ5me0VbdH/8cB+1ix+aT+Y
X-Google-Smtp-Source: AA6agR7UZjzoy5Us1DMpgDEjmQJbjXiO9fZmVN9HvfHnjj+EfE7r4AD/0k+hGqUw2dul+xlkdYKVCL0+BwWDSHv5eSSefeVvtzJw
MIME-Version: 1.0
X-Received: by 2002:a02:3348:0:b0:349:b71c:af7d with SMTP id
 k8-20020a023348000000b00349b71caf7dmr521605jak.181.1660924812727; Fri, 19 Aug
 2022 09:00:12 -0700 (PDT)
Date:   Fri, 19 Aug 2022 09:00:12 -0700
In-Reply-To: <20220819122008.1561-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000761b3f05e69a3131@google.com>
Subject: Re: [syzbot] possible deadlock in jbd2_journal_lock_updates
From:   syzbot <syzbot+79e6bbabf3ce17357969@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+79e6bbabf3ce17357969@syzkaller.appspotmail.com

Tested on:

commit:         ca688bff Add linux-next specific files for 20220808
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=151d45e3080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4c20e006003cdecb
dashboard link: https://syzkaller.appspot.com/bug?extid=79e6bbabf3ce17357969
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1267b2f3080000

Note: testing is done by a robot and is best-effort only.
