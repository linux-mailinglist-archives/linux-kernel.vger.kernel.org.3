Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C13448BD8F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 04:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347951AbiALDNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 22:13:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345682AbiALDNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 22:13:22 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B46C06173F;
        Tue, 11 Jan 2022 19:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GqZYm7HWdr6yksT1bvEeVcz5ehbUC5tSrp2F5WSgbQY=; b=MAFAX+sWiFCQG3op0rOLoxcr6J
        Z8wMYWNY1ybuxtomtpcKpbIFYgfx//FQkOkRFka84sqjMQbJ4WMuqtcAjN57eH1UVir3+T/07LcMr
        3M1wYJpr/SnpvX1vSSyC6kwtcmfVg+Tr2OkVnhs2bqKCP8hCPZBQQHyv1nIzLZrvx6UMtF32oaGwO
        rPUyP4eNhd+JmHJNKAndjFAcSDPzHO9VbCPzixTUEFsgZCJlv86HYI2kVwlKNcx9zxrjlgzZNGzx/
        dWdGWDairmEAPgTbrhyFX7C5leMxTbhR7fhtOauQfhwd3nJ1EwuAahllhHxFSytWzqiSoNi9KBqpX
        RueDwHRQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n7U4g-000zsy-At; Wed, 12 Jan 2022 03:13:22 +0000
Date:   Tue, 11 Jan 2022 19:13:22 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Jessica Yu <jeyu@kernel.org>,
        Matthias Maennich <maennich@google.com>,
        linux-modules@vger.kernel.org
Subject: Re: [PATCH] module.h: allow #define strings to work with
 MODULE_IMPORT_NS
Message-ID: <Yd5HUhgGpWF9AUte@bombadil.infradead.org>
References: <20220108140657.3361237-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220108140657.3361237-1-gregkh@linuxfoundation.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 08, 2022 at 03:06:57PM +0100, Greg Kroah-Hartman wrote:
> The MODULE_IMPORT_NS() macro does not allow defined strings to work
> properly with it, so add a layer of indirection to allow this to happen.
> 
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Jessica Yu <jeyu@kernel.org>
> Cc: Matthias Maennich <maennich@google.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thanks, queued onto modulex-next [0].

[0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=modules-next

  Luis
