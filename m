Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73FAA5AB7B9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 19:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236821AbiIBRpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 13:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235631AbiIBRps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 13:45:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6463E97EC4;
        Fri,  2 Sep 2022 10:45:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 197F7B82CD1;
        Fri,  2 Sep 2022 17:45:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C9BC433D6;
        Fri,  2 Sep 2022 17:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662140744;
        bh=IAX/zbZD+Vj6cEmd6Mj31B+0iUEHFKmq5HZH2ntSm9k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BFpYYFpS7E6zXL2r+ybhCdFPf+ESX9GfBgobUjrFUW6TdCQCvIs+wEW00xIRUOAxW
         /LXZABLpGh5p5rredDWN/3h9FYjoyKpiAwb3YcaAricxURN67CcIPJKmcU6M1Wwqn3
         6j4iTOB1csYzMve5Dvm2qyG0AlGtjMgokJC8Dd8hTFQWx3jow5DRMu+Q2v86AMMFJY
         DZNIye6lNJz+iy9Ef9A71cNMSJ5HAfNfS0ZUJJCfUoRNrzGRttrTJAn8jo2/OwTTMB
         jf6+vMZ9SD47eZ6v7PIK9469L5P3azPRKV+vkahq7nKOuN8NfX/PB/yf7mq/5phVxR
         5KfzeSQd0IQ2Q==
Date:   Fri, 2 Sep 2022 23:15:40 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, kishon@ti.com,
        sakari.ailus@linux.intel.com, hverkuil@xs4all.nl,
        jacopo@jmondi.org, laurent.pinchart+renesas@ideasonboard.com,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-media@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 1/4] phy: dphy: refactor get_default_config
Message-ID: <YxJBRNk8bqs6QmQ3@matsya>
References: <20220818143307.967150-1-m.felsch@pengutronix.de>
 <20220818143307.967150-2-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818143307.967150-2-m.felsch@pengutronix.de>
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
> Factor out the calculation into phy_mipi_dphy_calc_config(). This is
> needed for the follow up patch which adds the support to calculate the
> timings based on a given hs clock. No functional changes are done.

Acked-By: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
