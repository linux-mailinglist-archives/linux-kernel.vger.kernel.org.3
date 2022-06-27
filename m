Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583D255C167
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239754AbiF0RCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 13:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235496AbiF0RCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 13:02:13 -0400
Received: from mail.enpas.org (zhong.enpas.org [46.38.239.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 82F6F12090;
        Mon, 27 Jun 2022 10:02:11 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.enpas.org (Postfix) with ESMTPSA id 814CFFF9BF;
        Mon, 27 Jun 2022 17:02:09 +0000 (UTC)
Date:   Mon, 27 Jun 2022 19:01:26 +0200
From:   Max Staudt <max@enpas.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org,
        Vincent Mailhol <vincent.mailhol@gmail.com>,
        Oliver Neukum <oneukum@suse.com>, linux-kernel@vger.kernel.org,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v9] can, tty: can327 CAN/ldisc driver for ELM327 based
 OBD-II adapters
Message-ID: <20220627190126.4eb57a2b.max@enpas.org>
In-Reply-To: <20220627150557.qluqtejrddj5nfif@pengutronix.de>
References: <20220618195031.10975-1-max@enpas.org>
        <20220627150557.qluqtejrddj5nfif@pengutronix.de>
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

On Mon, 27 Jun 2022 17:05:57 +0200
Marc Kleine-Budde <mkl@pengutronix.de> wrote:

> On 18.06.2022 21:50:31, Max Staudt wrote:
> > This is the can327 driver. It does a surprisingly good job at
> > turning ELM327 based OBD-II interfaces into cheap CAN interfaces
> > for simple homebrew projects.
> > 
> > Please see the included documentation for details and limitations:
> > Documentation/networking/device_drivers/can/can327.rst
> > 
> > Cc: linux-can <linux-can@vger.kernel.org>
> > Signed-off-by: Max Staudt <max@enpas.org>
> > Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>  
> 
> Added with some minor coding style improvements (line breaks and
> whitespace changes) to make checkpatch and clang-format happier to
> can-next/master!

Wonderful, thank you!

(+CC: Greg, Oliver Hartkopp)


This quite fittingly marks the end of an era for me, so I would like to
thank everyone involved, more or less in order of appearance:

Oliver Hartkopp    for slcan (the inspiration) and related feedback.
Oliver Neukum      for the first reviews, before this went public.
Marc Kleine-Budde  for upstream guidance.
Greg Kroah-Hartman for TTY and style support.
Vincent Mailhol    for intensive reviews up until the end.

...and of course thanks to the numerous people I've been in touch with
via GitHub and otherwise. Bug reports, testing, or simply thanks and
encouragement - they have all helped.


Some stats for those interested: It has been a solid 8 years since the
idea for this driver was born in 2014, with occasional on and off work
on it since. The oldest code is from 2015, running in userspace and
injecting packets via vcan. It became a kernel module in 2016, with
link settings via "ip link". The first public version was released in
2018. It then gained in popularity, making upstreaming... inevitable ;)


Thank you all!


Max
