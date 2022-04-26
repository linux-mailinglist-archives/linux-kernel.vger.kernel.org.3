Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E0650ED40
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 02:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239449AbiDZAPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 20:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239382AbiDZAPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 20:15:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B745245517;
        Mon, 25 Apr 2022 17:12:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 785E3B81BBA;
        Tue, 26 Apr 2022 00:12:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26B92C385A4;
        Tue, 26 Apr 2022 00:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650931942;
        bh=Bo5zJ3zXwTqRYkYXc9dDCe9L1DEOgmLA6YoQiISiA9U=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=F4iQprc9jc8RUojThiZcVwyo/fxucVF1aVy7f9iS8IGF4wJp8pnkbwL0jWy5RCoE4
         MpmIpDtRqv278yl2591G/QzYLhqeXx8hjFlFiOFEAxCsPZwH8llVtl0B4dc40pV33I
         zQNAogmSafn9pdsw7kjoLncpEc2WhbeSwLu3TFyl7R3BKxBEIMQ8wozPS56BH14VBS
         uvB19Cjyakije1Mx9sHso8p+KSOTP52Vch/cATEfv5WJhzzkqd+b13GKAQM/lYR0CL
         mJ6QIRoxhfqRnVW9rTkDOvpghQ5unMPAdn8aywHVvGuYRVfWfRoVFLDpVcoOTcSA2b
         5PiF/S4/+/LPQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220409132251.31725-4-chun-jie.chen@mediatek.com>
References: <20220409132251.31725-1-chun-jie.chen@mediatek.com> <20220409132251.31725-4-chun-jie.chen@mediatek.com>
Subject: Re: [PATCH v5 03/15] clk: mediatek: Add MT8186 topckgen clock support
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
Date:   Mon, 25 Apr 2022 17:12:20 -0700
User-Agent: alot/0.10
Message-Id: <20220426001222.26B92C385A4@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chun-Jie Chen (2022-04-09 06:22:39)
> Add MT8186 topckgen clock controller which provides muxes, dividers
> to handle variety clock selection in other IP blocks.
>=20
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>
> ---

Applied to clk-next
