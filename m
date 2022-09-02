Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1355AB7BD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 19:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236665AbiIBRqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 13:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236387AbiIBRqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 13:46:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019DDD4BF0;
        Fri,  2 Sep 2022 10:46:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E3066220F;
        Fri,  2 Sep 2022 17:46:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A9F1C433C1;
        Fri,  2 Sep 2022 17:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662140760;
        bh=fTXcf2TIdAF6mJdGL4ZlTKOAGo0bqmITSBW1GWDdEIw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X7vTjxLCFl7Pw7/RP0dWQRvBqb8JHaI2uU2PjN7SjdbeACyAPxlBHowD1bShJJYEu
         t1UTxEaa4t4nPDNc/QFWPp9FD6gctQfc5aImkGlPvyHkJgGuGqf8+LEeTke8mptJx8
         GnV5yiitAafCjQjoAaaFHQ6KRKlkbVvayzyhQj9gWxh0kLwYQjrKupTnfslSo8UiEy
         aMV8rg/EHlieYb98VbBFY6EgOHh43OXOg8tpGpwXIKFSJ1/ihyNsJGl1O3zQJ4EYRu
         IzSI1/q1mbVdjFQjkhsoyUCt97Yg9i2xjqz1TYa8N3QmeLoXpb3XpYgbscViVecra5
         ixaDE1a8GxVAg==
Date:   Fri, 2 Sep 2022 23:15:56 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, kishon@ti.com,
        sakari.ailus@linux.intel.com, hverkuil@xs4all.nl,
        jacopo@jmondi.org, laurent.pinchart+renesas@ideasonboard.com,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-media@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 2/4] phy: dphy: add support to calculate the timing based
 on hs_clk_rate
Message-ID: <YxJBVHJPo+J6EsDD@matsya>
References: <20220818143307.967150-1-m.felsch@pengutronix.de>
 <20220818143307.967150-3-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818143307.967150-3-m.felsch@pengutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-08-22, 16:33, Marco Felsch wrote:
> For MIPI-CSI sender use-case it is common to specify the allowed
> link-frequencies which should be used for the MIPI link and is
> half the hs-clock rate.
> 
> This commit adds a helper to calculate the D-PHY timing based on the
> hs-clock rate so we don't need to calculate the timings within the
> driver.

Acked-By: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
