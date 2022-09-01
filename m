Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D795A8A67
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 03:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbiIABOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 21:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbiIABOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 21:14:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD1412E4D0;
        Wed, 31 Aug 2022 18:14:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 46DECB823CB;
        Thu,  1 Sep 2022 01:14:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED2C4C433D6;
        Thu,  1 Sep 2022 01:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661994851;
        bh=R/76vyDw5YFQkK7f+C2znxTwONiXMNY233XPvV8eTj4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=V55x74P73lLpqSgoCdJUPauFg/fACr3iPqob7PaHI0UEP7KbgEsGdRoIRM3AJVrvW
         00vmDXDnuFXSdf2PA8QX8efseS8pvqcI2qVpnyIJTaHpuc8E0JSzBCcK1SDPYJBQ9F
         taHdWOiH8KSC5iqoffjy9XKFbkQY08wcWGeWML7H/q+7BkjoEEzn8C4j1I2Qv6a+18
         itkOAsuwz87zSSnWNK1eUgkmiqPtsGpj/8pZpP5FmubrAWWS3rWvnPXelyab1uCQPp
         lfE9+90YFtB9TbTo7UoJboBMvk0YvU4bkU2+/4ipOrEm0kWYMrkODdgiduGEpqTb5M
         DfE2u4AjK84sQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220629105205.173471-2-angelogioacchino.delregno@collabora.com>
References: <20220629105205.173471-1-angelogioacchino.delregno@collabora.com> <20220629105205.173471-2-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 1/2] dt-bindings: reset: mt8195: Add resets for PCIE controllers
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     matthias.bgg@gmail.com, p.zabel@pengutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        angelogioacchino.delregno@collabora.com, wenst@chromium.org,
        chun-jie.chen@mediatek.com, miles.chen@mediatek.com,
        rex-bc.chen@mediatek.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, mturquette@baylibre.com
Date:   Wed, 31 Aug 2022 18:14:09 -0700
User-Agent: alot/0.10
Message-Id: <20220901011410.ED2C4C433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting AngeloGioacchino Del Regno (2022-06-29 03:52:04)
> Add the reset index for PCIe P0 and P1 (PCIe0, PCIe1) on MT8195.
>=20
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---

Applied to clk-next
