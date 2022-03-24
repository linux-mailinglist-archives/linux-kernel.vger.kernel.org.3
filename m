Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1064E5EF1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 07:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345739AbiCXGuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 02:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbiCXGuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 02:50:22 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D6B1B7BA;
        Wed, 23 Mar 2022 23:48:50 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id D480368B05; Thu, 24 Mar 2022 07:48:46 +0100 (CET)
Date:   Thu, 24 Mar 2022 07:48:46 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Kees Cook <keescook@chromium.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        kernel test robot <oliver.sang@intel.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        John Garry <john.garry@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
Subject: Re: [scsi]  6aded12b10: kernel_BUG_at_mm/usercopy.c
Message-ID: <20220324064846.GA12961@lst.de>
References: <20220320143453.GD6208@xsang-OptiPlex-9020> <20220323071409.GA25480@lst.de> <202203230809.D63BF9511@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202203230809.D63BF9511@keescook>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 08:40:30AM -0700, Kees Cook wrote:
> This series removes it:
> https://lore.kernel.org/linux-hardening/20220110231530.665970-1-willy@infradead.org/

If HARDENED_USERCOPY_PAGESPAN is so broken we really should remove it
ASAP independent of the other patches in the series.

