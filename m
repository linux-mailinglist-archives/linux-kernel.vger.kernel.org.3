Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E705474C8
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 15:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233621AbiFKNQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 09:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbiFKNQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 09:16:54 -0400
Received: from mail.enpas.org (zhong.enpas.org [IPv6:2a03:4000:2:537::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 96D1562BCE;
        Sat, 11 Jun 2022 06:16:52 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.enpas.org (Postfix) with ESMTPSA id E24B0100022;
        Sat, 11 Jun 2022 13:16:51 +0000 (UTC)
Date:   Sat, 11 Jun 2022 15:16:49 +0200
From:   Max Staudt <max@enpas.org>
To:     Vincent Mailhol <vincent.mailhol@gmail.com>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7] can, tty: can327 CAN/ldisc driver for ELM327 based
 OBD-II adapters
Message-ID: <20220611151649.5a9c5676.max@enpas.org>
In-Reply-To: <CAMZ6RqKM7Z3GzO6vKyWf7D1z=HvJBN2QaZz1==LBsEJKjz=Qag@mail.gmail.com>
References: <20220602213544.68273-1-max@enpas.org>
 <CAMZ6RqLLn3tE6kPd+yyHURsbBU_jVKN=u4=YvhZVyAf_NyRqCQ@mail.gmail.com>
 <CAMZ6RqKM7Z3GzO6vKyWf7D1z=HvJBN2QaZz1==LBsEJKjz=Qag@mail.gmail.com>
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

On Sat, 4 Jun 2022 00:47:10 +0900
Vincent Mailhol <vincent.mailhol@gmail.com> wrote:

> > > +#define ELM327_CAN_CONFIG_SEND_SFF           0x8000
> > > +#define ELM327_CAN_CONFIG_VARIABLE_DLC       0x4000
> > > +#define ELM327_CAN_CONFIG_RECV_BOTH_SFF_EFF  0x2000
> > > +#define ELM327_CAN_CONFIG_BAUDRATE_MULT_8_7  0x1000  
> 
> This ELM327_CAN_CONFIG_BAUDRATE_MULT_8_7 macro is not used.

True. It does document a flag in the ELM327 configuration registers
though, and it was originally meant for adding 7/8 bitrates (e.g. 87500
as a companion to 100000). I never got around to implementing those
bitrates, though.

I find opportunistic documentation helpful for future reference and
to give casual readers hints - can I leave it in there anyway, or is it
deemed an eyesore?


Max
