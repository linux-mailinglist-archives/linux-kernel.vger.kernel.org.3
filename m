Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D01A58F07F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 18:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232864AbiHJQhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 12:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiHJQhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 12:37:09 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C776DFB0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 09:37:09 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id s16-20020a5eaa10000000b006826060b7e4so8305809ioe.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 09:37:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=HftqFYxeFfAF1kajnG2GvwJLO2W0mn6ihIoeRrq/ih0=;
        b=V0bP1DGav4JAA7s53rYOrnt0s6yhTk2YJ7WqjjRVZtknSQ7BTif3iDPdrXKe9rQ0HK
         gYskF0hqGX7pnbmC0rDy/X6dlhIljTEAtjPwgeItOlOQ0jNONxDLGINorfhAs7Oh3CiL
         FoE3+D/EOv7mscGy0IqTdRZwasM+il6P6gjOgfomlEDp0YSn9I99TOn5JUvBEAe2AIzf
         DHFRIfRxR8d7m6iakxsR65YFL4J/7C5CltXqwqgw0HqLy3LVQ8LlxDIapf1cz2XG9X0x
         kU/sqqi/N3MFW3mrSLXLunFXdO3XzANRIY+sv5dvKNqufTcmWZ01KlWEtDyWDAyiNsjd
         uM3g==
X-Gm-Message-State: ACgBeo3RkEgzRAt6AEvjskGS6AAAla9i30LstoFizwSeax3LnS3r0Aut
        V7Zb78esv+EBrUWxltc7k3oMqlY9gAzK2yymMkocBvCSYzED
X-Google-Smtp-Source: AA6agR7VyFKsr9L0OoqYUhypsy3NSMzF1ZozSTqCPrgmt1L3V/tpLVBekRYGzCb45aCGVCI9GkbtJPOBlc8syxSrEINfoHzg1kd/
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a63:b0:2df:3655:a661 with SMTP id
 w3-20020a056e021a6300b002df3655a661mr13739480ilv.187.1660149428404; Wed, 10
 Aug 2022 09:37:08 -0700 (PDT)
Date:   Wed, 10 Aug 2022 09:37:08 -0700
In-Reply-To: <20220810111831.2626-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f44a2905e5e5a89e@google.com>
Subject: Re: [syzbot] INFO: trying to register non-static key in gsmld_write
From:   syzbot <syzbot+cf155def4e717db68a12@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+cf155def4e717db68a12@syzkaller.appspotmail.com

Tested on:

commit:         ca688bff Add linux-next specific files for 20220808
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10fd0705080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4c20e006003cdecb
dashboard link: https://syzkaller.appspot.com/bug?extid=cf155def4e717db68a12
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=168d3fe1080000

Note: testing is done by a robot and is best-effort only.
