Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76054DA37F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 20:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351495AbiCOTxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 15:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234402AbiCOTxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 15:53:07 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011EB1275C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 12:51:53 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id s42so738667pfg.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 12:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AESGvjdyhsL37hH/gg8iqfC/XQq+3H2UESbMogDHjQs=;
        b=ne3O4ENYlMZlKIYH3B2Sj5mJl+G7KJz4vLw56ZLU6MTOw1eiIR2uCFv4ccpXGh+Hlo
         +39Yd75p3WkPtIwBTuZK2d7dYQHBNWnRh+osDAdkmbs9uVuoESJEftR9xSY4wUT5qqvm
         9KukIDv7fbIvjLCMhiFIAIc6Sx8fseiM1ve2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AESGvjdyhsL37hH/gg8iqfC/XQq+3H2UESbMogDHjQs=;
        b=3Ndhyx6SW6izQkxC6UnvIDw9DoKqSbpE0g8iMUAfiMitVflUqkgRgyICsxQ/NIXpDB
         wmXHf0gTjwrc7J6JpnuxxrlGDRZUjO+qsYrdtJz//ep8B+EGIxvxhQfPvFmO7bRSNYFg
         j5GLPc3lLrODurSoNcYLv0KUJh4BU5WzHycwYzYjeFtIVmpccU67FQMoWVNbOtIgG8TE
         ekkubRIkLMdNUg0IjU9gbGWGachmw/SwzI9ZtpnqZp2cDLavPZK7Toif+PYn3XaHhZUA
         Fqilrdzy2pWBCQicaQ0W8VKnQkpom05+AP9SYtBRB4qlL+Ak68O+R5hX515ItLtGsMpm
         l94g==
X-Gm-Message-State: AOAM531tZtn1B0Xkc/5ctx3y4fD6cvZimVjx4y8T40MaDITpuZAfbURo
        7QR+Vm4+fpEhXvTHwa3/bFpuzSq2i7oSwQ==
X-Google-Smtp-Source: ABdhPJwp7gkcwDWzHijGdtdmzpVKBoaWyZ5PVhREIS56/xNmJW9DTUSlE/bqoSyc9uFxjJgPhLF3Rg==
X-Received: by 2002:a63:8ac7:0:b0:37c:8b82:dc3f with SMTP id y190-20020a638ac7000000b0037c8b82dc3fmr26303239pgd.167.1647373913494;
        Tue, 15 Mar 2022 12:51:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h18-20020a056a00231200b004f72b290994sm24885304pfh.180.2022.03.15.12.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 12:51:53 -0700 (PDT)
Date:   Tue, 15 Mar 2022 12:51:52 -0700
From:   Kees Cook <keescook@chromium.org>
To:     James Jones <linux@theinnocuous.com>
Cc:     bp@alien8.de, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: Remove a.out support
Message-ID: <202203151150.1CDB1D8DA@keescook>
References: <4c449fab-8135-5057-7d2c-7b948ce130cc@theinnocuous.com>
 <0b31b1d3-852d-6cab-82ae-5eecaec05679@theinnocuous.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b31b1d3-852d-6cab-82ae-5eecaec05679@theinnocuous.com>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 12, 2022 at 06:06:26PM +0000, James Jones wrote:
> [...]
> > docs, including copies of the old mac and aln a.out binaries, is
> > available here:
> >
> > https://github.com/cubanismo/jaguar-sdk

Do these end up requiring libc4, etc? I see "uselib" syscalls in the
disassembly...

$ for i in $(objdump -b binary -D -m i386 aln mac | grep -B4 'int.*$0x80' \
	| grep -E 'int|eax' | grep mov | awk '{print $8}' | cut -d, -f1 \
	| cut -c2- | sort -u); do printf "%d\n" $i; done | sort -n
1       exit
3       read
4       write
5       open
6       close
10      unlink
13      time
19      lseek
20      getpid
37      kill
45      brk
54      ioctl
55      fcntl
86      uselib
89      readdir
91      munmap
106     stat
107     lstat
108     fstat
126     sigprocmask

It seems like it should be possible to create an ELF wrapper for simple
a.out binaries...

-- 
Kees Cook
