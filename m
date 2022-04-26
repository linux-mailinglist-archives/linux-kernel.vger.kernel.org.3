Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3A950ED48
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 02:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239627AbiDZAP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 20:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239587AbiDZAPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 20:15:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE79E120116;
        Mon, 25 Apr 2022 17:12:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 90A93B81BAB;
        Tue, 26 Apr 2022 00:12:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4552FC385A7;
        Tue, 26 Apr 2022 00:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650931966;
        bh=TC1cdKqN3SuRioLLjZZQcwVv5OWMAgilm0pRHb51HKI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=FbIrq+bRbYyd2WMFJonUeySdWqcZKMtkdt7BKW6fC/LZ9Mi9lfGDtb8vEwwFZ6PV1
         vgHkzw2JQhRQSalvruCa+9QuIQcZyuqEr0n44gqKyhQ9y9O8idmciHKbQjcIvedU5p
         RdHFk9OW7OxmfC4gg2jxUlCEb2qE2gPfAIsG+iyY+7LaEUZGZ3xAouO36sqjJt+3XA
         1mRSShgO7emx0VVOgftLncH/CiI0ONZhCQocie46pnPq993UHsGR7tZ9kRB3ywiD4W
         R79uoD+rXRULJdYicYoRVCROkqUU6/k42VrYVX8DBUcaAOnDXigvb55XY18c6W6H58
         wMIHcCttgCxLA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220409132251.31725-6-chun-jie.chen@mediatek.com>
References: <20220409132251.31725-1-chun-jie.chen@mediatek.com> <20220409132251.31725-6-chun-jie.chen@mediatek.com>
Subject: Re: [PATCH v5 05/15] clk: mediatek: Add MT8186 apmixedsys clock support
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
Date:   Mon, 25 Apr 2022 17:12:44 -0700
User-Agent: alot/0.10
Message-Id: <20220426001246.4552FC385A7@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chun-Jie Chen (2022-04-09 06:22:41)
> Add MT8186 apmixedsys clock controller which provides Plls
> generated from SoC.
>=20
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>
> ---

Applied to clk-next
