Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C259B546CA5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 20:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350072AbiFJSmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 14:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350087AbiFJSmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 14:42:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F624149DB4;
        Fri, 10 Jun 2022 11:42:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 15BE1B836FF;
        Fri, 10 Jun 2022 18:42:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE96AC34114;
        Fri, 10 Jun 2022 18:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654886537;
        bh=PJBR6bKb3Ylt/8DyDdQwk5imWJG0lzjWUnMRvGHHesE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=bi4mAHAcf2fgQoDLYAunF0CMvF+EqEcOGK1JshkXVnrIa6ig8IJPbyKqqzr1fz45Y
         G/SPsoq/l31XgT/FUMq4A1plS6YNt5Pf2zMVP1Z0uXnQ/zA0t3C4829OJj1RJ5LTF1
         70UNuYrXPXFw3r2mc2qVDEkLEF4Kz68uIT//qft0cGKDozMWC35E83x0bN7oBpcMsX
         TrQEYTHRgNoP/nMYlkT6+2jZ6kwUgYlNVws+e2MjcAvVrwNq2TINy2ZKpr2kyksrow
         0odJG4t5S3UQWpyNOk7iY0yV8piZCTrTC3VfPDqwZU4ePiXN6vimqM8tXA5bXLt061
         6aEwYPE34OXWg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220523102339.21927-3-matthias.bgg@kernel.org>
References: <20220523102339.21927-1-matthias.bgg@kernel.org> <20220523102339.21927-3-matthias.bgg@kernel.org>
Subject: Re: [PATCH v3 2/2] clk: mediatek: Delete MT8192 msdc gate
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     allen-kh.cheng@mediatek.com, weiyi.lu@mediatek.com,
        chun-jie.chen@mediatek.com, linux-kernel@vger.kernel.org,
        ikjn@chromium.org, miles.chen@mediatek.com, robh+dt@kernel.org,
        linux-mediatek@lists.infradead.org,
        krzysztof.kozlowski+dt@linaro.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        angelogioacchino.delregno@collabora.com,
        Matthias Brugger <matthias.bgg@gmail.com>
To:     matthias.bgg@kernel.org, mturquette@baylibre.com
Date:   Fri, 10 Jun 2022 11:42:15 -0700
User-Agent: alot/0.10
Message-Id: <20220610184217.BE96AC34114@smtp.kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting matthias.bgg@kernel.org (2022-05-23 03:23:39)
> From: Matthias Brugger <matthias.bgg@gmail.com>
>=20
> The msdc gate is part of the MMC driver. Delete the not used code.
>=20
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>
>=20
> ---

Applied to clk-next
