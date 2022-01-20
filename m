Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08DCC4948DF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 08:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240583AbiATHuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 02:50:10 -0500
Received: from verein.lst.de ([213.95.11.211]:43353 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230405AbiATHuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 02:50:09 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9F36368AFE; Thu, 20 Jan 2022 08:50:05 +0100 (CET)
Date:   Thu, 20 Jan 2022 08:50:05 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Christoph Hellwig <hch@lst.de>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: videobuf2-dma-contig: Invalidate vmap range
 before DMA range
Message-ID: <20220120075005.GA4737@lst.de>
References: <20220119081417.20604-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220119081417.20604-1-senozhatsky@chromium.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
