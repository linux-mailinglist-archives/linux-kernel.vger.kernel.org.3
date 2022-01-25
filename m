Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E208349B53C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 14:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389171AbiAYNkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 08:40:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386420AbiAYNhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 08:37:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBB1C061748;
        Tue, 25 Jan 2022 05:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hIWwu7CZHoqXC33UGi3MUTqAEWUOsFTRpTUBCT7WnHs=; b=V1Pkn7653tgtgPGveH+VmAJb8P
        JneUFzY5tzZW+hK5YC2E4wglaygLKzwoMcKLLqpmH3STe/DK3eT8OP+WqgPHOB8YFR2NPOR4jD4iu
        jgncI+6thbj9FCmzMg7gRrHxfIwHj378nk9L8aD35LRNJH4gs3B0Gt9bvN1bLBauzDKWXSe0QgG7I
        yUBQ/Dog3pZd1e6UX/qmuMe8lAzx6sfFBNY4ozLo6M2uRqmSj4FkcKoaxv/AFyojnPe7ttY6TIvVI
        uVs0aY5l2tTXy/RvhvtisYr7YaTfCC9i1+pv6slMX668samW7c52CBb2yuWKoKvaAeqC1fsHL1B9z
        Zn2SZc1Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCM0k-002rKG-AM; Tue, 25 Jan 2022 13:37:26 +0000
Date:   Tue, 25 Jan 2022 13:37:26 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     John Garry <john.garry@huawei.com>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        artur.paszkiewicz@intel.com, jinpu.wang@cloud.ionos.com,
        chenxiang66@hisilicon.com, Ajish.Koshy@microchip.com,
        yanaijie@huawei.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linuxarm@huawei.com, liuqi115@huawei.com, Viswas.G@microchip.com,
        damien.lemoal@opensource.wdc.com
Subject: Re: [PATCH 05/16] scsi: libsas: Add struct sas_tmf_task
Message-ID: <Ye/9Fs+JrtlMC+Mb@casper.infradead.org>
References: <1643110372-85470-1-git-send-email-john.garry@huawei.com>
 <1643110372-85470-6-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1643110372-85470-6-git-send-email-john.garry@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 07:32:41PM +0800, John Garry wrote:
> Some of the LLDDs which use libsas have their own definition of a struct
> to hold TMF info, so add a common struct for libsas.
> 
> Also add an interim force phy id field for hisi_sas driver, which will be
> removed once the STP "TMF" code is factored out.
> 
> Even though some LLDDs (pm8001) use a u32 for the tag, u16 should be
> enough.

... because pm8001 limits the number of tags to 1024.
