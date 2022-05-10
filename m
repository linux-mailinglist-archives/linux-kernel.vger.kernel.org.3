Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA6D520D50
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 07:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236804AbiEJFxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 01:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbiEJFxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 01:53:04 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548B82B09EE
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 22:49:08 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5617168AFE; Tue, 10 May 2022 07:49:04 +0200 (CEST)
Date:   Tue, 10 May 2022 07:49:04 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     zhenwei pi <pizhenwei@bytedance.com>
Cc:     kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@fb.com,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] nvme: introduce bit 5 of smart critical warning
Message-ID: <20220510054904.GA10460@lst.de>
References: <20220507065026.260306-1-pizhenwei@bytedance.com> <20220507065026.260306-2-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220507065026.260306-2-pizhenwei@bytedance.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 07, 2022 at 02:50:24PM +0800, zhenwei pi wrote:
> According to NVM Express v1.4, Section 5.14.1.2 ("SMART / Health
> Information"), introduce bit 5 for "Persistent Memory Region has become
> read-only or unreliable".

Given that Linux does not support the PMR, do we really need this?
