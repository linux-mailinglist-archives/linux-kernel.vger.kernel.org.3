Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2EB487517
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 10:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346595AbiAGJzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 04:55:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236788AbiAGJzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 04:55:40 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB6EC061212
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 01:55:40 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id l10-20020a17090a384a00b001b22190e075so11425987pjf.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 01:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zFGzcYvSOCyKFk85uoXR06gkzPo3qnZX3+iKg13B8Qs=;
        b=fDe/ventyNhPXmnvbmLfT4xlloglwiYf+RpthMcLc5Pk0UbdbKiFlxNU4w/Jh12lz3
         0GMloo5wHSewYXABHYpnjgtrrGYLHoA0U+/1jqqXl8CcIsjy/LsqYalDEq2nNvZNRfaI
         cPgJfiyHspv4A+To9wy3XiGLfDfQYp7xI/Jq3BLwe/KqNCQ5oDws67Dttp7pUejRQIoW
         bwwZha9NFeQa6kotkd8fOF5d7wKrnnV+I4fn5f5lYh9xzTgf+In4zfETcKd40j+QN+w7
         aELX/H1EMfQOHx67fD4xZecWSzmw+l+37UeM49PHuuE7pMpaaBxOQPzFIeRbQeh5B383
         t6Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zFGzcYvSOCyKFk85uoXR06gkzPo3qnZX3+iKg13B8Qs=;
        b=zMhhXDN103Qps+PS8gS81TKpDiKCUEEcFTPoHK1t5JA4cjw5dg1g7OAE4fzYqe6Bnc
         +ikphcQmkiJtFGCI2c69NE2Ae9t20F7dZgh7IE7nM911qazWwrVBMX0URn/xmR48AXfG
         ZqmK6nTTJDFdG4FsEBiwdN+YaXS3f6pV4Q2nXDGgWio0QAYaDC+nE8wKrkG5f0okVJIR
         EtzIIQ/NJYStD8n99YdAQmGIuzOaM11F40tb+QqCLb7K2nSo/2kzPIeC+b0X3pKvW8xa
         pcoKS/6NG90fuZMyWLo6SqOs3iXbDjRT5DFfmlBTmtKRKinlAEq4czwlHWQZ6hhtSKCH
         tZvA==
X-Gm-Message-State: AOAM530wgW5mmYA/0tKldLKpEXm//l3ERPkMznIvsx09wum9VDITc2wb
        tgVV1ltqmZ7lSCsNZnZOsbq8eJQMLjBWQoVw
X-Google-Smtp-Source: ABdhPJxO1HqtsaEul2VvPlXMzFWkpde4PUaL57aUmXCzXUP4g3slVu5RUBEc82gJdiJHoSSSFqUQ5g==
X-Received: by 2002:a17:90a:e7cb:: with SMTP id kb11mr14742426pjb.75.1641549340245;
        Fri, 07 Jan 2022 01:55:40 -0800 (PST)
Received: from nlap2 ([171.78.146.184])
        by smtp.gmail.com with ESMTPSA id s7sm5635783pfu.133.2022.01.07.01.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 01:55:39 -0800 (PST)
Date:   Fri, 7 Jan 2022 15:25:32 +0530
From:   Abdun Nihaal <abdun.nihaal@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] staging: r8188eu: change functions to return void
Message-ID: <20220107095532.gosbmlwdmnljxbxp@nlap2>
References: <cover.1641490034.git.abdun.nihaal@gmail.com>
 <9db6b08837bd6354c8e07a4b1c4bca662091f945.1641490034.git.abdun.nihaal@gmail.com>
 <Ydct2sBt6aB+MChS@kroah.com>
 <20220107065210.7utcwjenvcspydyk@nlap2>
 <20220107085852.GQ7674@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107085852.GQ7674@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Jan 07, 2022 at 11:58:52AM +0300, Dan Carpenter wrote:
> You're not allowed to end a void function with a return statement.

Sorry, I didn't know that. I'll fix it.

> Checkpatch will only detect these if you run it again with the -f
> option.

Thanks. I'll make sure to run checkpatch on the modified files also (not
just on the patches).

Regards,
Abdun Nihaal
