Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 388E2566332
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 08:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiGEGdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 02:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiGEGdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 02:33:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D976260
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 23:33:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 32E8CB81616
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 06:33:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D8BC341C7;
        Tue,  5 Jul 2022 06:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657002817;
        bh=5gsyNNx8/9no9ENTib+RiXe7ITFvjUXl6MeaqVSqsb0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S7nczGZsoml5YVimtw38q542lymxBncPRvBRo9Gl5ztIBA2gqgi1mVpsRT4Hccc1w
         hkJ+lq1EM7rgfcIhy6LdTH60xae3NP5A9fPvohTvB+W6RLxQu1J0y1DBjQtju/kv/x
         n4ogrsFZqJfS5kRtoClUuBm0vpKnVlGYjxaSoyrqgvib39coV1XaM4azo05+dmgctE
         A8/24ZnvzHrofTj+/IyVkBbTT6dNWQpXI0FD4qS+yois9TDAPjzMgkaCB+5bBpNfe5
         F+EeH+WuXP1kpg/DUTwKzkrKtZC69ict1c0kreqIZBoYUyqp9Y9OgTYXsNX+yphV1b
         IXgOJ+MWnoUjw==
Date:   Tue, 5 Jul 2022 12:03:32 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] phy: rockchip-inno-usb2: Prevent incorrect error on
 probe
Message-ID: <YsPbPPsMb0O9LTr3@matsya>
References: <20220625212711.558495-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220625212711.558495-1-pgwipeout@gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-06-22, 17:27, Peter Geis wrote:
> If a phy supply is designated but isn't available at probe time, an
> EPROBE_DEFER is returned. Use dev_err_probe to prevent this from
> incorrectly printing during boot.

Applied, thanks

-- 
~Vinod
