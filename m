Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 643CA520C27
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 05:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235775AbiEJDlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 23:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235699AbiEJDlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 23:41:06 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D533656C;
        Mon,  9 May 2022 20:37:10 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id gj17-20020a17090b109100b001d8b390f77bso975663pjb.1;
        Mon, 09 May 2022 20:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=Tuw5rwdDw674mRKOWTVNmxFb45NMy2jQBbhpZfnBSUw=;
        b=YiFnFgxquAvcN9oAz4bKdkvIgiIB+a2cUP7hrsWWe9xQIDFp1zXiH07J5MVLpOKV/F
         4/25W0/6ytNqxy3QYpPHcfhrYm8fbk4jtIa38qc/7YG8XgaO4w9kFZwmTxTO9O1aNc4v
         EjGHqCZP6qg/s3Q+L/Yg4wze1XawIv1A28OydYVAtQr4qhhFmYw36rs67e3HT6AezUaN
         uXXBqjOWSVnAUwgw6WjU0gW10lKfbhbF4aKFF5V4l5B3bvRlljJy1/KRTxsxlZ12Jw3x
         C1qi6IhGu1Xg/QbTVzm+dPbsqsEow9KliIFgFZbD8z4XZKUQRxNzL5phc0oFNwUvTM49
         WVVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Tuw5rwdDw674mRKOWTVNmxFb45NMy2jQBbhpZfnBSUw=;
        b=FGHc/vxmnBRetQTaaDV+EgAqfYzLs2v5THw/iGbJbSTE60GnMOR9GIgnZT7u1MDGxU
         jOjqcxqb8nifPLuPFqO2Gcd0bRlct29mqkaGRlyf5F9jkiVmz7p8IUvbl5MkunHWGgYv
         kBqfYOOVrNKd5zrmPb2hSjetgN6AFR6hp+DU9n4dJ5NzjOeoLSgtEhyCIBdOPOU8PjE/
         h1uPDG+f62hmf1K76vlj2o2JSVE/e6xKzdkhFlsTW3mBVBGwzh2HaNUJU+L38oQzd5S3
         Kck00fNpuBeHJ6J3M1JRTDFt0nxVATS+Ce6wF952QBUAb8POEDekHroM98ymIg3PeEeV
         1B/w==
X-Gm-Message-State: AOAM533/Kfy4zAUVPuN2CseE4jtoDvKz420LEQZV9JQODFSWv0ZA5mni
        3x+S0dSuDH+UubhkUhIk7ZniX40gwjQ=
X-Google-Smtp-Source: ABdhPJwK/iXQY2YYJRwx8AcP5nD0enihRlu5tvzOsqIZ7H1RA2DlLUk7LB1M8Zr7G0Yu4mvm8wVUFw==
X-Received: by 2002:a17:90a:1f4f:b0:1d8:23d9:de1e with SMTP id y15-20020a17090a1f4f00b001d823d9de1emr21105172pjy.42.1652153829547;
        Mon, 09 May 2022 20:37:09 -0700 (PDT)
Received: from [10.1.1.24] (222-155-0-244-adsl.sparkbb.co.nz. [222.155.0.244])
        by smtp.gmail.com with ESMTPSA id c5-20020a170903234500b0015e8d4eb1f6sm708896plh.64.2022.05.09.20.37.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 May 2022 20:37:08 -0700 (PDT)
Subject: Re: linux-next: manual merge of the m68knommu tree with the m68k tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <20220510094442.26826532@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <7bcb1248-7329-9aee-5d81-7e846cd1e461@gmail.com>
Date:   Tue, 10 May 2022 15:37:03 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <20220510094442.26826532@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

apologies on my part - I had thought that I had copied in Greg on my 
patch series. And I evidently missed that his ELF patch would have 
clashed with mine.

Geert and Greg coordinate well as a rule, and both patches had been seen 
on the linux-m68k mailing list (just too far apart to jog my memory).

Won't happen again this decade (I hope).

Cheers,

	Michael


Am 10.05.2022 um 11:44 schrieb Stephen Rothwell:
> Hi all,
>
> Today's linux-next merge of the m68knommu tree got a conflict in:
>
>   arch/m68k/kernel/ptrace.c
>
> between commit:
>
>   c862fe70b023 ("m68k: Wire up syscall_trace_enter/leave for m68k")
>
> from the m68k tree and commit:
>
>   0d91043d8bdf ("m68knommu: implement minimal regset support")
>
> from the m68knommu tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>
