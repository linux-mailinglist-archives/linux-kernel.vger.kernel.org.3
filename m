Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4C6511423
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 11:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235206AbiD0JNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 05:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234048AbiD0JNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 05:13:15 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2102711D94B;
        Wed, 27 Apr 2022 02:09:54 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1njdfk-0000Hv-02; Wed, 27 Apr 2022 11:09:20 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 05C4EC01C9; Wed, 27 Apr 2022 11:00:50 +0200 (CEST)
Date:   Wed, 27 Apr 2022 11:00:50 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Michael Walle <michael@walle.cc>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        UNGLinuxDriver@microchip.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] MIPS: mscc: jaguar2: rename pinctrl nodes
Message-ID: <20220427090050.GC8404@alpha.franken.de>
References: <20220420195018.3417053-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420195018.3417053-1-michael@walle.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 09:50:16PM +0200, Michael Walle wrote:
> The pinctrl device tree binding will be converted to YAML format. Rename
> the pin nodes so they end with "-pins" to match the schema.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
> The YAML conversion patch is alread in
> https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/log/?h=devel
> 
>  arch/mips/boot/dts/mscc/jaguar2_pcb110.dts | 10 +++++-----
>  arch/mips/boot/dts/mscc/jaguar2_pcb111.dts | 10 +++++-----
>  arch/mips/boot/dts/mscc/jaguar2_pcb118.dts |  6 +++---
>  3 files changed, 13 insertions(+), 13 deletions(-)

series applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
