Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D754B87A9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 13:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233251AbiBPMac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 07:30:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233203AbiBPMa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 07:30:26 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB152A4146
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 04:30:13 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JzHNM68mqz4xmt;
        Wed, 16 Feb 2022 23:30:11 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <1e6162f334167e75f1140082932e3a354b16daba.1642413973.git.christophe.leroy@csgroup.eu>
References: <1e6162f334167e75f1140082932e3a354b16daba.1642413973.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/32s: Enable STRICT_MODULE_RWX for the 603 core
Message-Id: <164501434892.521186.15893809567759741150.b4-ty@ellerman.id.au>
Date:   Wed, 16 Feb 2022 23:25:48 +1100
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

On Mon, 17 Jan 2022 10:06:39 +0000, Christophe Leroy wrote:
> The book3s/32 MMU doesn't support per page execution protection and
> doesn't support RO protection for kernel pages.
> 
> However, on the 603 which implements software loaded TLBs, execution
> protection is honored by the TLB Miss handler which doesn't load
> Instruction TLB for non executable pages. And RO protection is
> honored by clearing the C bit for RO pages, leading to DSI.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/32s: Enable STRICT_MODULE_RWX for the 603 core
      https://git.kernel.org/powerpc/c/0670010f3b10aeaad0dfdf0dad0bcd020fc70eb5

cheers
