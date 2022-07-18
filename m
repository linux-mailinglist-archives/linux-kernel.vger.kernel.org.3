Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAE4577942
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 03:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbiGRBZi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 17 Jul 2022 21:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbiGRBZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 21:25:37 -0400
Received: from relay5.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB5412D1E
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 18:25:34 -0700 (PDT)
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay06.hostedemail.com (Postfix) with ESMTP id 6145734AF2;
        Mon, 18 Jul 2022 01:25:33 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf17.hostedemail.com (Postfix) with ESMTPA id 4F9451B;
        Mon, 18 Jul 2022 01:25:32 +0000 (UTC)
Message-ID: <75022a03a4d0c8b238dcf1c7b60b5d222b184f34.camel@perches.com>
Subject: Re: [PATCH] iio: Use parens with sizeof
From:   Joe Perches <joe@perches.com>
To:     Joe Simmons-Talbott <joetalbott@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 17 Jul 2022 18:25:31 -0700
In-Reply-To: <YtRsO7cLyDIH47od@spruce>
References: <20220717153438.10800-1-joetalbott@gmail.com>
         <59c0003bfc5b429a8e39151da942fcaf707109a0.camel@perches.com>
         <YtRsO7cLyDIH47od@spruce>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Stat-Signature: 1gw8a1ssdy3q8eymts5jdr64ozfj9jxw
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 4F9451B
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/KRbjCFivTyg9MUXbeneQDW+99K+w5z4A=
X-HE-Tag: 1658107532-148806
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-07-17 at 16:08 -0400, Joe Simmons-Talbott wrote:
> On Sun, Jul 17, 2022 at 10:08:37AM -0700, Joe Perches wrote:
> > On Sun, 2022-07-17 at 11:34 -0400, Joe Simmons-Talbott wrote:
> > > Prefer 'sizeof(var)' over 'sizeof var' as reported by checkpatch.pl.
> > 
> > unrelated trivia:
> > 
> > > diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> > []
> > > @@ -368,7 +368,7 @@ struct iio_poll_func
> > >  	va_list vargs;
> > >  	struct iio_poll_func *pf;
> > >  
> > > -	pf = kmalloc(sizeof *pf, GFP_KERNEL);
> > > +	pf = kmalloc(sizeof(*pf), GFP_KERNEL);
> > >  	if (pf == NULL)
> > >  		return NULL;
> > >  	va_start(vargs, fmt);
> > > @@ -560,7 +560,7 @@ struct iio_trigger *viio_trigger_alloc(struct device *parent,
> > >  	struct iio_trigger *trig;
> > >  	int i;
> > >  
> > > -	trig = kzalloc(sizeof *trig, GFP_KERNEL);
> > > +	trig = kzalloc(sizeof(*trig), GFP_KERNEL);
> > >  	if (!trig)
> > >  		return NULL;
> > 
> > It'd be nice to be consistent with the allocation return test.
> > 
> > Please pick one of:
> > 
> > 	if (ptr == NULL)
> > or
> > 	if (!ptr)		// my preference
> > 
> 
> I'm happy to submit a patch for that.  Do you want me to include a
> Suggested-by: tag?

Not really.

