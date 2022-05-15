Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F5B5276E2
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 12:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236296AbiEOKRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 06:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236271AbiEOKRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 06:17:08 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AB117A93
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 03:17:08 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L1JG93lXtz4xXJ;
        Sun, 15 May 2022 20:17:05 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     benh@kernel.crashing.org, ruscur@russell.cc,
        YueHaibing <yuehaibing@huawei.com>, oohall@gmail.com,
        mpe@ellerman.id.au, nick.child@ibm.com, paulus@samba.org,
        christophe.leroy@csgroup.eu
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220316104239.26508-1-yuehaibing@huawei.com>
References: <20220316104239.26508-1-yuehaibing@huawei.com>
Subject: Re: [PATCH v2 -next] powerpc/eeh: Remove unused inline functions
Message-Id: <165260954984.1040779.9924441836509487459.b4-ty@ellerman.id.au>
Date:   Sun, 15 May 2022 20:12:29 +1000
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

On Wed, 16 Mar 2022 18:42:39 +0800, YueHaibing wrote:
> pseries_eeh_init_edev() is exclusively in eeh_pseries.c,
> make it static and remove unused inline function.
> pseries_eeh_init_edev_recursive() is only called from files build
> wich CONFIG_HOTPLUG_PCI_RPA which depends on CONFIG_PSERIES and
> CONFIG_EEH, so can remove the unused inline version.
> 
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/eeh: Remove unused inline functions
      https://git.kernel.org/powerpc/c/f06351f8c0c85e2d53e73c53a33b4ef55b4ad6de

cheers
