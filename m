Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A32F494841
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 08:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358941AbiATH32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 02:29:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiATH30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 02:29:26 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C38FC061574;
        Wed, 19 Jan 2022 23:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DD4J0NEMsiV0fB4Qh9I3IDqre4XQm8+bbfAjQ2SfAFA=; b=yRQodjPQ0a4xCAT+0HrcBxpd3P
        hUYmiaTF9MBXfBfZsikT+5gKjtPef8c92JccnTFrn6cjMT0qCTAU7X6NavLpHk4JIKJrdaFFvBYXa
        FumBL5P/wOZdSJU5a1R4SncnrxSilRcuowvBsYpZah4xaZwTo1nmVWGDPTqsNk7YhKvau3C1R8wtR
        LPRu4DMlOtKENRVzvwCN3p4GI0bTw9S+2U4IWzeTyV6GiH1FCW31Xwj+Nm7Ya+w1bNhcWZAhuWTPT
        ZxH2sqcm7rtM93cZWeBnT4veXKngsluKHIq63M49hJ/wwJRt8JdEDVuc9k98lEJuX3+UZf5FYAbID
        e6UqcyTA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nARsk-009LOs-EC; Thu, 20 Jan 2022 07:29:18 +0000
Date:   Wed, 19 Jan 2022 23:29:18 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Peter Chen <peter.chen@kernel.org>,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Roger Quadros <rogerq@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-usb@vger.kernel.org, Bastien Nocera <hadess@hadess.net>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v20 2/5] driver core: Export device_is_bound()
Message-ID: <YekPTh/G1IkvpSiI@infradead.org>
References: <20220119204345.3769662-1-mka@chromium.org>
 <20220119124327.v20.2.Ie1de382686d61909e17fa8def2b83899256e8f5d@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220119124327.v20.2.Ie1de382686d61909e17fa8def2b83899256e8f5d@changeid>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 12:43:42PM -0800, Matthias Kaehlcke wrote:
> Export device_is_bound() to enable its use by drivers that are
> built as modules.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>

Didn't Greg clearly NAK this the last few times it came up?
