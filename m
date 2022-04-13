Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D31A4FF394
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234471AbiDMJgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbiDMJgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:36:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A42053E31
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:33:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC23861AA0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 09:33:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91667C385A4;
        Wed, 13 Apr 2022 09:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649842431;
        bh=hEhA6vlEbgiN/xrO95gWAor7RejqPLSP7eutiio7lyU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bUeCiA6ljOPCKhNZSYEPSmsreon9E4L/fiv5x8KOA5PTYgPjF77h7ViZvfO+MZG1S
         DUJBOw8zLT41y8GIJxWusMpX/gACXHF4QNpK2JwywEgyIV7Bz0E9jOsLmuo9FlwiD0
         wge3TbuEbqPjrB0sfka5+2k6bJpsWj/XfdAQoMKkuuSXC9QLdJOD9+W7Uxn+Vtkg12
         EJPKb+j387t3q4kvQrhmppGoWqCHhfnSpCAq8nl+FGzHLCNj9fN4L4h+jvVpmi3vmj
         9wRscZypVWFNJLySDdj/Wfa03ozdcGfavLjTtAiVozcZOR8Dd4QAQ7AfWo4Lo7P7+v
         hnTgqEDKqF/Ag==
Date:   Wed, 13 Apr 2022 15:03:46 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Liam Beguin <liambeguin@gmail.com>,
        Roger Quadros <rogerq@ti.com>, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] phy: ti: omap-usb2: Fix error handling in
 omap_usb2_enable_clocks
Message-ID: <YlaY+mIN8QAzDd43@matsya>
References: <YjIC1hWuVN3qkdqx@shaak>
 <20220318105748.19532-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220318105748.19532-1-linmq006@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-03-22, 10:57, Miaoqian Lin wrote:
> The corresponding API for clk_prepare_enable is clk_disable_unprepare.
> Make sure that the clock is unprepared on exit by changing clk_disable
> to clk_disable_unprepare.

Applied, thanks

-- 
~Vinod
