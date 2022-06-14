Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDB254AB76
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 10:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355016AbiFNIKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 04:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238473AbiFNIKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 04:10:19 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0B739B8D;
        Tue, 14 Jun 2022 01:10:18 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id g186so7874523pgc.1;
        Tue, 14 Jun 2022 01:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DKrBXbhsk8rXYX4B7Q1js+0hKxTUwLaVs+hkqyQf9jE=;
        b=DRdzNKvj0nSfADR6gyGc3ltwo+/dPOCReZNBDqOSctcXv123j/zw8OpaobROHWJDKM
         5PAOKEWGh+anm9A7R0e08HHEyDm2c1rsk1uRk/kwcfNyFckvINQ4prSWJfip5UaYOhbx
         IuuXQ2XK3YreJEoGnrYVrzg8IJd0fgQvGoLUTDJwi3/p9VwWJU+8fTGU/XPlIjdqsH2m
         Pce48e3TMyzeT4GhKvCkFOLlM/l8DeqpbIFQh6yCF36n5tTt5ks+Jghyi3PxHQk9vb/2
         mXMJliceuaqPZKtBEY+BjezKMeQEDJrwfKcZuaEzWlCEgemaHHG2Bf5AEMKIk/IaZLZ1
         xKig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DKrBXbhsk8rXYX4B7Q1js+0hKxTUwLaVs+hkqyQf9jE=;
        b=azpqHwOq12ru1coowRKwfbeG/uotUCjTOTtdJeTXE/NAl4L0C0a3H04hs5k7JDefBz
         Ot3UWLTClKz8wBtBPM/9T865DkoOhn5FpssSdsodhH4JuS6a2TS2M5NHbpEhYDR8pvBZ
         KOEt6p52UrEITfQpMzt2WCjcnVnlB9493k2HC0xc5Ytgor49oOrsI7yD1Ci5tEV/Fbv9
         Tuy7FnO75RY+8VvSwlWnqc0NvZldN2w4j2f0tRsOY9WO8wftODrIZWPJMIhcm0BV7pTO
         x9NfN6HOr7cOYMiMIbdC/oinRbN7WG8F5YQo1TeD+ZTBAhxNNHVv/lJAzygQxGuBEO8v
         nPrg==
X-Gm-Message-State: AOAM533bHrNnSYXs46lmfuIROutGIubxGk2scRXAimdJR1hWPaVZnW0L
        8gJyxz0V6ig6WihnlluTj5vp7mnRALI=
X-Google-Smtp-Source: ABdhPJwvHzWSrAhj67Ep7N87YKehYY56PKqLmnjpqnNBUYZsd+FDQ1zvxrmu1pvUNhUQ6eKRt7Y4zg==
X-Received: by 2002:a63:80c6:0:b0:405:1796:ea72 with SMTP id j189-20020a6380c6000000b004051796ea72mr3432755pgd.447.1655194217760;
        Tue, 14 Jun 2022 01:10:17 -0700 (PDT)
Received: from localhost (subs32-116-206-28-37.three.co.id. [116.206.28.37])
        by smtp.gmail.com with ESMTPSA id d10-20020a170903208a00b001689e31ff9dsm6524607plc.9.2022.06.14.01.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 01:10:17 -0700 (PDT)
Date:   Tue, 14 Jun 2022 15:10:14 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Greg KH <greg@kroah.com>, Neal Liu <neal_liu@aspeedtech.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the usb tree
Message-ID: <YqhCZoA4SukXq9lf@debian.me>
References: <20220614120833.06cec8e7@canb.auug.org.au>
 <YqgtsXSNZKds2bDl@kroah.com>
 <20220614175247.30b02dc2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220614175247.30b02dc2@canb.auug.org.au>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 05:52:47PM +1000, Stephen Rothwell wrote:
> Hi Greg,
> 
> On Tue, 14 Jun 2022 08:41:53 +0200 Greg KH <greg@kroah.com> wrote:
> >
> > On Tue, Jun 14, 2022 at 12:08:33PM +1000, Stephen Rothwell wrote:
> > > Hi all,
> > > 
> > > After merging the usb tree, today's linux-next build (arm
> > > multi_v7_defconfig) failed like this:
> > 
> > Failed like what?
> 
> Sorry about that.  I no longer have the actual error message, but it
> was complaining about a duplicate DT node "ahb usb@1e6a2000".  The
> patch managed to be applied twice.
> 
> > > Caused by commit
> > > 
> > >   2cee50bf4590 ("ARM: dts: aspeed: Add USB2.0 device controller node")

Hi Stephen,

I mean the missing error you reported was:

  DTC     arch/arm/boot/dts/aspeed-ast2500-evb.dtb
  DTC     arch/arm/boot/dts/aspeed-ast2600-evb-a1.dtb
arch/arm/boot/dts/aspeed-g6.dtsi:320.21-328.5: ERROR (duplicate_node_names): /ahb/usb@1e6a2000: Duplicate node name
ERROR: Input tree has errors, aborting (use -f to force output)

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
