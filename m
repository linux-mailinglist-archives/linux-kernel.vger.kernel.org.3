Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C21B501EBB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 00:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347369AbiDNWxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 18:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347335AbiDNWxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 18:53:30 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1505F8C5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 15:51:04 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id r66so6009083pgr.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 15:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NmbaSnv4y5xMGTlU8ENC8ho38hjGPo6HcBQqGFgE7fg=;
        b=A6c41PYgjZELRGT1LHkHqYeqfZGz+IzMDcM/eK2CdoLx9x4Rk2I1cVR9UwITG++aDK
         0ed+4YkHiOBhJrkJtq2iPZbxc/4bTZBg9moRAgShSetICYBI4TUIAIxInHnznwo9roCM
         OCXyr2StDJzksDqqYYvaWQDgmdhuTluksYt5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NmbaSnv4y5xMGTlU8ENC8ho38hjGPo6HcBQqGFgE7fg=;
        b=P4NLsBdI64aakD99N8CDp/ykVtfttdPjz3Z+QMyVCVG8v7RFwGfnd3+3QrQPYWB2yU
         3Oghodli49Uc4l4hNjclcmzhKxFe65xxwnICq+lXzZFXWw2Aum4wt9KYQ1A4FQ2B7CH4
         XFjhx25B92Kgj1pGNGxCT7KF5vDmwN5rpkD3R95j0vpZOyOPzIeK64+rWuogT0KMuv5I
         tzhPbud04y+SmsOAbm7ESeH/vwfWm5+WXMjEyRbkdzfPbIYJguFWVoXokJShk34rlDNi
         5pB0IhxB7R1VapyZopH7YQxdlXtotfX+LLaHzMsybfMcRlZTQgIF2BWpRB9BwEK2j7PM
         O6RQ==
X-Gm-Message-State: AOAM531k7PpX9x7wZkSoYSa6AWTSnG9CvLmvfSxCMsBPYT4nD6dAkb4G
        2F6NqT6rnVSJ2Vy8AESnNfdaug==
X-Google-Smtp-Source: ABdhPJw1WfdQgJMU5KTNCN8tOxbpMzFChkkNktUkUq6tl7GNiadTyrSzIM3Bwd/MZY5PXKg3iFO8ng==
X-Received: by 2002:a63:f34d:0:b0:399:5abe:b2e1 with SMTP id t13-20020a63f34d000000b003995abeb2e1mr4112093pgj.451.1649976664252;
        Thu, 14 Apr 2022 15:51:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id fv7-20020a17090b0e8700b001ce18c551dcsm2584285pjb.19.2022.04.14.15.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 15:51:03 -0700 (PDT)
Date:   Thu, 14 Apr 2022 15:51:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Qing Zhao <qing.zhao@oracle.com>, Bill Wendling <morbo@google.com>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        clang-built-linux <llvm@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        "Jose E. Marchesi" <jemarch@gnu.org>
Subject: Re: toolchain mitigations plumbers session
Message-ID: <202204141549.B1DE158@keescook>
References: <CAKwvOdniB-+F37ygZhRytBGVFjwnukyOpmoiJTCeusMdb=6_=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdniB-+F37ygZhRytBGVFjwnukyOpmoiJTCeusMdb=6_=g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 02:30:33PM -0700, Nick Desaulniers wrote:
> Hi Qing, Kees, and Bill,
> Jose and I are currently in the planning process to put together a
> Kernel+Toolchain microconference track at Linux Plumbers Conference
> this year (Sept 12-14) in Dublin, Ireland.
> 
> Would you all be interested in leading another session on
> kernel+toolchain collaboration for mitigations?

Yes please! With work Qing and Bill (and Sami and Joao and others) have
been doing lately, this session will have a lot of new stuff to talk
about!

> Do you plan to attend
> plumbers this year which will be in person?

Yes, my current intention is to attend plumbers in person this year.
However, I reserve the right to shake the magic covid 8-ball again as
we get closer to September. :)

-Kees

-- 
Kees Cook
