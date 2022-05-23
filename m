Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696A4530D0E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 12:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbiEWJcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 05:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233203AbiEWJbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 05:31:53 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A521B167E9;
        Mon, 23 May 2022 02:31:46 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1nt4Os-0001Pn-01; Mon, 23 May 2022 11:30:54 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 154F5C02F4; Mon, 23 May 2022 11:19:17 +0200 (CEST)
Date:   Mon, 23 May 2022 11:19:17 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     =?utf-8?B?5ZGo55Cw5p2wIChaaG91IFlhbmppZSk=?= 
        <zhouyanjie@wanyeetech.com>
Cc:     paul@crapouillou.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com
Subject: Re: [PATCH 0/3] Refresh device tree and defconfig for Ingenic SoCs
 and boards.
Message-ID: <20220523091916.GF5069@alpha.franken.de>
References: <1652384021-46309-1-git-send-email-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1652384021-46309-1-git-send-email-zhouyanjie@wanyeetech.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 03:33:38AM +0800, 周琰杰 (Zhou Yanjie) wrote:
> 1.Add PWM node for X1830 SoC from Ingenic.
> 2.Add SSI nodes for X1000 SoC and X1830 SoC from Ingenic.
> 3.Refresh SSI related nodes in CU1000-Neo and CU1830-Neo.
> 4.The X1830 SoC used by the CU1830-Neo and the X1000 SoC
>   used by the CU1000-Neo are both single-core processors,
>   therefore the "OST_CLK_PERCPU_TIMER" ABI should not be
>   used in the OST nodes of the CU1830-Neo and CU1000-Neo,
>   it is just a coincidence that there is no problem now.
>   So replace the misused "OST_CLK_PERCPU_TIMER" ABI with
>   the correct "OST_CLK_EVENT_TIMER" ABI.
> 5.Refresh the defconfig files of the CU1000-Neo board and
>   the CU1830-Neo board, remove the selection of SPI-GPIO,
>   and add the selection of SSI.
> 
> 周琰杰 (Zhou Yanjie) (3):
>   MIPS: Ingenic: Add PWM nodes for X1830.
>   MIPS: Ingenic: Refresh device tree for Ingenic SoCs and boards.
>   MIPS: Ingenic: Refresh defconfig for CU1000-Neo and CU1830-Neo.
> 
>  arch/mips/boot/dts/ingenic/cu1000-neo.dts | 77 ++++++++++++++++---------------
>  arch/mips/boot/dts/ingenic/cu1830-neo.dts | 76 +++++++++++++++---------------
>  arch/mips/boot/dts/ingenic/x1000.dtsi     | 20 ++++++++
>  arch/mips/boot/dts/ingenic/x1830.dtsi     | 53 +++++++++++++++++++++
>  arch/mips/configs/cu1000-neo_defconfig    |  2 +-
>  arch/mips/configs/cu1830-neo_defconfig    |  2 +-
>  6 files changed, 154 insertions(+), 76 deletions(-)
> 
> -- 
> 2.7.4

seried applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
