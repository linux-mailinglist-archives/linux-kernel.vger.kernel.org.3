Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B5F5608BA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 20:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbiF2SJG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Jun 2022 14:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiF2SJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 14:09:05 -0400
Received: from relay5.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A1211A28
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 11:09:03 -0700 (PDT)
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay01.hostedemail.com (Postfix) with ESMTP id 826E060C93;
        Wed, 29 Jun 2022 18:09:02 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf10.hostedemail.com (Postfix) with ESMTPA id 5999F40;
        Wed, 29 Jun 2022 18:09:01 +0000 (UTC)
Message-ID: <2f2d8b6ddb4418bbe351d6c19d08e9241de20087.camel@perches.com>
Subject: Re: [PATCH 1/7] Staging: rtl8192e: Added blank lines before/after
 struct
From:   Joe Perches <joe@perches.com>
To:     Felix Schlepper <f3sch.git@outlook.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, wjsota@gmail.com
Date:   Wed, 29 Jun 2022 11:09:00 -0700
In-Reply-To: <AM9P190MB129916C683B7D8B241EF85D0A5BB9@AM9P190MB1299.EURP190.PROD.OUTLOOK.COM>
References: <cover.1656402464.git.f3sch.git@outlook.com>
         <f23e5ad2839c238665956f0d552cacd9944b724d.1656402464.git.f3sch.git@outlook.com>
         <f110442f5cceb0161f32c2b942ef7be6f5c5a63c.camel@perches.com>
         <AM9P190MB129916C683B7D8B241EF85D0A5BB9@AM9P190MB1299.EURP190.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 5999F40
X-Stat-Signature: cxpy4bhehp97he7ibrn6fwndwm5kmkk4
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+PFQLq9iP8uUoYJGt7spzt5iZz7rrAPH0=
X-HE-Tag: 1656526141-482888
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-06-29 at 14:11 +0200, Felix Schlepper wrote:
> On 28.06.2022 10:58, Joe Perches wrote:
> > On Tue, 2022-06-28 at 10:30 +0200, Felix Schlepper wrote:
> > > This addresses an issue raised by checkpatch.pl:
> > > 
> > >      $ ./scripts/checkpatch.pl --terse -f drivers/staging/rtl8192e/rtllib_wx.c
> > >      CHECK: Please use a blank line after function/struct/union/enum
> > >      declarations
> > > 
> > > The additional blank line above the struct/before the headers is
> > > just cleaner.
> > []
> > > diff --git a/drivers/staging/rtl8192e/rtllib_wx.c b/drivers/staging/rtl8192e/rtllib_wx.c
> > []
> > > @@ -17,10 +17,12 @@
> > >  #include <linux/module.h>
> > >  #include <linux/etherdevice.h>
> > >  #include "rtllib.h"
> > > +
> > >  struct modes_unit {
> > >  	char *mode_string;
> > >  	int mode_size;
> > >  };
> > > +
> > >  static struct modes_unit rtllib_modes[] = {
> > >  	{"a", 1},
> > >  	{"b", 1},
> > 
> > Please always look deeper at the code and do not simply take
> > any checkpatch suggestion as the "best" fix.
> > 
> > Using this struct style with an embedded length is error prone
> > and would likely be better as a simple char * array.
> > 
> > Also, the existing sprintf use of mode_string and mode_size is
> > nonsensical.  There is nothing to format in any of the mode_size.
> > so the use of mode_size as an argument is silly.
> First of all, thank you for your suggestions.
> I did realize that there is nothing to format, but I did not dare to
> make that change in case a format could be added.
> However, looking at it now. This has not been touched in over 10 years.
> So it is probably safe to change that.
> > 
> > Perhaps something like this would be better:
> > ---
> >  drivers/staging/rtl8192e/rtllib_wx.c | 21 +++++----------------
> >  1 file changed, 5 insertions(+), 16 deletions(-)
> > 
> > diff --git a/drivers/staging/rtl8192e/rtllib_wx.c b/drivers/staging/rtl8192e/rtllib_wx.c
> > index cf9a240924f20..90dcce152d80c 100644
> > --- a/drivers/staging/rtl8192e/rtllib_wx.c
> > +++ b/drivers/staging/rtl8192e/rtllib_wx.c
> > @@ -17,17 +17,9 @@
> >  #include <linux/module.h>
> >  #include <linux/etherdevice.h>
> >  #include "rtllib.h"
> > -struct modes_unit {
> > -	char *mode_string;
> > -	int mode_size;
> > -};
> > -static struct modes_unit rtllib_modes[] = {
> > -	{"a", 1},
> > -	{"b", 1},
> > -	{"g", 1},
> > -	{"?", 1},
> > -	{"N-24G", 5},
> > -	{"N-5G", 4},
> > +
> > +static const char *rtllib_modes[] = {
> > +	"a", "b", "g", "?", "N-24G", "N-5G",
> >  };
> >  
> >  #define MAX_CUSTOM_LEN 64
> > @@ -72,11 +64,8 @@ static inline char *rtl819x_translate_scan(struct rtllib_device *ieee,
> >  	/* Add the protocol name */
> >  	iwe.cmd = SIOCGIWNAME;
> >  	for (i = 0; i < ARRAY_SIZE(rtllib_modes); i++) {
> > -		if (network->mode&(1<<i)) {
> > -			sprintf(pname, rtllib_modes[i].mode_string,
> > -				rtllib_modes[i].mode_size);
> > -			pname += rtllib_modes[i].mode_size;
> > -		}
> > +		if (network->mode & BIT(i))
> > +			pname = stpcpy(pname, rtllib_modes[i]);
> >  	}
> >  	*pname = '\0';
> Would this not be also redundant since stpcpy already returns a pointer to the new
> NUL-terminating character?
> >  	snprintf(iwe.u.name, IFNAMSIZ, "IEEE802.11%s", proto_name);

Only if proto_name is initialized.  Is it?

Also I believe stpcpy is not a standard linux call, so maybe
this needs to be strcpy or strncpy then strlen.

