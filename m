Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5B94C8636
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 09:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbiCAIRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 03:17:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbiCAIRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 03:17:41 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42AEC85BC9;
        Tue,  1 Mar 2022 00:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OvB2N8uwUWiqh7KU3u7tlH5CR5GU2KZPJ8qghHMswqU=; b=vxfKFQJD0/y1eEjix7v7uWnCAg
        Y8yte/g0fZr+B1EDvHPb1gAv+2Q21S0V++4YqZEUaj7AQncPD9INwReuUfXu5waYVsVFsDLDGG2Fd
        BVfZ8nSV/Jgypr+VtADqIhjgNWdC1QTzszI/zM9FpK4Gj3NPZCypxM0h5a2nRAmSLLsvIiZU9xjC6
        rTRq9bAdc9VGaNDu3QJnKcGMATXgWWlISMWhuqywF/eNKaA9aKDME9TkxnLvYD7ghHL0YXNA+rCws
        FQAx7t46dVub2mZRD8dq3Vt8wjNUStLLsE2lG6QOvjyLW51ibLXNZcYk6HHgA0OLPVAIQPJyT77IV
        IZbhkOYA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nOxgk-00FXz5-V6; Tue, 01 Mar 2022 08:16:54 +0000
Date:   Tue, 1 Mar 2022 00:16:54 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, hdegoede@redhat.com,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/2] ata: ahci: Drop low power policy board type
Message-ID: <Yh3WdvBYRTdXkyuk@infradead.org>
References: <20220228213302.2915071-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228213302.2915071-1-mario.limonciello@amd.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I really like this and hope it can stick.  Needing quirk lists for
sensible power policies is a bad thing.

Acked-by: Christoph Hellwig <hch@lst.de>
