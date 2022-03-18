Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44B24DD8CD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 12:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235704AbiCRLQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 07:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235663AbiCRLQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 07:16:35 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782C51AA072;
        Fri, 18 Mar 2022 04:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=gTrHSaows6P5rC0BqhyXnWLtvk2vll7NYVs5JyeogtQ=;
  b=AY7tGrinlq3iYyC0wIS7teWB69QYqXAZfuCQXbHqrL5FSEQe2HFFCCV7
   AbI7/YmIN3Utb3MR/Ylryb1zqwNja2ZtfwbsUHO25d2M5pnZvgZYHg2Fz
   5rzMvl4Q7Ci77KfuyRoJtsZM1ukbhVp5zVFR2yH4O0/ggF0ddErfHmivT
   0=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.90,192,1643670000"; 
   d="scan'208";a="26861438"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 12:15:14 +0100
Date:   Fri, 18 Mar 2022 12:15:14 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To:     Joe Perches <joe@perches.com>
cc:     Julia Lawall <Julia.Lawall@inria.fr>,
        Richard Henderson <rth@twiddle.net>,
        kernel-janitors@vger.kernel.org,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: fix typos in comments
In-Reply-To: <176f485c00e3c6c03ff794dc47f23702fc592a4f.camel@perches.com>
Message-ID: <alpine.DEB.2.22.394.2203181215040.2686@hadrien>
References: <20220318103729.157574-19-Julia.Lawall@inria.fr> <176f485c00e3c6c03ff794dc47f23702fc592a4f.camel@perches.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 18 Mar 2022, Joe Perches wrote:

> On Fri, 2022-03-18 at 11:37 +0100, Julia Lawall wrote:
> > Various spelling mistakes in comments.
> []
> > diff --git a/arch/alpha/kernel/sys_eiger.c b/arch/alpha/kernel/sys_eiger.c
> []
> > @@ -148,7 +148,7 @@ eiger_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
> >
> >  	/* The SRM console has already calculated out the IRQ value's for
> >  	   option cards. As this works lets just read in the value already
> > -	   set and change it to a useable value by Linux.
> > +	   set and change it to a usable value by Linux.
>
> generally accepted alternative spelling.
>
> https://www.dictionary.com/browse/useable

OK, thanks.

julia
