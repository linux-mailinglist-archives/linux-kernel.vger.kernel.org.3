Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADA6649E953
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240421AbiA0RyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:54:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236845AbiA0RyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:54:03 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A1AC06173B;
        Thu, 27 Jan 2022 09:54:02 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id u18so4699008edt.6;
        Thu, 27 Jan 2022 09:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=laYFRcQ6Vet2MN5kc/u+o9hxoOpEdPIalVN/8MOBW7s=;
        b=qIgueeT1i5FOB7ZsdaOualU8UcSQH8s3re2rxJNy4vVKtwBUhVZJb7anExsnJBsmq9
         75Mv3Cb79xnRdC9djgzw7yNxwxjAJt7ETJaYMF0GyR1l3W/0nHbkwEAbNOOUE+GlBndi
         rdt/5wvr27Q6UVdvT5XJ+ipgCq4949+IT6q5J54q5MF6dmLb1umLcb9SDjl31wNeTEOp
         8Hn4wfpBBdnBIirN1+K6MbVNlKyoNc/WHI6Oo3PKW3KhkG8LpZcHTOopBVfqHt/k9uWa
         2pf4MqN1Pg3et2SpnTpSX3yMZcAQx/XI2Df9qou4oZEOaqi3VMm3LEaRHP3fkjv1QB/l
         F4FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=laYFRcQ6Vet2MN5kc/u+o9hxoOpEdPIalVN/8MOBW7s=;
        b=IG48D/5X3pA457c0hMHrxMF5lY38kokBIwNHKXQE+EYsRNC9oDNSi1lJJ3uP8602Mq
         bt5M0gyOtE4MLMVhWd1EWqE4iFGIGPtr6g6X/oXKNMrSArJsci4T0pNa8YwvEGwhka41
         xR69hUWFbrAOo+fDJWNDHOOHAmKNPdQ6cJUWXR5Jm36P0T7D3pGvcnOkNrbpwrBluBLY
         Lz0juYS/lEFAMdaDCXsUbC6wrrTSxMInSwMn5QEWHmmA+Gx0sc2jdtwPOXH5CN1mO4aG
         +FZ/yRUfb5G6Oi1KRJTpCZIrEOaiplE9OsojDg0jxtt5djQ22EwCl+yVNpNTZSdVbKA7
         xinQ==
X-Gm-Message-State: AOAM530qkoDYvolr6ZusrMgvy6tmH9Y/iGBWNFYioJdaL7d9i9Po2k7v
        o6ULoMOkcKrbaPcxtIxu+O8=
X-Google-Smtp-Source: ABdhPJyP1DtdlfY7X90QtKg6ZCysmpQT1s+XSsFa7yxBKEvba828ZyBzXxPMeyhEBe5xXMQ9ufunaQ==
X-Received: by 2002:aa7:cb17:: with SMTP id s23mr4622696edt.282.1643306041409;
        Thu, 27 Jan 2022 09:54:01 -0800 (PST)
Received: from tom-desktop (net-188-217-49-141.cust.vodafonedsl.it. [188.217.49.141])
        by smtp.gmail.com with ESMTPSA id d17sm11817230ede.88.2022.01.27.09.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 09:54:00 -0800 (PST)
Date:   Thu, 27 Jan 2022 18:53:58 +0100
From:   Tommaso Merciai <tomm.merciai@gmail.com>
To:     Richard Leitner <richard.leitner@linux.dev>
Cc:     Richard Leitner - SKIDATA <Richard.Leitner@skidata.com>,
        "linuxfancy@googlegroups.com" <linuxfancy@googlegroups.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: usb251xb: add boost-up property support
Message-ID: <20220127175358.GA3171@tom-desktop>
References: <20220121232612.7283-1-tomm.merciai@gmail.com>
 <Ye5PUpp9eMX9jSRe@ltleri2>
 <20220125214245.GA4196@tom-ThinkPad-T470p>
 <YfDzgPwhkIpFv+yR@ltleri2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfDzgPwhkIpFv+yR@ltleri2>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 08:08:48AM +0100, Richard Leitner wrote:
> On Tue, Jan 25, 2022 at 10:42:45PM +0100, Tommaso Merciai wrote:
> > On Mon, Jan 24, 2022 at 07:03:57AM +0000, Richard Leitner - SKIDATA wrote:
> > > On Sat, Jan 22, 2022 at 12:26:12AM +0100, Tommaso Merciai wrote:
> > > >  
> > > > +	if (!of_property_read_u8(np, "boost-up", &property_u8)){
> > > > +		hub->boost_up = property_u8;
> > > 
> > > IMHO we don't need the property_u8 var here as you could pass
> > > &hub->boost_up directly to of_property_read_u8() ?
> > 
> > Hi Richard,
> > Thanks for your reply. You mean like:
> > 
> > if (!of_property_read_u8(np, "boost-up", &hub->boost_up))
> 
> exactly.

Thanks Richard,
I'll send v2.

Thanks,
Tommaso

> 
> > 
> > Let me know. I'll fix that in v2.
> > 
> 
> great!
> 
> thanks & regards;rl
