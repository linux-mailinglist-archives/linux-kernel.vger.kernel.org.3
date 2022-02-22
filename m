Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478464BFFDD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 18:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbiBVRNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 12:13:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbiBVRNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 12:13:45 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44790107DB4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 09:13:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id AE54FCE13B8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 17:13:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97EC1C340E8;
        Tue, 22 Feb 2022 17:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645549996;
        bh=pn5pZ26KI5h4wNVAeelY2f2HuitaafHua9H3GNAI2FM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=djXCSpg8jGro30zRrdBFVDqPnG5NW1tQoMBpeMq7PMvNTPoAozlV1+jM1Scal8ZXM
         U95dukHpxY5+t0rt1EqA464x59yZCjUt+GIJDwxBBlnRlXLJMAkcUFIzh93nrYJIjP
         uxXsRUnbtQehyAMnHTHobpbr2Bf1bzH0AraYW9mM=
Date:   Tue, 22 Feb 2022 18:13:13 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Desmond Yan (APD)" <desmond.yan@broadcom.com>
Cc:     Scott Branden <scott.branden@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] misc: bcm-vk: add kconfig for supporting viper
 chip
Message-ID: <YhUZqYrvNy05h86j@kroah.com>
References: <20220218200811.17136-1-desmond.yan@broadcom.com>
 <YhCdNyRxGYmhx21f@kroah.com>
 <CAEuuh2_b-xGAux_EmBaNCGcBM7C0-Z8d_q1BBZ+LA0zpkZEunQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEuuh2_b-xGAux_EmBaNCGcBM7C0-Z8d_q1BBZ+LA0zpkZEunQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?


http://daringfireball.net/2007/07/on_top

On Tue, Feb 22, 2022 at 07:41:04AM -0800, Desmond Yan (APD) wrote:
> Greg,
> 
> This is to allow the customer to use their own driver, by default,
> which is their preferred option.

We do not care about out-of-tree code, and do not add Kconfig options
just for that, sorry.

Why not just add the out-of-tree driver here to the in-kernel code?
What is preventing that from happening today?

thanks,

greg k-h
