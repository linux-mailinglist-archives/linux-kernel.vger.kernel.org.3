Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C7A5AC4E0
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 17:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234419AbiIDPGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 11:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiIDPG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 11:06:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3E8356FD;
        Sun,  4 Sep 2022 08:06:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1108BB80D8C;
        Sun,  4 Sep 2022 15:06:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3F67C433D6;
        Sun,  4 Sep 2022 15:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662303985;
        bh=pwPJZ7tg9YJru8UeTZSAissvCywCwuoVOcaEMeA0UGY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WWTl1mnZduqQDq1DBgc4t+n3yGVFIgaqaqGBxdJpVchN3Le5ara2QcLnRZkp+ITnZ
         fo0JoipBDM9ebgAByW5yFtVkezqL4T1rcgnwrs4I+4+YgBb3KS9JYS0aeMAr9oJgff
         S7qQnkMLwjVmJxfhSJFuvZEjXkVmcC/SeDcNJS6oZlgHSPONtS8bFDNa2G+OICteN2
         QDLDjPg2UsPsGJkvHKggNJnkGqE0X3ZzxyOhty/EvdNcH0ZoRSOR0dalDb8uy1hy1A
         z7P8OervDN4zqxs02SnnOKUpExoEQk65SwKZYMzU9cwoDAFNyXFRo3kzvAS1n/7uUz
         g8V2P52ExHtpQ==
Date:   Sun, 4 Sep 2022 20:36:20 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Frank Wunderlich <linux@fw-web.de>
Cc:     linux-rockchip@lists.infradead.org,
        Frank Wunderlich <frank-w@public-files.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        Johan Jonker <jbx6244@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Simon Xue <xxm@rock-chips.com>, Liang Chen <cl@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/5] phy: rockchip: Support PCIe v3
Message-ID: <YxS+7B0d+TqEJH3v@matsya>
References: <20220825193836.54262-1-linux@fw-web.de>
 <20220825193836.54262-4-linux@fw-web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825193836.54262-4-linux@fw-web.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-08-22, 21:38, Frank Wunderlich wrote:
> From: Shawn Lin <shawn.lin@rock-chips.com>
> 
> RK3568 supports PCIe v3 using not Combphy like PCIe v2 on rk3566.
> It use a dedicated PCIe-phy. Add support for this.
> 
> Initial support by Shawn Lin, modifications by Peter Geis and Frank
> Wunderlich.
> 
> Add data-lanes property for splitting pcie-lanes across controllers.
> 
> The data-lanes is an array where x=0 means lane is disabled and  x > 0
> means controller x is assigned to phy lane.

Applied, thanks

-- 
~Vinod
