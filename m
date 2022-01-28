Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B414D49F494
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 08:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346933AbiA1Hoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 02:44:46 -0500
Received: from verein.lst.de ([213.95.11.211]:47238 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237006AbiA1Hom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 02:44:42 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 64D6168AA6; Fri, 28 Jan 2022 08:44:39 +0100 (CET)
Date:   Fri, 28 Jan 2022 08:44:39 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add bio.h to the block section
Message-ID: <20220128074439.GA3098@lst.de>
References: <20220127064221.1314477-1-hch@lst.de> <990369e1-0868-5cd1-2f97-286c50be2cba@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <990369e1-0868-5cd1-2f97-286c50be2cba@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 10:20:50AM -0700, Jens Axboe wrote:
> On 1/26/22 11:42 PM, Christoph Hellwig wrote:
> > bio.h is pater of the block layer, so list it in the MAINTAINERS file
>            ^^^^^
> 
> part?

Yes.  Do you want a resend?
