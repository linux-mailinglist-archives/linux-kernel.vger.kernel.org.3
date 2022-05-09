Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29F951FFC6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 16:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236992AbiEIOan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 10:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237071AbiEIOaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 10:30:39 -0400
Received: from sonata.ens-lyon.org (domu-toccata.ens-lyon.fr [140.77.166.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E9E198758
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 07:26:44 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by sonata.ens-lyon.org (Postfix) with ESMTP id 7FAF9201A9;
        Mon,  9 May 2022 16:26:42 +0200 (CEST)
Received: from sonata.ens-lyon.org ([127.0.0.1])
        by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ogE-C3U51zax; Mon,  9 May 2022 16:26:42 +0200 (CEST)
Received: from begin (nat-inria-interne-52-gw-01-bso.bordeaux.inria.fr [194.199.1.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by sonata.ens-lyon.org (Postfix) with ESMTPSA id 7FAF8201A5;
        Mon,  9 May 2022 16:26:42 +0200 (CEST)
Received: from samy by begin with local (Exim 4.95)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1no4LS-002SUz-MI;
        Mon, 09 May 2022 16:26:42 +0200
Date:   Mon, 9 May 2022 16:26:42 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, speakup@linux-speakup.org
Subject: Re: [PATCHv2] speakup: Generate speakupmap.h automatically
Message-ID: <20220509142642.gsi5cppgadc2gojy@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        speakup@linux-speakup.org
References: <20220430003934.fkua7vwoz6heigrp@begin>
 <20220430073321.6b4lvrrt7buzh7dp@begin>
 <YnkfeyobcOOgDGkH@kroah.com>
 <20220509140705.n3eei4r5ko6bbex4@begin>
 <Ynki154mxF+2L8WH@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ynki154mxF+2L8WH@kroah.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH, le lun. 09 mai 2022 16:19:03 +0200, a ecrit:
> On Mon, May 09, 2022 at 04:07:05PM +0200, Samuel Thibault wrote:
> > Greg KH, le lun. 09 mai 2022 16:04:43 +0200, a ecrit:
> > > Any reason you can't add the code in utils.c into genmap.c and then
> > > merge into makemapdata.c to make this a single .c file that does both
> > > things?
> > 
> > Yes: genmap is a tool that end-users can use without needing the Linux
> > source code, while makemapdata needs it.
> 
> But who will run genmap?

I guess you meant makemapdata?

Long-term-wise this patchset will need a bit of work to properly install
the genmap tool so the user can call it.  I'm here mostly making sure
to put into the Linux kernel how speakupmap.h is generated (rather
than the currently very magic file), while at the same time keeping
the separation between makemapdata and genmap that will make sense
longterm-wise.

Samuel
