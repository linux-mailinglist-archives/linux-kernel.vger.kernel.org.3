Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99FFE50B3C0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 11:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445772AbiDVJJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 05:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356741AbiDVJJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 05:09:01 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CD451E6F
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 02:06:04 -0700 (PDT)
Received: from mail-wm1-f49.google.com ([209.85.128.49]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N1gac-1nsqjS1Ud6-0122Ki for <linux-kernel@vger.kernel.org>; Fri, 22 Apr
 2022 11:06:02 +0200
Received: by mail-wm1-f49.google.com with SMTP id v64-20020a1cac43000000b0038cfd1b3a6dso7508456wme.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 02:06:02 -0700 (PDT)
X-Gm-Message-State: AOAM532LFtIDIdVx+YIwRvHce/9bdOE1JicttUh8UOdob6HWiy0sWPK9
        8xC4/XMebIbitilN0+gaJtXlbfpM+TICk5fVchY=
X-Google-Smtp-Source: ABdhPJyBJy68LeWxoCtkZpxUNMy01/6v++E4fqe+8tuCDM/CbPdYU7ohbVixofosAP/W+Pe5EImxDo7fKgPauiW5gWg=
X-Received: by 2002:a7b:ce15:0:b0:38e:b7b0:79be with SMTP id
 m21-20020a7bce15000000b0038eb7b079bemr3153470wmc.71.1650618361979; Fri, 22
 Apr 2022 02:06:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220204072234.304543-1-joel@jms.id.au> <20220204072234.304543-2-joel@jms.id.au>
 <YmJPRPhfA4Cki85S@kroah.com>
In-Reply-To: <YmJPRPhfA4Cki85S@kroah.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 22 Apr 2022 11:05:46 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0G_xNQ6b2e71VXPVi+-j5L--SU37gFErwGYuh1QPrr1A@mail.gmail.com>
Message-ID: <CAK8P3a0G_xNQ6b2e71VXPVi+-j5L--SU37gFErwGYuh1QPrr1A@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] firmware: Add boot information to sysfs
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Joel Stanley <joel@jms.id.au>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Jeffery <andrew@aj.id.au>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:0NVKVjl/TQk0UtjI91jMgAun+WwfT1DDqE/TxRS4h2d4QQ1MpmQ
 GmWm5FrJXZ0wK43Pz2mfjim4nPccoAMv64WmBasQO60DUuk+1aM6wu+Mxz9lmBlOiDmOTAv
 W7/nkhmryjwBvnDJspjiemL/KTooyGeFcwcPPkN5cfnqsWdPoQF1K6FvSEpw/LjWiG/Hr9l
 qi01RKfbxJhJpOTiaBYjw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AfU11mqt1Jo=:Z+5KKHD1eVOKYgWMLTlHq6
 pc3TIhIDl8pgFn6UFRad0zQ+kWFRZK8tMGCBh9eB0K/7amQBjPpeqi565U6jg68PYQ6qRDGpG
 LMaPrdTAS8EvwNvMt5c6F3tuMv2uAhFOBDvyhu19cpIjIj9cN7P8v1UqNAGCwSkL8kHpfm2gc
 +g08sQMl70GRVvWHDDFTnRRIUHfaqcZzyc2gWYI9zvE8elyJIxjtmd8xW4ApoJHFVf4vLyBo/
 AS4N93Uf/4TTWlzalAuZRScKNLiZqQGNBK8/v7ifLsmseT3mxLPqc9cs7JqHQH9qr9GyBAqf0
 rBcH0TKQuFuKMIxa1QSXRkMuhqFTedrDFjhqDWSleqUku9G1ZxjefZzL5oI0I2a6PTd4zvp6R
 GaLjZ9dNSqNF++YEE/OKEITUK4nOhmH62eM7KGmIKqDBBP7nVwZIo50rMR/MvHJlV0ePxTLnD
 geU8aWD4LGlmCBzULL1SQw2jZYXeDusshE3ddDoGmTmGLBb/kL35RDd3ycG5F8dkDVkFZcHXi
 edozaRPm3xTOBGHP7U9d/lL3PZhbE7LRuLIjzQ1ujujvPdTdKP4B7XYtTZQQzjDPlvtvDm3MP
 mIF2jhrD5bTQBCbabK2SUDkavbl1Qiwx481Htywqt+N3dJFmLAyQjlPrsfUudce3XNkf555v3
 g4u5yuxL/VNaUx/COQwXHqHDyLsT3N9S0m9PNztjgP92ht9oSUubba4cVAI5ZKxqXw/ERIgQV
 +4ERbufVgj2WtskkIAltE4c85+q/nCv3NQL4YSfvrJaH3XjU9J6Iab3yg6yh2/5byHclEPoDs
 0yZPltDDap9mTKzwcxhzBPGqDM/ICQG79Pxp/7E+O6qyge4CNY=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 8:46 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Fri, Feb 04, 2022 at 05:52:32PM +1030, Joel Stanley wrote:
> > +What:                /sys/firmware/bootinfo/*
> > +Date:                Jan 2022
>
> It isn't January anymore :)

The patch was sent on Feb 4, I would expect that to be close enough. Does this
need to be the month of the kernel release it is merged into instead?

> > +Description:
> > +             A system can expose information about how it was started in
> > +             this directory.
>
> I do not understand what you mean by "how it was started".
>
> > +             This information is agnostic as to the firmware implementation.
>
> How?  This should be very firmware specific.

The original patch was specific to a particular SoC vendor. Since the
information provided here is fairly generic in the end, I asked for
the interface
to be generalized to the point that it can be reused across multiple
vendors and architectures.

      Arnd
