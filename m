Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57B154D785
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 03:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356490AbiFPBxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 21:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354540AbiFPBxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 21:53:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822E5186F4;
        Wed, 15 Jun 2022 18:53:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 15265B8216B;
        Thu, 16 Jun 2022 01:53:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8ED6C3411A;
        Thu, 16 Jun 2022 01:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655344411;
        bh=s07JkacgYheRotOQFYTku/YMbG8vMO95kzvQ82X52Bc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=KcnkPwWpaJUZZ49/RkqIAnNfcQGE0hW8FH76WIHf34P9fPO043LXJaf1gjc2HnZb+
         2jKXrEZlq0BSOCWMKNeY03Kigj/9AJg88lLpoTRbpfLGYH67hTggeFsZj1JjiHqonW
         L+vAtsIuy+S7vgKRfNcAlO4iNmg4Jhk6XlCeMSLS32tuYlaG36TKyx5CFGXxClRVZh
         PCGANzSD5RS8+OCafYmD1RvdQFO9WAqu+CDFpuvP8Ru/E4iAf9lPJ9E8pK5cELzVSZ
         kDPphfWnTdSLu/Gg/Ve03XUJMOsf2xpUP1XayIYAfbfnCtYpMMsTIo5vqSKupFPFfY
         WFUj9xYmO/+ow==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220523093346.28493-13-rex-bc.chen@mediatek.com>
References: <20220523093346.28493-1-rex-bc.chen@mediatek.com> <20220523093346.28493-13-rex-bc.chen@mediatek.com>
Subject: Re: [RESEND v8 12/19] dt-bindings: arm: mediatek: Add #reset-cells property for MT8192/MT8195
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     p.zabel@pengutronix.de, angelogioacchino.delregno@collabora.com,
        nfraprado@collabora.com, chun-jie.chen@mediatek.com,
        wenst@chromium.org, runyang.chen@mediatek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        mturquette@baylibre.com, robh+dt@kernel.org
Date:   Wed, 15 Jun 2022 18:53:28 -0700
User-Agent: alot/0.10
Message-Id: <20220616015331.A8ED6C3411A@smtp.kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rex-BC Chen (2022-05-23 02:33:39)
> We will use the infra_ao reset which is defined in mt8192-sys-clock
> and mt8195-sys-clock.
> The value of reset-cells is 1.
>=20
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Tested-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> ---

Applied to clk-next
