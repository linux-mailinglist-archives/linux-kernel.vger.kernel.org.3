Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178A84B52C9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 15:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354935AbiBNOHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 09:07:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234941AbiBNOHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 09:07:39 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBD8A1AE
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 06:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=oAU+VLSaXso0ujzSNwncj9WmEz
        yecfQzHvYbRWOmTGobVhVFC4e9WWlhA8gu0aNSK+SQshBtdyo4/urVl56PSmxAWJ7J9ZUKL+GttHa
        SBXQzqqJIZvmMplYqJHDsEDrfF8w7ysekOLgP4Y2phSCM7wiUKIwbJ6PtvQGSP4fbWTGChvLSVAhs
        m12/LtL2y1+UrqtkCHw8RyCPUAnWPVn1SApA9E41Be2y+jHbBSO1z2UFuCpGP377qprbHuyj0luyf
        lyl3c+C4vJaa8jNkrW/fyLNx8a6NGKVSUi+6wFv5Q6pQu1woliidn74j3OfUKZhXmQMnzU1Nq0apm
        yuVUqOjQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJc0m-00FaTJ-7K; Mon, 14 Feb 2022 14:07:28 +0000
Date:   Mon, 14 Feb 2022 06:07:28 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dax: make sure inodes are flushed before destroy cache
Message-ID: <YgpiIDyNfFTHafhP@infradead.org>
References: <20220212071111.148575-1-ztong0001@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220212071111.148575-1-ztong0001@gmail.com>
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

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
