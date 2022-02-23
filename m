Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03474C1AEE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 19:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243814AbiBWS2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 13:28:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236852AbiBWS2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 13:28:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194B0403FD
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 10:27:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BCADFB8214D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 18:27:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BC90C340E7;
        Wed, 23 Feb 2022 18:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645640850;
        bh=7OgHyiPZRyJQPgoQ07b1ufg2ZdQI0FSsYZNyRANpbv8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pwFKeaoudRzmOwQzln5PhTGaoQDw6SzYlUxnWs+72Ng7kFBZ5IhfgJlAMpMpGzdep
         ymJyHwBtTTCWwQG0Dlo0fdrsjeDrRulTFaMPaxevKgt/EaWj7b1Fub/sbhbMG4rWGe
         ju+T0IprA3SueL8Ow57oquDPdg097RaQ33YCT51g=
Date:   Wed, 23 Feb 2022 19:27:27 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Desmond yan <desmond.yan@broadcom.com>,
        Olof Johansson <olofj@fb.com>, Arnd Bergmann <arnd@arndb.de>,
        bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] misc: bcm-vk: add kconfig for supporting viper
 chip
Message-ID: <YhZ8j6lAj8iHzLCq@kroah.com>
References: <20220218200811.17136-1-desmond.yan@broadcom.com>
 <YhCdNyRxGYmhx21f@kroah.com>
 <CAEuuh2_b-xGAux_EmBaNCGcBM7C0-Z8d_q1BBZ+LA0zpkZEunQ@mail.gmail.com>
 <YhUZqYrvNy05h86j@kroah.com>
 <534605ef-aeb1-b0a2-2326-be6faba4709c@broadcom.com>
 <YhXht9ieY8vDuBTS@kroah.com>
 <3b2ff726-7ed8-9810-8d06-078f4f1fa4d8@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b2ff726-7ed8-9810-8d06-078f4f1fa4d8@broadcom.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 09:59:48AM -0800, Scott Branden wrote:
> Hi Greg,
> 
> On 2022-02-22 23:26, Greg Kroah-Hartman wrote:
> > On Tue, Feb 22, 2022 at 09:14:02PM -0800, Desmond yan wrote:
> > > 
> > > Greg,
> > > 
> > > Please see inlined.
> > > 
> > > On 2/22/22 09:13, Greg Kroah-Hartman wrote:
> > > > A: http://en.wikipedia.org/wiki/Top_post
> > > > Q: Were do I find info about this thing called top-posting?
> > > > A: Because it messes up the order in which people normally read text.
> > > > Q: Why is top-posting such a bad thing?
> > > > A: Top-posting.
> > > > Q: What is the most annoying thing in e-mail?
> > > > 
> > > > A: No.
> > > > Q: Should I include quotations after my reply?
> > > > 
> > > > 
> > > > http://daringfireball.net/2007/07/on_top
> > > > 
> > > > On Tue, Feb 22, 2022 at 07:41:04AM -0800, Desmond Yan (APD) wrote:
> > > > > Greg,
> > > > > 
> > > > > This is to allow the customer to use their own driver, by default,
> > > > > which is their preferred option.
> > > > 
> > > > We do not care about out-of-tree code, and do not add Kconfig options
> > > > just for that, sorry.
> > > > 
> > > > Why not just add the out-of-tree driver here to the in-kernel code?
> > > > What is preventing that from happening today?
> > > 
> > > Using the bcm_vk driver for viper is only for proof-of-concept, and is not
> > > aimed to be deployed for production.  In parallel, customer is developing
> > > their own production-ready driver and would probably upstream it whenever
> > > the appropriate time comes.
> > 
> > Ok, so let us not add a new config option only for one person working on
> > writing their own driver.  Let's just add the device id as there are
> > more people than just that one person wanting to use their hardware with
> > the existing drivers.
> The bcm_vk driver is the official driver for Valkyrie.  For Viper, the
> bcm_vk driver is only for proof of concept, testing, and demonstration
> purposes. For production, the new driver in development will be used.
> 
> To support such configuration, we need to have the Viper pci id configurable
> and off by default in the bcm_vk driver to allow the new production driver
> to be developed against the upstream kernel and drivers.
> > 
> > Please resubmit this without the Kconfig change and I will be glad to
> > take it.
> I don't understand what there would be to submit?  The Viper pci id is
> already upstreamed into the bcm_vk driver.  The sole purpose of this patch
> is to add the Kconfig option and have it off by default.

Ah, I missed that it was disabling the id.  That's even worse.  No,
sorry, not going to take this upstream.  Again, we do not add changes to
the kernel (and especially not Kconfig options) for out-of-tree code.

You know this...

thanks,

greg k-h
