Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0639E566330
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 08:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiGEGcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 02:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiGEGcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 02:32:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D287B11
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 23:32:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADC176119F
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 06:32:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B1F7C341C7;
        Tue,  5 Jul 2022 06:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657002760;
        bh=+O65Y5o3T7Br8OzntHnLsnqAXOerkRpKxVPoUCxEmxU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JsyPYO8IOUQ4X+4B2XJanvVDRB8u2ae8i3MqCG0ykGHm6CBjdje+BNEyOG+AYrV1h
         P2b89XBD2DavyVaqkYnQRVsLBQ1HxvteKr2pwgp+/NPZhqgkRADmeH4EPmQ80gaXzH
         X6SLdxhVXqp1wSziTUs2kvn9UPL9TTM83RvfWeTttXVIUiMF06Jb5FtXcCwyDl6SSl
         k2dDIpEXjCTYurZuW5EjNojVELxaCURjJqC/R2kzTGTjpt0kXq8XU1hLXCkSsuve11
         ILZGrmI6sw15rXRfWFOVNDSWLxFxCsuXu/uE9wtAkuY7dq/ZZ4P2Ai03ORX09Ikaxb
         RWYpGVf03KB6Q==
Date:   Tue, 5 Jul 2022 12:02:35 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jiang Jian <jiangjian@cdjrlc.com>
Cc:     narmstrong@baylibre.com, khilman@baylibre.com, kishon@ti.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        victor.liu@nxp.com, andrzej.hajda@intel.com,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: dphy: drop unexpected word "the" in the comments
Message-ID: <YsPbA/jCj/nuPDP+@matsya>
References: <20220621120015.113682-1-jiangjian@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621120015.113682-1-jiangjian@cdjrlc.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-06-22, 20:00, Jiang Jian wrote:
> there is an unexpected word "the" in the comments that need to be dropped
> 
> file: ./drivers/phy/amlogic/phy-meson-axg-mipi-dphy.c
> line: 139
> * when in RxULPS check state, after the the logic enable the analog,
> changed to
> * when in RxULPS check state, after the logic enable the analog,

Applied, thanks

-- 
~Vinod
