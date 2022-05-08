Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A3251EF28
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 21:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238971AbiEHTIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 15:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238521AbiEHRr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 13:47:57 -0400
X-Greylist: delayed 331 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 08 May 2022 10:44:04 PDT
Received: from fx.arvanta.net (static-213-198-238-194.adsl.eunet.rs [213.198.238.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7E74DBE10;
        Sun,  8 May 2022 10:44:04 -0700 (PDT)
Received: from m1 (unknown [10.5.1.15])
        by fx.arvanta.net (Postfix) with ESMTP id D245E2B2FB;
        Sun,  8 May 2022 19:38:29 +0200 (CEST)
Date:   Sun, 8 May 2022 19:38:30 +0200
From:   Milan =?utf-8?Q?P=2E_Stani=C4=87?= <mps@arvanta.net>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc:     Philip Rinn <rinni@inventati.org>, wens@csie.org,
        Samuel Holland <samuel@sholland.org>, robh+dt@kernel.org,
        krzk+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] arm64: dts: allwinner: a64: olinuxino: Enable audio
Message-ID: <YngAFrGeivZpJ5dK@m1>
References: <4fc41278-c46c-6486-a336-f2a329bd6bd0@sholland.org>
 <20220407155145.10891-1-rinni@inventati.org>
 <40976a35-2241-a2f0-c9be-dd32c1b51814@sholland.org>
 <4727823.31r3eYUQgx@kista>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4727823.31r3eYUQgx@kista>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-04-10 at 20:23, Jernej Škrabec wrote:
> Dne petek, 08. april 2022 ob 00:06:01 CEST je Samuel Holland napisal(a):
> > On 4/7/22 10:51 AM, Philip Rinn wrote:
> > > Enable the audio hardware on the Olimex A64-OLinuXino board family.
> > > Tested on the A64-OLinuXino-2Ge8G-IND variant.
> > > 
> > > Signed-off-by: Philip Rinn <rinni@inventati.org>
> > 
> > Acked-by: Samuel Holland <samuel@sholland.org>
> 
> Applied to sunxi/dt-for-5.19. Thanks!

About week ago I made nearly same patch but Jernej pointed me to this
one. I applied this patch and it works like one I made.

Audio output works fine, but recording doesn't work at all in my tests.
I can hear myself from microphone on headphones quite fine but 'arecord'
records only some kind of white noise. Tried all alsamixer widget
combinations but didn't managed to record anything.

Kind regards
