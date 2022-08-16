Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3123E595B79
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 14:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235201AbiHPMNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 08:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234968AbiHPMMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 08:12:40 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1487823A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 05:07:07 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id g22-20020a056602249600b0067caba4f24bso5822906ioe.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 05:07:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=BfoNF+003bgEMkMGaYc3NGH0AuXwcMTieITtAOOMKTE=;
        b=dtTZHyKwjbslXRFlEiuGw78ZQ9QqP6VKsUryKP6pBP4T6LZ2M2KuTRp63i2j6i4/aN
         5V5bH9MkelibXAoLrL3BcftTXadiTHQQpPSNeTIsHD+zwaUu89jtooYYwPzOCHZF8BFD
         Ozcmjuwf/RbePUw80UcVlhaDkLoDVoTEIpG8Z0uwCJ9nkdXXkeJOAB63ToXtiKArpUmJ
         bXvI0JCF3t4cvMQBdO2EtfMukr+1QI6nhf6xPwrhznRyTq/NyHdayQTB/0vFrDCaZnpV
         r1umjNrQVYWVDp3oL4aSgYP2p99u9Gv+UIipV0HABZQb68jbRvVln4HCmXHTAEGP4fzO
         6qAQ==
X-Gm-Message-State: ACgBeo3ybI2dhFdrPgRnrJXZqbUblrdskdJvnTQeiOTqp1+F8it0cEZP
        v5CSNRJaFmmBw7fSeCLgnbd34KP9gtK/o3sudnEB/7KUCMYl
X-Google-Smtp-Source: AA6agR4MlTO15N9gHgQVIfvM6oGmtJGRSxYQrtlZ2qYNJp6YuAg9FOgrJWZ31rXtaFwKKuuCAYRCzl9zEKjsRTG2TZ3uXpSY8HNF
MIME-Version: 1.0
X-Received: by 2002:a05:6638:210d:b0:343:17cb:60a7 with SMTP id
 n13-20020a056638210d00b0034317cb60a7mr9606899jaj.292.1660651626758; Tue, 16
 Aug 2022 05:07:06 -0700 (PDT)
Date:   Tue, 16 Aug 2022 05:07:06 -0700
In-Reply-To: <20220816105922.966-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004f0e5705e65a96f2@google.com>
Subject: Re: [syzbot] WARNING: suspicious RCU usage in bpf_sk_reuseport_detach
From:   syzbot <syzbot+24bcff6e82ce253f23ec@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+24bcff6e82ce253f23ec@syzkaller.appspotmail.com

Tested on:

commit:         94ce3b64 net/tls: Use RCU API to access tls_ctx->netdev
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11bf00cb080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=53da55f2bdeb0d4c
dashboard link: https://syzkaller.appspot.com/bug?extid=24bcff6e82ce253f23ec
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=171d056b080000

Note: testing is done by a robot and is best-effort only.
