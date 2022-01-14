Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8D3548EA5D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 14:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235859AbiANNHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 08:07:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235435AbiANNHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 08:07:22 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CF0C06173E
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 05:07:22 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id r16-20020a17090a0ad000b001b276aa3aabso21994364pje.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 05:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Z0NkaBOzgvDQnSJ4jvXCY6LqU2hqhhzJbfXjrrmCm7I=;
        b=Bs7JM1wXbxZXSJm1Za1YpzTj04UZSBvKBqwe2MMoc7NUszFU2lijGEA9CeAGY8jvVW
         d04UnJO7PFtef2HhvxtRsfLCunCjllWSLnr3uoBJ8DL8lHbK6rjNaDDUYi5nD/3CvAEG
         kXtVZRLAauLokmtsuNEBA3Q3TwjCPlZVztzVmD0/PhYiSCBy/2eS8FCnXsd4Po94zllL
         Uy4AVIhv9Hn9/YwNJS1CzQrTa1zwvu2muyTTR50+oAn6G3bjrloLQnVhJUh0SF1vZ/Mj
         Tyj0hHAA8m8t3yqX/Wq/sgO8WrDLoU3NvEFuO+Hp+Vxfo/chWLMDSrEWk7tKmsoc4kzO
         VLLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Z0NkaBOzgvDQnSJ4jvXCY6LqU2hqhhzJbfXjrrmCm7I=;
        b=SZQcTQKELRtqOn9tnwXkr3IhzATvm4jKPXyVnsXAOiWvCw5sdxuooqftjVEu+2EPK5
         W4xubzLxu9rblsPxAE2fC+8Ui6HiY+mfcJz9Ivcpi4m3pTwsPvrGzkV/a0qN+PNl1hLh
         lDRshSEGXrZV9xQ++kiNE0c/fBa0Xw87A4WeSJl/mQSAqASEj7jtUy4HeGY6fuOrVC9c
         hJoVDJd+v9OicKi018wHkwpuVSQTdE2lY+Q0Li4U9XyfpCiht8fq+25wVAU08xclAZqY
         3k1RHO3ytMp5caFnJB0JD3thyjaN92GQ/Zgz7C7o0aakcofAOKrj7mBPuztWkc1FL4mI
         6onQ==
X-Gm-Message-State: AOAM532bCtNxWrs0LbWmPMEJaX7j7zE/7iOyfuNu+DOJ0wYm6gxc19r2
        S2lHStVeLDLmFmqvw609yHTtuD0uDzs=
X-Google-Smtp-Source: ABdhPJxxlA3aDrBFKZJFxZgX5wfwIud8+NsPYnBGeVnW6zBJKbIAVc6Ra7EQLoh8lylW7+sppnDR6w==
X-Received: by 2002:a17:90b:3510:: with SMTP id ls16mr4112981pjb.50.1642165641375;
        Fri, 14 Jan 2022 05:07:21 -0800 (PST)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id p64sm1591669pfg.41.2022.01.14.05.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 05:07:20 -0800 (PST)
Date:   Fri, 14 Jan 2022 22:07:18 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Openrisc <openrisc@lists.librecores.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] OpenRISC updates for 5.17
Message-ID: <YeF1hpMbYo5PMmkD@antec>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please consider for pull

The following changes since commit d58071a8a76d779eedab38033ae4c821c30295a5:

  Linux 5.16-rc3 (2021-11-28 14:09:19 -0800)

are available in the Git repository at:

  git://github.com/openrisc/linux.git tags/for-linus

for you to fetch changes up to 7f435e42fd6b65fd8759963156e1ef0fb7d213f8:

  openrisc: init: Add support for common clk (2022-01-12 06:13:22 +0900)

----------------------------------------------------------------
OpenRISC updates for 5.17

A few fixups and enhancements for OpenRISC:
 - Fix to add proper wrapper for clone3 to save callee saved regs
 - Cleanups for clone, fork and switch
 - Add support for common clk so OpenRISC and use more drivers

----------------------------------------------------------------
Stafford Horne (4):
      openrisc: Cleanup switch code and comments
      openrisc: Use delay slot for clone and fork wrappers
      openrisc: Add clone3 ABI wrapper
      openrisc: init: Add support for common clk

 arch/openrisc/Kconfig                |  1 +
 arch/openrisc/include/asm/syscalls.h |  2 ++
 arch/openrisc/kernel/entry.S         | 27 +++++++++++++--------------
 arch/openrisc/kernel/time.c          |  4 ++++
 4 files changed, 20 insertions(+), 14 deletions(-)
