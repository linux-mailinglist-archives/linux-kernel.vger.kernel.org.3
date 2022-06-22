Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947C9554B97
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 15:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353035AbiFVNny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 09:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357134AbiFVNnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 09:43:42 -0400
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986865FBD
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 06:43:41 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 4F96D2D0; Wed, 22 Jun 2022 15:43:40 +0200 (CEST)
Date:   Wed, 22 Jun 2022 15:43:39 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Bo Liu <liubo03@inspur.com>
Cc:     will@kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: Remove usage of the deprecated ida_simple_xxx API
Message-ID: <YrMci73Qko5ssAND@8bytes.org>
References: <20220617020555.2361-1-liubo03@inspur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220617020555.2361-1-liubo03@inspur.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 10:05:55PM -0400, Bo Liu wrote:
> Use ida_alloc_xxx()/ida_free() instead of
> ida_simple_get()/ida_simple_remove().
> The latter is deprecated and more verbose.
> 
> Signed-off-by: Bo Liu <liubo03@inspur.com>
> ---
>  drivers/iommu/iommu.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Sorry, just applied this similar change:

https://lore.kernel.org/r/20220608021655.1538087-1-liuke94@huawei.com

