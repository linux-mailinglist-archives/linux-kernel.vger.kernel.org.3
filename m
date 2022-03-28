Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565644EA23A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 23:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiC1VIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 17:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiC1VIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 17:08:41 -0400
Received: from mail.thepaulodoom.com (www.thepaulodoom.com [45.77.108.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 04B72E0CB;
        Mon, 28 Mar 2022 14:06:58 -0700 (PDT)
Received: from hp-amd-paul (c-98-240-189-147.hsd1.mn.comcast.net [98.240.189.147])
        by vultr.guest (OpenSMTPD) with ESMTPSA id ffe6c82d (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 28 Mar 2022 21:06:57 +0000 (UTC)
Date:   Mon, 28 Mar 2022 16:06:53 -0500
From:   Paul Lemmermann <thepaulodoom@thepaulodoom.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IIO: accel: fixed coding style issues
Message-ID: <YkIjbdICfxBZx3qf@hp-amd-paul>
References: <YkHOpCT2Gad1YaxN@hp-amd-paul>
 <CAHp75Vf7R2=m7apZfXkY9-nETNiG7n6oXpivBg-56Wguzx2+8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vf7R2=m7apZfXkY9-nETNiG7n6oXpivBg-56Wguzx2+8A@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 11:32:44PM +0300, Andy Shevchenko wrote:
> On Mon, Mar 28, 2022 at 7:45 PM Paul Lemmermann
> <thepaulodoom@thepaulodoom.com> wrote:
> >
> > Fixed case statement issues and spacing issues.
> 
> ...
> 
> >                         switch (val[j]) {
> > -                       case -1: str = "-1"; break;
> > -                       case 0:  str = "0";  break;
> > -                       case 1:  str = "1";  break;
> > -                       default: goto unknown_format;
> > +                       case -1:
> > +                               str = "-1";
> > +                               break;
> > +                       case 0:
> > +                               str = "0";
> > +                               break;
> > +                       case 1:
> > +                               str = "1";
> > +                               break;
> > +                       default:
> > +                               goto unknown_format;
> >                         }
> 
> What you cited from documentation mostly affects the new code, but
> this code is already in the kernel and modifying it, esp. taking into
> account 3x LOCs count, looks like an unneeded churn, even if
> documentation thinks otherwise.
> 
> What I could acknowledge from your proposal is the default case.
> Otherwise just leave it to the point if we touch this code for
> something else in the future.
> 
> ...
> 
> >  static const struct of_device_id kxsd9_of_match[] = {
> > -        { .compatible = "kionix,kxsd9" },
> > -        { },
> > +       { .compatible = "kionix,kxsd9" },
> 
> > +       { },
> 
> I dunno why you touched this line (likely TABs vs. spaces), but please
> remove the comma as well here.

Yes, that is exactly why this patch exists.

Thank you, I will take these thoughts into account and submit a new
patch.

Thanks!
Paul
> 
> >  };
> 
> -- 
> With Best Regards,
> Andy Shevchenko
