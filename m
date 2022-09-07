Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580A15AFFA4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 10:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbiIGIxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 04:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbiIGIxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 04:53:19 -0400
X-Greylist: delayed 743 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 07 Sep 2022 01:53:09 PDT
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BB029AC252
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 01:53:09 -0700 (PDT)
Received: from 8bytes.org (p4ff2bb62.dip0.t-ipconnect.de [79.242.187.98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 3D75D2409B7;
        Wed,  7 Sep 2022 10:53:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1662540788;
        bh=PbJNz8e+eLuPd03LpOTi4uNeF9KXbmGmwB8GxoCqd40=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IG3Uto1dtr422Vi2d0xYJaLwwJyzsAB3r707UvCJmwY1S8zNC1ZB3yOmb7DmX2JJP
         If78vWvcb84VtumNkmqwnG6ehqrbPPi3J6FV+yCgtSW2LQgYgUNZV6x6GqQcATzkok
         5Vvt50zREcfxQXbCwoBA4lWDDSxDXYNXphFuDx1m/Euw2yziAJ73dMMzRIapgb2K5m
         yemT+u00rEfjDhQA3uopzkwlHHZbZ3kpVBeVY9DdPT5H/Zjdzm/jyCYeloKzYIgCts
         UBk+uQLyatswchX4BUwZQvdkWQ22GQe05fm1XbOMiJMzxhMuZCdFnmM4YLOMb2BtEq
         CKA+vkza/2+6g==
Date:   Wed, 7 Sep 2022 10:53:07 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Yuan Can <yuancan@huawei.com>
Cc:     will@kernel.org, robin.murphy@arm.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] iommu: Remove duplicate ida_free in
 iommu_group_alloc
Message-ID: <Yxhb86pnOWLJ5qoM@8bytes.org>
References: <20220815031423.94548-1-yuancan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815031423.94548-1-yuancan@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 03:14:23AM +0000, Yuan Can wrote:
>  drivers/iommu/iommu.c | 1 -
>  1 file changed, 1 deletion(-)

Applied, thanks.
	
