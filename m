Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD6DD49DF52
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 11:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239379AbiA0KZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 05:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239368AbiA0KZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 05:25:38 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7463C061747;
        Thu, 27 Jan 2022 02:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=4lsnRtGVKhTEs8dFGKbRX50i0T
        qsfKKF7JjZYv8c0z53H6EEyUdZ0sxwl9fckYwmaGriAN4Clfc/5x/7CAQMrkkBub3lptzqSRF5vXv
        EeyG8GPduvsNVZIPYkpPhDwAl35iHODIq2858l3Z+4MzU/xdxNo9EPRGzPesfNo7BPFiS/hzJQ7Gy
        wXxGaPK3yl8g5eaEonwzp9LZTCuhafh4lSL1XEA7zXrnAsHXzsIqIuAao5GV3t3ABHM2HvgXchZAn
        Z5gVF/zUCmtN/N+0981jLGDlGtL3cIrIRizC6axb11HyST+/2i3rctsHiBM2okvC3Ws2G/uuABf23
        UHQx4vNA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nD1y5-00F914-1q; Thu, 27 Jan 2022 10:25:29 +0000
Date:   Thu, 27 Jan 2022 02:25:29 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     John Garry <john.garry@huawei.com>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        artur.paszkiewicz@intel.com, jinpu.wang@cloud.ionos.com,
        chenxiang66@hisilicon.com, Ajish.Koshy@microchip.com,
        yanaijie@huawei.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linuxarm@huawei.com, liuqi115@huawei.com, Viswas.G@microchip.com,
        damien.lemoal@opensource.wdc.com
Subject: Re: [PATCH 11/16] scsi: libsas: Add sas_abort_task_set()
Message-ID: <YfJzGRpTdQ7tU/xb@infradead.org>
References: <1643110372-85470-1-git-send-email-john.garry@huawei.com>
 <1643110372-85470-12-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1643110372-85470-12-git-send-email-john.garry@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
