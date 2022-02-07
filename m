Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1F54AB465
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 07:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244725AbiBGFvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 00:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233796AbiBGE6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 23:58:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D423C043181
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 20:58:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CB0FCB81053
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 04:58:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7703AC004E1;
        Mon,  7 Feb 2022 04:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644209898;
        bh=hmzT2AM8lylqdoXOy+nKuqNdHRMelSGHWNMXUYiaoGc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y8AKHJ9Ng4PD8Gsvp2Siq7XkcHRj1aCI1pdJkjWbi+A30MM0i/XJAuR+VTilS48aC
         ZeBhZPDfS23qr6+AoHQ6exvRUjYJKhKoHyyeb3AhEpP5kExCjCsUqEF9+FClnlOv8o
         5BCytzYDGzOEgKGEQqTLhFD+dHpmXGQBCHNeQE1r9kCakUeOv8HjeiCmV6f5Mipcsg
         3NJTCG+HHclV+jEsywudpA3eY4+yGXPKdbBM6c29Mr5TCvSoU2L+CPijWsa8iE9Ucr
         l8iOXDjT0RblIL7OhFdBkQi7a11PKY/7/lhzhb6SI1Yz8uOzQpAJNt7VyUvPKbYSvc
         9/VxtKWkPv7fQ==
Date:   Mon, 7 Feb 2022 10:28:13 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] phy: cadence: Sierra: Add support for skipping
 configuration
Message-ID: <YgCm5VUGpQZxVUar@matsya>
References: <20220128072642.29188-1-a-govindraju@ti.com>
 <YfqT444YoGBIturt@matsya>
 <1d5c41a8-24aa-3cfb-fff0-c2695102aa91@ti.com>
 <YfseaJADVocxqnOu@matsya>
 <3444e347-2603-6f5b-94de-09642c41fc27@ti.com>
 <YfzERMrPh+TrXr9x@matsya>
 <004e4d00-936f-1e4f-8378-b779ae168c60@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <004e4d00-936f-1e4f-8378-b779ae168c60@ti.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-02-22, 11:48, Aswath Govindraju wrote:

> Thank you for the clarification. I will make note of mentioning this
> from next time. So, just to confirm, if the fixes are merged then v2 of
> this patch series will apply cleanly.

I have merged fixes and applied v2 now

-- 
~Vinod
