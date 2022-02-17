Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5264B9B8A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 09:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238232AbiBQIyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 03:54:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiBQIyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 03:54:52 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E3423969A;
        Thu, 17 Feb 2022 00:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QaKedEj5ii+6DwNo8CGrk0ieUJahKy3wagkYAZjkWLc=; b=WX4jIQFUWdkQlduz1zVnuhK6D8
        sfZPN4ESdngUiUhGmAIJOh4p6xowYnzKfTunJeUEcD+0qklyl4qo5KbTsV2cQCCmjELLEI1k4Tkc8
        Nh3MoYg3EuP3vXUH8X9sTTvkylCbaJCKMs9hlNWic/r8yd/DV9T0xZYdq7zDEGG/vz1pCO9u8nZK/
        /V8yU0ynB3eU+dW8JXzRuYeF1AvJeJZnz06VrNwyBiQD6W2/mjJBYtyTZCg0iVQcjsdAKDQ4nk54H
        nmvUmz4yJD9wjVkT+xaGUJSvuhmDPn3+0pKa02uB8+sbBW7x1s0x1Iz4FMthgrH9PaQarNcJhPn7g
        SwmnkL8w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nKcYe-009cMl-M2; Thu, 17 Feb 2022 08:54:36 +0000
Date:   Thu, 17 Feb 2022 00:54:36 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Wang Jianchao (Kuaishou)" <jianchao.wan9@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <jbacik@fb.com>,
        Tejun Heo <tj@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC V4 5/6] blk-ioprio: make ioprio pluggable and modular
Message-ID: <Yg4NTJnWv7dqO15e@infradead.org>
References: <20220217031349.98561-1-jianchao.wan9@gmail.com>
 <20220217031349.98561-6-jianchao.wan9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217031349.98561-6-jianchao.wan9@gmail.com>
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

> +static int blk_ioprio_init(struct request_queue *q);
> +
>  static struct rq_qos_ops blkcg_ioprio_ops = {

Same ordering comment as for the last ones.
