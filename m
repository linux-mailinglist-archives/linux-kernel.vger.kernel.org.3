Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29CF520822
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 01:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbiEIXKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 19:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiEIXKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 19:10:35 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7B684A13
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 16:06:40 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id v66so16834864oib.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 16:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=l+6bkoiHuyshS+JPXnUMHnBZFV/wfxVAGfO/qzKwoVc=;
        b=EDaMJuCkGO9CCosE+qnH8oGKjpDPetxRm7tkbzmcq4a77u+65GpDvChVy6LfBsrfq1
         h2Kh77t3aUvPLi2hbALuOppo6qCSoZMFg1yTBy4JhAwmDbgSfaQ8KHaPw74hAP7DGv85
         qOReMIXBBvNSBAFkU17Ba4mV1Kvf2LgppS2eK6woeDjg74NFrBU+gj3UC5W38xrENxOU
         uNvaC75e3FjpNb0FTvqZ3NEucPNrNhpYpAOV7vUhcUMHkn2b5GQ2IG+Xa4ic/2j5pwnC
         R3A2MUCl9ESFYxG1kqF6phm0X7rptCNa4P9wubP3b2AEeJI7VH3nKMzKa1f/JKykPB3X
         7Gyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=l+6bkoiHuyshS+JPXnUMHnBZFV/wfxVAGfO/qzKwoVc=;
        b=nc+k5m6dFCN1ipRssC+SROtcGlhxFSNktyWZYTRql39+s3DjE3VLafXRPShehH1b/s
         ZISQRvb6IT8TvIqswAEqjMgaAMfo+pPJkHG2QnDpvWF0q8gFloyWAm7I7Houwe+hrFhP
         9a5c3pMj36F5zTXgMn0woGlIwCY3/wKvmWGKaWtGBZleuwv0fIenHcGHNu/sxqkmM3k1
         cKjF+ykmMEtppzSJV5zz+48XUAyQ93q2Ad95hJjP9EgXYFguyfGUppjOnJE86ZTfV1Nv
         qVCovawpOxDl/p7rstipglU+8f6jc9Tj8W4Rdi1gKeEXWhCG5Pf9MHHmMPokieyae3LH
         2Mdw==
X-Gm-Message-State: AOAM533U6OMP9c9c1K46BOtFSb08k6SvxVw6x7HfWw5U/c1zo8Y271CW
        XC/qzAnoDbNmsy4t3O7jhNWPREDL+MpWPQ==
X-Google-Smtp-Source: ABdhPJzKcIYX/5976/T4yfuPIstXOPasvFjxytdaOsOLNfT6sxeIRz7NsawQfktLpnReRSMKpKJLNw==
X-Received: by 2002:a05:6808:56b:b0:325:9f5e:3fd4 with SMTP id j11-20020a056808056b00b003259f5e3fd4mr12204429oig.199.1652137599537;
        Mon, 09 May 2022 16:06:39 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p22-20020a056870831600b000eb0e40b4b8sm5069804oae.48.2022.05.09.16.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 16:06:38 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 9 May 2022 16:06:36 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.18-rc6
Message-ID: <20220509230636.GA1551031@roeck-us.net>
References: <CAHk-=wi0vqZQUAS67tBsJQW+dtt89m+dqA-Z4bOs8CH-mm8u2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi0vqZQUAS67tBsJQW+dtt89m+dqA-Z4bOs8CH-mm8u2w@mail.gmail.com>
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

On Sun, May 08, 2022 at 02:09:27PM -0700, Linus Torvalds wrote:
> So 5.18 is looking like it's going to be one of the larger releases in
> numbers of commits (we'll see where it ends up - it's going to be
> neck-and-neck with 5.14 right now, but won't be as big as 5.13 was).
> But despite the merge window being big, the release candidates have
> generally been quite modest in size, and rc6 continues that trend. I
> keep expecting the other shoe to drop, but 5.18 just seems to be quite
> well-behaved.
> 
> Let's see if this jinxes it, but nothing looks particularly scary
> here. rc6 looks to be mostly some driver updates (network drivers and
> rdma stand out, small random fixes elsewhere), with the usual
> smattering of architecture updates (x86 kvm fixes, but also a
> long-standing x86 kernel FP use issue, and a smattering of parisc and
> powerpc fixes). And some wireguard selftest updates.
> 
> The rest is mostly some btrfs fixes, some core networking, and just
> random small one-offs elsewhere.
> 
> Please do go test it all out - because things may look good now, but
> continued testing is the only thing that will make sure.
> 

Build results:
	total: 151 pass: 151 fail: 0
Qemu test results:
	total: 489 pass: 489 fail: 0

... and even the parisc warning is gone now.

Guenter
