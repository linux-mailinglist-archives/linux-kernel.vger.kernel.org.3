Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8332454D773
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 03:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350401AbiFPBvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 21:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350198AbiFPBvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 21:51:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010BD58388;
        Wed, 15 Jun 2022 18:51:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9110F61CC7;
        Thu, 16 Jun 2022 01:51:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E68FAC3411A;
        Thu, 16 Jun 2022 01:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655344260;
        bh=4U5Lj/b/Nnw+5T77ExxngXXDFdxOraiwkpEje5p7KTU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=CtlotVeT91CLGG4UkX+Gnwkhe1AIRE5ubXXYSpecAlUEGQ9SjZEYZkLGdSRbGVCOT
         3aycrxRrgAOHgxXIIGInEqijPmvJbuO/48ZDkce4qnhNa6xDRMHE9dXK7tE9K44hnT
         1fikloK8vPgcZGR272scLnjvK1VgD5weJnl3dMAiWYoq4bDo1a0hDX5sMocq1ziii9
         1gngOsjsyJWA3oK0QTl9Gjmddil6Ifg3q0zRgosDN7RWI/KcsyBicEb93h3na61Apo
         TXKLyloEB8iIWnLKPXq6M+uQEmKH5vDZgur33S4m0Ac+NCLTBfCDU/gVj2AK663mou
         YBwWyta05xgkQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220523093346.28493-5-rex-bc.chen@mediatek.com>
References: <20220523093346.28493-1-rex-bc.chen@mediatek.com> <20220523093346.28493-5-rex-bc.chen@mediatek.com>
Subject: Re: [RESEND v8 04/19] clk: mediatek: reset: Extract common drivers to update function
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
Date:   Wed, 15 Jun 2022 18:50:56 -0700
User-Agent: alot/0.10
Message-Id: <20220616015059.E68FAC3411A@smtp.kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rex-BC Chen (2022-05-23 02:33:31)
> To make drivers more clear and readable, we extract common code
> within assert and deassert to mtk_reset_update_set_clr() and
> mtk_reset_update().
>=20
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Tested-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> ---

Applied to clk-next
