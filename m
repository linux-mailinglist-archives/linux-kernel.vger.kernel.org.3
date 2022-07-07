Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C39A56A765
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 18:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235521AbiGGQGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 12:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235304AbiGGQGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 12:06:41 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8E92E9CA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 09:06:40 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id j17-20020a056e02219100b002dc4e721203so577647ila.22
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 09:06:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=Ef6EaxbhRWWl9yGrcwKYUAdX/pBweihX45OfiVsisKs=;
        b=CTahiq79S9pNoMM9UnaoP0omDXc7tZByLiUFLy4aJVv0iW+DI6GT5klUgfly43m0h9
         zSvz0kA9OMWfzW+1b7Ddy5qHOOyOvyUwfGeko+LRWK/sTZ690jcpzeTT1cDnlbTqYMhX
         ZTPxNETWmaXtyrR/r1rAgTJHh6HwCjkjaqXgsF9D6HWGQSa2Fff5Id1N95nYmuryXRuw
         zXsKRJrUdVW14d6gCjx2BByaVsLNoDSGUdUAply6ZyEVc/X9+gzEzp/NHhZjFqWmlRMf
         AFRM445MJZORL547FS5LEMRUKoDDClDDUiX1lyTV0TmoUgQCplA8KO7VyfSLPf0cHsAj
         5D1A==
X-Gm-Message-State: AJIora92hkSKKNS/cHPQHRcwKfum4r7t35TjeFgP2L1bdFztDX0c4fGr
        kK2qjVcgHAkZikUozoYipNqlv9YqzeD2ln+g0Hqf4hBnU3FK
X-Google-Smtp-Source: AGRyM1vkNnDgKntPM6HUPetN4DNdMynXMRpG/oOB+J/sKZ78p6g+lQqAwILEx+ChV3Fpo28F7D7DSvqk9IFongu276gGFPQ8e6Fl
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1310:b0:33f:1f49:26be with SMTP id
 r16-20020a056638131000b0033f1f4926bemr1563287jad.141.1657210000099; Thu, 07
 Jul 2022 09:06:40 -0700 (PDT)
Date:   Thu, 07 Jul 2022 09:06:40 -0700
In-Reply-To: <20220707160545.7731-1-code@siddh.me>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005fcfa605e339458c@google.com>
Subject: Re: [syzbot] linux-next boot error: general protection fault in add_mtd_device
From:   syzbot <syzbot+fe013f55a2814a9e8cfd@syzkaller.appspotmail.com>
To:     Siddh Raman Pant <code@siddh.me>
Cc:     code@siddh.me, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-next@vger.kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com, vigneshr@ti.com
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

> #syz test linux-next master

"linux-next" does not look like a valid git repo address.

>
