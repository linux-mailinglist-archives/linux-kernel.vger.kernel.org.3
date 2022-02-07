Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11FA14AB562
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 08:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240436AbiBGG6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 01:58:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiBGGpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 01:45:09 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E485FC043184
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 22:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hjWf60JMAVQJhgmfPlSAZ5+/ceseer8Z60uDPAGgkAM=; b=pXzzk49YMnKOxHpmbc1xBRgNAL
        Ujjdd1Q+r1Gjl7lGPov+1N+OOEbrvHtVbAfEyYQO77jxzH84Ia7qA1WQoF9TDMvc9LrfuFSjMzG6i
        6VbmkrhCNvBRqB2CwPGbKMZ3ctisrbKiSjrk3dEGRuBe2APNAlNgfzCxU3OIlk3eBAhCB5n9CbM5b
        Lj49nzeWXJ1EfaM10qescnIfoa8ioXZuDLSRk5Ezh84PAUtgDgGcDB3qotgIrnPIBlEQ6ukIf/VRX
        4G1lvmG8+Ujb3sn2am0knaGYQD+j5rHpvnwNCpFVlcftMRoVJJ09VwRuennleFVgZt60ASDVTbkHQ
        kAtwVylw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nGxlq-009B91-SM; Mon, 07 Feb 2022 06:45:06 +0000
Date:   Sun, 6 Feb 2022 22:45:06 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Stafford Horne <shorne@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Randy Dunlap <rdunlap@infradead.org>,
        openrisc@lists.librecores.org
Subject: Re: [PATCH] openrisc: remove CONFIG_SET_FS
Message-ID: <YgC/8ng5WX6Nt104@infradead.org>
References: <20220206013648.3491865-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220206013648.3491865-1-shorne@gmail.com>
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

On Sun, Feb 06, 2022 at 10:36:47AM +0900, Stafford Horne wrote:
> Remove the address space override API set_fs() used for User Mode Linux.

This ain't UML :)

> +	return size <= TASK_SIZE && addr <= (TASK_SIZE - size);

No need for the inner braces.
