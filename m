Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3626654D7A7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 03:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357326AbiFPB52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 21:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244252AbiFPB50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 21:57:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E507590A0;
        Wed, 15 Jun 2022 18:57:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 34300B821FA;
        Thu, 16 Jun 2022 01:57:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8C18C3411A;
        Thu, 16 Jun 2022 01:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655344642;
        bh=cmn9Qs4S5xB8Dc9eJVr9KNNDJY4P8CuibZYJMPmTGnw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=GmqIKHQcyD60oBmidK2q7gFaWhZIlHuvG1iwv3Hd8pbBitarzwuVmjkfnoW3L+rpw
         7EQHlRE/MTVDnIYPZH0ddxN7uBCw/JeRZfp61hMgmGaYy4j/c88p21PTMU/H+RLA3+
         74Ed0qtQc4TKGtlijb79rhMrPXLZXbVgvJ3O90OpQO40atbI9SysJyKtyeRBJkJlfq
         R0/+n6e+/0Gql/L1SFJJuMau7niq2xFgmnnqg4zU4WCIoUEcYU6hO9XOelvVwdfwxU
         l8ZQRW6yYqskuH2lICVR4VyPFlyUlYvQ6HQjVVjN55eAdYAYnhG6pfGzTK1/e1MzSP
         MiBb4T659tlpg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <5e557269561d62972f8e44490bf7a6f97088f56b.camel@mediatek.com>
References: <20220523093346.28493-1-rex-bc.chen@mediatek.com> <5e557269561d62972f8e44490bf7a6f97088f56b.camel@mediatek.com>
Subject: Re: [RESEND v8 00/19] Cleanup MediaTek clk reset drivers and support SoCs
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     p.zabel@pengutronix.de, angelogioacchino.delregno@collabora.com,
        nfraprado@collabora.com, chun-jie.chen@mediatek.com,
        wenst@chromium.org, runyang.chen@mediatek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        mturquette@baylibre.com, robh+dt@kernel.org
Date:   Wed, 15 Jun 2022 18:57:19 -0700
User-Agent: alot/0.10
Message-Id: <20220616015722.C8C18C3411A@smtp.kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rex-BC Chen (2022-06-12 22:26:52)
> I also pushed another series to move these drivers to drivers/reset
> folder[1], but I think we still can let this series merged.

Sure. I merged everything except the DTS patches.

>=20
> If you have any comments for [1], please let me know.

I'll take a look. Thanks.
