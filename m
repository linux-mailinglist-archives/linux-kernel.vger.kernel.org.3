Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0E74B62CD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 06:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbiBOFba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 00:31:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234108AbiBOFao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 00:30:44 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF2B123419
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 21:30:21 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JyV6L3Wrkz4xsm;
        Tue, 15 Feb 2022 16:30:18 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20211220134036.683309-1-thierry.reding@gmail.com>
References: <20211220134036.683309-1-thierry.reding@gmail.com>
Subject: Re: [PATCH] powerpc: dts: Fix some I2C unit addresses
Message-Id: <164490279131.270256.1190323452286806072.b4-ty@ellerman.id.au>
Date:   Tue, 15 Feb 2022 16:26:31 +1100
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

On Mon, 20 Dec 2021 14:40:36 +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> The unit-address for the Maxim MAX1237 ADCs on XPedite5200 boards don't
> match the value in the "reg" property and cause a DTC warning.
> 
> 

Applied to powerpc/next.

[1/1] powerpc: dts: Fix some I2C unit addresses
      https://git.kernel.org/powerpc/c/d5342fdd163ae0553a14820021a107e03eb1ea72

cheers
