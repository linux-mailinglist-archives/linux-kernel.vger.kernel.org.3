Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564794D0459
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 17:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241978AbiCGQno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 11:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242183AbiCGQni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 11:43:38 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A4F35861;
        Mon,  7 Mar 2022 08:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dZ5ezsuEtPttQFdHzk6smo3zWVoSu7+ceMuIlWOmZYs=; b=HxxanOKYrIkyKERJAGiE7BSo/F
        nw/zRMZwV6QO1ZCrfnsTpq52v9qrqMrbte7yL/NVifHFxBOQIjHe5kvab95AbpESaiG0ECtl5nJeg
        D/bfMiY+iZ2KA803m+moPurXBies0z8cDlU4/l3nCPW0y2kRS2yqCcpkJgabbxE2H8FBcaCxqqNHA
        yIJHE9wgYY2DGZpJ32vEZOOgVEDtXO15QBEtwBnvO7Gf9+FHZi5hqWb5FNxuxcJd4b2MfgWvHdBAy
        h+8582DZslTnxKpjHyR57RPI/lX+5Xhc3mh3qzGlIcr27X5rVppJ37R7s4bIRVvDaO1yVlSih5tiY
        9zIJABww==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nRGRS-000sgV-A6; Mon, 07 Mar 2022 16:42:38 +0000
Date:   Mon, 7 Mar 2022 08:42:38 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Daehwan Jung <dh10.jung@samsung.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>, sc.suh@samsung.com,
        cpgs@samsung.com, cpgsproxy5@samsung.com
Subject: Re: [PATCH v2 4/4] usb: host: add xhci-exynos module
Message-ID: <YiY1/tojTSqAbYmZ@infradead.org>
References: <1646648256-105214-1-git-send-email-dh10.jung@samsung.com>
 <CGME20220307101852epcas2p2639761a90e794f0b4a4a842a17ba534e@epcas2p2.samsung.com>
 <1646648256-105214-5-git-send-email-dh10.jung@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1646648256-105214-5-git-send-email-dh10.jung@samsung.com>
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

On Mon, Mar 07, 2022 at 07:17:36PM +0900, Daehwan Jung wrote:
> This is for reference to introduce usb offload as seeing how a user does.
> We only care DCBAA, Device Context, Transfer Ring, Event Ring, and ERST.
> They are allocated on specific address(SRAM) for Co-Processor.
> Co-processor could use them directly without xhci driver after then.

No one cares about your "reference".  Without a real, actual users
crappy hooks like this are completely uninteresting.
