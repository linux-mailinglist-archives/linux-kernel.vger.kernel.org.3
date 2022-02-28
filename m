Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5384C6959
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 12:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235387AbiB1LHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 06:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiB1LHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 06:07:01 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3FE30F5D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 03:06:23 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id e23-20020a6b6917000000b006406b9433d6so8315670ioc.14
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 03:06:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=NGeRMKnns/CkUBI5ujUz37hjPuAcdJGxEeUdErwvJTg=;
        b=dfDam53E2hSbMiq0xgRz2BgvOf2GUaSAArLd7PbIVxDAF7j89DqWegcGO2yQDGsrAm
         S+WogvngOkMD8wrV0zA/3uQFnXqnANbk6tXrDIboIXV0NoBEcVRXS950nuJQRVSX5WGf
         YzHvSL7GYU+msJRpRRKpBi/yShgVnOGLGxTyhjAZxdvAEYXo0HKlJsW2B405mxz7wl25
         CPdKfboFHsv12qTxIU0xagZOfJC30HJbchyzHhh/+CJGzz/89gWywmQ/pdrBayUsI3T6
         QsONO2vxoNop/iRs8jlnKG6U5JglzYut8V1dlxTaFaAM1814MPyqgCsOKh8Vh3HGXBNA
         c4IA==
X-Gm-Message-State: AOAM530CeIx0SD8IXXXJDb4J1FDftkzjXs/iIijR20fyGkvOuxn1ILM+
        zirJS/oW179Uu8mwzQW9LX7nsNBUu/zbeepbR6U4f6u4vu91
X-Google-Smtp-Source: ABdhPJxeTFVWqRcnYQKyeoUA5fs9iql/0PWMeiaUOHnhz5OQep44nI/xLdBW0DeoycNoFKhdyFNXJ09Y+uZkA9tshqS68Y5B1qpt
MIME-Version: 1.0
X-Received: by 2002:a02:b19e:0:b0:30d:d9f5:d03c with SMTP id
 t30-20020a02b19e000000b0030dd9f5d03cmr16825134jah.19.1646046382076; Mon, 28
 Feb 2022 03:06:22 -0800 (PST)
Date:   Mon, 28 Feb 2022 03:06:22 -0800
In-Reply-To: <YhysqzlMHWTXLR4B@linutronix.de>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e3387805d912097c@google.com>
Subject: Re: [syzbot] linux-next test error: WARNING in __mod_memcg_lruvec_state
From:   syzbot <syzbot+a526c269335f529d25c8@syzkaller.appspotmail.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     akpm@linux-foundation.org, bigeasy@linutronix.de,
        cgroups@vger.kernel.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@kernel.org,
        roman.gushchin@linux.dev, sfr@canb.auug.org.au,
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

> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/bigeasy/staging.git 71d365035711aef4c4b1018d02fcf7868e3cb0c5

This crash does not have a reproducer. I cannot test it.

>
> On 2022-02-27 22:09:43 [-0800], Andrew Morton wrote:
>> (cc bigeasy)
>> 
>>                         WARN_ON_ONCE(!irqs_disabled());
>> 
>> in __mod_memcg_lruvec_state(), methinks.
>
> This report ist from before you added
>    mm-memcg-protect-per-cpu-counter-by-disabling-preemption-on-preempt_rt-where-needed-fix.patch
>
> to your tree. So it can be ignored. The next -next tree should be fine.
>
> Sebastian
