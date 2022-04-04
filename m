Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B49F4F118A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 11:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344830AbiDDJCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 05:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343716AbiDDJCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 05:02:06 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDEAC29CB2;
        Mon,  4 Apr 2022 02:00:10 -0700 (PDT)
Received: from wf0416.dip.tu-dresden.de ([141.76.181.160] helo=phil.dip.tu-dresden.de)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nbIZB-0008Ew-WA; Mon, 04 Apr 2022 11:00:06 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Michael Riesch <michael.riesch@wolfvision.net>,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Tianling Shen <cnsztl@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Levin Du <djw@t-chip.com.cn>,
        Liang Chen <cl@rock-chips.com>, Alex Bee <knaerzche@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH v2 0/3] (partial) arm64: dts: rockchip: add basic dts for the radxa rock3 model a
Date:   Mon,  4 Apr 2022 11:00:00 +0200
Message-Id: <164906273050.1398682.18343164633060967077.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220310210352.451136-1-michael.riesch@wolfvision.net>
References: <20220310210352.451136-1-michael.riesch@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Mar 2022 22:03:49 +0100, Michael Riesch wrote:
> This series introduces basic support for the Radxa ROCK3 Model A
> featuring the Rockchip RK3568 SoC. The basic support includes Ethernet,
> USB2 and the headphone connector.
> 
> Patch 3 adds support for the Video Output Processor (VOP) 2 and the
> HDMI output. It requires the VOP2/HDMI TX patches (which are discussed
> on the list) and can be considered as RFC.
> 
> [...]

(partial) Applied, thanks!

[1/3] dt-bindings: arm: rockchip: add radxa rock3 model a
      commit: 65a31b5abb7f4c373ce0de52eca75348156c87d2
[2/3] arm64: dts: rockchip: add basic dts for the radxa rock3 model a
      commit: 056ef970c434a572f81eae199846bf3f521a8303

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
