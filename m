Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C33A532897
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 13:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236532AbiEXLPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 07:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236254AbiEXLPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 07:15:34 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594E56B03A
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 04:15:33 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L6s7R6xbdz4xYX;
        Tue, 24 May 2022 21:15:31 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     cgel.zte@gmail.com, mpe@ellerman.id.au
Cc:     paulus@samba.org, linux-kernel@vger.kernel.org, nick.child@ibm.com,
        benh@kernel.crashing.org, Zeal Robot <zealci@zte.com.cn>,
        lv.ruyi@zte.com.cn, maz@kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20220402013419.2410298-1-lv.ruyi@zte.com.cn>
References: <20220402013419.2410298-1-lv.ruyi@zte.com.cn>
Subject: Re: [PATCH] powerpc/sysdev: fix refcount leak in icp_opal_init()
Message-Id: <165339057736.1718562.8464783736668414946.b4-ty@ellerman.id.au>
Date:   Tue, 24 May 2022 21:09:37 +1000
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

On Sat, 2 Apr 2022 01:34:19 +0000, cgel.zte@gmail.com wrote:
> From: Lv Ruyi <lv.ruyi@zte.com.cn>
> 
> The of_find_compatible_node() function returns a node pointer with
> refcount incremented, use of_node_put() on it when done.
> 
> 

Applied to powerpc/next.

[1/1] powerpc/sysdev: fix refcount leak in icp_opal_init()
      https://git.kernel.org/powerpc/c/5dd9e27ea4a39f7edd4bf81e9e70208e7ac0b7c9

cheers
