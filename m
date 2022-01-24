Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7BFC4976CD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 01:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240538AbiAXApr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 19:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235309AbiAXApq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 19:45:46 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A3EC06173B
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 16:45:46 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id g9-20020a17090a67c900b001b4f1d71e4fso14889491pjm.4
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 16:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=syJJE/Qo6SPH0sSL0neAN+nKt5eaHiqDKA6r4xdpWFk=;
        b=hX7OzedDjaKYQVBoUIG9Pwcc+aoUWV943bQwHSYprltvYFkoVVQciJ2K7U8JRrgDTp
         vJgf11p6kYT5dUNtKnYsyBm69OdYk551j6Ust56PNGxdHNWF/u5xPTjRFZbaIp4m1slQ
         ZKlw1xHL8ib0MCoW7e+8XbhBih80icLi17iQwNkRqW+l8v/knTBOASik4Ax3/mUln8//
         FwcDGGmSfwZ4nArcybfqi4w5V9VklBmWkuELO/ervw7htleo6or8kNS96j38UGyds/UO
         A/cLjqJoaL44ebcQ9yPYFtKxlhX51GXIXRjLgDRtZKmNsUlEATdBWMm0yPW/0MoGDAbF
         C3PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=syJJE/Qo6SPH0sSL0neAN+nKt5eaHiqDKA6r4xdpWFk=;
        b=XXuWwcQBDGj9wZEICuHi2Z3/89t/n6h1BKyxp+u580cxcmZi5jWDVl/6rUKXo/yJ1M
         j0thBX1t73IJXvFKbYQOj5u2JarGJlqq04oRYcHOQSDxCxqU/nbVW2UFDTjpJC5mKU67
         LYx7HcNsvjbiMl4XCD+ltp/cfB2qJoyM4Pru6VvSAgp2oXGgwsVybLSFlc5N+bnDhr8u
         hhkdwL418VPnCSZrxM/O0+p6SLczU10vWj5T628QLtPEhu9GmnvvaotFlCYDIO46dXat
         fojDjzJIclb9X/DDdNJgqYtrneoxC/Eno/ymYfH6iqsnvM9u6NYXHG3iFdOHXLCSwhSk
         BEdA==
X-Gm-Message-State: AOAM533QZppu1gcJIvFmB3E/Y8QJyso+H3MP5fvSF1CBTVGhhIxiVC4K
        59pncl+PZcVuDiV0Y3U3EamFZdItuNc=
X-Google-Smtp-Source: ABdhPJzjOXW6micKO9T5xFVT4xpONrBnU5j0xRC5sUUOdGNlLIa/FE0dfIRzjqdLoLhkok9qV4bR6g==
X-Received: by 2002:a17:902:da88:b0:14b:2d82:c074 with SMTP id j8-20020a170902da8800b0014b2d82c074mr8531002plx.13.1642985146108;
        Sun, 23 Jan 2022 16:45:46 -0800 (PST)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id o8sm386585pfu.52.2022.01.23.16.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 16:45:45 -0800 (PST)
Date:   Mon, 24 Jan 2022 09:45:43 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Kuniyuki Iwashima <kuniyu@amazon.co.jp>
Cc:     benh@amazon.com, jonas@southpole.se, kuni1840@gmail.com,
        linux-kernel@vger.kernel.org, openrisc@lists.librecores.org,
        stefan.kristiansson@saunalahti.fi
Subject: Re: [PATCH] openrisc/boot: Remove unnecessary initialisation in
 memcpy().
Message-ID: <Ye32t5ZccUwfa+ag@antec>
References: <Ye3keps4aHhkbYzr@antec>
 <20220124000249.4295-1-kuniyu@amazon.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124000249.4295-1-kuniyu@amazon.co.jp>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 09:02:49AM +0900, Kuniyuki Iwashima wrote:
> From:   Stafford Horne <shorne@gmail.com>
> Date:   Mon, 24 Jan 2022 08:27:54 +0900
> > On Sun, Jan 23, 2022 at 11:01:00AM +0900, Kuniyuki Iwashima wrote:
> > > 'd' and 's' are initialised later with 'dest_w' and 'src_w', so we need not
> > > initialise them before that.
> > > 
> > > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.co.jp>
> > 
> > This looks fine to me.  I will queue this for the next release.
> 
> Thank you.
> 
> 
> > 
> > Just curious why are you working on OpenRISC?
> 
> While reading memcpy() variants, I found a nit to fix in x86 boot-time
> memcpy() [0].  While I'm at it, I just started reading all arch ones ;)
> 
> [0]: https://lore.kernel.org/lkml/20220123015807.45005-1-kuniyu@amazon.co.jp/

Got it.

Thanks again!
