Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F370A466C93
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 23:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244912AbhLBWcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 17:32:13 -0500
Received: from mail-qv1-f48.google.com ([209.85.219.48]:39805 "EHLO
        mail-qv1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377292AbhLBWbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 17:31:48 -0500
Received: by mail-qv1-f48.google.com with SMTP id gu12so976348qvb.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 14:28:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ADfUBBKKR2V7Th9eag/BQ1lRZNTT71LihshaeivJjKw=;
        b=R4N7ZQqQWvd6gOJvBTvvoTviiHDhlsMPf0oR3UZxHScJSiIaZ0U9PPJ4GW89NuVNWr
         ENFsgjIqTE53V05eTZZfyLeUEAXE3c/EomO1Osrjcbfc0RMvb5SIM+QR9vIovCReiZTd
         OfQQEpHyWnwcaQwMvSKyC+GP8Dn1HhrVdnkoZIu9Apu69Hg2f5BjRPMy6gM3/beYB0WZ
         EIqcKPSnw7UxaFynbofnIgxsuXg9DTQxPT8Tb5WIkYP71Bksx4ma5Qi/eYy/WXJC0btl
         tzAm8V6oG9OA185yAncS/qYIdcjfiQ3h2ZHk4/KTjtS8BqTGwEtR85tHSgeee8EVhu7Y
         1quA==
X-Gm-Message-State: AOAM532P7qi4p7tkP1oCjaf6T7lg+5x/9J44eeowkRIbmVbomSQfth3G
        z4ujGZCEP5h61NUveTMp8+1elR6UoTA=
X-Google-Smtp-Source: ABdhPJw8wFsQ839+bLxO3bOUze7vEugN1GGd5YEvkUj+mhIU9U5ZQLrCe1KT/PVAhz5y9TrjH/o+lA==
X-Received: by 2002:ad4:5b82:: with SMTP id 2mr16449840qvp.93.1638484104808;
        Thu, 02 Dec 2021 14:28:24 -0800 (PST)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com. [209.85.219.53])
        by smtp.gmail.com with ESMTPSA id s7sm941916qta.31.2021.12.02.14.28.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Dec 2021 14:28:24 -0800 (PST)
Received: by mail-qv1-f53.google.com with SMTP id i12so947345qvh.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 14:28:23 -0800 (PST)
X-Received: by 2002:a05:6214:1d26:: with SMTP id f6mr16312132qvd.19.1638484103593;
 Thu, 02 Dec 2021 14:28:23 -0800 (PST)
MIME-Version: 1.0
References: <20211110105952.62013-1-andriy.shevchenko@linux.intel.com>
 <20211110105952.62013-3-andriy.shevchenko@linux.intel.com>
 <YZJExzxJ4j8g6jEY@smile.fi.intel.com> <AS8PR04MB8946B4800AE34258F7F2BA688F989@AS8PR04MB8946.eurprd04.prod.outlook.com>
 <YZN7+UlXtJi8/i1L@smile.fi.intel.com> <YZ0WlMyS36Gj565C@smile.fi.intel.com>
 <CADRPPNT3yhr3jAPZm=hcON3nd97eLSrkWqFBV6kh6W5gf0w3Xg@mail.gmail.com>
 <YaiS2iHCrGkXgTdX@smile.fi.intel.com> <AS8PR04MB894640E4FF4EB7D01604049E8F699@AS8PR04MB8946.eurprd04.prod.outlook.com>
 <Yak6Co4lO761HmWG@smile.fi.intel.com>
In-Reply-To: <Yak6Co4lO761HmWG@smile.fi.intel.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Thu, 2 Dec 2021 16:28:11 -0600
X-Gmail-Original-Message-ID: <CADRPPNS98G2iBiK0_nE7d6Dq-6FkSDme8a+1is5_GZ-iWJrhvg@mail.gmail.com>
Message-ID: <CADRPPNS98G2iBiK0_nE7d6Dq-6FkSDme8a+1is5_GZ-iWJrhvg@mail.gmail.com>
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

On Thu, Dec 2, 2021 at 3:30 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Dec 02, 2021 at 08:01:54PM +0000, Leo Li wrote:
> > > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Sent: Thursday, December 2, 2021 3:33 AM
> > > On Wed, Dec 01, 2021 at 01:41:16PM -0600, Li Yang wrote:
> > > > On Tue, Nov 23, 2021 at 10:32 AM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
>
> ...
>
> > > > The build test is good.  I have applied it for next.  Thanks.
> > >
> > > Thanks, what about MAINTAINERS updates? I don't see them neither in next
> > > nor in your tree.
> >
> > I am ok with these MAINTAINERS updates.  I thought you want to send them directly to Linus.  I can take them if you like.
>
> I was just pointing out that it would be good that you (as a maintainer of SOC
> FSL) have them applied and pushed for the current cycle, but they are not code
> fixes anyway, so it's not critical.
>
> TL;DR: Yes, please take them, thanks!

Got it.  Both applied for next.  Thanks.

Regards,
Leo
