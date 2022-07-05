Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913D5566418
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 09:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbiGEH1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 03:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbiGEH1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 03:27:10 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFADABC3F
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 00:27:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 26715CE1A00
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 07:27:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17F87C341C7;
        Tue,  5 Jul 2022 07:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657006025;
        bh=P9WW1S4fhwQrJAaPn5iB7lNyAya9Q15GecNEfE4VjO4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AXsPunkY4b9NsUuMA7VBjiPtGjsvdUvyy5CDpaDQspcvO9a4o8/LMiB70MUF01Q32
         HNG70OQWCKEEKI8GU1OpOPTpxTll/PR35jSE/7h7iZ/zDl2GhVUta/yH3pXhwa7wiT
         wq2uhBPZDLTAD56zANY4oKr4sHlbhCbjnPwinj4m0MvfIuYbEi8+D6CRn5MR0+RcOA
         IPCxLeWVUlTKbpHtHh/SCQuKPfbqs98jCpTbSt6HzsRtOVNZgZ/IqBp8gyg+Dpf1tO
         5z4JMAEF9GQzoPZXtXK4iZTGg4e7ty+qApMEtiJwqzQPCYQy8MPqGmOGRegu9k/43i
         O0eEaeBLQq0yg==
Date:   Tue, 5 Jul 2022 12:57:01 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: rockchip-inno-usb2: Sync initial otg state
Message-ID: <YsPnxQXKpDJ4MC4a@matsya>
References: <20220622003140.30365-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622003140.30365-1-pgwipeout@gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-06-22, 20:31, Peter Geis wrote:
> The initial otg state for the phy defaults to device mode. The actual
> state isn't detected until an ID IRQ fires. Fix this by syncing the ID
> state during initialization.

Applied, thanks

-- 
~Vinod
