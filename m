Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D02AF4B13BC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 18:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244956AbiBJRAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 12:00:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244255AbiBJRAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 12:00:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F2AB89;
        Thu, 10 Feb 2022 09:00:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7F8261DAF;
        Thu, 10 Feb 2022 17:00:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D7EC004E1;
        Thu, 10 Feb 2022 17:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644512438;
        bh=aQEqo6ymIB6+YcMUwy13z0sNve9kVyiSVyXb90VD/sY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y7ucSnD9MXKl9zHyGsJJJKDNgkTtMCYFbE9gtSwh2lIy83xf2vQvyu/qdEGcOIlB2
         dWTBiX1CzwLvkgsPOuBAYc2Oy+mIDFAVWmuAl6LqC6vdghFXCqgZsbrWsDSakVKhqz
         K4ZF2w8ny6B7JE3QU8KyHZTAzETyxUKIKjHbrTpI=
Date:   Thu, 10 Feb 2022 18:00:34 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-spdx@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH v2] random: add proper SPDX header
Message-ID: <YgVEsotBkXVPknAK@kroah.com>
References: <CAHmME9pc5NRLW4wUy57bqd_gX01PBVoydOQp9Z0rWT+j+fAb+Q@mail.gmail.com>
 <20220210161611.157765-1-Jason@zx2c4.com>
 <YgVCKjDpuYChCKzu@kroah.com>
 <CAHmME9qOSpjzUhwkXoL9OagBzKj51mPr=f-tNNnLCEQsAdWSmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9qOSpjzUhwkXoL9OagBzKj51mPr=f-tNNnLCEQsAdWSmg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 05:53:33PM +0100, Jason A. Donenfeld wrote:
> Hi Greg,
> 
> Thanks for the review. Comments are inline below.
> 
> On Thu, Feb 10, 2022 at 5:49 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > Where did the "or later" come from?  I don't see that in the original
> > text.
> 
> Yea, this part seems a little bit ambiguous:
> 
> > > - * ALTERNATIVELY, this product may be distributed under the terms of
> > > - * the GNU General Public License, in which case the provisions of the GPL are
> > > - * required INSTEAD OF the above restrictions.  (This clause is
> > > - * necessary due to a potential bad interaction between the GPL and
> > > - * the restrictions contained in a BSD-style copyright.)
> >
> > I do not see a "or later" here.
> 
> I don't see a "2.0" either. I think we can infer from context that it
> couldn't have been < 2.0. So in the absence of a number, maybe this
> means >= 2.0, and hence "or later"? Or since at the time it probably
> meant 2.0, do we infer this to mean == 2.0? I really have no idea,
> which is why I'm glad this list exists.
> 
> It sounds like your perspective is that this is == 2.0?

Without a "or later" it has to be "2.0" as that is what the overall
kernel license is.  That's what we did for the big SPDX sweep, so that
keeps things being decided in the same manner.

thanks,

greg k-h
