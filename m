Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC775210D4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 11:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238768AbiEJJbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 05:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238806AbiEJJbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 05:31:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3825228B874;
        Tue, 10 May 2022 02:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=BrtBtSFxwxVknHSWi63tk45YlZ
        rup93B0eJxX3AaOamS/adcgHEVr/DEkWJLvo94m/m9dFxqGOHWrfszpdIIemycDTtX6ZCrcTKJWUm
        oL0D8zhHFiuG7HlL8myAi9D28AwS6mJ4JOhkhZ1Ba6RJF8f27MU5OBq0T9HYNU0XmV5uyB530p9tF
        JD207fSwylW5QyRg5Xg0Y3p+uclt3uVfuDuKS4pjSU8Efo5rXWytDk9L2xfPJW4jKxMHIUotaLP5N
        5n+VHBux3Gn7X33sHMQWFkN1FUp/DqrsufWd1DfFXfnXhpL9kKwWfOuKqTlC16a/fQ6IWyu8yiMKH
        iHpdgZoA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1noM98-000onP-6E; Tue, 10 May 2022 09:27:10 +0000
Date:   Tue, 10 May 2022 02:27:10 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-spdx@vger.kernel.org
Subject: Re: debugobjects: Convert to SPDX license identifier
Message-ID: <Ynov7rvbZr52kLTS@infradead.org>
References: <87v8udpy3u.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v8udpy3u.ffs@tglx>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
