Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B594FF0CC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 09:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbiDMHwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 03:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233466AbiDMHwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 03:52:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2A964F5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 00:49:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CEC576152B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 07:49:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABAA4C385A6;
        Wed, 13 Apr 2022 07:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649836177;
        bh=U5PFHPlUvPZnKkFDVh2DWWPvU8ylQUClBVWmpgIeQN8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YIcN8dEbQPD4AXASMcF4KWt3uc1Wf8dkf0NVKB9SbSj8GBbWjMiXP0nYBKSlWmr1t
         UMIZxQl++1jqmr/cWNew75zE2zGbuxWPjFXsgM/oP86tLlFaDhvM9I/iIToWLqhxc2
         8uM8fFrxHGe/cqM7P/0y41lPctHsEV7pB5PIMjnxHEKTIi3lG9cE1/YWF09HLQwTyx
         /e2b8jQplvbZUHXSNBO1LeXcvu29+mLBR+A22h513FNlCe3/qPxoDekFebfVEZ0DUs
         EnOAF9zEE4xHze8pbAcjj/WCry/rkyGEh9a0z6syhYNvi2IDk1g+jCjkpKoAc4AdpO
         jmuivhSio3W5Q==
Date:   Wed, 13 Apr 2022 13:19:33 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     chunkuang.hu@kernel.org, p.zabel@pengutronix.de,
        chunfeng.yun@mediatek.com, kishon@ti.com, matthias.bgg@gmail.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] phy: mediatek: phy-mtk-mipi-dsi: Simplify with
 dev_err_probe()
Message-ID: <YlaAjXmwFB6eRNnd@matsya>
References: <20220328145217.228457-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220328145217.228457-1-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-03-22, 16:52, AngeloGioacchino Del Regno wrote:
> Use the dev_err_probe() helper to simplify error handling during probe.

Applied, thanks

-- 
~Vinod
