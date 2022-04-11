Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792354FBF0F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 16:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347272AbiDKO2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 10:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347269AbiDKO2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 10:28:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7C5396A7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 07:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Y+87u4QYoEsVfA+FHG0tdBUkX/ZdHdh0s0fH1yaPbwg=; b=jpbocxzJOPnRbPSPWl6IBLjSsY
        zjtrkzIPoRqpIX45xb6EC9KckvKhuOBpj+TNsALOJjZRiXhi3XQtB1BV6dsYzAlva5jcd95I3ewFF
        7heZXa7OoZilw26jwcwwKxJauT8E5Oq0G/Er3M93CTna/+XQxFnA7cdeayQYU/ThN3M+K2bVwe2K5
        ekaACOgEBiws7u+b9/invhF3TMxe/Vh2P4nQnLk2lJQD95uNEOO3Axe52RzzBv0aHUH+fsSBPdZaP
        O83ZF07UGd4sB9+bI33xqju4qComliojgddUgT8f3vMZq4teB8WTHJ+x4yIRqJD3bNHhXV3r8fkcf
        60ZCzWsg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nduzV-009OLa-MK; Mon, 11 Apr 2022 14:26:05 +0000
Date:   Mon, 11 Apr 2022 07:26:05 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Change return type of
 dmar_insert_one_dev_info()
Message-ID: <YlQ6feP5Dd9Ux18Y@infradead.org>
References: <20220409133006.3953129-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220409133006.3953129-1-baolu.lu@linux.intel.com>
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

On Sat, Apr 09, 2022 at 09:30:06PM +0800, Lu Baolu wrote:
> The dmar_insert_one_dev_info() returns the pass-in domain on success and
> NULL on failure. This doesn't make much sense. Change it to an integer.

Looks sensibel.  Why not also merge it with domain_add_dev_info while
you're at it?
