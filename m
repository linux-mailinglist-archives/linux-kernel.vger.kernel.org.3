Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D1E513140
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 12:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234840AbiD1K2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 06:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiD1K22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 06:28:28 -0400
X-Greylist: delayed 8042 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 28 Apr 2022 03:25:12 PDT
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C152E1837A;
        Thu, 28 Apr 2022 03:25:10 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 87B01374; Thu, 28 Apr 2022 12:25:08 +0200 (CEST)
Date:   Thu, 28 Apr 2022 12:25:07 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     xkernel.wang@foxmail.com
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, will@kernel.org,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iommu/msm: add a check for the return of kzalloc()
Message-ID: <Ymprg6lvpn+9Vozl@8bytes.org>
References: <tencent_EDB94B1C7E14B4E1974A66FF4D2029CC6D08@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_EDB94B1C7E14B4E1974A66FF4D2029CC6D08@qq.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 04:52:39PM +0800, xkernel.wang@foxmail.com wrote:
> From: Xiaoke Wang <xkernel.wang@foxmail.com>
> 
> kzalloc() is a memory allocation function which can return NULL when
> some internal memory errors happen. So it is better to check it to
> prevent potential wrong memory access.
> 
> Besides, to propagate the error to the caller, the type of
> insert_iommu_master() is changed to `int`. Several instructions related
> to it are also updated.
> 
> Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
> ---
> ChangeLog:
> v1->v2 propagate the error to the caller.
>  drivers/iommu/msm_iommu.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)

Applied, thanks.
