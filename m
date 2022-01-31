Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8123F4A50C3
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 22:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379468AbiAaVGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 16:06:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbiAaVGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 16:06:08 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5911AC06173B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 13:06:08 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id b1-20020a17090a990100b001b14bd47532so386144pjp.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 13:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SU2C5Ut+6pVhWNusD7rQJSCoDPKXcj6KPViieB+X2lo=;
        b=hoQPs3vvKd7f1xYDysO+MqUCq4Iv27DRIoE1LCB2rYcxtJxZsOpFbFs/dzUF4N+KB7
         YOvrYpJQ6TEndtT426TWvnQaEdc8kuPAvKL1ohdSugHUSz5qDExR/NXy0vXMuNI258E+
         TfjMsP0xEQN9+BRl5R2eCk8q0PFJoH0jSWOzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SU2C5Ut+6pVhWNusD7rQJSCoDPKXcj6KPViieB+X2lo=;
        b=DERV8FSZ6Ukeg2XlyWUt6sE8i5blSsVSPvEFlHebVRIjgsiCWRkAuHaZUzv2Phjl4z
         VwZdHJ6z3doO6EHhNjsoSh2ao8G5ZyhIvino1JoavPa/ex3IOd1P5pQkbBFI0lpVTm9Y
         vFvnT2Krz4/rP3Zr+2CC6jz9H+rDnH7D2smHrozo+wqX2Z3KxU0Y6zVXjQZuNp4F17ZO
         7gTBUwz9ce7Xc4wi9HJldmrZsK4zSc1hQKXFml6T6MxTULjwiWXs3Qezor3HlylC2+Zf
         ofsAcsnKov+6fARIu5LRnEc+WyXiq8GWfi5AGS194RLD0OHvsVeeBHdWbrcRlFbvMg19
         D3gQ==
X-Gm-Message-State: AOAM532gnY515Py4WH9ROJAc3VCUiaQCuI3DDV63jSH7azM+HGHBKCBs
        Jy8m9TAlzcq7Apel7SmuIAQ0PRyW9lRXbQ==
X-Google-Smtp-Source: ABdhPJw3mk7g/0+d8ppkglsn7LnLQZW0nlmnZxQQxVqkVpoCYTS2/ssuThB0561M1pMoYV+W9kT4YA==
X-Received: by 2002:a17:902:c215:: with SMTP id 21mr21063159pll.134.1643663167174;
        Mon, 31 Jan 2022 13:06:07 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z6sm5913634pfb.171.2022.01.31.13.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 13:06:06 -0800 (PST)
Date:   Mon, 31 Jan 2022 13:06:06 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Saeed Mahameed <saeedm@nvidia.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Leon Romanovsky <leon@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
Subject: Re: linux-next: build failure after merge of the kspp tree
Message-ID: <202201311300.39BE058A1@keescook>
References: <20220131100954.74a2034f@canb.auug.org.au>
 <202201302002.41A8DDA2@keescook>
 <20220131155932.3f88ec71@canb.auug.org.au>
 <202201302216.97F2691@keescook>
 <20220131191019.fpa5sn5u4kuov5ub@sx1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131191019.fpa5sn5u4kuov5ub@sx1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 11:10:19AM -0800, Saeed Mahameed wrote:
> On 30 Jan 22:19, Kees Cook wrote:
> > On Mon, Jan 31, 2022 at 03:59:32PM +1100, Stephen Rothwell wrote:
> > > On Sun, 30 Jan 2022 20:04:00 -0800 Kees Cook <keescook@chromium.org> wrote:
> > > > https://lore.kernel.org/linux-hardening/20220124172242.2410996-1-keescook@chromium.org/

Fixes: 34802a42b352 ("net/mlx5e: Do not modify the TX SKB")

> > > > https://lore.kernel.org/linux-hardening/20220124172028.2410761-1-keescook@chromium.org/

Fixes: b5503b994ed5 ("net/mlx5e: XDP TX forwarding support")

> > > yeah, neither has made it yet.  However, it would not have helped as I
> > > am merging the kspp tree very early so that new bugs get fixed in the
> > > trees that introduce them.  These 2 are in Linus tree (for a long time)
> > > and so it would be better if these fixes went int the net tree and then
> > > Linus' tree as bug fixes.
> 
> I need proper fixes tags to submit to net, can you provide ?

Sure! See above.

> another option is to use a shared branch with those fixes and pull it to
> both net-next and kspp.

It's just a handful left now, so I think we'll avoid this for now.

Thanks!

-- 
Kees Cook
