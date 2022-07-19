Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104CF579B9A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 14:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240357AbiGSMac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 08:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240488AbiGSM3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 08:29:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A75E68707;
        Tue, 19 Jul 2022 05:11:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 372A1615F4;
        Tue, 19 Jul 2022 12:11:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A939DC341C6;
        Tue, 19 Jul 2022 12:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658232676;
        bh=V2z6pp8MGIZMODkGoJeoLyOFQM76mCY2XwDpKMqsZz4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nisjwxsRQq4kJLxDHtBhIHYnOnKlDbfhPEcXSuOwWyov46tC5CZuk6WXTK0sWfSco
         FaTIGYz5GNDvexZQCarZfVKZJM7AbOiKOZXLxbQoLOgMgApuQhWlKyM5pRk66PiGrj
         5u37zsMU/HyAAPJSOKTrpb3BFQVdvk8dRYUnyVWQWaDD0yHQB53P8U4iadVHwjDiiB
         k5f6g3QSDw//oLNIwTGQN0PjM22freaaXT8Rl1xojUueQt5UDbYJTAeosRX3L7gMB3
         u6yLTk+NsOIodwHH63qw+5T+UShSQTUfPv1jiIMzWYmIr7uGzluWXGAqFg0CG1/OZK
         WcCyctOvB/e8w==
Date:   Tue, 19 Jul 2022 13:21:11 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Hui Liu <hui.liu@mediatek.com>, lars@metafoo.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, srv_heupstream@mediatek.com,
        zhiyong.tao@mediatek.com, guodong.liu@mediatek.com,
        johnson.wang@mediatek.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 1/1] dt-bindings: iio: adc: Add compatible for MT8188
Message-ID: <20220719132111.624af06e@jic23-huawei>
In-Reply-To: <c764d5c1-2d4d-e829-a728-eed253a66701@collabora.com>
References: <20220719014657.28714-1-hui.liu@mediatek.com>
        <20220719014657.28714-2-hui.liu@mediatek.com>
        <c764d5c1-2d4d-e829-a728-eed253a66701@collabora.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jul 2022 11:44:44 +0200
AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> wrote:

> Il 19/07/22 03:46, Hui Liu ha scritto:
> > From: "Hui.Liu" <hui.liu@mediatek.com>
> > 
> > Add dt-binding documentation of auxadc for MediaTek MT8188 SoC platform.
> > 
> > Signed-off-by: Hui.Liu <hui.liu@mediatek.com>  
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
Applied to the togreg branch of iio.git.

Thanks,

Jonathan

