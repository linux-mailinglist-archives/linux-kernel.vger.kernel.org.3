Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E47450ED61
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 02:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238535AbiDZARa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 20:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240026AbiDZARX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 20:17:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288031229D6;
        Mon, 25 Apr 2022 17:14:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C6931B81BAB;
        Tue, 26 Apr 2022 00:14:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF98C385A4;
        Tue, 26 Apr 2022 00:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650932054;
        bh=QEJdt0UF+tcaaYi/1FBeIDbmE6yAI30SB+nMUM/acVY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Xa23/1HeSPEmrAY+7btpsAjJaEMl6FCq0pvD2lCqvOPrCwtvxYLTtKLy82oac81uC
         lr9xQV9AcEuhSEmPK9bpEPM3eVTR2YQZNC0kidP8I5w4VjgMntGYs3A+7NT25jhaBS
         e+8vqnTTTgI2LuyV5tDbG878OJP43HKDfr8jf/7ZJc2+eE4IqkfLUVfOauIRLRpYk5
         +EzHcG3NEpdalYvhOSZvKsMVvoji5U87FQ9MG97gn3LLB+aZfO9B3XKOK3gVPRGhPD
         5nVezUJx8ORAU9rqRmbI0xx6FwGCRbRYqLQLkSwlM9pbwfbVhn4rxX1/a6MwGqnfzK
         lZBbIVnDITaRA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220409132251.31725-16-chun-jie.chen@mediatek.com>
References: <20220409132251.31725-1-chun-jie.chen@mediatek.com> <20220409132251.31725-16-chun-jie.chen@mediatek.com>
Subject: Re: [PATCH v5 15/15] clk: mediatek: Add MT8186 ipesys clock support
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Date:   Mon, 25 Apr 2022 17:14:12 -0700
User-Agent: alot/0.10
Message-Id: <20220426001414.6FF98C385A4@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chun-Jie Chen (2022-04-09 06:22:51)
> Add MT8186 ipesys clock controller which provides clock gate
> control for Image Process Engine.
>=20
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>
> ---

Applied to clk-next
