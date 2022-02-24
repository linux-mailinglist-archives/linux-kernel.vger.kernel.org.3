Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCD74C2D48
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 14:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235092AbiBXNhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 08:37:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbiBXNhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 08:37:39 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8083CBA75E;
        Thu, 24 Feb 2022 05:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7aqAN+NnpSZwwrMPtcPE7dlz5yuJbDqnRPGeamokN7A=; b=iaKEbDa0RehVT2n/UtmhsOiWkM
        RLzlnEiXS7WJuTIGDJgFWZzjcUn5UhP+Y7HpnumyVomHkDenClOrwkCLnmCB/0za8ed1ephspviwo
        F0sm1YJAx6QUVndteHidVIzcOIFT0x4izXs8aPmrYy5yC+OATcvTRYVM0Kn8OhXH/JShcRRWPELxi
        tGL+VHKekgHK+4KH+0Uq+SVfcPoKo7LJkYRAkBqzLNUiMiTOM44D2A1OVs2ZU6s4CT8WGiVFe0MEA
        SDC/WKkiUfgEn0vCScjy16Agf15nVb5MPRbltFGc43UkIn13H3HinSwXXzVrXTjMZ4wzp2yEDwatT
        F8FN1NJg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNEIp-000xaN-O3; Thu, 24 Feb 2022 13:37:03 +0000
Date:   Thu, 24 Feb 2022 05:37:03 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Wang Jianchao (Kuaishou)" <jianchao.wan9@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <jbacik@fb.com>,
        Tejun Heo <tj@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC V5 0/16] blk: blk-rq-qos framework refactor and cleanup
Message-ID: <YheJ/8W3LM0U23gl@infradead.org>
References: <20220224090654.54671-1-jianchao.wan9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224090654.54671-1-jianchao.wan9@gmail.com>
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

On Thu, Feb 24, 2022 at 05:06:38PM +0800, Wang Jianchao (Kuaishou) wrote:
> Hi Jens
> 
> This patchset is working on our v4.18 kernel to provide the capacity
> for upgrade blk-rq-qos policies on the fly w/o needing to restart
> machine and applications.

Why would you upgrade kernel code at runtime?  And how is what you do
on some randm old kernel relevant for mainline?
