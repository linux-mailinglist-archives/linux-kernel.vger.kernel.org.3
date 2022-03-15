Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2924DA3E5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 21:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244955AbiCOUXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 16:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240623AbiCOUXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 16:23:19 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFCF3467A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 13:22:06 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id g11-20020a056602072b00b00645cc0735d7so58994iox.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 13:22:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=WEkhoTVVedY5DexXEQJJfW/um3h2zWtR80MaPcoaP2Q=;
        b=bYL4rbmAjtreqjrIlNxYQFxLgexilbWut/gnjPv8KCjwNrjwEFat8OqWF4U1OSnISD
         ehrTkDyTpsjhL0+FVaLeCE8sATx6bVpuJW2hrgrSHuywGW7p3zWRAsEN1+SokRt/rIjn
         Jc8TqBpT5296JhdzR9JuVxhRjX6tUo/PsV3knTZcgOXFdAGigKnYHy3dTvo0r02hbVQR
         spI2B9KSTf1jfn6Pb+nhCx87u0jCcgdRPsx1iAksBxoIBN71XJBUqLHRqPWhH0a60rJl
         NS+UvSasYxRu6d9H3OwV+PUepkaYAt0qb/TxvW7Qe8FXYcVXEPo117XcSzDfQgF250gF
         0GGQ==
X-Gm-Message-State: AOAM530eB6yfLwG0ar31OfnORktECEs6ALRNgEU37J47b8gdnpPU+pLv
        ts0uD05Gox9hB4scJ6UPNq1sIYokImfaTbTO3vRVZ1rNaBRC
X-Google-Smtp-Source: ABdhPJy27TvSFLmnt7700rf9BDQ+MGeQcOZFU2USh3j36Mwz659RgtdxE7YraE1wqVt42BhXVM+2W4Iz7z9xA/vdB+E2ah1B6o8H
MIME-Version: 1.0
X-Received: by 2002:a5d:8552:0:b0:63d:8cae:b2ca with SMTP id
 b18-20020a5d8552000000b0063d8caeb2camr23112544ios.81.1647375725894; Tue, 15
 Mar 2022 13:22:05 -0700 (PDT)
Date:   Tue, 15 Mar 2022 13:22:05 -0700
In-Reply-To: <a30ec1e7-564f-665b-7c20-54dad6124418@linaro.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f422ca05da478cae@google.com>
Subject: Re: [syzbot] kernel BUG in ext4_ind_remove_space
From:   syzbot <syzbot+fcc629d1a1ae8d3fe8a5@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tadeusz.struk@linaro.org, tytso@mit.edu
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
checking file fs/ext4/inode.c
patch: **** unexpected end of file in patch



Tested on:

commit:         56e337f2 Revert "gpio: Revert regression in sysfs-gpio..
git tree:       upstream
dashboard link: https://syzkaller.appspot.com/bug?extid=fcc629d1a1ae8d3fe8a5
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14bf8361700000

