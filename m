Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496AE4FF0CA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 09:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbiDMHvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 03:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233393AbiDMHvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 03:51:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D162DC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 00:49:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 890FCB82133
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 07:49:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C45B7C385A3;
        Wed, 13 Apr 2022 07:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649836164;
        bh=P3PLLYEnQouhxbXJippcLF+VwcPI1Q2ZMS5OvlaMfyA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nSteYYZB6AVx6v/PHai0BVgRNkBYhVWJfvdWe1bnv0yrQYkYwgbU07JDTO80e2tyr
         ukdSwYpauO7qtS6AuSZ6eUCUXAXXuypOL5tAV8P7CSuws0dIrAC05YkyiQMtLwMfF3
         Z3DaTjVivkAYgPvCB7RUQ8Vv0KiJew0yDUCVz/ZHIuE/UPi5Fe7qEDmIuD9fxCn1Bx
         nHYsh6i/SxngdHcaEUcTdKkor3uK+CRi5ZSUUii6Fi1yWzP6dbjMjNLzso/nmPh3Dg
         hLrf+P5KU43ovVLVoSf/ZP8Fm2thEpIeCpJyLCNNKNO0G1thbQfdSFHnCibZMScTYo
         HgCAP5grseUgQ==
Date:   Wed, 13 Apr 2022 13:19:20 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     chunkuang.hu@kernel.org, p.zabel@pengutronix.de,
        chunfeng.yun@mediatek.com, kishon@ti.com, matthias.bgg@gmail.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: mediatek: phy-mtk-hdmi: Simplify with
 dev_err_probe()
Message-ID: <YlaAgMk9bIGiMMV7@matsya>
References: <20220328111046.210736-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220328111046.210736-1-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-03-22, 13:10, AngeloGioacchino Del Regno wrote:
> Use the dev_err_probe() helper to simplify error handling during probe.

Applied, thanks

-- 
~Vinod
