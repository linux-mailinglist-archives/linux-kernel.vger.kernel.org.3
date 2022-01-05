Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1BE484C34
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 02:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236950AbiAEBkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 20:40:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234393AbiAEBkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 20:40:06 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720E6C061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 17:40:06 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id u21so48920228oie.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 17:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iyhHcB5elDgUXWbmyQDE/CVVbmtcmn6z6cYdqpJrjcc=;
        b=f897XoCAcGAhRYRw6I79a6y0wZPc/i4EWI5SvH+QVjEEMyu7rEwZhC1qCx+7V9D5rB
         QTlbNZBSzex6wORg2YpRjsJa7bNwFZZ5q54YX/KLMgi7dsUZ3y6/2hzOyA0V26D//THp
         ByR9FkfQ+Xh/WGinkBMj9CR6Nt4KgJrCa3+I5QndjKMX7zgJlfyfqhpgInz6UC7A5ubj
         lBbw/ZyFqftiap+3V7HJJ6Z6Vh8DYIJ+bpVvGGtNb9faIF1QufE2yY2rZBXudg4o6DuM
         PICd7Uof4JRVZS4Uzsb2XmUtiBBwkxJ+0hNYY1r8IsUlx1+cZ3PbGwl5lqXcJUWQbOiR
         zRew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=iyhHcB5elDgUXWbmyQDE/CVVbmtcmn6z6cYdqpJrjcc=;
        b=wBnxR+aZMK1uKpMDd82zdqsBlDUs3dpN935Th043/raYBq1iYpIXH+aP0+r7cIMwFx
         ZjTKyG9oUOd4FGfmpd41yt7axMpvHcB+mXMGTn5BfYLV/60ip7lLun2d7aoQzoO3OZqa
         N3GE4to0yGEngoVHJE7aAAfyHfEto8/VaSKNJdgzcfD8oRzAIS6wu035tgn5FE2uIeyC
         lwfpJmCQmxE21dwZNW8xet1qr/IT1DeWmjU92LzHUzAPtxMeIC1oP7dVSDMiOcoASMaM
         3p81EWwSXgsXPf/xe/dKhv6FMtc3ckExkKcK4S+52yL76osPiOV/JVxfHQHHJhNoBhku
         G3fQ==
X-Gm-Message-State: AOAM530kcDyfrMHnA3qpDzlqxB68qxPSu4LD8/L4IGsrfOtoMYi/DwOz
        kASP9mpGzmD6bOAi7XqQmsCDLcXvLVI=
X-Google-Smtp-Source: ABdhPJy10PMqwu4IMoc6eHvHtTTE48TKwijpAdzQOkkNU00gb70SwMCTHG0vZmDCQIk73mV2aK+URQ==
X-Received: by 2002:a05:6808:b16:: with SMTP id s22mr835837oij.52.1641346805798;
        Tue, 04 Jan 2022 17:40:05 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t26sm8036786ott.28.2022.01.04.17.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 17:40:05 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 4 Jan 2022 17:40:04 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.16-rc8
Message-ID: <20220105014004.GA2893410@roeck-us.net>
References: <CAHk-=wg=3dEpPGhz8YvJUDWhFW_GUeASBGmqyw3aPQRfB3ki9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg=3dEpPGhz8YvJUDWhFW_GUeASBGmqyw3aPQRfB3ki9w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 02, 2022 at 02:37:22PM -0800, Linus Torvalds wrote:
> So as expected, this is a tiny rc - there really hasn't been a lot
> going on during the holidays. Even now, not everybody is necessarily
> back, and we'll likely have another very quiet upcoming week and then
> I'll do the real 5.16 release and we'll hopefully be more or less back
> to normal (and thanks to the people who have already sent me pending
> pull request for 5.17 - it helps me to have them early, since I'll
> unfortunately have some travel during the upcoming merge window).
> 
> The bulk here (and "bulk" is probably the wrong word to use, it's all
> pretty small) is gpu and networking drivers, and some core networking
> fixes. There's some other minor noise in here too (usb, i2c, input,
> auxdisplay, scsi, perf tooling), but it's all very small.
> 
> Please, as you emerge from your holiday-induced food coma, do give it
> a quick test so that we can all be happy about the final release next
> weekend.
> 

Build results:
	total: 153 pass: 153 fail: 0
Qemu test results:
	total: 480 pass: 480 fail: 0

Guenter
