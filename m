Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 670434AEC7D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 09:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235016AbiBIIcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 03:32:11 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:39898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241376AbiBIIcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 03:32:06 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1230C05CBB2;
        Wed,  9 Feb 2022 00:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+upS63/manp8aG/GDlDB7YoAD+Y7d+/++pVvGIkneFg=; b=bzPNvSr6pX+GQ6hSByNwNGOvvc
        zNB5TdUf2a5cCLy2kmI0cOtm7yYVhxbdjAoPStO9a7AZtqKG7Z0OoI5ki9h3dTX76KNW5isV4FJBA
        0ErLS2+4sl/HCH8mZRMa5KxTYmDVrmjNviy+MuXNf07LrL7G87k6J44E9dkmkZONYKIfyLsB3VrWO
        Coj7dBWYkmCFy/2tED3x84bEsEENaWrTigC4aCQ75n+lQSFDCzyM862e5P5NtEbHB9FUPQPY00VLw
        pq/CdMzmlB8PNLZmgp/yOT4N3KG4OiS8h+p6RUrHukV2i9kuYboc02CtXxm0/yCDE+ZZbavLwZLdV
        JzlbierQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHiOW-00GdLv-9M; Wed, 09 Feb 2022 08:32:08 +0000
Date:   Wed, 9 Feb 2022 00:32:08 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Barry Song <21cnbao@gmail.com>
Cc:     axboe@kernel.dk, corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org,
        Barry Song <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH] docs: block: biodoc.rst: Drop the obsolete and incorrect
 content
Message-ID: <YgN8CKUoRG4TQaqt@infradead.org>
References: <20220207074931.20067-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207074931.20067-1-song.bao.hua@hisilicon.com>
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

I suspect it is timeto just drop that entire file.  It is so stale
that it is actively harmful.
