Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93393539A04
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 01:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348637AbiEaXXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 19:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237601AbiEaXW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 19:22:56 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697B8939D5
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 16:22:55 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id u18so143910plb.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 16:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=FKa/exg80q3Okni/CqHYIJ750Grih4tzVzwD5wDdMrk=;
        b=2jk4pcLua88t2dFrSqdSOuzeQo4JdMC8qT0jX+1K/Y2Hzl4X5eLNpSH18ruVc8z9IB
         mmhTM6Ef0Qm8P5mW/fJTWwvOhi52djawAZ4l3SmHR2zhvP6W/N8FuIzoutR+P4CdGCtS
         nWdRMMfoLy4nosxsd3Tr73cWuHnmsJ/oUloRNZnkIOpeoAr0CSl3m4o8CZqqfE/32jxV
         8yl5fweKk4s+qFBVUkrz4X7EVgRZBhueE4qpzm9PQMlRtLscQEuj6Vx0SsPBG9R8G36V
         RPr8LbAFjSGYZSRa1LQmO/HZy3G6Ge3bcPkm12VE0wrLVlNo+ohQEIueMLe0d1MLsQky
         pGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=FKa/exg80q3Okni/CqHYIJ750Grih4tzVzwD5wDdMrk=;
        b=crzZFSeF4mN0aBJdtjrtKQ943r3CTjwi8gNBHGOY5jbydz7i88EFkYZenlUJpFFXPc
         YqH5bpWE8vXsuDvZ/wSD41xpqlsc1mxPLjAMgW0lfB6jRxji22pQaI5S1NOaUSAI8KVs
         I9YphaIb76k8IKy6B78aHswXCOEooj3EN31NGiVkUL2I2nl3cdMSVxz4IZW/srjl9H7s
         CJJJzHESoAmkw+dtvQCQwrrJDnRiAkE3MP55VpdpPTTOvgwD+mxE3eaAI0F8OAnCwKOe
         MjlCvHvOWiXo1gwunV9McrYvagTATTDub6TLxJQdHPZcwBUhnsBHsC2CtxUHsojtx7OV
         qJ1Q==
X-Gm-Message-State: AOAM531x0StoX9ftsgRAMnbNKsObII9I5T08HwNTaaP+bWTlHDKQyGoO
        eXSjVHje4rvM9VXkol7OdknIwtywdRCbwg==
X-Google-Smtp-Source: ABdhPJwrGZs7IUC2JzbLIn3lRMOLiBR0ER03E5PHcGqnVKAOPXe5sDdBTFXcvWVVpAurdfHRc7Y/2w==
X-Received: by 2002:a17:90a:5c84:b0:1dc:9b42:f2cf with SMTP id r4-20020a17090a5c8400b001dc9b42f2cfmr30970168pji.123.1654039374887;
        Tue, 31 May 2022 16:22:54 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id iz18-20020a170902ef9200b0016363b15acasm87280plb.112.2022.05.31.16.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 16:22:54 -0700 (PDT)
Date:   Tue, 31 May 2022 16:22:54 -0700 (PDT)
X-Google-Original-Date: Tue, 31 May 2022 16:22:51 PDT (-0700)
Subject:     Re: [GIT PULL] RISC-V Patches for the 5.19 Merge Window, Part 1
In-Reply-To: <CAHk-=whMTEAuBRAS7aonfVM9wgupOok4HO6gX9X0FBzE3Uv2sA@mail.gmail.com>
CC:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Message-ID: <mhng-c2485265-8142-4d5e-9b9f-2b63d1e01647@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Arnd, who probably saw this already...

On Tue, 31 May 2022 14:52:16 PDT (-0700), Linus Torvalds wrote:
> On Tue, May 31, 2022 at 10:13 AM Palmer Dabbelt <palmer@rivosinc.com> wrote:
>>
>> I have a single manual resolution in the fe510 device tree, just the result of
>> some conflicting fixes.  It's not showing up in my merge, but a bunch of other
>> automatic resolutions are which is a bit worrisome on my end -- I don't usually
>> touch other trees, but we had a handful of big cross-tree things this time.
>
> Gaah. I'd have normally preferred for things like this to go through
> Arnd, but it looks like he at least ack'ed these things..

Ya, makes sense -- I don't really like touching other peoples' trees, 
it's a headache for everyone.  There is a bit of overhead involved in 
doing one of the multi-tree merges, though, so I'm never quite sure 
where to draw the line.  We did one for the spinlocks where it was 
pretty clear that was the way to go, as it was used by a handful of 
trees and didn't take that long to get the RISC-V bits cleaned up.

The compat stuff was a mess for a cycle or two, though, and RISC-V was 
the only user of the new bits.  I always feel bad trying to dump messes 
on other folks, so I figured it was easier to just fix it myself and by 
the time that happened it looked like everyone else had stopped paying 
attention.  I poked it a few times both before and after putting into my 
for-next, but with the Acks I just took it.

After seeing those conflicts I kind of wanted to push for it to get 
merged a different way.  Had it not been both before some other 
stuff and a persistent headache I probably would have just sent the PR 
before that merge and asked folks again, but I guess I just wanted to 
finally have this one done.

Though now that I say that, merging something because it was a headache 
is probably the wrong message to send folks... ;)

> I've obviously pulled it, as you can see from the pr-tracker-bot reply
> that already went out.

Thanks, I'll try not to make a mess next time.
