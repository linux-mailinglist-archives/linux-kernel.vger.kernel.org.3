Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9F4554A58
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346654AbiFVMxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 08:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232608AbiFVMxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 08:53:13 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F11DF89;
        Wed, 22 Jun 2022 05:53:11 -0700 (PDT)
Received: from [62.91.21.7] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1o3zqr-0001t1-JW; Wed, 22 Jun 2022 14:52:57 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     arm@kernel.org, soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 26/40] arm64: dts: rockchip: align gpio-key node names with dtschema
Date:   Wed, 22 Jun 2022 14:52:54 +0200
Message-ID: <4976966.7s5MMGUR32@phil>
In-Reply-To: <ca7f343f-fec0-a365-9263-06354c920b01@linaro.org>
References: <20220616005224.18391-1-krzysztof.kozlowski@linaro.org> <20220616005333.18491-26-krzysztof.kozlowski@linaro.org> <ca7f343f-fec0-a365-9263-06354c920b01@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Am Mittwoch, 22. Juni 2022, 10:34:08 CEST schrieb Krzysztof Kozlowski:
> On 16/06/2022 02:53, Krzysztof Kozlowski wrote:
> > The node names should be generic and DT schema expects certain pattern
> > (e.g. with key/button/switch).
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > 
> > ---
> > 
> > Changes since v2:
> > 1. rk3308-evb.dts, rk3326-odroid-go2.dts: different names according to
> >    discussion.
> > ---
> 
> Heiko,
> 
> Any comments on Rockchip parts? Can you pick them or shall I grab them
> with rest of cleanups?

no it looks good and I'll just pick up the patch.

Thanks
Heiko


