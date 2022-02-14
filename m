Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28E164B3E84
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 01:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238832AbiBNAFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 19:05:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbiBNAFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 19:05:43 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E745651E5F
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 16:05:36 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id x193so15879047oix.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 16:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=snIn7NtEKu1qsq+HPHuUn19fynNzzPiisikY6pv4Ar0=;
        b=WGQb+FxvNcRxUgr1oU5OIdpjb6cLqQ6p/09zgqImtNcQni+w6BerKp+Mce0vEiqmqv
         I2No9FcyItPkpSaPb6ZMBprFy1Gp4IJ/8v3jryXwqwxcSS4kaIwOUDl1Qs5ICZQZxx5j
         ZQawqCRk180fEFbZ08HUbplq0JHo48+sdVbk8ZfAIi+ZJNzEsCWkjyevZ3OV8Y+9NVMq
         MdK/U78LDootB/oEK2+9AWno4yEbgUd2TwlSA72ZR6LeM3CeG7t/hBtrFyFJHmzGMEzK
         IFfSBWgm4Oi/FwH7fBAuUs+fmseTciZ+YcklFS/GWrePJTFCGCZkWUpMnOFA0lwW8SQa
         Xw/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=snIn7NtEKu1qsq+HPHuUn19fynNzzPiisikY6pv4Ar0=;
        b=2jiixWpglbjNdCc55bpdH5gslkGjOvXYkPxCQGG444mKdQFgHZaZozQY43JOf+ZsuV
         kLyp1iNS+q9EMdAzxBIoBRB7HZh78oy4L+OWHgTpB7OUOQOyYav+9GvvqIgRLAKXv+T+
         R9u3VEAah0vGNVoZQU1K7PON59132YFVHGLpv1UJ7C8XOL8NQj4br+a6VkleEHkHq+6n
         YoTRrV7Dx79LywKXN4R4JWXniZ1OzcKlC1UQ4M1nLZAfJCHyj/rV0CBu+PeIhSNZsCxh
         +66sGgTuxYX/9S2DZ3u/RFMOnujuWfHib7kD8aIwHvPN3aVn4rwq+e59qGmwKoVcB/1W
         k53Q==
X-Gm-Message-State: AOAM5311wM8+R7vcGqQHN0rrLUoGsZOiz8sMxCrTT+mn5AhAiszZxH2m
        KdsyTarTVw8kq+To4udlTR+tMUVTEDmctQ==
X-Google-Smtp-Source: ABdhPJykDGBu575L6XcxWhlXge21a/01KZFiG4ACAtPRb/trwksXhaQ/tvRFY5H6cjpTwLg0XybW6g==
X-Received: by 2002:a05:6808:1918:: with SMTP id bf24mr4606248oib.253.1644797136267;
        Sun, 13 Feb 2022 16:05:36 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t21sm11700881otq.81.2022.02.13.16.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Feb 2022 16:05:35 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 13 Feb 2022 16:05:34 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.17-rc4
Message-ID: <20220214000534.GA976691@roeck-us.net>
References: <CAHk-=wgpOhU0cU+KZHA86OsoN2BxqT4ZoTMYHDMuzbiiiKK1Eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgpOhU0cU+KZHA86OsoN2BxqT4ZoTMYHDMuzbiiiKK1Eg@mail.gmail.com>
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

On Sun, Feb 13, 2022 at 12:29:27PM -0800, Linus Torvalds wrote:
> Things continue to look pretty normal for 5.17. Both the diffstat and
> the number of commits looks pretty much average for an rc4 release.
> 
> About half the changes being to drivers (all over, but as usual gpu
> and networking is a noticeable part of driver changes), with arch
> updates showing up next (devicetree updates dominate, but there's
> "real code" changes too).
> 
> Other than that, we've got filesystem fixes, core networking, tooling,
> and misc core kernel fixlets.
> 
> The appended shortlog gives details as usual, nothing in here looks worrisome.
> 

Build results:
	total: 155 pass: 154 fail: 1
Failed builds:
	powerpc:skiroot_defconfig
Qemu test results:
	total: 488 pass: 487 fail: 1
Failed tests:
	arm:orangepi-pc:multi_v7_defconfig:usb1:net,nic:sun8i-h3-orangepi-pc:rootfs

Nothing new here. It should be noted that the fix for the orangepi boot
failure introduces (or exposes) another problem. I reported this at
https://lore.kernel.org/linux-media/20211206131648.1521868-1-hverkuil-cisco@xs4all.nl/T/#t

Guenter
