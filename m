Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087B75AC648
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 22:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234977AbiIDULL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 16:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiIDULJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 16:11:09 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAA92A725;
        Sun,  4 Sep 2022 13:11:05 -0700 (PDT)
Received: (Authenticated sender: peter@korsgaard.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 74875FF804;
        Sun,  4 Sep 2022 20:10:53 +0000 (UTC)
Received: from peko by dell.be.48ers.dk with local (Exim 4.94.2)
        (envelope-from <peter@korsgaard.com>)
        id 1oUvxD-005rMX-Lq; Sun, 04 Sep 2022 22:10:51 +0200
From:   Peter Korsgaard <peter@korsgaard.com>
To:     <Conor.Dooley@microchip.com>
Cc:     <samuel@sholland.org>, <wens@csie.org>, <jernej.skrabec@gmail.com>,
        <linux-sunxi@lists.linux.dev>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <heiko@sntech.de>
Subject: Re: [PATCH 07/12] riscv: dts: allwinner: Add Allwinner D1 Nezha
 devicetree
References: <20220815050815.22340-1-samuel@sholland.org>
        <20220815050815.22340-8-samuel@sholland.org>
        <adc4a8e2-7347-7616-99b9-59762023b2ff@microchip.com>
Date:   Sun, 04 Sep 2022 22:10:51 +0200
In-Reply-To: <adc4a8e2-7347-7616-99b9-59762023b2ff@microchip.com> (Conor
        Dooley's message of "Fri, 19 Aug 2022 22:10:44 +0000")
Message-ID: <87o7vuzyr8.fsf@dell.be.48ers.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>>   <Conor.Dooley@microchip.com> writes:

 > Hey Samuel,
 > Finally got around to giving this a go with the fix for loading
 > modules which is mostly what was blocking me before..

 > On 15/08/2022 06:08, Samuel Holland wrote:
 >> "D1 Nezha" is Allwinner's first-party development board for the D1 SoC.
 >> It was shipped with 512M, 1G, or 2G of DDR3. It supports onboard audio,

 > I am really not keen on the way you have things, with the memory
 > nodes removed from the device tree. I know your preferred flow
 > for booting these things might be to pass the dtb up from U-Boot,
 > but I think the devicetree in the kernel should be usable in a
 > standalone manner, even if that is the barest-minimum memory
 > config.

Yes, this also confused me. Part of the reason seems to be that u-boot
on RISC-V doesn't fixup the memory node of a provided device tree like
it is done on E.G. ARM for some reason.

-- 
Bye, Peter Korsgaard
