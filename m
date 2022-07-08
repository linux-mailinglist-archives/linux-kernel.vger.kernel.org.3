Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6BA556B226
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 07:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237057AbiGHFOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 01:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiGHFOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 01:14:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE17676973
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 22:14:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 694DCB824E4
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 05:14:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3644C341CA;
        Fri,  8 Jul 2022 05:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657257260;
        bh=W7KkzfO+bktfe4mQFitUfFgnlWNpKQuE4WA0mV6VAQU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z19CH3RM1F1xFmBu7O7sWi9TJBOqstLuD68mnp1xnabbPH/lFtAsrH0qBsPxOAUKE
         8K6sQfB+wCNtBZwmEDZUdvaGKP2oCL7YcTnZBZU99q3uhkuSB15NEbNqmP8eE9Qwks
         JlrXKTvKFofUrcO5rbwJiwlrK6trMHecKq8piJzFa+qn18XqiwV8N0DXSGyKeYsrJH
         HtJ+tzeCs/+EjO2kGhJEoSF4iFTmzWQ73hdN7Q9jJEmAWSvT7eo6mdbJsh+v1FVlsG
         0JSBxjcZGMcjykvRykBDGpyA7FCIGNiwahA0EYOq6fGAmwbIpiVrqYiqiCXj94S9OU
         mz0C4zu4PLA7Q==
Date:   Fri, 8 Jul 2022 10:44:16 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        dri-devel@lists.freedesktop.org, msp@baylibre.com,
        chunkuang.hu@kernel.org
Subject: Re: [PATCH -next] phy: phy-mtk-dp: change mtk_dp_phy_driver to static
Message-ID: <Yse9KMuN96CRrpj6@matsya>
References: <20220707135309.801181-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707135309.801181-1-yangyingliang@huawei.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-07-22, 21:53, Yang Yingliang wrote:
> mtk_dp_phy_driver is only used in phy-mtk-dp.c now, change it to static.

Applied, thanks

-- 
~Vinod
