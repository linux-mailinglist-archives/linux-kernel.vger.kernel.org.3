Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE7E5328AD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 13:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236649AbiEXLQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 07:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236622AbiEXLQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 07:16:05 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DFFE0AB
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 04:16:04 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L6s810S6Qz4yTT;
        Tue, 24 May 2022 21:16:01 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     benh@kernel.crashing.org, mpe@ellerman.id.au, nick.child@ibm.com,
        Peng Wu <wupeng58@huawei.com>
Cc:     wangxiongfeng2@huawei.com, liwei391@huawei.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220425081245.21705-1-wupeng58@huawei.com>
References: <20220425081245.21705-1-wupeng58@huawei.com>
Subject: Re: [PATCH -next] powerpc/iommu: Add missing of_node_put in iommu_init_early_dart
Message-Id: <165339058771.1718562.10340726142485751524.b4-ty@ellerman.id.au>
Date:   Tue, 24 May 2022 21:09:47 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Apr 2022 08:12:45 +0000, Peng Wu wrote:
> The device_node pointer is returned by of_find_compatible_node
> with refcount incremented. We should use of_node_put() to avoid
> the refcount leak.
> 
> 

Applied to powerpc/next.

[1/1] powerpc/iommu: Add missing of_node_put in iommu_init_early_dart
      https://git.kernel.org/powerpc/c/57b742a5b8945118022973e6416b71351df512fb

cheers
