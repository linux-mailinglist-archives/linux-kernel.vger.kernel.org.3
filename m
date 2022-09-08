Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84D05B1D06
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 14:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbiIHMbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 08:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbiIHMbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 08:31:06 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD16FFD233
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 05:31:05 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 1CCF65C009F;
        Thu,  8 Sep 2022 08:31:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 08 Sep 2022 08:31:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1662640265; x=1662726665; bh=Md
        V0qKoHOlwl2QfutWs5dt4KXVZS5mtyiU/1CzsgRp0=; b=K4XWwenyfokwJHOJMX
        rC7lO6bhF8C8DHkZ22Aa2A45k3CQ4VW9U52oPByZA24zk/5RlcYFQfxNzLIGlyX5
        TxKmog2y0LBxmR17X6mGlpVTYiZ8Gsab0WmS/jpUkqeFGhscfYklrjrm3BK6deUu
        9939z5wzvTvnYLSQ3L+g2Kgx2mujtk1Ckqe/MEWygS0P6JfmIZNhLhHPMGINCOLr
        Mc/0AD3HSwYfqF4vViRMx6c+idh7nseWQ4XHpRy8U1JNlRvLylWI9LeUlKPHjXPr
        IcwHA7WFaFhUQxkmPpY+J9IMfR/6imkGWyqDnyuUQLzVYmCc7bK39nF2PL4WW+es
        nF3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1662640265; x=1662726665; bh=MdV0qKoHOlwl2QfutWs5dt4KXVZS
        5mtyiU/1CzsgRp0=; b=A26k42YFpzUq5qLZHmPK0fUqcYknidcmqAEetm9GTQfS
        pG1YIK9T87DrOzRxsGTCcZJPLfgG3ffeYuijnYdm/HYsy+uW2zwwHrDFpTFxdCWu
        D9YzOARL6x6wetvaD3hWlAKzSfgrzWoCF4SpeIoUfrEm5HW0tbt1jxZRrzlmGXnr
        xo7oacXYdnCLWZExCJ1ugefWR7XTgaoIQVVILJPpZfIFKDw3CLp6bb+MGHWLRAIf
        btmRmtAsHP94AnykzszzsYiJqBs/A/gTJiQ/KpqVgCQbaLHUfh6nOqg2LRqBTU8B
        vlAS6OtN2dMPRnaLl796B9X4495KVrke3F2LhuwG5g==
X-ME-Sender: <xms:iOAZY4K03CK4cR2qd_NQqGvvooP41yLcJuBjgPEFtPTt_FuWWqHEog>
    <xme:iOAZY4LD840pOmEV-jAnSfu3z3PeQtp6WoOoTAdHcXNbm5xcH3fuekXIfapoj9zVq
    QVfmTP-JoqBEOkrjdw>
X-ME-Received: <xmr:iOAZY4tiqWFMpCOPXLSrFMsVG69QvEDcYfSAuxl5JW7ULZPBHvM-aUBbzrPdq-aVYHYPag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedtvddgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:iOAZY1ZDr2rp2071VXQWBqWBkqeoITYPpqcHTzwz4fRaqn-7Gon_aA>
    <xmx:iOAZY_azqsaWyLPm4UM8ezW5Ev5yW4FH7jHYkg23N-blTnxiwO-P-A>
    <xmx:iOAZYxBADLB-qD9SCk6hq0D4lY6C07zyGw92aB5woI7rAGnuvyWOug>
    <xmx:ieAZY6w0qVY7hld9KezyTdbGCoqnuPZFiOWxCacGBmVrW9GOCMuo_Q>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Sep 2022 08:31:04 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id E53B21037A1; Thu,  8 Sep 2022 15:31:02 +0300 (+03)
Date:   Thu, 8 Sep 2022 15:31:02 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v2] mm/huge_memory: prevent THP_ZERO_PAGE_ALLOC increased
 twice
Message-ID: <20220908123102.rpihrmisv55j3b2o@box.shutemov.name>
References: <20220908035533.2186159-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908035533.2186159-1-liushixin2@huawei.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2022 at 11:55:33AM +0800, Liu Shixin wrote:
> If two or more threads call get_huge_zero_page concurrently,
> THP_ZERO_PAGE_ALLOC may increased two or more times. But actually,
> this should only count as once since the extra zero pages has been
> freed. Redefine its meaning to indicate the times a huge zero page
> used for thp is successfully allocated.

I don't particularly care, but it is not obvoius why the new behaviour is
better.

All huge zero pages are freed apart from possibly the last one allocated.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
