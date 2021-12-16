Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69FB7476BF7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 09:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234210AbhLPIcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 03:32:17 -0500
Received: from verein.lst.de ([213.95.11.211]:59582 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229612AbhLPIcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 03:32:16 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id ED05268B05; Thu, 16 Dec 2021 09:32:13 +0100 (CET)
Date:   Thu, 16 Dec 2021 09:32:13 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v1 1/2] uuid: Discourage people from using UAPI header
 in new code
Message-ID: <20211216083213.GA24815@lst.de>
References: <20211213203507.54157-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213203507.54157-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both patches looks good to me:

Acked-by: Christoph Hellwig <hch@lst.de>

Given that the uuid tree isn't in linux-next anymore due to inactivity,
can you send them to Andrew for inclusion in -mm with my ACK?
