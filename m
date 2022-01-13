Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBC4848DA93
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 16:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236050AbiAMPSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 10:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiAMPSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 10:18:32 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A605C06161C;
        Thu, 13 Jan 2022 07:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OQF3wHoqAzbGTdFjiMwWYEVY5YMoXVnPqYxTU0udag8=; b=hsru4/j6NRqL7YN3K/+ryJjg6B
        3uwh+J7ha3K7E2o996pzcqPC2H3eb7BabcTKqTqdOG68Ck1VXjYixGbKByJVO4RqWsufMRfW7QK9w
        IhnggGA7Xb7IabOBBnXRCJnPCxIfCfY74ZxH1sqFFECekVUJgdeWywYwlBaLVwmdlD15oVOyK4Lh9
        blmG/LNPHE5w5ruBDn1KCTJah6lz++PuExfEIFdZgt9TKyy0pPNgK+MkV9ODoZFxmVQAtU77Wo18S
        3wld2uDjZep6X3b4bIPOrnGudDDUuyDmaKCBvlwa49D2Is1bIyfl/ZrVPTIZEptcjO+UUOMtxtmzk
        4EgMJgFA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n81s0-006NEA-3l; Thu, 13 Jan 2022 15:18:32 +0000
Date:   Thu, 13 Jan 2022 07:18:32 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] kernel: Fix spelling mistake "compresser" ->
 "compressor"
Message-ID: <YeBCyAmDymM3drLb@bombadil.infradead.org>
References: <20220113092417.1354537-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220113092417.1354537-1-colin.i.king@gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 09:24:17AM +0000, Colin Ian King wrote:
> There is a spelling mistake in a pr_err error message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Thanks, queued onto modules-next!

  Luis
