Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425F34D0A6C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 23:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237731AbiCGWBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 17:01:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234197AbiCGWBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 17:01:19 -0500
X-Greylist: delayed 1008 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Mar 2022 14:00:24 PST
Received: from mail.enpas.org (zhong.enpas.org [IPv6:2a03:4000:2:537::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A1A557561A;
        Mon,  7 Mar 2022 14:00:23 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.enpas.org (Postfix) with ESMTPSA id 1E2E51000CB;
        Mon,  7 Mar 2022 22:00:23 +0000 (UTC)
Date:   Mon, 7 Mar 2022 23:00:17 +0100
From:   Max Staudt <max@enpas.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can@vger.kernel.org, Oliver Neukum <oneukum@suse.com>,
        linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCH v3] can, tty: elmcan CAN/ldisc driver for ELM327 based
 OBD-II adapters
Message-ID: <20220307230017.4332d602.max@enpas.org>
In-Reply-To: <YiZ/5WaNHhaONjX1@kroah.com>
References: <20220307214303.1822590-1-max@enpas.org>
        <YiZ/5WaNHhaONjX1@kroah.com>
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

On Mon, 7 Mar 2022 22:57:57 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Mon, Mar 07, 2022 at 10:43:03PM +0100, Max Staudt wrote:
> > +    sudo ldattach \
> > +           --debug \
> > +           --speed 38400 \
> > +           --eightbits \
> > +           --noparity \
> > +           --onestopbit \
> > +           --iflag -ICRNL,INLCR,-IXOFF \
> > +           29 \
> > +           /dev/ttyUSB0  
> 
> I think you mean "30" here, not "29", right?

Right.  m-(

Thanks for catching this. I'll wait for more updates before sending v4.


Max
