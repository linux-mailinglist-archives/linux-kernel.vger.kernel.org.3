Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802505621AF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 20:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236562AbiF3SFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 14:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234707AbiF3SFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 14:05:00 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63E6335
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 11:04:59 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id F278868AA6; Thu, 30 Jun 2022 20:04:55 +0200 (CEST)
Date:   Thu, 30 Jun 2022 20:04:55 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jane Chu <jane.chu@oracle.com>
Cc:     dan.j.williams@intel.com, linux-kernel@vger.kernel.org, hch@lst.de,
        nvdimm@lists.linux.dev
Subject: Re: [PATCH] pmem: fix a name collision
Message-ID: <20220630180455.GA17898@lst.de>
References: <20220630175155.3144222-1-jane.chu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630175155.3144222-1-jane.chu@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 11:51:55AM -0600, Jane Chu wrote:
> -static phys_addr_t to_phys(struct pmem_device *pmem, phys_addr_t offset)
> +static phys_addr_t _to_phys(struct pmem_device *pmem, phys_addr_t offset)

I'd rather call this pmem_to_phys as that is a much nicer name.
