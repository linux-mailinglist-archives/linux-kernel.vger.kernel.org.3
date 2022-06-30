Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0916E560FC7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 05:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbiF3DwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 23:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiF3DwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 23:52:01 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF8B30F48;
        Wed, 29 Jun 2022 20:51:59 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id m14-20020a17090a668e00b001ee6ece8368so1530125pjj.3;
        Wed, 29 Jun 2022 20:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ww35KvPbbjc84EcIzgLWF7R368pVQCk81zL7hh0gsy8=;
        b=SjHanqCBoSVhVl0q6cRp0IvcGb7UBIZFKMUhOZ6rAE+rvHl36/sUTfmAof89gFuOAc
         uQ9fc7zajEa8Iy+u4/xWZKWnTCNFSBD4p/N/TOw3h3mEuLMEqWgPIhIlzMEvBtUxNPLW
         R3vE5JByabprap5TPJvzKHwxdDz8pRfs4VvcF0Voaf+XGf9MW1lz8wD+P4bqjdfTkSZd
         Eg+umyIpg0ACpZL8O9M05+YVftmOq4qXsrfb0Xp49rqYYctp9toZTHCuoqS1HH+OSH2L
         oAK2y6EWlVv/42kyau0YMg+X0YO2dJ0zVcfUwLswn2a1yvGfI4TRw083EWbeZzSmD2UD
         e7Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ww35KvPbbjc84EcIzgLWF7R368pVQCk81zL7hh0gsy8=;
        b=CiNwI6AF+CKIL/0veb0Tpsh9mgNUqKdPtHY96pUwIVRjIG5MyBngafPEz3SDiTYtTF
         ViHxY+RPwX4BSnwl2pfN2rPiVWQ4fUokeffub+u0FrETQsxj0oQzD6UaFPaeTPxkxCZr
         aSaOZmiFMl4RQzfPZtA1Ce7wUjxFwy12q6mS63lv68tC1CIQ6Z/YPh7gVx9LG9QshHom
         iXB1Pu66zDSucGrxt11qOEPcdhaEuE1RuKfBp9Hdkpei/biKoPEUJNkBHPXZXGT6jwPe
         8KA1wmkCTkYKGamF0bNMvjLAIuj2o8noCSOKeNalz/1Yfud80tBbtSAYAcfY+sM+vPr0
         VssA==
X-Gm-Message-State: AJIora8JhINiHHhoWwqzj4CbnlV1BigZ3dnQ6/7PZwQbmZloWdNMuNK/
        QxM1Syug1NEz+9xrcW4FnSA=
X-Google-Smtp-Source: AGRyM1tgM4RIWDQecAOhX5NWccj1dwC63jWSYuJ5zzwt9yFEtgmtMgzO94TPYC128B1OkCPeQZ6rZA==
X-Received: by 2002:a17:902:ce8b:b0:16a:4a3e:4fa1 with SMTP id f11-20020a170902ce8b00b0016a4a3e4fa1mr12408705plg.167.1656561118597;
        Wed, 29 Jun 2022 20:51:58 -0700 (PDT)
Received: from sebin-inspiron ([103.160.233.84])
        by smtp.gmail.com with ESMTPSA id m9-20020a17090a158900b001ef3daa0f21sm87498pja.16.2022.06.29.20.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 20:51:57 -0700 (PDT)
Date:   Thu, 30 Jun 2022 09:21:50 +0530
From:   Sebin Sebastian <mailmesebin00@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Neal Liu <neal_liu@aspeedtech.com>,
        Felipe Balbi <balbi@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-aspeed@lists.ozlabs.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] usb: gadget: dereference before null check
Message-ID: <Yr0d1tULzx4Mn1pp@sebin-inspiron>
References: <20220629080726.107297-1-mailmesebin00@gmail.com>
 <YrwMJ+3mdFO2Lpm0@kroah.com>
 <YrxCP4EE2jhUm8e+@sebin-inspiron>
 <Yrxwbb/TbFmYdga/@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yrxwbb/TbFmYdga/@kroah.com>
X-Spam-Status: No, score=2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 05:31:57PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Jun 29, 2022 at 05:44:55PM +0530, Sebin Sebastian wrote:
> > On Wed, Jun 29, 2022 at 10:24:07AM +0200, Greg Kroah-Hartman wrote:
> > > On Wed, Jun 29, 2022 at 01:37:25PM +0530, SebinSebastian wrote:
> > > > Fix coverity warning dereferencing before null check. _ep and desc is
> > > > dereferenced on all paths until the check for null. Move the
> > > > initializations after the check for null.
> > > > Coverity issue: 1518209
> > > > 
> > > > Signed-off-by: SebinSebastian <mailmesebin00@gmail.com>
> > > > ---
> > > >  drivers/usb/gadget/udc/aspeed_udc.c | 9 +++++----
> > > >  1 file changed, 5 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/drivers/usb/gadget/udc/aspeed_udc.c b/drivers/usb/gadget/udc/aspeed_udc.c
> > > > index d75a4e070bf7..96f8193fca15 100644
> > > > --- a/drivers/usb/gadget/udc/aspeed_udc.c
> > > > +++ b/drivers/usb/gadget/udc/aspeed_udc.c
> > > > @@ -341,10 +341,6 @@ static void ast_udc_stop_activity(struct ast_udc_dev *udc)
> > > >  static int ast_udc_ep_enable(struct usb_ep *_ep,
> > > >  			     const struct usb_endpoint_descriptor *desc)
> > > >  {
> > > > -	u16 maxpacket = usb_endpoint_maxp(desc);
> > > > -	struct ast_udc_ep *ep = to_ast_ep(_ep);
> > > > -	struct ast_udc_dev *udc = ep->udc;
> > > > -	u8 epnum = usb_endpoint_num(desc);
> > > >  	unsigned long flags;
> > > >  	u32 ep_conf = 0;
> > > >  	u8 dir_in;
> > > > @@ -356,6 +352,11 @@ static int ast_udc_ep_enable(struct usb_ep *_ep,
> > > >  		return -EINVAL;
> > > >  	}
> > > > 
> > > > +	u16 maxpacket = usb_endpoint_maxp(desc);
> > > > +	struct ast_udc_ep *ep = to_ast_ep(_ep);
> > > > +	struct ast_udc_dev *udc = ep->udc;
> > > > +	u8 epnum = usb_endpoint_num(desc);
> > > > +
> > > >  	if (!udc->driver) {
> > > >  		EP_DBG(ep, "bogus device state\n");
> > > >  		return -ESHUTDOWN;
> > > > --
> > > > 2.34.1
> > > > 
> > > 
> > > Hi,
> > > 
> > > This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> > > a patch that has triggered this response.  He used to manually respond
> > > to these common problems, but in order to save his sanity (he kept
> > > writing the same thing over and over, yet to different people), I was
> > > created.  Hopefully you will not take offence and will fix the problem
> > > in your patch and resubmit it so that it can be accepted into the Linux
> > > kernel tree.
> > > 
> > > You are receiving this message because of the following common error(s)
> > > as indicated below:
> > > 
> > > - Your patch breaks the build.
> > > 
> > > - Your patch contains warnings and/or errors noticed by the
> > >   scripts/checkpatch.pl tool.
> > > 
> > > - This looks like a new version of a previously submitted patch, but you
> > >   did not list below the --- line any changes from the previous version.
> > >   Please read the section entitled "The canonical patch format" in the
> > >   kernel file, Documentation/SubmittingPatches for what needs to be done
> > >   here to properly describe this.
> > > 
> > > If you wish to discuss this problem further, or you have questions about
> > > how to resolve this issue, please feel free to respond to this email and
> > > Greg will reply once he has dug out from the pending patches received
> > > from other developers.
> > > 
> > > thanks,
> > > 
> > > greg k-h's patch email bot
> > 
> > I am sorry to keep on bothering with this incorrect patches. I am
> > running the checkpatch script everytime before I sent any patches. It is
> > not showing any warnings or errors. Is it because of my name that my
> > patches are getting rejected? I can see a space missing.
> 
> Did you test build your patch?  If not, why not?
> 
> thanks,
> 
> greg k-h

Ok, now I understand the source of all errors. I did build the entire
tree, but make never touched udc. I have fixed all errors and warnings,
build the patch properly, ran through checkpatch and is now ready for
submission.
