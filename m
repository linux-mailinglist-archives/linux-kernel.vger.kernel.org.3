Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0933549CE0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 21:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347702AbiFMTIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 15:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347664AbiFMTHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 15:07:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA728D31BB;
        Mon, 13 Jun 2022 10:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SF1l8Qz9/K72VhTgB8P+cXYCh+NrzEDi0Nkv+Tnn95E=; b=2WazOj0lkc3ICz6cVZvBtYACLd
        4SQ27dxYrNgXbdKdxDe3MW+VhdKfKPRMOuRgeDgzZtF8Xk++XRjJbMtoJt89z4jVdQcJvfKkep7eO
        anW+SEfaoQk1gHJuwLo9oajAL+phHwApEgqL04CUy45JRosropHICdKvOnqpCUGxt2XhDTVv4Dn8j
        3tzOXVdb75Erel+ya0cY08wt9KLFGSoLMShjvsQ0CV/QUw/Z8E1aTUet1a/C7ksRWKtscH1UXJfjn
        jzS1u2hrINGbPzZISFvN1p1gI13sGQ5EWTVafddc0BfunDigSuZCPTKfL79XciZU9BbV0FT6zfevl
        GPqRTOYg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o0nSF-004oyL-SP; Mon, 13 Jun 2022 17:02:19 +0000
Date:   Mon, 13 Jun 2022 10:02:19 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     =?utf-8?B?6LW15q2m5LqR?= <zhaowuyun.zwy@alibaba-inc.com>
Cc:     axboe <axboe@kernel.dk>, jejb <jejb@linux.vnet.ibm.com>,
        "martin.petersen" <martin.petersen@oracle.com>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block: peek PM requests during runtime PM
Message-ID: <Yqdtm9LtSVyjpJnS@infradead.org>
References: <4a2754ad-d76d-482f-9337-5364d46cd38d.zhaowuyun.zwy@alibaba-inc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a2754ad-d76d-482f-9337-5364d46cd38d.zhaowuyun.zwy@alibaba-inc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

What tree is this against?  Neither elv_next_request nor
blk_pm_allow_request exist in upstream, and haven't for a long time.
