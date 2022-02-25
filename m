Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDCBA4C4016
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 09:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238490AbiBYI3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 03:29:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238488AbiBYI3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 03:29:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88A8239D5D
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 00:28:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FD1E61C4F
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 08:28:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C3DC340E7;
        Fri, 25 Feb 2022 08:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645777708;
        bh=nhUImlcEfUVQ3AnB3IAWai1Ov9lBtp35vbO8g3TVH4s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sj4sYTRodxHZ6quzQ4MX4ggaH/K8CTJgGyUQW56lEmeyOejLr4AcdIFA4LPaRKrNN
         6pBF8XOgacmoQKyK6A6MGzf/pFgLB8T5tVeKBfveD78mTQBcpyHw7Onl+OHuzZ603F
         RWPWHet4ioaD7BS6J9m6xn5Xc+yOHzPxqFWKyN7TEaszm9sFdHS6YXEecf6/+509Us
         agQVYILEcqSOsU1lBXMjct+k+qISOktl8VYfR9hvIm8tTk4PTGL3JqyK+/Rfs7LV4q
         qrR+38Pml6J7xZQqR1PFbjt9XIBQvmDKjOo73SusOMg2MRbYvbUNXyYZCblHg70yHz
         nzHSVr8nWFKfg==
Date:   Fri, 25 Feb 2022 13:58:25 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     cgel.zte@gmail.com
Cc:     kishon@ti.com, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Minghao Chi (CGEL ZTE)" <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] phy/cadence: Use of_device_get_match_data()
Message-ID: <YhiTKXpJ5a9tWmbg@matsya>
References: <20220214020626.1714696-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214020626.1714696-1-chi.minghao@zte.com.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-02-22, 02:06, cgel.zte@gmail.com wrote:
> From: "Minghao Chi (CGEL ZTE)" <chi.minghao@zte.com.cn>
> 
> Use of_device_get_match_data() instead of open-coding it.

Applied, thanks

-- 
~Vinod
