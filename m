Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75EC84E8986
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 21:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236438AbiC0TJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 15:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbiC0TJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 15:09:47 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C22B12774;
        Sun, 27 Mar 2022 12:08:07 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a8so24516137ejc.8;
        Sun, 27 Mar 2022 12:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BxomEH7mBMDC7vV6gSKOuhM47d4NlIfrh1onB9N0Od0=;
        b=qAiRmKZJNfFh19RaQfBUp31it/jsbz1JUr44+pCnieFadvYIF+ccceG/DxA5s+vRif
         52evKqmF8WGzpeJqtCpEonapFJTA/B/D2W7UVPHa0Sreamhz+G7Q5+LqpwyDvUHaOLD6
         OK29aPdTzOxaJZUYC1+T+IQRBj2Hsh7a/l7/kg3w7vgRBMCoQBtP+Fy7XBm6UXCh0zh7
         r2rIIzy0UUarKBTdcW8o54ojZuGbGi3sGxO0xpj6fyKSJMFBDWZA4AH1hjAPMFSoHzu1
         ugRZpQWHwcyHrBJD8hIQQWAndvt0XSibbkhvPkEBfO5Am+/Cs6Tv1sqsJ8o3vVNRXn22
         gouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=BxomEH7mBMDC7vV6gSKOuhM47d4NlIfrh1onB9N0Od0=;
        b=pSa/wm9g/xbpd33rFJtNbZKVi1ZT9/pc8SYQJmD5H+3Of+kYonCNdAkQyV5gpe1g9b
         6wKDkSiDT//aFZPc5RNo9z1pHHzB6oPGAFqiFt6JwBp3FlzQMw1ppmfBYAzLyEa4yqRv
         1rWurbT93jXy2t02j3usEDEyBnTv98/i5e47eKm0SZyP2um97e/fHn39NgIGj/4tot4u
         IpUXIBEUA+T/kpbFiF0h4DNfelxVzAe+vCIPOql3wP4LkhTw/2aIa3Zo+H07mD464S8d
         LuMIV2GHUhRiFzb0lZnyxX2GiUjkkg34tr68Hpi6rML1Zv8GzF3lx3zO/83X+om66+Ke
         DJvA==
X-Gm-Message-State: AOAM5328O2p7dV9DSbzyftA8qVu1qvOloJCfedH3PjJVUQMNMbcAjOs3
        DocjVuASwr+6PXPrpb5D9k4=
X-Google-Smtp-Source: ABdhPJxr82WtL/Qgn0CCu82RnnP8MbMjS9EtRYklkXacPi/Eh2DQ77LPpL+E+qPg/rS9pj3+eG1BGQ==
X-Received: by 2002:a17:907:3e18:b0:6da:7ac5:4ad4 with SMTP id hp24-20020a1709073e1800b006da7ac54ad4mr23617627ejc.212.1648408086027;
        Sun, 27 Mar 2022 12:08:06 -0700 (PDT)
Received: from gmail.com (0526F2AE.dsl.pool.telekom.hu. [5.38.242.174])
        by smtp.gmail.com with ESMTPSA id m25-20020a170906161900b006d43be5b95fsm4960552ejd.118.2022.03.27.12.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 12:08:04 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 27 Mar 2022 21:08:03 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Subject: Re: [tip: x86/urgent] x86/config: Make the x86 defconfigs a bit more
 usable
Message-ID: <YkC2E4HXlNN+ga8F@gmail.com>
References: <6PkRPjnHE@gmail.com>
 <164811181676.389.2059677983505845292.tip-bot2@tip-bot2>
 <20220324101833.GD8939@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324101833.GD8939@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, Mar 24, 2022 at 08:50:16AM -0000, tip-bot2 for Ingo Molnar wrote:
> > The following commit has been merged into the x86/urgent branch of tip:
> > 
> > Commit-ID:     aee8bf2d5aab5e7cc24fa90238930fd14d72e580
> > Gitweb:        https://git.kernel.org/tip/aee8bf2d5aab5e7cc24fa90238930fd14d72e580
> > Author:        Ingo Molnar <mingo@kernel.org>
> > AuthorDate:    Thu, 24 Mar 2022 09:31:13 +01:00
> > Committer:     Ingo Molnar <mingo@kernel.org>
> > CommitterDate: Thu, 24 Mar 2022 09:32:20 +01:00
> > 
> > x86/config: Make the x86 defconfigs a bit more usable
> > 
> >  - Use 'make savedefconfig' to refresh & regenerate the files
> >  - Add in KVM boot enablers
> 
> We shouldn't duplicate kvm_guest.config.

I think x86-defconfig should be usable by itself - not just via the 
somewhat obscure combination of:

  make defconfig
  make kvm_guest.config

right?

> >  - Enable the cgroup features most distros rely on
> 
> I've not yet had defconfig+kvm_guest.config fail to boot on debian
> images (I occasionally grab one here:
> https://cloud.debian.org/images/cloud/sid/daily/latest/ )

Systemd is rather negative about missing cgroup features - at a point it 
used to insert 30(?) seconds delays during bootup warning about missing 
cgroups support, etc.

Also the main Debian derived distros (Ubuntu, etc.) plus Debian itself has 
most of cgroups enabled - so why should we test something that very few 
users are using?

Thanks,

	Ingo
