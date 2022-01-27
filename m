Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0B4449DF4C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 11:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235393AbiA0KYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 05:24:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239329AbiA0KYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 05:24:53 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76EBEC061714;
        Thu, 27 Jan 2022 02:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=izqOD5F8dA92uJDmNjo9GhAw3p
        S88FtqXCWnuhoX+1R9GOs6TgF31g4uMx8R41YYHvjAfrBg/P5/S7GQ6LwBHPe95QLzQrw7FmEteJQ
        amsWqATk5Y89fP96bzmTHe+ByMH1uKybQ57kmhXP7OGMSK0GEQvHW7NkrJtc7cWFFtu6KOBrlCJzI
        D7cYE/B2Knd8tlRcB0LgGkoOWldpQ+ai6+vGNM+5finxF8Fg2NYFPse4MJNzZLvMiVxeb5+xCKbax
        cA73SncXYZ16zRLR7Vb/4qekXW1OrIIiX/pjV4jkiiq/Hp68W5IuDZi5I18mOLJMVae6/z5tzc2QJ
        j4yz4hfA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nD1xM-00F8sM-LE; Thu, 27 Jan 2022 10:24:44 +0000
Date:   Thu, 27 Jan 2022 02:24:44 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     John Garry <john.garry@huawei.com>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        artur.paszkiewicz@intel.com, jinpu.wang@cloud.ionos.com,
        chenxiang66@hisilicon.com, Ajish.Koshy@microchip.com,
        yanaijie@huawei.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linuxarm@huawei.com, liuqi115@huawei.com, Viswas.G@microchip.com,
        damien.lemoal@opensource.wdc.com
Subject: Re: [PATCH 09/16] scsi: libsas: Add TMF handler exec complete
 callback
Message-ID: <YfJy7ErwskYng6wc@infradead.org>
References: <1643110372-85470-1-git-send-email-john.garry@huawei.com>
 <1643110372-85470-10-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1643110372-85470-10-git-send-email-john.garry@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
