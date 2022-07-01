Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2543562A1D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 06:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234012AbiGAEHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 00:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233809AbiGAEHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 00:07:08 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D59C65
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 21:07:06 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id bo5so1312514pfb.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 21:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=IY8goiZ1JBtpku++C9CD9bs6j+IuJRusr8YmntfJEGo=;
        b=aLj1r8Lj4Ms0Ut7M6JiRsc+4eKHLPrUHVY4czgHSqwLAOqs+0qTppNNDCco5mZXu4J
         WRpWOpCD/C5Dubw14p67oFWZzT3vs9GOdbnIkbx89rYGfh9fol438aSEcQMT2UA+4eo2
         KepnJUP9wu+5ADp0RuZGmn8ZxRGG7rgI/AC42eIx7ZTZvfEKMJdk3IIUFwJx9ysNujQ/
         zuAUoUMWIUDB6CIn8kcaf26sW1Uz9Bb5fDIVfpwNoropRLfJwNdgxhAxCubwK/+oysx/
         y5VgndyDuRjsvbWsQcxo9Tp1WnK3SmyyNqoZwuxJbItJLScmq2VpPF7u9/7hbEDMh8VB
         w/9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=IY8goiZ1JBtpku++C9CD9bs6j+IuJRusr8YmntfJEGo=;
        b=FRZlaQB5OAOVe4WJLnR4VacMcLhqZv+g1rf+2i1lxEvyI8Ig3tXZbmAdYcWCe62uM9
         CoKTICA4y91CHMsvHni7Iup7BDOqtRbqmD2qFMcSQ2m5PMijU2qSBXpFm7PBDq7ysT7c
         sJOy4KQ7pNFO8Ujg0LMcUJFRkG2v+brbs0Hv1V9Q+EhULud6igsEnDteAYRRfj52ruZL
         AXRGLhNFnv6E9V3W8PV6nVVhiBBfoJUgPw5Jmgtst/c5tfEV4cvfXUCT25Gg8phBEHNp
         wBMCmdsSYYfMkstfMge8oW283OHrvyhhGuwrBo9LZbhm+rz2Z5xQt/bE9sjHAHW3Muy0
         Z7Ow==
X-Gm-Message-State: AJIora+QxF0p6bFvUE7Nv1rTqZrTScGWvIjs2DqVmgULcgBtfQBH5/Dw
        kWnQN9erlgUohwIYutD7tY7EIwqeyfa7BQ==
X-Google-Smtp-Source: AGRyM1sVBp+DLhMeTViEgDkuBeGdR/Y0NrmWeUnt3HCL253i4fvsg3QWDQ2JDMBTvhNrr3x8R5JxpQ==
X-Received: by 2002:a63:6b0a:0:b0:40d:ffa6:85c5 with SMTP id g10-20020a636b0a000000b0040dffa685c5mr10481968pgc.327.1656648426398;
        Thu, 30 Jun 2022 21:07:06 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id v22-20020a17090a0e1600b001ecbd9aa1a7sm5462214pje.1.2022.06.30.21.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 21:07:05 -0700 (PDT)
Date:   Thu, 30 Jun 2022 21:07:05 -0700 (PDT)
X-Google-Original-Date: Thu, 30 Jun 2022 21:06:53 PDT (-0700)
Subject:     Re: [PATCH 0/3] riscv: Kconfig: Style cleanups
In-Reply-To: <20220520120232.148310-1-juergh@canonical.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        juergh@canonical.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     juerg.haefliger@canonical.com
Message-ID: <mhng-bb67d78e-c98c-43ec-92b9-b2bcc46c9265@palmer-mbp2014>
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

On Fri, 20 May 2022 05:02:29 PDT (-0700), juerg.haefliger@canonical.com wrote:
> The majority of the Kconfig files use a single tab for basic indentation
> and a single tab followed by two whitespaces for help text indentation.
> Fix the lines that don't follow this convention.
>
> While at it:
>   - Add trailing comments to endif/endmenu statements for better
>     readability.
>
> Juerg Haefliger (3):
>   riscv: Kconfig: Fix indentation and add comments
>   riscv: Kconfig.erratas: Add comments
>   riscv: Kconfig.socs: Add comments
>
>  arch/riscv/Kconfig         | 19 +++++++++----------
>  arch/riscv/Kconfig.erratas |  2 +-
>  arch/riscv/Kconfig.socs    |  4 ++--
>  3 files changed, 12 insertions(+), 13 deletions(-)

Thanks, this is on for-next.  There were a few merge conflicts, 
everything looks pretty straight-forward but let me know if there were 
any issues.
