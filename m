Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792724F5D61
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 14:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbiDFMB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 08:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbiDFMBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 08:01:32 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21BF54A2AD
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 00:43:14 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id y4-20020a6bd804000000b0064c68fa4f70so1118202iob.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 00:43:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=MkeNPOor3tp1MVRA9nQqdb5POaUs2uj19lBDdaMJKro=;
        b=TRDwWKi0hY/71m2qoZoVgvGvTKbJH9VzS018bABUUrAeoSmCyGMde1ZOFDpHBEuGdE
         CI/gzhgktGN4prc8a3urQLjmTcAMkO6+4n/FlQGtv7TjS7Xinbe1nJDmpZLk3Ood/eME
         BMBAloKbaFHkKcGIE9OuFvCSyphJY1EqLg8DVNkhbXi6qa4Z1ovm7bemrhR+Y2Mv5sbn
         ussWvcX01NWaAfXUkG/C3Hs6YuY2aK340dWqWQxzPY/s8XwH+JEvayTaPhIVL2fmdNXE
         i8S5ooftpW20zknhmy3cfsFId5q4EpHkNdPBy9RItdRyhPmpyrlfLG8Brkp7cTyNygO/
         V1+w==
X-Gm-Message-State: AOAM533KErUHAJWEcCplFe7QdS62ouUzpsybzpAP6ZFb2EOgNSMm042O
        Nh4mDuxuqkUW/cXcsh0tXH+zZO2SdcsAmu3yXpoMHMaEzrW8
X-Google-Smtp-Source: ABdhPJzjqrtDt3g+hvSHz2sMORelLCH2R9488TmKUkOOM8Ak87C1BQXNZkmHHmVXaulpT9M5Z9n4pFFNkLJpKX79ZXK25/41R2Bq
MIME-Version: 1.0
X-Received: by 2002:a92:c244:0:b0:2ca:1a82:2364 with SMTP id
 k4-20020a92c244000000b002ca1a822364mr3574008ilo.69.1649230994038; Wed, 06 Apr
 2022 00:43:14 -0700 (PDT)
Date:   Wed, 06 Apr 2022 00:43:14 -0700
In-Reply-To: <20220406073118.5627-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008d656e05dbf783bd@google.com>
Subject: Re: [syzbot] general protection fault in simple_recursive_removal (2)
From:   syzbot <syzbot+17404da5afdf21e8d612@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+17404da5afdf21e8d612@syzkaller.appspotmail.com

Tested on:

commit:         ce4c854e Merge tag 'for-5.18-rc1-tag' of git://git.ker..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
kernel config:  https://syzkaller.appspot.com/x/.config?x=595bcd2109a73f9c
dashboard link: https://syzkaller.appspot.com/bug?extid=17404da5afdf21e8d612
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1353fd30f00000

Note: testing is done by a robot and is best-effort only.
