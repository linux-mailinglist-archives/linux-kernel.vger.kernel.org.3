Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248FA52ABB7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 21:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352596AbiEQTM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 15:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352601AbiEQTL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 15:11:28 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C08035DD2;
        Tue, 17 May 2022 12:11:27 -0700 (PDT)
Received: from wf0416.dip.tu-dresden.de ([141.76.181.160] helo=phil.dip.tu-dresden.de)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nr2bM-00043L-Iv; Tue, 17 May 2022 21:11:24 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     zhangqing@rock-chips.com, Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzk+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        linux-rockchip@lists.infradead.org, sboyd@kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: clock: convert rockchip,rk3188-cru.txt to YAML
Date:   Tue, 17 May 2022 21:11:20 +0200
Message-Id: <165281458742.3119039.1251106396664362865.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220329111323.3569-1-jbx6244@gmail.com>
References: <20220329111323.3569-1-jbx6244@gmail.com>
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

On Tue, 29 Mar 2022 13:13:22 +0200, Johan Jonker wrote:
> Current dts files with RK3188/RK3066 'cru' nodes are manually verified.
> In order to automate this process rockchip,rk3188-cru.txt has to be
> converted to YAML.
> 
> Changed:
>   Add properties to fix notifications by clocks.yaml for example:
>     clocks
>     clock-names

Applied, thanks!

[1/2] dt-bindings: clock: convert rockchip,rk3188-cru.txt to YAML
      commit: 43434c6681daa89c4c96b6c5ab82cdf894960ee0
[2/2] ARM: dts: rockchip: add clocks property to cru node rk3066a/rk3188
      commit: 89b6d86ded950b385b4778e061f7fc8311fb007e

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
