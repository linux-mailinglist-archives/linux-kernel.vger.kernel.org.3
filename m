Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E98577A39
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 06:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233190AbiGRE64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 00:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiGRE6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 00:58:53 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2440FFB
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 21:58:51 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2E2B168B05; Mon, 18 Jul 2022 06:58:48 +0200 (CEST)
Date:   Mon, 18 Jul 2022 06:58:47 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bean Huo <beanhuo@iokpp.de>
Cc:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        beanhuo@micron.com
Subject: Re: [PATCH v2] nvme: Use command_id instead of req->tag in
 trace_nvme_complete_rq()
Message-ID: <20220718045847.GB21700@lst.de>
References: <20220715212721.332857-1-beanhuo@iokpp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220715212721.332857-1-beanhuo@iokpp.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to nvme-5.20.
