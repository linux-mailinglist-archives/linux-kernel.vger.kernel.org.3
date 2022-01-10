Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB49489089
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 08:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239149AbiAJHLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 02:11:10 -0500
Received: from verein.lst.de ([213.95.11.211]:37037 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230433AbiAJHLI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 02:11:08 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1EF4068AFE; Mon, 10 Jan 2022 08:11:04 +0100 (CET)
Date:   Mon, 10 Jan 2022 08:11:04 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, Christoph Hellwig <hch@lst.de>, lkp@intel.com,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Smart <jsmart2021@gmail.com>
Subject: Re: [mkp-scsi:for-next 67/132]
 drivers/scsi/elx/libefc/efc_els.c:73 efc_els_io_alloc_size() warn:
 sleeping in atomic context
Message-ID: <20220110071104.GA625@lst.de>
References: <202201082354.iAG3UuiL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202201082354.iAG3UuiL-lkp@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So while this warning is correct, it is not new.  GFP_DMA can sleep
just like GFP_KERNEL. Someone was already trying to give this a spin
on the linux-scsi list, but we really need maintainer helper here.
