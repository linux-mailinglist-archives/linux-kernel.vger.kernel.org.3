Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 109F5494A87
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 10:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241448AbiATJPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 04:15:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiATJPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 04:15:38 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BBEC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 01:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=A/9WmQWO7B9GchEtuY+JTXZWcQ
        CpelZ1CwMSDni3LF+NE1KlLFT3r+5yFUSbyV0L6okwB8w+dGbZ35Wzkxm9pmLd3dRDTr5gotZPtIn
        IkqjAowhuC/JuWqAbhSFPmL9jpU9pknbLJHhMH/wT1ToCd7XYV66UqCqvl2Vth1t/xgoXmAz5ywIn
        BHFldml0v/ApluQf/3wfixVW2QeLXj633sChqfgO7FxuRhoKZe+xriHwUmtgh4lt1OxIbjOB9b2Ld
        gfpjEZXECL0FCOMNlCV8r6gR/zj3+4RAjapOFBaRTIhq4DkVbxYCucR74pSaxNCCBfDMLA0agDqrF
        WvnDtjeA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nATXa-00A8Xe-DM; Thu, 20 Jan 2022 09:15:34 +0000
Date:   Thu, 20 Jan 2022 01:15:34 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v2 11/28] mm: Make compound_pincount always available
Message-ID: <YekoNtQS780arcrD@infradead.org>
References: <20220110042406.499429-1-willy@infradead.org>
 <20220110042406.499429-12-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110042406.499429-12-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
