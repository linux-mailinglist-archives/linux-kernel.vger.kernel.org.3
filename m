Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268D9500893
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240521AbiDNIoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 04:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241159AbiDNImz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 04:42:55 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688A03893
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:40:31 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id c6so5418374edn.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=am1NIkz6tOpNczOlzqelfWQy0MAGLWn7F9cz1V3LtzI=;
        b=aImOuH3f+KOJXtLNTY1AS408NTZZ9DtGBMtQLVaHok1qyR9QMQwlj6KlF1ac2u5pMg
         AScB1kMF5Ik7pUKeH4PYqYyv+w+PKoMvaM0oCI6Heqs6y3xyawEKa5MjUWjvytM51nSh
         V3m2tb1kGTAkacUVTWhqHRdIEp49sAbSVIWN/nDKiMrpjn0Jx1N8bN94TpwnistNmfNY
         Stlm7YaO0NhWqXiQsW2u8vh0QEGgpDWvEuQzBZyzfzXGchOjmY2fUzPRLmXD2cezziWW
         e4ivR3S0xUPhbMH7541wi/qarj+OGzJLkyBxxIoiw1y1I7qaTW6eOTXU/QGzUu/AUi3W
         lD7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=am1NIkz6tOpNczOlzqelfWQy0MAGLWn7F9cz1V3LtzI=;
        b=bZn2gYOyrPbIqPBpf2tMCrDlDFo4GePX+ZcPVtrpMyvSiPLxGQVZxe27mBe7wisSMR
         YuRhrVzclTfPsMBbeo85BClsq8fRaOrKtJ/vycPImzgz5byLCh9RPa6gFWJXpnCdjg+U
         z2jPwRBDSGT3NC9WheP9MiNgerh11S6UlcCKu9nwtvdZQoFr7Swyj+p4D34hdUbiyY9t
         mupVX4flARSRf2tSCu430+OjkEJYaDG6g0H++h1tARcOH/c//fsR5a8fk32DmgIKL1c+
         SciU+3M3JlSQUEGHpdP/gb4tTd1tqZBLNP1PmGBLwGOVpjZ7m5/fy9/eMO6+uI825yZF
         jmrw==
X-Gm-Message-State: AOAM532NlTgtiFuLeTAWl5/r7mpVFxqxwYrm4MhR6Ze3vSB6GAwGP8j7
        GZ6Nn74k3P069p5kX2j1HIE=
X-Google-Smtp-Source: ABdhPJyV95K340bLEdgVVeTTZWMr7Zfbw8u+Zrr9DoJfHrfeW42yBcWA+KVWYLh7bs/7HTCoYdE3Ig==
X-Received: by 2002:a05:6402:1cc1:b0:413:2b12:fc49 with SMTP id ds1-20020a0564021cc100b004132b12fc49mr1807087edb.118.1649925629784;
        Thu, 14 Apr 2022 01:40:29 -0700 (PDT)
Received: from leap.localnet (host-79-43-11-75.retail.telecomitalia.it. [79.43.11.75])
        by smtp.gmail.com with ESMTPSA id v10-20020a170906380a00b006a68610908asm421825ejc.24.2022.04.14.01.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 01:40:28 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        David Kershner <david.kershner@unisys.com>,
        sparmaintainer@unisys.com
Subject: Re: [PATCH v2] staging: Remove the drivers for the Unisys s-Par
Date:   Thu, 14 Apr 2022 10:40:26 +0200
Message-ID: <2100119.irdbgypaU6@leap>
In-Reply-To: <YlfJ1UQQQeYBvTHV@kroah.com>
References: <20220413080111.13861-1-fmdefrancesco@gmail.com> <YlfJ1UQQQeYBvTHV@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On gioved? 14 aprile 2022 09:14:29 CEST Greg Kroah-Hartman wrote:
> On Wed, Apr 13, 2022 at 10:01:11AM +0200, Fabio M. De Francesco wrote:
> > The Unisys sub-tree contains three drivers for the "Unisys Secure 
Partition"
> > (s-Par(R)): visorhba, visorinput, visornic.
> > 
> > They have no maintainers, in fact the only one that is listed in 
MAINTAINERS
> > has an unreacheable email address. During 2021 and 2022 several patches 
have
> > been submitted to these drivers but nobody at Unisys cared of reviewing 
the
> > changes. Probably, also the "sparmaintainer" internal list of 
unisys.com is
> > not anymore read by interested Unisys' engineers.
> > 
> > Therefore, remove the ./unisys subdirectory and delete the relevant 
entries
> > in the MAINTAINERS, Kconfig, Makefile files.
> > 
> > Cc: David Kershner <david.kershner@unisys.com>
> > Cc: sparmaintainer@unisys.com
> > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> > 
> > v1->v2: Add two "Cc:" lines, one to David Kershner and the second to 
the
> > "sparmaintainer" list at unisys.com, as requested by Greg Kroah-
Hartman.
> > 
> >  MAINTAINERS                                   |    8 -
> >  drivers/staging/Kconfig                       |    2 -
> >  drivers/staging/Makefile                      |    1 -
> >  .../ABI/sysfs-platform-visorchipset           |   89 -
> >  .../staging/unisys/Documentation/overview.txt |  337 ---
> >  drivers/staging/unisys/Kconfig                |   16 -
> >  drivers/staging/unisys/MAINTAINERS            |    5 -
> >  drivers/staging/unisys/Makefile               |    7 -
> >  drivers/staging/unisys/TODO                   |   16 -
> >  drivers/staging/unisys/include/iochannel.h    |  571 -----
> >  drivers/staging/unisys/visorhba/Kconfig       |   15 -
> >  drivers/staging/unisys/visorhba/Makefile      |   10 -
> >  .../staging/unisys/visorhba/visorhba_main.c   | 1142 ---------
> >  drivers/staging/unisys/visorinput/Kconfig     |   16 -
> >  drivers/staging/unisys/visorinput/Makefile    |    7 -
> >  .../staging/unisys/visorinput/visorinput.c    |  788 ------
> >  drivers/staging/unisys/visornic/Kconfig       |   16 -
> >  drivers/staging/unisys/visornic/Makefile      |   10 -
> >  .../staging/unisys/visornic/visornic_main.c   | 2131 -----------------
> 
> 
> 
> >  19 files changed, 5187 deletions(-)
> >  delete mode 100644 drivers/staging/unisys/Documentation/ABI/sysfs-
platform-visorchipset
> >  delete mode 100644 drivers/staging/unisys/Documentation/overview.txt
> >  delete mode 100644 drivers/staging/unisys/Kconfig
> >  delete mode 100644 drivers/staging/unisys/MAINTAINERS
> >  delete mode 100644 drivers/staging/unisys/Makefile
> >  delete mode 100644 drivers/staging/unisys/TODO
> >  delete mode 100644 drivers/staging/unisys/include/iochannel.h
> >  delete mode 100644 drivers/staging/unisys/visorhba/Kconfig
> >  delete mode 100644 drivers/staging/unisys/visorhba/Makefile
> >  delete mode 100644 drivers/staging/unisys/visorhba/visorhba_main.c
> >  delete mode 100644 drivers/staging/unisys/visorinput/Kconfig
> >  delete mode 100644 drivers/staging/unisys/visorinput/Makefile
> >  delete mode 100644 drivers/staging/unisys/visorinput/visorinput.c
> >  delete mode 100644 drivers/staging/unisys/visornic/Kconfig
> >  delete mode 100644 drivers/staging/unisys/visornic/Makefile
> >  delete mode 100644 drivers/staging/unisys/visornic/visornic_main.c
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 3ed62dcd144e..a62da6d0f943 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -20183,14 +20183,6 @@ F:	drivers/cdrom/cdrom.c
> >  F:	include/linux/cdrom.h
> >  F:	include/uapi/linux/cdrom.h
> >  
> > -UNISYS S-PAR DRIVERS
> > -M:	David Kershner <david.kershner@unisys.com>
> > -L:	sparmaintainer@unisys.com (Unisys internal)
> > -S:	Supported
> > -F:	drivers/staging/unisys/
> > -F:	drivers/visorbus/
> 
> You forgot to delete the files in this directory as well :(
> 
Sorry, that's worse than just being forgetful. I did not carefully read the
lines I deleted in MAINTAINERS :(

I will post a v3 soon. In the meantime, I'll also add between the lines
"Cc:" that other person that Alison found in drivers/staging/unisys/TODO.

Thanks,

Fabio M. De Francesco



