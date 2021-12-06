Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFC54697A8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 15:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245044AbhLFOEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 09:04:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbhLFOEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 09:04:50 -0500
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB32C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 06:01:22 -0800 (PST)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 8775F396; Mon,  6 Dec 2021 15:01:20 +0100 (CET)
Date:   Mon, 6 Dec 2021 15:01:19 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     linux-kernel@vger.kernel.org, David Woodhouse <dwmw@amazon.co.uk>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH 0/5] iommu/amd: fixes for suspend/resume
Message-ID: <Ya4XrxbcXvdQv0kp@8bytes.org>
References: <20211123161038.48009-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123161038.48009-1-mlevitsk@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 06:10:33PM +0200, Maxim Levitsky wrote:
> Best regards,
>    Maxim Levitsky
> 
> Maxim Levitsky (5):
>   iommu/amd: restore GA log/tail pointer on host resume
>   iommu/amd: x2apic mode: re-enable after resume
>   iommu/amd: x2apic mode: setup the INTX registers on mask/unmask
>   iommu/amd: x2apic mode: mask/unmask interrupts on suspend/resume
>   iommu/amd: remove useless irq affinity notifier
> 
>  drivers/iommu/amd/amd_iommu_types.h |   2 -
>  drivers/iommu/amd/init.c            | 107 +++++++++++++++-------------
>  2 files changed, 58 insertions(+), 51 deletions(-)

Suravee, can you please have a look? These look like v5.16 material.

Thanks,

	Joerg
