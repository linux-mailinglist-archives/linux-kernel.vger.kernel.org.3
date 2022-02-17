Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C314B9B55
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 09:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237981AbiBQInb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 03:43:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237909AbiBQInX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 03:43:23 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98E9222DC9;
        Thu, 17 Feb 2022 00:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=srOPsA2UG/DyG90LXGGf2coqIfcpStSnhfATvzutOpo=; b=Oi0y9I30bfF8XTa3KuI8sK89ov
        Db1xrUrYgQ3MvGtT9SGZrjouxcnZR4obZFG9Oynu8WSAjGon5BgzYF0IddnJtDkPknFPhyEGCrAhg
        IAYH+oh5OVt1k/pa4wnP7ELans2RzRVZJXewnuzu9FkGgbubxsfTsGUsCGgz4QU4sPOre7ITEcl+E
        5gsjiHpYf5jcZgkJwAv/mQm1kjRCztwdTdNQIZHz6G+XsRwVyIYzWie7L/X3hTZPiUliIi9Y5HgfT
        pbEmBI629DkZ/COtR/fVQtRzj3mv+WbLP83gscr1yVg7JBRqRQKoyGlJr8ei00wUPvBbmF1NNGuOq
        MU5o5UOQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nKcNT-009X9N-Qc; Thu, 17 Feb 2022 08:43:03 +0000
Date:   Thu, 17 Feb 2022 00:43:03 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Wang Jianchao (Kuaishou)" <jianchao.wan9@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <jbacik@fb.com>,
        Tejun Heo <tj@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC V4 0/6] blk: make blk-rq-qos policies pluggable and modular
Message-ID: <Yg4Kl6EHWS5N3WoH@infradead.org>
References: <20220217031349.98561-1-jianchao.wan9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217031349.98561-1-jianchao.wan9@gmail.com>
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

On Thu, Feb 17, 2022 at 11:13:43AM +0800, Wang Jianchao (Kuaishou) wrote:
> Hi Jens
> 
> blk-rq-qos is a standalone framework out of io-sched and can be used to
> control or observe the IO progress in block-layer with hooks. blk-rq-qos
> is a great design but right now, it is totally fixed and built-in and shut
> out peoples who want to use it with external module.

And that's got.  External modules do not matter.

That being said this series has a bunch of nice cleanups, but we really
do not need the exports and modular build.
