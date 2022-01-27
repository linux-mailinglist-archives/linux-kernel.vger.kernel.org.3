Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2804449DF55
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 11:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239402AbiA0KZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 05:25:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239368AbiA0KZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 05:25:53 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B47C061714;
        Thu, 27 Jan 2022 02:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=X5ynarJdcNVwdOpjRCtHoAZDw7
        bxlHTQU4Lh9rIF7PhAHkYQ3K8Ckz2SRNhcJUlSq/wdFPwJnGKQQDNSWDKp6uwq99MFQLTBZmlSyF0
        1UvzS7ZhoLfhwP09uWtFi3HQAZzqBMKqEp3/JxztbX/QbGv/C3gjVKzhru5QL8L7tV8lclfkoEcOC
        V+GFYhtHpduIPjJXv98Ry38Hswje5JGQJ8jvwiPF0coqqOrcn7/l9+STNHRAXslifjnOcOTt4xccj
        8G+oBeG2vhpAlarlvwyvsCH1G7aHOcRlZfj+BUpUcg/VZgYzDVu2vdtfkCCX/0+aWZKrygMGlFmwu
        su1UWcBw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nD1yM-00F95l-S4; Thu, 27 Jan 2022 10:25:46 +0000
Date:   Thu, 27 Jan 2022 02:25:46 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     John Garry <john.garry@huawei.com>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        artur.paszkiewicz@intel.com, jinpu.wang@cloud.ionos.com,
        chenxiang66@hisilicon.com, Ajish.Koshy@microchip.com,
        yanaijie@huawei.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linuxarm@huawei.com, liuqi115@huawei.com, Viswas.G@microchip.com,
        damien.lemoal@opensource.wdc.com
Subject: Re: [PATCH 12/16] scsi: libsas: Add sas_clear_task_set()
Message-ID: <YfJzKqugZZJDsJ4m@infradead.org>
References: <1643110372-85470-1-git-send-email-john.garry@huawei.com>
 <1643110372-85470-13-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1643110372-85470-13-git-send-email-john.garry@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
