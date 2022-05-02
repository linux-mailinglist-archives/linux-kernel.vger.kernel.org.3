Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4993A517447
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 18:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242889AbiEBQdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 12:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241610AbiEBQdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 12:33:06 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34952BF4A
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 09:29:37 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id s131so15725345oie.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 09:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yeGLd+sTT5KTfYeCPCekLm64hqp1R2sASd/9fl8jRdA=;
        b=ixV5KorB8y8CRMOGsXHN1x2h6ELpPj38HPNfW9zoGwnhK8Y0UeiteOIrxMPFvQBr4W
         OVyfSlqXLRqEbYI/OkvfS9ZinYdFSYxcJY0dXpEe12qFC4gSJJQGSjNfX0MaqWF4aHZc
         jJcByL7lLCH9CN7cquxOJQdipejvSVLEutfvIMyrovnDTMEkrNt1hG1/ibEKln+DVM2e
         iZ5HeyAjBATFpWCgL8D6D4yoPMQbyq7VE8vwU6elM1O7doQuHESqTZcoapkKhayQFuM9
         G0/nV2oU/Dc6mxCgibXipBotNCELYWIL7sZDxu0NSywutsECOghQfPi/b2xtPVKy8uHc
         ddAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=yeGLd+sTT5KTfYeCPCekLm64hqp1R2sASd/9fl8jRdA=;
        b=NpD6iXpPrJhmnaEaqEGJ4D+vGbAwyN3UuwD2y5IDafW9Qn4E7L7uF4WJQROUcSK40B
         fa2kFH09wFGfYslmO5Z+bFZoQ+uzfOIhWFI0W81dj1p8Uqc8R9CdsirMS0pn72Olfd+n
         FXoJ65PlJSNkQmBn9arXpxOLkW/Ilui5Ejxe53aIIj+VahwWDy3KfbRFNc092KFZeNID
         m96X/F/6hhQk34qUgxFDAPsRYxgqANUh+S9M1YOYREGhVclKR/3Q7oT700jpZOXyh9Qo
         8/mg2BFQJEUffzBfPFNtkahSWHK6chtzwLl7eCka4RqiB19vX/YlCCe+exQ77MkosLCP
         TyLA==
X-Gm-Message-State: AOAM532rhcLAYSD+tNAL6BspD9aVC+x3fpVIszhibDm5X38/eHaQO6pZ
        p7/4AZ5giUSn8Gl+Lp1WKawPglIidK08lg==
X-Google-Smtp-Source: ABdhPJznkf9x6RfyL7nq8oW8hm3r9Z6VXo+AZBYcTg7vlnHkPL8/I1nDDGbkHv0Nh50+2PVCJYFnuQ==
X-Received: by 2002:a05:6808:f90:b0:325:4a7:5555 with SMTP id o16-20020a0568080f9000b0032504a75555mr7569340oiw.157.1651508976516;
        Mon, 02 May 2022 09:29:36 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e15-20020a4ad24f000000b0035eb4e5a6b3sm3946291oos.9.2022.05.02.09.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 09:29:35 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 2 May 2022 09:29:34 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.18-rc5
Message-ID: <20220502162934.GA981862@roeck-us.net>
References: <CAHk-=wjUhfhaes6_hMYDQFTbGjkmA-j2ZSeXZ32H66ufRfYrmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjUhfhaes6_hMYDQFTbGjkmA-j2ZSeXZ32H66ufRfYrmQ@mail.gmail.com>
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

On Sun, May 01, 2022 at 02:13:49PM -0700, Linus Torvalds wrote:
> So if rc4 last week was tiny and smaller than usual, it seems to have
> been partly timing, and rc5 is now a bit larger than usual.
> 
> But only a very tiny bit larger - certainly not outrageously so, and
> not something that worries me (admittedly partly because of that small
> rc4: it doesn't feel like we're having any more issues than usual,
> it's just that the work ended up shifting a bit to this past week).
> 
> The diffstat looks normal too, although with an odd bump for the n_gsm
> tty ldisc code. I could have sworn that thing was legacy and nobody
> used it, but apparently I would have been very wrong about that.
> 
> That small oddity aside, nothing surprising in here, with about half
> the patch being drivers (mainly networking, gpu, pincontrol, clk, usb,
> and that tty gsm thing), with the rest being the usual suspects:
> architecture fixes (kvm, some arm dts files), core networking, tools
> (both objtool and perf) and some documentation fixes. Add in a few
> random things, and you have rc5.
> 
> The shortlog is appended for people who want to see the details, but
> it honestly doesn't look very interesting.
> 
> But "interesting" isn't what we're going for - we're past the halfway
> mark in the release, and "boring" is very much what we want.
> 
> Please do test, and hopefully we don't have some silly brown-paper bug
> like the no-mmu breakage in rc4.
> 

Build results:
	total: 151 pass: 151 fail: 0
Qemu test results:
	total: 489 pass: 489 fail: 0

We still have

WARNING: CPU: 0 PID: 1 at fs/sysfs/group.c:115 internal_create_group+0x360/0x394

for parisc nosmp boot tests, but that is fixed in -next and not really
critical.

Guenter
