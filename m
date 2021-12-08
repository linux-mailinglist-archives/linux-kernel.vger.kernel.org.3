Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79EEA46DC6A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 20:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239719AbhLHTqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 14:46:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbhLHTqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 14:46:12 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2929C061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 11:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=D6G63kD+QDj+5KwfLg0nEUgDh2s5bXmOJpC2K2QPQw0=; b=uv83qmjoiD9bWp4iDzzOPvqTYr
        Jd+WY3AfAegU7t8ScgXBsHUndgwyF+9aTz2PT7xPMuUK1OEWn27K25LzOic13kglh2GnvVqxxf41X
        A1fiZ1dlB2GNHuy6UZlTV6U/Z+C5hBpcAahoxU6rJ08Himub4wzdohNOeGan2YHg43NlEAXRiPoTP
        7qUew8Dk8aG5DeC0rNYAQsCthTj/Mk8cBwuFHJeY/b+dA59P0QhY3eATCL79uu+M7cww3NGWrCiFW
        nIzPJnD/h+A7QDEGDO2SZ4RDKVGCOungEpyeAiNT5MDBG3x/2WpuYlCc+FfGREc3r/EecDkuvDrpf
        nPtOT1uQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mv2pq-00E5xU-0a; Wed, 08 Dec 2021 19:42:38 +0000
Date:   Wed, 8 Dec 2021 11:42:37 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Yu Chen <chen.yu@easystack.cn>
Cc:     jeyu@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: Remove outdated comment
Message-ID: <YbEKrXq/ckltjccJ@bombadil.infradead.org>
References: <20211122142648.10842-1-chen.yu@easystack.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122142648.10842-1-chen.yu@easystack.cn>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021 at 06:26:48AM -0800, Yu Chen wrote:
> Since commit e513cc1c07e2 ("module: Remove stop_machine from module
> unloading") this comment is no longer correct. Remove it.
> 
> Signed-off-by: Yu Chen <chen.yu@easystack.cn>

Queued up, thanks!

  Luis
