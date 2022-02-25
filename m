Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F264C49EF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 17:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242507AbiBYQBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 11:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237269AbiBYQBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 11:01:40 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0459A1F125C;
        Fri, 25 Feb 2022 08:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wfjhhRO+5XQUgZqXRTp6j+39HFHaPTJy/wyfDgOULLA=; b=u96BIZxc+turssbOCVzJwjMepN
        +prbPyjppZFBCcBqcM2h1LK4A0f6gF1ozzaUnu6LZe3hyl/F3fn8r/ne9Ph/RmOfKam0187y6rN5J
        U2SOWvWp3GEhHGIbd72NzwoTwX9SoECBZCkDh33ZTwk075bsWBJYYnD1Pt/q6ja/rV2IoxpSLdPoX
        VtQHBv/cAXe1mZPvc1E84sB25qi+Oi/uKTdezrhBXxjKpIxcbAzHnrcpSTThynVOEWV/5InAQ46yF
        nJs/onZe86RLvJmKnTU8Pxft/pFvNP/V81PWX1bIH0bWnGgzel783pZ5jJFwti+WU/KiklijQWOHC
        vEUuQlGw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNd1h-005mFy-2R; Fri, 25 Feb 2022 16:01:01 +0000
Date:   Fri, 25 Feb 2022 08:01:01 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        pmenzel@molgen.mpg.de, hdegoede@redhat.com
Subject: Re: [PATCH v2 1/3] ata: ahci: Rename board_ahci_mobile
Message-ID: <Yhj9Pdp/sHASmBw4@infradead.org>
References: <20220225061113.223920-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225061113.223920-1-mario.limonciello@amd.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 12:11:11AM -0600, Mario Limonciello wrote:
> This board definition was originally created for mobile devices to
> designate default link power managmeent policy to influence runtime
> power consumption.
> 
> As this is interesting for more than just mobile designs, rename the
> board to `board_ahci_low_power` to make it clear it is about default
> policy.

Is there any good reason to not just apply the policy to all devices
by default?
