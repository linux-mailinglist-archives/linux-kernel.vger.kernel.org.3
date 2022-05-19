Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9900F52C8CF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 02:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbiESAmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 20:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbiESAmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 20:42:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC18FB0407;
        Wed, 18 May 2022 17:42:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92023617C6;
        Thu, 19 May 2022 00:42:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9572C385A9;
        Thu, 19 May 2022 00:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652920963;
        bh=zmNRJAaXDXQx4amQA3NMoD0Oaa4WRs4hCXKUciYbCyo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=iYFZMhX/CORPBGnQ2Mzvjif3e6iszkSNpCdkUQxE7yVOFEC/heSv/x+KQELAPAusA
         OGXRH1WTqBDKa0PDSg6z1WvqyCSyN/vFXdtFP03fhyPrJyLbDsX//G1br7wvVXMtXx
         4RvkTJadGgMiMUX1NFckAA7bXJ7RhvnE2XaFPZjcxFGrn70W7hcWbHMBQGN8wept2N
         kyadsOW7U/XqjEY0/9xW4+MZ42Y4vhZeXMMMeVL/MDw3++OeFSjdmat7Wrcues1y7/
         qSsYEUjX3qRfxgzYCBR+Mg7Ebu2tn2lBkHQAiSohT7yBF77xJ7+Wj2xgZoKgCiGiW4
         ZwutDE6m/xIoA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220513073621.12923-1-mandyjh.liu@mediatek.com>
References: <20220513073621.12923-1-mandyjh.liu@mediatek.com>
Subject: Re: [PATCH v2] clk: mediatek: use en_mask as a pure div_en_mask
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     miles.chen@mediatek.com, wenst@chromium.org,
        chun-jie.chen@mediatek.com,
        angelogioacchino.delregno@collabora.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Mandy Liu <mandyjh.liu@mediatek.com>
To:     Mandy Liu <mandyjh.liu@mediatek.com>, mturquette@baylibre.co
Date:   Wed, 18 May 2022 17:42:40 -0700
User-Agent: alot/0.10
Message-Id: <20220519004242.E9572C385A9@smtp.kernel.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mandy Liu (2022-05-13 00:36:21)
> From: Chun-Jie Chen <chun-jie.chen@mediatek.com>
>=20
> We no longer allow en_mask to be a combination of
> pll_en_bit and div_en_mask, so remove pll_en_bit(bit0)
> from en_mask to make en_mask a pure en_mask that only
> used for pll dividers.
>=20
> This commit continues the work done in commit 7cc4e1bbe300
> ("clk: mediatek: Fix asymmetrical PLL enable and disable
> control") and commit f384c44754b7 ("clk: mediatek:
> Add configurable enable control to mtk_pll_data") to
> clean up en_mask(bit0) default setting.
>=20
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> Signed-off-by: Mandy Liu <mandyjh.liu@mediatek.com>
>=20
> ---

Applied to clk-next
