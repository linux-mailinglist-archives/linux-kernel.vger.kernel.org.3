Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41554E4E0B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 09:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242574AbiCWIVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 04:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235107AbiCWIVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 04:21:38 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784EE657A6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 01:20:09 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 79EF568B05; Wed, 23 Mar 2022 09:20:05 +0100 (CET)
Date:   Wed, 23 Mar 2022 09:20:05 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     monish.kumar.r@intel.com
Cc:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        abhijeet.rao@intel.com
Subject: Re: [PATCH] nvme-pci: Add quirk changes for Samsung X5 SSDs
Message-ID: <20220323082005.GA26611@lst.de>
References: <20220316075449.18906-1-monish.kumar.r@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316075449.18906-1-monish.kumar.r@intel.com>
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

applied to nvme-5.18.
