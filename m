Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9607A49DF4F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 11:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239361AbiA0KZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 05:25:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239329AbiA0KZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 05:25:16 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE9CC06173B;
        Thu, 27 Jan 2022 02:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8KPpiZACzbidVKB4Lcq8auZD9JbGpbn9qF1vpT20cAY=; b=euIorKoq4Rzft5YiaYAGvQWIR5
        XGfzTVgNk3tf7QqQ4XTDVLxVP/zi0KA5SlPDnW3a4noNZ6vzMwWnt2uiYeAFNt5x0znlnOkQ7ngld
        jEousgYvOKcocBxp5zLjIgDIuylaX5Ws6WBp8/gYeGcasKOABysre4TyfYkWVC48+R/hcS4aDS38n
        PAU9yG03avgmWig0ZzjbxZvP5cYSEU0ao2D+NEMmFsRI9wkK9UzAbf/0kPL9npx5F9muow3w73fnr
        sGMCvvhd2mBZvSqFpPjrDqiQrMlUQ3RvojvyOqb/2KROCND+79UswcNBXTKHfY/iNbdE5kWu6R8Vz
        dvAxUF3A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nD1xn-00F8x6-8P; Thu, 27 Jan 2022 10:25:11 +0000
Date:   Thu, 27 Jan 2022 02:25:11 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     John Garry <john.garry@huawei.com>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        artur.paszkiewicz@intel.com, jinpu.wang@cloud.ionos.com,
        chenxiang66@hisilicon.com, Ajish.Koshy@microchip.com,
        yanaijie@huawei.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linuxarm@huawei.com, liuqi115@huawei.com, Viswas.G@microchip.com,
        damien.lemoal@opensource.wdc.com
Subject: Re: [PATCH 10/16] scsi: libsas: Add TMF handler aborted callback
Message-ID: <YfJzB4NOIthca7Sn@infradead.org>
References: <1643110372-85470-1-git-send-email-john.garry@huawei.com>
 <1643110372-85470-11-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1643110372-85470-11-git-send-email-john.garry@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 07:32:46PM +0800, John Garry wrote:
> The hisi_sas TMF handler has some special processing when the TMF is
> aborted, so add a callback and fill it in for the hisi_sas driver.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
