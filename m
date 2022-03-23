Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 423C04E4CCC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 07:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241925AbiCWGiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 02:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbiCWGiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 02:38:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AFA71A29;
        Tue, 22 Mar 2022 23:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=dIcO2O5bBX9E+mrtJnriFMKGfN
        ZcdTz5mLp/7l7VJwolhENKm76cr/aEHm9/0WNDH51F1r+pumqzR9Ixs8AwZG//Goy0QF1f8NUk7If
        +wcq761TgoyQI/YSWvhM3hYd8kLogASD3Hhwulv+TlTs5LH8oDN9LpsJIZN6NnrVxoAT2tQvOx5U7
        Wi/+rxvAnXDERrkr5Nj2unwuj4iaTco1r3slbKbJQuqNsawLGg9V8VA2lOLKNRoPTXZKJWy98uAwj
        w9Vk4dKkjO72UosDJ6VqNSZjEe+meNiaSYH+H8uAKY9hspOMP93M2oJlcObmUlxeYEXp/qx2bs1tA
        uPU0bdQg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWubt-00Cr2s-BT; Wed, 23 Mar 2022 06:36:45 +0000
Date:   Tue, 22 Mar 2022 23:36:45 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Kevin Groeneveld <kgroeneveld@lenbrook.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: sr: fix typo in CDROM(CLOSETRAY|EJECT) handling
Message-ID: <Yjq//TsTcrmkp8FX@infradead.org>
References: <20220323002242.21157-1-kgroeneveld@lenbrook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220323002242.21157-1-kgroeneveld@lenbrook.com>
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
