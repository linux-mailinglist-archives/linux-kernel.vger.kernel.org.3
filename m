Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB8B4FB31D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 06:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244686AbiDKFAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 01:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244682AbiDKFAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 01:00:38 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013F820F49
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 21:58:26 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-d6e29fb3d7so15983668fac.7
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 21:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kJuexkGPihhCFQ9G7n/meJT/qMlsj0kY3mf4Csm4V5I=;
        b=YHcJAvB1dfgRAPM9EDuJW3Y4fkyN/QmOLvdC7wKbBrF934rgBftVCaB03CtFQr9ZTk
         dP17bmCKaXEDmjsr1g8Xm+06Aiym/H8ldW6u9cm7d3NtIu866lvFuiQMQAoRNqhGGlGw
         1GNaVbY4ETJT4qC4phPSuKl3APU3aacWb0r4RBadTBIg68XEdaIvVlLlkgQ68RRc9Rux
         udDdfg8BAZgQdvDR96bCK/fuayGd/fuUA9swKTnhgmZ+Z1je9ZYxycfL81305LB6pccj
         MkPHHatC5x29BxRmZKudnoE+YSsrqrOatk48pLgKEZZDrY6RrhZYm3QBXuJkQn4DIvLn
         iAOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=kJuexkGPihhCFQ9G7n/meJT/qMlsj0kY3mf4Csm4V5I=;
        b=WOBVCpprf94jrzADfSaSgkoJ1E1skhMpqFdlNc87fFRsHVcSrsp1u06PGQ/yBV/N4l
         mgDnxMeECLt6PgnbEFF6wK6EN4wS8L1xfijSA48v6rSivCgnrptQSkBnPLqFOQpHP3Ok
         +B6WQ1WWYIIpUqP1dvgOeUGkzlQfi2TZAXGnMOEqAZQrTadaMnL7+FBiHHdFhes1U3Ok
         QcKFZzFiJqspbUd9GD+VS7aiUY/c+VhRzrbWGU50yYHPabkP+/do4K5wtNDASS5o7DpB
         RSTsAEf2rGG0amZ3db6hIaVJ7ke0Vz7EqyEYc8Lb4RACJvsRt4rsF4QWB1zU+1k4GraT
         Sulw==
X-Gm-Message-State: AOAM533k521DmqpGdgpsbs3Za91rnpUzxogTSNhNuVPK2c/sBkFxN6Iu
        HbTjmhGg+8u5cUMOyw+Tk5+2XdQzagY=
X-Google-Smtp-Source: ABdhPJws7oa/oOpuECwblcEiJV5PDdrhW1R1QHf9/dH6HuPrKawsUUA6C5M7QbkWLE5ylPOI2BWPbg==
X-Received: by 2002:a05:6870:e388:b0:e1:fc4a:4f85 with SMTP id x8-20020a056870e38800b000e1fc4a4f85mr13736992oad.87.1649653104499;
        Sun, 10 Apr 2022 21:58:24 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r35-20020a056870582300b000df0dc42ff5sm11604852oap.0.2022.04.10.21.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 21:58:23 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 10 Apr 2022 21:58:22 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.18-rc2
Message-ID: <20220411045822.GA295401@roeck-us.net>
References: <CAHk-=wh0+DYC2+Aeu2=vfUtGaDqVuKxKrxyhwQFoG89rcynzww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh0+DYC2+Aeu2=vfUtGaDqVuKxKrxyhwQFoG89rcynzww@mail.gmail.com>
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

On Sun, Apr 10, 2022 at 02:54:27PM -1000, Linus Torvalds wrote:
> It's Sunday afternoon for me, which means "rc release time". Things
> look fairly normal here, although it's early in the release cycle so
> it's a bit hard to say for sure. But at least it's not looking
> particularly odd, and we have fixes all over.
> 
> Drivers is the bulk of it, and there's a little bit of everything
> here, although the AMD GPU driver fixes are perhaps the most
> noticeable. But there's also networking, scsi, rdma, block, you name
> it...
> 
> On the non-driver side, we've got a bump in the diffstat for the
> static call infrastructure, but that's really just code movement. The
> actual changes are more spread out than that bump would imply, and are
> generally pretty small. There's some filesystem fixes, core
> networking, and obviously the usual architecture work.
> 
> And as has been the case lately, there's the usual tooling updates -
> selftests and perf.
> 
> Full shortlog appended, it's not exactly tiny, but it's easy enough to
> scroll through to get a feel for what's been going on.
> 
> Testing appreciated as always,

Build results:
	total: 151 pass: 151 fail: 0
Qemu test results:
	total: 488 pass: 488 fail: 0

The only issue left in my testing is the warning in nosmp parisc code.

WARNING: CPU: 0 PID: 1 at fs/sysfs/group.c:115 internal_create_group+0x360/0x394

This problem is fixed in linux-next with
https://lore.kernel.org/all/20220401203114.348053-1-deller@gmx.de/
which should hopefully find its way into mainline soon.

Guenter
