Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7892347A5A3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 09:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237799AbhLTICb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 03:02:31 -0500
Received: from 8bytes.org ([81.169.241.247]:50310 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231402AbhLTICa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 03:02:30 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id B3DEF39A; Mon, 20 Dec 2021 09:02:28 +0100 (CET)
Date:   Mon, 20 Dec 2021 09:02:25 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/amd: Fix =?utf-8?Q?typo_?=
 =?utf-8?Q?in_*glues_=E2=80=A6?= together* in comment
Message-ID: <YcA4kdl+ZzHvuOEh@8bytes.org>
References: <20211217134916.43698-1-pmenzel@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211217134916.43698-1-pmenzel@molgen.mpg.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 02:49:16PM +0100, Paul Menzel wrote:
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
>  drivers/iommu/amd/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.
