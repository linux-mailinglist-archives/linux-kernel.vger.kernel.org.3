Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A912C4DCF3E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 21:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiCQUZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 16:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiCQUZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 16:25:19 -0400
Received: from mail.enpas.org (zhong.enpas.org [46.38.239.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ABD4F144B7A;
        Thu, 17 Mar 2022 13:24:02 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.enpas.org (Postfix) with ESMTPSA id B9C01FF86A;
        Thu, 17 Mar 2022 20:24:01 +0000 (UTC)
Date:   Thu, 17 Mar 2022 21:23:59 +0100
From:   Max Staudt <max@enpas.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Vincent Mailhol <vincent.mailhol@gmail.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org, Oliver Neukum <oneukum@suse.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCH v3] can, tty: elmcan CAN/ldisc driver for ELM327 based
 OBD-II adapters
Message-ID: <20220317212359.71252c57.max@enpas.org>
In-Reply-To: <20220314220408.hn4vdohtjdbfoaqo@pengutronix.de>
References: <20220307214303.1822590-1-max@enpas.org>
        <CAMZ6RqJZObevKPc29jW+m6i0eAgestTbw8KCPXxSGHzSXK7cRg@mail.gmail.com>
        <20220309135414.34f77251.max@enpas.org>
        <CAMZ6RqJJ-PO=WeFeuXk4iC9GHLXz_ZMWtsVCm6sGVGbmeE5U1Q@mail.gmail.com>
        <20220314220408.hn4vdohtjdbfoaqo@pengutronix.de>
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

On Mon, 14 Mar 2022 23:04:08 +0100
Marc Kleine-Budde <mkl@pengutronix.de> wrote:

> On 09.03.2022 22:49:49, Vincent Mailhol wrote:
> > Either we agree that using can_rx_offload without implementing
> > the mailbox_read() is OK and in that case, the can_rx_offload
> > framework should be modified to allow mailbox_read() to be a NULL
> > pointer.
> > 
> > Either it is not the case and you use the more classic
> > netif_rx().
> > 
> > And I do not have the answer. I haven't studied can_rx_offload
> > enough to be a judge here. Sorry.
> > 
> > @Marc, any thoughts?  
> 
> Use can_rx_offload_add_manual() instead.

m-(

Yes, it's right underneath _add_fifo() and does the right thing. No
idea how I missed it, I thought I had looked through all variants.

Thanks!


> > Also give a look at can_dropped_invalid_skb().  
> 
> ACK

Done.


> Marc

Max
