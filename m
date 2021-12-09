Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B20E46F6B4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 23:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbhLIWXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 17:23:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhLIWXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 17:23:37 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC54C061746;
        Thu,  9 Dec 2021 14:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NAo2bHCGDeEK5Bqsf+dGhQmWcFTTb/rlSMp2qdc8fr8=; b=VLzpRAp8+3ctmcn6q/R2xix/ar
        eaBJFCK0/pmj5II+biw31fXiN5PifLNYERWepLBCAkPY/FLDLFXtICkajY61DR/AkfBRf0v1hNr5V
        1qHrg2F9V9W8SseNenMQ/1mpQuj/1Gqdpa2AHXM9dLQP7Fv358/Dzi1lBqhlLHwnQq3bojVJM7PCn
        Mt/v0QvgLYEO2TkKiIDh5z6gXkt9GidLDOsYAKHGHbVknjf6yhsMIr+4cnb97o0n9NG+UaYbW+053
        yEelL/edkkzLI02r7E1OFrT04HR4bolLL4xSqEdFT+SrLRR9vU0V+wOp2jSxI3Jqf25FuERRzMZeo
        NXkL2gjQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mvRlh-000DnB-7T; Thu, 09 Dec 2021 22:20:01 +0000
Date:   Thu, 9 Dec 2021 14:20:01 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org
Subject: Re: [PATCH v2] MAINTAINERS: Remove myself as modules maintainer
Message-ID: <YbKBEZ5Fuo1JY3h9@bombadil.infradead.org>
References: <20211209084313.10621-1-jeyu@kernel.org>
 <20211209165953.wohokahzh5z6tnw7@ldmartin-desk2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209165953.wohokahzh5z6tnw7@ldmartin-desk2>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 08:59:53AM -0800, Lucas De Marchi wrote:
> On Thu, Dec 09, 2021 at 09:43:13AM +0100, Jessica Yu wrote:
> > Luis has done a great job maintaining modules so far. As I'm planning to
> > take a break from work soon, I think we're ready to transition over fully.
> > 
> > Signed-off-by: Jessica Yu <jeyu@kernel.org>
> 
> Acked-by: Lucas De Marchi <lucas.demarchi@intel.com>

Queued up on modules-next. 

> Thanks for your work maintaining the modules! Agreed Luis is already
> doing a great job, also sending patches for kmod userspace.

Thanks for the kind words to you both.

  Luis
