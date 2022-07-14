Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10541575114
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 16:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239511AbiGNOtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 10:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbiGNOtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 10:49:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4264D4F670;
        Thu, 14 Jul 2022 07:49:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D49F961D1E;
        Thu, 14 Jul 2022 14:49:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB8D4C34115;
        Thu, 14 Jul 2022 14:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657810156;
        bh=MvYGgKUfMiBeLWl7rTPRRjLAeDMlTd5tlvmNnG7OT/w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KKcXLtwNhdTkwUoUKVpnKyc7D5a84j/nCoLSYiGrU0LW6EuYIQac0RYAooKakTyfz
         etef7jGf+gjxdpwsRQ8GjUyB2ekcBpcg/hte17tUpioRSh85WLj6B6/dZUNXiNBzhN
         xOU9LHUpfjlgCh6EvEyFAKLBHDHVchsPnudRObmE=
Date:   Thu, 14 Jul 2022 16:49:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org,
        olivia@selenic.com, paul.gortmaker@windriver.com,
        dwmw2@infradead.org, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Change mentions of mpm to olivia
Message-ID: <YtAs6S/WwVV7zQAr@kroah.com>
References: <20220712185419.45487-1-f.fainelli@gmail.com>
 <20220712200010.kbx24o2nxobrhmey@pengutronix.de>
 <036b6113-d6a1-ca82-5033-98bc9caa7255@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <036b6113-d6a1-ca82-5033-98bc9caa7255@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 03:15:41PM -0700, Florian Fainelli wrote:
> On 7/12/22 13:00, Uwe Kleine-König wrote:
> > On Tue, Jul 12, 2022 at 11:54:19AM -0700, Florian Fainelli wrote:
> > > Following this mercurial changeset:
> > > https://www.mercurial-scm.org/repo/hg-stable/rev/d4ba4d51f85f
> > > 
> > > update the MAINTAINERS entry to replace the now obsolete identity.
> > > 
> > > Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> > > ---
> > > This was first submitted by Uwe:
> > > 
> > > https://lore.kernel.org/lkml/20210920080635.253826-1-u.kleine-koenig@pengutronix.de/
> > 
> > My variant was to drop Matt/Olivia. Given that we didn't get any
> > feedback from them, that's still what I would favour.
> > 
> > Without any feedback (and committment?) from Olivia, I tend to nack this
> > patch.
> 
> I do not care either way, by explicitly CC'ing Olivia we give a fighting
> chance of seeing one's identify continue to be listed under MAINTAINERS. Now
> without any recent commits in the past 12 years, one could argue that
> removal is long due.
> 
> Either way is fine as long as we stop getting SMTP server bounces which is
> just extremely annoying...

I'll take it for now until the EMBEDDED maintainership is worked out by
others.

thanks,

greg k-h
