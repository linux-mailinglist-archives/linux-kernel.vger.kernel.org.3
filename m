Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7286B54D75C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 03:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350262AbiFPBu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 21:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344417AbiFPBuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 21:50:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2229580D4;
        Wed, 15 Jun 2022 18:50:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A4833B8216B;
        Thu, 16 Jun 2022 01:50:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A52EC3411A;
        Thu, 16 Jun 2022 01:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655344213;
        bh=FhkQ0cJWFo5/+JckmuSC374vXWxCqLkRJWGOYKujcis=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=PNl/1VYOBJX+GK1z/xA0+SyTgO77bCwmSxek9sWJiyXF3hW18+uFdu0FcHGn+4Rx/
         Gv0XGdBins1WjCWomLRsl7tauGUnSyXxzsjmsa4vh6ZDtiQV02ChpP5fQ4ikDrDFOn
         oMy4hfUozi4SBaiACcCWlMKILFEVurMDHqsBRen96yGLnOFELzJn4MGLJjUbho386e
         oEU3GgbEr/t+ZN634T47FHhEgniX2FAfKEHOZbbZ2DaZnonktjtpD1Uo5+AzcVuPIj
         RQXm75B7sBP7fUgbeBJKjGMG8Vr+Z6RaTV+9zHzO14D7ultcXw6zha8FDShsJWlmAB
         CtdmnB63fvC7A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220523093346.28493-2-rex-bc.chen@mediatek.com>
References: <20220523093346.28493-1-rex-bc.chen@mediatek.com> <20220523093346.28493-2-rex-bc.chen@mediatek.com>
Subject: Re: [RESEND v8 01/19] clk: mediatek: reset: Add reset.h
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
Date:   Wed, 15 Jun 2022 18:50:10 -0700
User-Agent: alot/0.10
Message-Id: <20220616015013.3A52EC3411A@smtp.kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rex-BC Chen (2022-05-23 02:33:28)
> Add a new file "reset.h" to place some definitions for clock reset.
>=20
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Tested-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> ---

Applied to clk-next
