Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1DF0482ED1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 08:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbiACHrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 02:47:36 -0500
Received: from verein.lst.de ([213.95.11.211]:45792 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230370AbiACHrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 02:47:36 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id BB2EA68AA6; Mon,  3 Jan 2022 08:47:32 +0100 (CET)
Date:   Mon, 3 Jan 2022 08:47:32 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     SeongJae Park <sj@kernel.org>
Cc:     akpm@linux-foundation.org, hch@lst.de, hughd@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/shmem: Fix a build error due to shmem_unuse() under
 !CONFIG_SHMEM
Message-ID: <20220103074732.GA28350@lst.de>
References: <20211230103844.15302-1-sj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211230103844.15302-1-sj@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
