Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A67585095
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 15:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236456AbiG2NMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 09:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236618AbiG2NK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 09:10:56 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568EA3B961;
        Fri, 29 Jul 2022 06:10:55 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LvSZ55wVyz4x1Y;
        Fri, 29 Jul 2022 23:10:53 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     mpe@ellerman.id.au, wim@linux-watchdog.org, linux@roeck-us.net,
        npiggin@gmail.com, nathanl@linux.ibm.com,
        christophe.leroy@csgroup.eu,
        Laurent Dufour <ldufour@linux.ibm.com>, rdunlap@infradead.org
Cc:     haren@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
        hch@infradead.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org
In-Reply-To: <20220713154729.80789-1-ldufour@linux.ibm.com>
References: <20220713154729.80789-1-ldufour@linux.ibm.com>
Subject: Re: [PATCH v5 0/4] Extending NMI watchdog during LPM
Message-Id: <165909973609.253830.7930031213898440605.b4-ty@ellerman.id.au>
Date:   Fri, 29 Jul 2022 23:02:16 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jul 2022 17:47:25 +0200, Laurent Dufour wrote:
> When a partition is transferred, once it arrives at the destination node,
> the partition is active but much of its memory must be transferred from the
> start node.
> 
> It depends on the activity in the partition, but the more CPU the partition
> has, the more memory to be transferred is likely to be. This causes latency
> when accessing pages that need to be transferred, and often, for large
> partitions, it triggers the NMI watchdog.
> 
> [...]

Applied to powerpc/next.

[1/4] powerpc/mobility: wait for memory transfer to complete
      https://git.kernel.org/powerpc/c/882c0d1704cf61df13f01933269202d51e74b9f3
[2/4] watchdog: export lockup_detector_reconfigure
      https://git.kernel.org/powerpc/c/7c56a8733d0a2a4be2438a7512566e5ce552fccf
[3/4] powerpc/watchdog: introduce a NMI watchdog's factor
      https://git.kernel.org/powerpc/c/f5e74e836097d1004077390717d4bd95d4a2c27a
[4/4] pseries/mobility: set NMI watchdog factor during an LPM
      https://git.kernel.org/powerpc/c/118b1366930c8c833b8b36abef657f40d4e26610

cheers
