Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9BD8590B96
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 07:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236579AbiHLFnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 01:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiHLFnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 01:43:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325F1A3D5E;
        Thu, 11 Aug 2022 22:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=egiayMlu6lLFksnMTZyF5mzrNo
        pj+f9KOgRfuPhahpUBXwo0r/knu2oLBsErygNDaH5nJ0Qnr5QlGd/01ZevLHFOq6X9y/q1DTEofz8
        LpRaTQV+jdbjgz+jua2QZGm9DSEI6tSh81CK3pih33jijX3uBOV00lfjmUZXjqUkDCjwp560DJxtS
        1nf4xRAgdDt+h+38lE+MqGtCEUmFqA6/Bt6ouv4K/+YUmnPVWhy/VXwkizwoI2z4uKeb4S7fv8pf+
        5q49XWotbURgUFtiT/G0fGNquoBHlm0jQBDs5w55DYDEu4y4ifh0CR2zgBL4sQlCTAJJgzGp+R655
        IMCNzLIQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oMNRd-00Fq4G-EI; Fri, 12 Aug 2022 05:42:53 +0000
Date:   Thu, 11 Aug 2022 22:42:53 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Rafael Mendonca <rafaelmendsr@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        syzbot+31c9594f6e43b9289b25@syzkaller.appspotmail.com,
        Hillf Danton <hdanton@sina.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: Do not call blk_put_queue() if gendisk allocation
 fails
Message-ID: <YvXoXQPE5u9L5LKj@infradead.org>
References: <20220811232338.254673-1-rafaelmendsr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220811232338.254673-1-rafaelmendsr@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
