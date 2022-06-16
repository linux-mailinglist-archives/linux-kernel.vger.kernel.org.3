Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39BC54D77F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 03:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350890AbiFPByL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 21:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357326AbiFPBxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 21:53:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484D65908D;
        Wed, 15 Jun 2022 18:53:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96B4861CDE;
        Thu, 16 Jun 2022 01:53:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB884C3411A;
        Thu, 16 Jun 2022 01:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655344427;
        bh=HiMa+tJvNJGODYWz5WKt+6j0GBah4EbArBxZz+K7pjM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=oGCVVmvGmbeeNKeo4pIkroVmZEAYKxHL+jhT7JHH4oHijIACesAbid8zK86Kh39Ak
         tGoJR6I7sgZnN3SpdKmDy0vDYvwzr5mynkaTacoSQRjSiWqzzzDFJf6EKHe+6kRzt9
         YnPRwAQ/ZAxr52aGxVinagHFtNdctm/rwwY7RBsMEyVMUNJOuB2IRt6Zv7Qd6P4U7i
         VduVnCpjubYTD6m+sljhXSd/8poolbHHkB2iI5kptEoESMZVeW/JbVEVFGD6mxXXCM
         XaJUIG53bgpYyyZ+urqCgpMBo7CFp3Ut40mDQSH9kMwAabyBueFDw4KrFe/7RaZwpD
         px29ESAdg4mZQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220523093346.28493-14-rex-bc.chen@mediatek.com>
References: <20220523093346.28493-1-rex-bc.chen@mediatek.com> <20220523093346.28493-14-rex-bc.chen@mediatek.com>
Subject: Re: [RESEND v8 13/19] dt-bindings: reset: mediatek: Add infra_ao reset index for MT8192/MT8195
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
Date:   Wed, 15 Jun 2022 18:53:43 -0700
User-Agent: alot/0.10
Message-Id: <20220616015346.EB884C3411A@smtp.kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rex-BC Chen (2022-05-23 02:33:40)
> To support reset of infra_ao, add the index of infra_ao reset of
> thermal/svs/pcei for MT8192 and thermal/svs for MT8195.
>=20
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> [N=C3=ADcolas: Test for MT8192]
> Tested-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> ---

Applied to clk-next
