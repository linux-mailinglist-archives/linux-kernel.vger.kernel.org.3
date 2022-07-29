Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52EDA5850B9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 15:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236457AbiG2NT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 09:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236391AbiG2NT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 09:19:26 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7170B5924F
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 06:19:25 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LvSlw0mMVz4xG7;
        Fri, 29 Jul 2022 23:19:24 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     paulus@samba.org, Jason Wang <wangborong@cdjrlc.com>
Cc:     mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, nick.child@ibm.com,
        benh@kernel.crashing.org
In-Reply-To: <20220715035250.5978-1-wangborong@cdjrlc.com>
References: <20220715035250.5978-1-wangborong@cdjrlc.com>
Subject: Re: [PATCH] powerpc/sysdev: Fix comment typo
Message-Id: <165909977971.253830.8297331374740310382.b4-ty@ellerman.id.au>
Date:   Fri, 29 Jul 2022 23:02:59 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jul 2022 11:52:50 +0800, Jason Wang wrote:
> The double `is' is duplicated in line 110, remove one.
> 
> 

Applied to powerpc/next.

[1/1] powerpc/sysdev: Fix comment typo
      https://git.kernel.org/powerpc/c/738f9dca0df3bb630e6f06a19573ab4e31bd443a

cheers
