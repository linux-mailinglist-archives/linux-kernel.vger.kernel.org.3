Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A825D572CE3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 07:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbiGMFHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 01:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiGMFH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 01:07:28 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27774C8E95
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 22:07:27 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id y141so9275788pfb.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 22:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0zrCOg5AGslBs6QuY32No58qTlOSvD8WCmFSfSxxXuk=;
        b=Lxov7rPU6PR+7iNyeqTFyEENwDTA/MkHmsplx/o8dXP05bfaZHIUsHsAXY1rJe4kAY
         nLpZUY1uyzEmjdIMMPYoKmRSMDvhn7isXqQSxiFnWFwSAPw6QEBAoWJDsNBHqqIco0cQ
         6m4lVCII6hWn9muqOb8onfYQupKWc8TjARoVVyvFyrAkPUMJG2wYJlrcIoRm7bFtMgRW
         npDSDi4K9sJcjHp16VvI7wiKqVqTsfuOze6x8ydZFdkY0ZK5e4tbkEV2qC0VlCcrPgI+
         k60fC1IDtHJUP97upx0N80J8ovk4rOB12ffYMcjW0IYqh7RsJFarEVFQK//IAzkKQAQR
         LExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=0zrCOg5AGslBs6QuY32No58qTlOSvD8WCmFSfSxxXuk=;
        b=0y4mKFuEyk7mNrDA6a6FbkU5FZE1bvmW2N4Kp5sWVUJzwaGV+gMVLkabY8nlICcfT9
         YHDKvEdQQhmKxKzH7/tMju++S8SLYkDCXjzDnVTZ1MyuQYyhZN673LV/PdykXQD8nebr
         t7TnCSyryMoiMfeRAt4aJ8eJi5/JYORp3pRXOwLp0nCBBRYdfS3r8MoEOUzyHZqGIQYK
         bUmeQJ6Fnk97yroVOt4SIKpXvXbL/3nOqQnvUxDP+aFvjjDajjoutJLi+zTy8/r6Zs+O
         DecQfVPhVwa6ruXeUW45/HMt2jaTeeadlGUsINCZyu+tBE9VNIUXj7UKWkmRnqdIke99
         wo7g==
X-Gm-Message-State: AJIora/R86A1gTupmJ10wsYYken46ItTV1VIhr5cWhXM2QWRYaZS2isM
        KUdsbYoSQo3WA/6SLyK6/vlUFBoWw5nrkg==
X-Google-Smtp-Source: AGRyM1ssy4E4Y4chHEGaMhOEdtT1LZPr3ydm2I+tAOhnjs6m48j2j/Q0L+M+8Gb0TsAlBVAinqhBAQ==
X-Received: by 2002:a63:ed48:0:b0:40d:9866:6834 with SMTP id m8-20020a63ed48000000b0040d98666834mr1495136pgk.324.1657688846564;
        Tue, 12 Jul 2022 22:07:26 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id lp2-20020a17090b4a8200b001e87bd6f6c2sm258504pjb.50.2022.07.12.22.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 22:07:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 12 Jul 2022 22:07:24 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.19-rc6
Message-ID: <20220713050724.GA2471738@roeck-us.net>
References: <CAHk-=wgTmGaToVFdSdoFqT2sNkk7jg2rSWasUYv-tASUZ2j_0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgTmGaToVFdSdoFqT2sNkk7jg2rSWasUYv-tASUZ2j_0Q@mail.gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 10, 2022 at 02:54:10PM -0700, Linus Torvalds wrote:
> Things looking fairly normal for rc6, nothing here really stands out.
> A number of small fixes all over, with the bulk being a collection of
> sound and network driver fixes, along with some arm64 dts file
> updates.
> 
> The rest is some selftest updates, and various (mostly) one-liners all
> over the place. The shortlog below gives a good overview, and is short
> enough to just scroll through to get a flavor of it all.
> 
> Perhaps somewhat unusually, I picked up a few fixes that were pending
> in trees that haven't actually hit upstream yet.  It's already rc6,
> and I wanted to close out a few of the regression reports and not have
> to wait for another (possibly last, knock wood) rc to have them in the
> tree.
> 

Build results:
	total: 150 pass: 149 fail: 1
Failed builds:
	powerpc:allmodconfig
Qemu test results:
	total: 489 pass: 489 fail: 0

Same problems as every week.

Building powerpc:allmodconfig ... failed
--------------
Error log:
powerpc64-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.o uses hard float, drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_resource.o uses soft float
powerpc64-linux-ld: failed to merge target specific data of file drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_resource.o
powerpc64-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.o uses hard float, drivers/gpu/drm/amd/amdgpu/../display/dc/dcn315/dcn315_resource.o uses soft float
powerpc64-linux-ld: failed to merge target specific data of file drivers/gpu/drm/amd/amdgpu/../display/dc/dcn315/dcn315_resource.o
powerpc64-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.o uses hard float, drivers/gpu/drm/amd/amdgpu/../display/dc/dcn316/dcn316_resource.o uses soft float
powerpc64-linux-ld: failed to merge target specific data of file drivers/gpu/drm/amd/amdgpu/../display/dc/dcn316/dcn316_resource.o

My attempt to fix the problem was rejected, but I don't see an alternate
solution either (or at least I was not copied on it, and the problem still
persists in linux-next).

plus

OF: amba_device_add() failed (-19) for /amba/smc@10100000
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at lib/refcount.c:28 of_platform_bus_create+0x33c/0x3dc
refcount_t: underflow; use-after-free.

I won't report again unless there are new problems or any of the known
issues are fixed.

Guenter
