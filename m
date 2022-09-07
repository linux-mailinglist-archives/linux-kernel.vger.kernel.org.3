Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 266655AFF82
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 10:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbiIGIp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 04:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiIGIps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 04:45:48 -0400
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5EFD85FAFF
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 01:45:45 -0700 (PDT)
Received: from 8bytes.org (p4ff2bb62.dip0.t-ipconnect.de [79.242.187.98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 7C8B42405F1;
        Wed,  7 Sep 2022 10:37:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1662539867;
        bh=8IVdbekt/J76mnSaLtAMZgVjG1Z8HFBk+8tCH/hMZgA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=3xo0tMnN+UbnHuyXz3bbgyPKTxFDnThHyxZ+zHV8YVIECtquvuHZvA7SEXRiXIoFI
         VGQQqPEmPH2tWYiZgonsbmT+8nC9xAR6zFCQ9YbWoGoyYa7dJr4ak1MQAzQ4Oj4ewT
         raMuaO4igCgGwxeUZbsfspKOLrwXykSSzlZRJSPcAAgYGVq0CJTy5PZu1jVvOxP+Fs
         7+UAAAEn/vrm4NDG8mr51cPiuw5lxj8qlMAut5+ym4YpmrdVQGGs3uX4nExaAtHBT7
         CIsBv/xgaQtW/sgXMjEtz/aHFKZUFKyeUKUnRUwNMDVLaLravWGUSsyKtCOGU7G49P
         fmKge2JVIHwPg==
Date:   Wed, 7 Sep 2022 10:37:46 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Joerg Roedel <jroedel@suse.de>,
        Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v1 1/1] iommu: Do not dereference fwnode in struct device
Message-ID: <YxhYWlbHPNdI4n//@8bytes.org>
References: <20220801164758.20664-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801164758.20664-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2022 at 07:47:58PM +0300, Andy Shevchenko wrote:
>  drivers/iommu/iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.
