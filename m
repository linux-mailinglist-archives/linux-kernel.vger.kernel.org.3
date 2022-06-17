Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE8E54F862
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 15:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381974AbiFQNh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 09:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380506AbiFQNhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 09:37:52 -0400
Received: from mail.enpas.org (zhong.enpas.org [IPv6:2a03:4000:2:537::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AA62A17E22;
        Fri, 17 Jun 2022 06:37:51 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.enpas.org (Postfix) with ESMTPSA id 9867AFFCE5;
        Fri, 17 Jun 2022 13:37:49 +0000 (UTC)
Date:   Fri, 17 Jun 2022 15:37:45 +0200
From:   Max Staudt <max@enpas.org>
To:     Vincent Mailhol <vincent.mailhol@gmail.com>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8] can, tty: can327 CAN/ldisc driver for ELM327 based
 OBD-II adapters
Message-ID: <20220617153745.4a3a7a03.max@enpas.org>
In-Reply-To: <CAMZ6RqLXouCXyt=OGm3GCXdnMJjnycz0BSwM6mcyXtAky_XOdQ@mail.gmail.com>
References: <20220612152601.142314-1-max@enpas.org>
        <CAMZ6RqLXouCXyt=OGm3GCXdnMJjnycz0BSwM6mcyXtAky_XOdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jun 2022 19:00:10 +0900
Vincent Mailhol <vincent.mailhol@gmail.com> wrote:

> Hi Max,
> 
> Because you will have to send a v9 for the split as requested by Marc,
> let me through a last couple of nitpicks.

Perfect, thanks for your help!


> Some of the function or struct names are still prefixed with elm327,
> some other with can327. Could you harmonize everything and use the
> same prefix throughout the file?

This was from back in the elmcan days, where I named the device
specific things according to the device, and the Linux glue according
to the driver. I agree, elm327/can327 is too similar and confusing now.

Done, thanks!


> > +/* Dummy needed to use bitrate_const */
> > +static int can327_do_set_bittiming(struct net_device *netdev)
> > +{
> > +       return 0;
> > +}  
> 
> Seems you forgot to remove that guy :)
> c.f.
> https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/commit/?id=7e193a42c37cf40eba8ac5af2d5e8eeb8b9506f9

Oops m(
I've removed it now, thanks.


Max
