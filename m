Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F34557B654
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 14:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236570AbiGTM2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 08:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiGTM2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 08:28:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B12B64E03;
        Wed, 20 Jul 2022 05:28:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC4F361586;
        Wed, 20 Jul 2022 12:28:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20DD2C341CB;
        Wed, 20 Jul 2022 12:28:35 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Q4Pb7MFh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1658320112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bn4I/P3v7zIII+0ck5b6cxiwDLLoL6K44OVDFgm36Mg=;
        b=Q4Pb7MFhHcRFBS5a6jUCC7TRBeDOW3mxsfbTpYdCbgMTMEziiRe3uEL4Zeyd7MhO4/WAi0
        vF8rinsrIPsQ2Q2YPjoQYDiQBXYodrQAp2ugJrqR0uht218/SWYm7yTplKNV+khpXwgwQN
        XDHq+GVS9mjwaPfshNDZJ14MZN0W34Y=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ac37a37e (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 20 Jul 2022 12:28:31 +0000 (UTC)
Received: by mail-qt1-f181.google.com with SMTP id u12so945311qtk.0;
        Wed, 20 Jul 2022 05:28:31 -0700 (PDT)
X-Gm-Message-State: AJIora8f1hwLpEEKas4Gcw5OOYHSIsFn5kOR3TMn2YNETifLPfrr2qQ+
        Yyae1SAm41VFNYx7RFgxfxVLA0VjoUOvjv07Gns=
X-Google-Smtp-Source: AGRyM1vPXUN9nYsUdeJjICVW242pgZNq/l0/P4E4A0/tpJU8tqt7xrdKVp83a7eMc7mXhiH/dCZ0MwmyW3WPuCyUTRk=
X-Received: by 2002:a05:622a:86:b0:31e:9b00:68ba with SMTP id
 o6-20020a05622a008600b0031e9b0068bamr29656759qtw.390.1658320110851; Wed, 20
 Jul 2022 05:28:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220720113518.317032-1-Jason@zx2c4.com> <87sfmwotp9.fsf@meer.lwn.net>
In-Reply-To: <87sfmwotp9.fsf@meer.lwn.net>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 20 Jul 2022 14:28:20 +0200
X-Gmail-Original-Message-ID: <CAHmME9rsHKwQ3gDbMLUaN978QaBdNRj87VNgDXc-FUGHZ6APNg@mail.gmail.com>
Message-ID: <CAHmME9rsHKwQ3gDbMLUaN978QaBdNRj87VNgDXc-FUGHZ6APNg@mail.gmail.com>
Subject: Re: [PATCH] docs: ABI: correct QEMU fw_cfg spec path
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Simon Sapin <simon.sapin@exyr.org>,
        Gabriel Somlo <somlo@cmu.edu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jon,

On Wed, Jul 20, 2022 at 2:27 PM Jonathan Corbet <corbet@lwn.net> wrote:
>
> "Jason A. Donenfeld" <Jason@zx2c4.com> writes:
>
> > A few weeks ago, QEMU switched docs/specs/fw_cfg.txt to be
> > docs/specs/fw_cfg.rst, so update the reference in the kernel docs to
> > reflect this.
> >
> > Cc: Simon Sapin <simon.sapin@exyr.org>
> > Cc: Gabriel Somlo <somlo@cmu.edu>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > ---
> >  Documentation/ABI/testing/sysfs-firmware-qemu_fw_cfg | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-firmware-qemu_fw_cfg b/Documentation/ABI/testing/sysfs-firmware-qemu_fw_cfg
> > index ee0d6dbc810e..7cbce4af6346 100644
> > --- a/Documentation/ABI/testing/sysfs-firmware-qemu_fw_cfg
> > +++ b/Documentation/ABI/testing/sysfs-firmware-qemu_fw_cfg
> > @@ -12,7 +12,7 @@ Description:
> >               configuration data to the guest userspace.
> >
> >               The authoritative guest-side hardware interface documentation
> > -             to the fw_cfg device can be found in "docs/specs/fw_cfg.txt"
> > +             to the fw_cfg device can be found in "docs/specs/fw_cfg.rst"
> >               in the QEMU source tree.
>
> This is a worthy change, but is there any chance we could provide a URL
> instead so that people don't have to go finding the QEMU source to get
> the information they need?

Sure. Will send a v2.
(I just stumbled upon this when actually following the breadcrumbs
from one to another manually.)

Jason
