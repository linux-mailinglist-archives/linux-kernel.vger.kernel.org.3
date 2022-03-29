Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7364EA5ED
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 05:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbiC2DXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 23:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbiC2DXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 23:23:47 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD847EB10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 20:22:05 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id c4so14230100qtx.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 20:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=K9v2ULS9mYTr++spxmd9Eb26jIZAkD2Gt9jFbo3C2CE=;
        b=iAr6SWiIrN+QLCMonaexPNXmVPgZaByTCMEYwPCbIRo+VqoHxly7673hJLCvacs7kt
         SDMWSCRfZE4kuRjKXzvfw4B+x5HVJ7Gej3IAF2QvW1WMrCT/DOBHUFLtkYNwTjr2NtBR
         LLFQnBhWtRlo5oAa3/hqEC9ld/t50Lp/9SILtOszT9MerbVIixoIDfS9Iwb3cAEVogWM
         zHrvN4YxBi0/++OZR6gzHK3Tm0IxOlMqiH4KOgMxjn4kLXv0KiyKGVdrl7k3x0oYKwYD
         VayfSIHdc8sHTMYuP/14d/Jiq4sPZFCtg8N0ONJB69lEJFzWfKv4FzkvT4aZ8NamNX73
         e/2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=K9v2ULS9mYTr++spxmd9Eb26jIZAkD2Gt9jFbo3C2CE=;
        b=yZr+oNlnx2QKKG9myVNDzXY+izDVphOPgRdi/O3NNNxKTHdQYq9Ye4QOQq3cOPPF0Q
         NJiuUUVgusCYDDnNyhEGuIzMg3ytoPNGTG125b7nam0yp7GtFt6B1v/z1ltouU9SWkz/
         MM9AnCFZFoxhLwkqN+gzR5+rlrqA65bxDUXjrwr/Pp48rLFi1iEAMPmttZjrTvLL8vUQ
         Rab9JAXi+R7rMQ2nmjDUXZX7cfogfwhhjofP18V1v5NqIbYBQQNJkpXtHOh1k54JjPO2
         G5iELEBQ8tyGI7wxY5FSH2h0dvHdBQc4U0UIQwmYSqDVMXS4cNFpvvLiFK11CeyLogbg
         4KSQ==
X-Gm-Message-State: AOAM531FtZ6cZpQVnxtuDycEP0iEYhyan0q6Kkh5L6TD9JJ+1yjpS1Kl
        o1lar/rPX/cxnxUB/7UKfEA=
X-Google-Smtp-Source: ABdhPJw+JVbHzZm6ftwez213TcAnf+g+6a/xat/wmtCmcQgFxCxvj7I/VIXS5IHfFfCawLU86YsC9A==
X-Received: by 2002:a05:622a:1c7:b0:2e1:ed8b:7180 with SMTP id t7-20020a05622a01c700b002e1ed8b7180mr25160711qtw.305.1648524124715;
        Mon, 28 Mar 2022 20:22:04 -0700 (PDT)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d26-20020a05620a159a00b0067d4f5637d7sm8878641qkk.14.2022.03.28.20.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 20:22:04 -0700 (PDT)
Message-ID: <62427b5c.1c69fb81.fc2a7.d1af@mx.google.com>
X-Google-Original-Message-ID: <20220329032201.GA2375412@cgel.zte@gmail.com>
Date:   Tue, 29 Mar 2022 03:22:01 +0000
From:   CGEL <cgel.zte@gmail.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
        eparis@redhat.com, linux-audit@redhat.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Yang Yang <yang.yang29@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] audit: do a quick exit when syscall number is invalid
References: <20220326094654.2361956-1-yang.yang29@zte.com.cn>
 <202203270449.WBYQF9X3-lkp@intel.com>
 <62426553.1c69fb81.bb808.345c@mx.google.com>
 <CAHC9VhRNuoPH6AySUbe6h2D6kghhezyVQtTAvm-t-fTpXH6XwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhRNuoPH6AySUbe6h2D6kghhezyVQtTAvm-t-fTpXH6XwQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 11:06:12PM -0400, Paul Moore wrote:
> On Mon, Mar 28, 2022 at 9:48 PM CGEL <cgel.zte@gmail.com> wrote:
> > Sorry could anybody give a hand to solve this? It works well on x86_64 and arm64.
> > I have no alpha environment and not familiar to this arch, much thanks!
> 
> Regardless of if this is fixed, I'm not convinced this is something we
> want to merge.  After all, a process executed a syscall and we should
> process it like any other; just because it happens to be an
> unrecognized syscall on a particular kernel build doesn't mean it
> isn't security relevant (probing for specific syscall numbers may be a
> useful attack fingerprint).
>
Thanks for your reply.

But syscall number less than 0 is even invalid for auditctl. So we
will never hit this kind of audit rule. And invalid syscall number
will always cause failure early in syscall handle.

sh-4.2# auditctl -a always,exit -F arch=b64 -S -1
Syscall name unknown: -1

> -- 
> paul-moore.com
