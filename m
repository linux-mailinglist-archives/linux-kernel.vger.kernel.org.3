Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF82489445
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 09:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242441AbiAJIvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 03:51:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242016AbiAJIt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:49:28 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B72C02982F;
        Mon, 10 Jan 2022 00:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=JilVrNRN2CPQ5GOttA5vJd8GKj
        rAqlhmrMZhPWmJCRMHNYc2VbpHZAHA8u+rEGGVdsg0SlOxPcVpt4wtCpXDh4EROWQK2yIkg/fPjLT
        LdFIQBrzdfuXHrr8/vfUkjoDgzIlYogahHNCeY03Woezacz1htO5YmKFL0lHT81gmcvHhyEMpJMj9
        HW2xua/Y+V1JUj5kSi0HaJ4BnFEe0nICMDQusldvngQlCnXU0nGKgHyEkL9mhZRNYAOxCD1N7dOCX
        0CHfVHjGBTlX3oYV+AZlL3KAwZaoF6uTcpdKLtGECdVld4W/CkDXwAWHRof3qa8+tEp9+u87hKwDb
        Hp+37Dgg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6qLR-00A1ce-JS; Mon, 10 Jan 2022 08:48:01 +0000
Date:   Mon, 10 Jan 2022 00:48:01 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     arnd@arndb.de, hch@infradead.org, akpm@linux-foundation.org,
        sathya.prakash@broadcom.com, sreekanth.reddy@broadcom.com,
        suganath-prabu.subramani@broadcom.com,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 13/16] scsi: mptsas: Use dma_alloc_coherent() in
 mptsas_exp_repmanufacture_info()
Message-ID: <YdvywZI+Hm8sIpSz@infradead.org>
References: <cover.1641500561.git.christophe.jaillet@wanadoo.fr>
 <d78d4a5b096897932808ed7e3a4540db1687c25d.1641500561.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d78d4a5b096897932808ed7e3a4540db1687c25d.1641500561.git.christophe.jaillet@wanadoo.fr>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
