Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17CED4FA6EE
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 13:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241471AbiDILDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 07:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbiDILDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 07:03:43 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DD0139271;
        Sat,  9 Apr 2022 04:01:34 -0700 (PDT)
Received: from p508fd313.dip0.t-ipconnect.de ([80.143.211.19] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nd8qM-0000r9-FR; Sat, 09 Apr 2022 13:01:26 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Dan Johansen <strit@manjaro.org>,
        Frank Wunderlich <frank-w@public-files.de>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: Aw: Re:  Re: [PATCH] arm64: dts: rockchip: Fix clocks for rk356x usb
Date:   Sat, 09 Apr 2022 13:01:25 +0200
Message-ID: <4559790.iIbC2pHGDl@phil>
In-Reply-To: <trinity-b6d141b2-264a-4a57-9707-6a38a80cea16-1649501859874@3c-app-gmx-bap35>
References: <20220409075147.136187-1-linux@fw-web.de> <ba60121a-a120-b717-6a2f-7883685d17e6@manjaro.org> <trinity-b6d141b2-264a-4a57-9707-6a38a80cea16-1649501859874@3c-app-gmx-bap35>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 9. April 2022, 12:57:39 CEST schrieb Frank Wunderlich:
> Hi
> > Gesendet: Samstag, 09. April 2022 um 12:40 Uhr
> > Von: "Dan Johansen" <strit@manjaro.org>
> 
> > So the issue is only with usb 3 ports, not usb 2 ports?
> 
> my board has no standalone usb2-ports. usb2 is integrated into the usb3 ports (dual phy). here both were not working.
> 
> afaik rk3566 has standalone usb2 ports that may not be broken, but i have no such board for testing.

As far as I understand the issue now after checking the code, this
patch actually fixes the usb3 series from Peter, right?

I.e. the usb-nodes that are fixed in this patch are not yet present
in the main rk356x dtsi and only get added in
"arm64: dts: rockchip: add rk356x dwc3 usb3 nodes" [0]

As we don't want to add broken changes, this fix should squashed
into a next version of the patch adding the nodes.


Heiko

[0] https://lore.kernel.org/r/20220408151237.3165046-4-pgwipeout@gmail.com


