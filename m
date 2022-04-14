Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06AE501736
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 17:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350728AbiDNPYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243589AbiDNN7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 09:59:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138CD1FA7F
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 06:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4/pEuKJD0exhbqhQFiolMt3v3y9R1XnuywsaVJyyU3c=; b=VN5ehUVtLeYYIJZAHbj1MDO9cp
        vuBGPIuMjPTKe+xsl/n8nVGc5LWY9Z58eKgDAVEIZBmzh+YZRLF6E8nUNOntDhMSoHDJ4FPTeBE+v
        NErQ4//4Cz4/dxcR3lDj8i+TrqNSaUUKe0RxKx8lxsKFKub+RtNbyLzKvRI/k8Hsm3xeYABFL6Oco
        iDTZpZJOAQOfzZeGWKW3ZiGelmquBdaTWd2ZhZ7lZWTONFHgWdmMqV8uyhCSvLs0gZBSqxq+U9mPC
        psnPmOZsIGH/CofotiGjfMJ86EbTMJQUnXPJyp4u7urXKko1DWNHuQwQHZSfVklLM3qOQh5eO8JR3
        Ce7UOAVg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nezwa-00FBD7-3W; Thu, 14 Apr 2022 13:55:32 +0000
Date:   Thu, 14 Apr 2022 14:55:32 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Liam Howlett <liam.howlett@oracle.com>,
        Yu Zhao <yuzhao@google.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 00/70] Introducing the Maple Tree
Message-ID: <Ylgn1LNM/iCZ2sfU@casper.infradead.org>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
 <20220413235051.3a4eb7c86d31656c7aea250c@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413235051.3a4eb7c86d31656c7aea250c@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 11:50:51PM -0700, Andrew Morton wrote:
> Several patches were marked
> 
> From: Liam
> Signed-off-by: Matthew
> Signed-off-by: Liam
> 
> Which makes me wonder whether the attribution was correct.  Please
> double-check.

I'll take responsibility for at least some of those confusions.
As you might imagine, we've collaborated closely for several of these
patches, and I may not always have got --author right when re-writing
a patch.  I don't think it fundumentally matters; nobody's promotion
is riding on who gets credited for which patch ;-)
