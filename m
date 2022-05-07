Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC91951E47B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 07:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383354AbiEGFoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 01:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445737AbiEGFo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 01:44:26 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B2DE000
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 22:40:40 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id e5so7740803pgc.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 22:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AVuaOiXhV01Z47Oo1rP7YN34nHEPNRHjJX/XRSE9e0M=;
        b=EkJzGm/JeHn0Akm0WvBv/z4h/vyU57IPa7rnZoXNc/ZlcQ0LKsROLOEpk33iPvRk8H
         wAbpoS72stM8zkuhQq55tVgSEbT5p7v+UQrNpyWBG/D7qQ1vsOmTUkSNyAoHt7ljGG//
         4R5J+W1RhtpueH8IaUblBU46vRlfpC69NotB/JLGJgX3YsI1EV0SgevZ4Kw5tpoYZ2e/
         q2gd9srrc8xYR4riTXVR5YFFtaqQl41wfLR1AWCDoQsRSAqrDas2+9fixH5xynyLa0ur
         UUHm+uWyetASlKm/O8M6i1RTMyvbDlBrTnfuIjzY7z5esa6cc4AnIQtLrXudShsCR3iX
         bE5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AVuaOiXhV01Z47Oo1rP7YN34nHEPNRHjJX/XRSE9e0M=;
        b=uUiSWegpayhgCvITqyEQnbUwEuwioaQE0ci5JiKFoEdKqhKqRuK8MFQKDsNi72DloF
         SS+MBOtWw9PGBbZKBz01+wNzvWT07LMI3i+FdidMqXMQBBC0/zPY3KuazO5Xj/M+9vQK
         Ky7X47jMhb+VJxhsq3cFvQAsKKlmG2gutVT8zCIhrvM3zPkEhSLFArloLESp2z736Gze
         460NsL61MHdH0sUGYekVNO1U3WLYEfJ03XLyjF64Q89w9mgkJzesnKVMV+jmKn5EvLlU
         6Kp/MVqBuo0oXXHpDZ2xF8x3kF3/zqqE48Lb1XUw05nt2YEFKDZfKqrZequkHCOjkXmT
         Lohg==
X-Gm-Message-State: AOAM533oqiVTXzxZ5muicC4uoOXrKau1BRZCEEaSZRKEnLycoaCY4WVa
        bsCd5S22SmWzZBGJIofw2hw4wZqUUZJc7Q==
X-Google-Smtp-Source: ABdhPJz7LcUUD4gahOIUtRR7xASy10zcWdIn+aPL3P9fPuCKGJt388cR5ZYsKV4EWvX/n7RcOXduJw==
X-Received: by 2002:a63:eb58:0:b0:3c2:6d66:c238 with SMTP id b24-20020a63eb58000000b003c26d66c238mr5597405pgk.436.1651902040128;
        Fri, 06 May 2022 22:40:40 -0700 (PDT)
Received: from localhost ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id 19-20020a170902e9d300b0015e8d4eb253sm2748412plk.157.2022.05.06.22.40.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 May 2022 22:40:39 -0700 (PDT)
Date:   Sat, 7 May 2022 13:40:41 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, zhangwen@coolpad.com
Subject: Re: [PATCH 2/3] erofs: remove obsoluted comments
Message-ID: <20220507134041.000060da.zbestahu@gmail.com>
In-Reply-To: <20220506194612.117120-2-hsiangkao@linux.alibaba.com>
References: <20220506194612.117120-1-hsiangkao@linux.alibaba.com>
        <20220506194612.117120-2-hsiangkao@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  7 May 2022 03:46:11 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Some comments haven't been useful anymore since the code updated.
> Let's drop them instead.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/inode.c    |  5 -----
>  fs/erofs/internal.h | 25 -------------------------
>  2 files changed, 30 deletions(-)
> 
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index 8d3f56c6469b..8b18d57ec18f 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -8,11 +8,6 @@
>  
>  #include <trace/events/erofs.h>
>  
> -/*
> - * if inode is successfully read, return its inode page (or sometimes
> - * the inode payload page if it's an extended inode) in order to fill
> - * inline data if possible.
> - */
>  static void *erofs_read_inode(struct erofs_buf *buf,
>  			      struct inode *inode, unsigned int *ofs)
>  {
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index ce2a04836cd2..cfee49d33b95 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -397,31 +397,6 @@ extern const struct super_operations erofs_sops;
>  extern const struct address_space_operations erofs_raw_access_aops;
>  extern const struct address_space_operations z_erofs_aops;
>  
> -/*
> - * Logical to physical block mapping
> - *
> - * Different with other file systems, it is used for 2 access modes:
> - *
> - * 1) RAW access mode:
> - *
> - * Users pass a valid (m_lblk, m_lofs -- usually 0) pair,
> - * and get the valid m_pblk, m_pofs and the longest m_len(in bytes).
> - *
> - * Note that m_lblk in the RAW access mode refers to the number of
> - * the compressed ondisk block rather than the uncompressed
> - * in-memory block for the compressed file.
> - *
> - * m_pofs equals to m_lofs except for the inline data page.
> - *
> - * 2) Normal access mode:
> - *
> - * If the inode is not compressed, it has no difference with
> - * the RAW access mode. However, if the inode is compressed,
> - * users should pass a valid (m_lblk, m_lofs) pair, and get
> - * the needed m_pblk, m_pofs, m_len to get the compressed data
> - * and the updated m_lblk, m_lofs which indicates the start
> - * of the corresponding uncompressed data in the file.
> - */
>  enum {
>  	BH_Encoded = BH_PrivateStart,
>  	BH_FullMapped,

Reviewed-by: Yue Hu <huyue2@coolpad.com>
