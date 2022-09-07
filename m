Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB2C5AFCD1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 08:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbiIGGtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 02:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiIGGtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 02:49:02 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5601A83F11
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 23:49:01 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8E38567373; Wed,  7 Sep 2022 08:39:08 +0200 (CEST)
Date:   Wed, 7 Sep 2022 08:39:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Dennis Maisenbacher <Dennis.Maisenbacher@wdc.com>
Cc:     linux-nvme@lists.infradead.org,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nvmet: fix mar and mor off-by-one errors
Message-ID: <20220907063908.GA21581@lst.de>
References: <20220906073929.3292899-1-Dennis.Maisenbacher@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906073929.3292899-1-Dennis.Maisenbacher@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to nvme-6.0.
