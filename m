Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0B35760D9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 13:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbiGOLsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 07:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiGOLsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 07:48:41 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D987639B
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 04:48:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 43BADCE2EEE
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 11:48:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED09DC34115;
        Fri, 15 Jul 2022 11:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657885716;
        bh=mKWhPThcZmP1RLWqrhqBF+ZhH0KatTGFVjzBtLtdpu4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eERiyrRXCg7lr+J2REf2VMzZc1HPKXbJtpBbKd+r+lOBbsWRGYbwiN1+jREtEsA3M
         RSGqId2uDmoYE7OmEa0udZULdp+WAYVYIHTFP3aiNYz9K5TXJgkhUaFKaAdi80WmFN
         VrJDjMHfKUFYKf1Hw7MjZt5WPmLSlg+XJeLxH9QRO4nx6T98It2tAAilvmf6FVx1f3
         CHcdv96gAldK6MS9LUfRSGpkFkyNqxRopxjXPmdrddqs+Cgp4DZYmxN1T7hFMS8hEM
         trd5cCVZd5XX5+rg8ZsUo93P2lyvkuCwajbIFzu3PnEpC8XXdHrY76jAT6c1nB0KE+
         tn6jiZAlXd3+g==
Date:   Fri, 15 Jul 2022 17:18:32 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] phy: rockchip-inno-usb2: Ignore OTG IRQs in host mode
Message-ID: <YtFUEGgOGEQy7duZ@matsya>
References: <20220708061434.38115-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708061434.38115-1-samuel@sholland.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-07-22, 01:14, Samuel Holland wrote:
> When the OTG port is fixed to host mode, the driver does not request its
> IRQs, nor does it enable those IRQs in hardware. Similarly, the driver
> should ignore the OTG port IRQs when handling the shared interrupt.
> 
> Otherwise, it would update the extcon based on an ID pin which may be in
> an undefined state, or try to queue a uninitialized work item.

Applied, thanks

-- 
~Vinod
