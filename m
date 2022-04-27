Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD9AA511420
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 11:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235428AbiD0JNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 05:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234031AbiD0JNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 05:13:13 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 576BBCFB81;
        Wed, 27 Apr 2022 02:09:56 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1njdfk-0000Hv-01; Wed, 27 Apr 2022 11:09:20 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id AB05AC01C9; Wed, 27 Apr 2022 10:59:29 +0200 (CEST)
Date:   Wed, 27 Apr 2022 10:59:29 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, paul@crapouillou.net,
        zhouyu@wanyeetech.com, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mips: dts: ingenic: x1000: Add PWM device tree node
Message-ID: <20220427085929.GB8404@alpha.franken.de>
References: <20220411155315.51769-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411155315.51769-1-aidanmacdonald.0x0@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 04:53:15PM +0100, Aidan MacDonald wrote:
> Copied from the jz4740 devicetree and trimmed to 5 timers, which
> is what the hardware supports.
> 
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
> v2: Reduce regmap length since only the first 5 timers need to be accessed,
>     and don't wrap the clock-names at 80 columns.
> 
>  arch/mips/boot/dts/ingenic/x1000.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
