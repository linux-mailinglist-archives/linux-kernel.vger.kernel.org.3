Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDB934656AD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 20:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbhLATo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 14:44:56 -0500
Received: from mail-qt1-f178.google.com ([209.85.160.178]:33387 "EHLO
        mail-qt1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240028AbhLATow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 14:44:52 -0500
Received: by mail-qt1-f178.google.com with SMTP id n15so25279282qta.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 11:41:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bjDuMIeNukQm5l61QJg6nNUANP6Dica4CrK7FOgg6ks=;
        b=iVdtbM0WQa8SvJJEWNI+vOdiOZYeivm9Z4vDRHIQ3/7VUd5QEg6Evv4NmcqBm2beGp
         VJYpVROAayjmgxTqZwvSkNibjQc+eqXGuE7MjeM+44JWJeTetuvPzpeXgBVLDodCFooe
         ERNy53Ag6aZ5fFIsMaT3oMHUap/2J7UsfvV82crFo+0YgGlcPEFUIjZJqNJZPRaU4Uo+
         tmf8Jn7w3OioeLU0lS4tfnMI+WmyxC1Mrmoik9wwQCvGxSZdPXIFHd7/97mAT0AgW/33
         SufypYJz32Kfp8iZZF2Ppc1cjzfgWFYGBChcN3XAredwmat9x+ZftmIcNv+JZotiHHxq
         kDWw==
X-Gm-Message-State: AOAM533f6mnA9ykfLrCrhnuS7BVgbcJohEW+lbYFeC77FC8DimT6h/PD
        //DzsKQxHRSySMJPzGACKU3XDUYIX6s=
X-Google-Smtp-Source: ABdhPJwIN56a+dqCMMeCID8PPEZY8GXgeJHsh7lruPzb+FJwwjXg/VU+zSmePRMi77HrvoBQM3HOUQ==
X-Received: by 2002:ac8:5806:: with SMTP id g6mr8873763qtg.125.1638387690521;
        Wed, 01 Dec 2021 11:41:30 -0800 (PST)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com. [209.85.222.175])
        by smtp.gmail.com with ESMTPSA id h11sm375945qkp.46.2021.12.01.11.41.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Dec 2021 11:41:30 -0800 (PST)
Received: by mail-qk1-f175.google.com with SMTP id a11so32218763qkh.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 11:41:29 -0800 (PST)
X-Received: by 2002:a05:620a:298e:: with SMTP id r14mr8391905qkp.509.1638387689177;
 Wed, 01 Dec 2021 11:41:29 -0800 (PST)
MIME-Version: 1.0
References: <20211110105952.62013-1-andriy.shevchenko@linux.intel.com>
 <20211110105952.62013-3-andriy.shevchenko@linux.intel.com>
 <YZJExzxJ4j8g6jEY@smile.fi.intel.com> <AS8PR04MB8946B4800AE34258F7F2BA688F989@AS8PR04MB8946.eurprd04.prod.outlook.com>
 <YZN7+UlXtJi8/i1L@smile.fi.intel.com> <YZ0WlMyS36Gj565C@smile.fi.intel.com>
In-Reply-To: <YZ0WlMyS36Gj565C@smile.fi.intel.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Wed, 1 Dec 2021 13:41:16 -0600
X-Gmail-Original-Message-ID: <CADRPPNT3yhr3jAPZm=hcON3nd97eLSrkWqFBV6kh6W5gf0w3Xg@mail.gmail.com>
Message-ID: <CADRPPNT3yhr3jAPZm=hcON3nd97eLSrkWqFBV6kh6W5gf0w3Xg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] soc: fsl: Replace kernel.h with the necessary inclusions
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Qiang Zhao <qiang.zhao@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 10:32 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Nov 16, 2021 at 11:38:01AM +0200, Andy Shevchenko wrote:
> > On Mon, Nov 15, 2021 at 10:24:36PM +0000, Leo Li wrote:
> > > > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > Sent: Monday, November 15, 2021 5:30 AM
> > > > On Wed, Nov 10, 2021 at 12:59:52PM +0200, Andy Shevchenko wrote:
> >
> > ...
> >
> > > > > v2: updated Cc list based on previous changes to MAINTAINERS
> > > >
> > > > Any comments on this, please?
> > > >
> > > > I really want to decrease amount of kernel.h usage in the common headers.
> > > > So others won't copy'n'paste bad example.
> > >
> > > There seems to be no problem with the patch although I didn't get time to really compile with it applied.
> > >
> > > Will pick them up later after build test.
> >
> > Thank you!
> >
> > Note, it has two fixes against MAINTAINERS which may be sent, I believe,
> > sooner than later to Linus.
>
> Any new so far?

The build test is good.  I have applied it for next.  Thanks.

Regards,
Leo
