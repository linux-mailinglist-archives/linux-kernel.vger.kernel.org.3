Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE9F4D6E23
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 11:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbiCLKcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 05:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbiCLKb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 05:31:59 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC19623D189
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 02:30:54 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KFzbb5Dq1z4xLX;
        Sat, 12 Mar 2022 21:30:51 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     benh@kernel.crashing.org, mpe@ellerman.id.au,
        christophe.leroy@csgroup.eu, wen.yang99@zte.com.cn,
        Hangyu Hua <hbh25y@gmail.com>, peng.hao2@zte.com.cn,
        paulus@samba.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220223070223.26845-1-hbh25y@gmail.com>
References: <20220223070223.26845-1-hbh25y@gmail.com>
Subject: Re: [PATCH] powerpc: 8xx: fix a return value error in mpc8xx_pic_init
Message-Id: <164708099004.827774.1268843120953006497.b4-ty@ellerman.id.au>
Date:   Sat, 12 Mar 2022 21:29:50 +1100
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

On Wed, 23 Feb 2022 15:02:23 +0800, Hangyu Hua wrote:
> mpc8xx_pic_init() should return -ENOMEM instead of 0 when
> irq_domain_add_linear() return NULL. This cause mpc8xx_pics_init to continue
> executing even if mpc8xx_pic_host is NULL.
> 
> 

Applied to powerpc/next.

[1/1] powerpc: 8xx: fix a return value error in mpc8xx_pic_init
      https://git.kernel.org/powerpc/c/3fd46e551f67f4303c3276a0d6cd20baf2d192c4

cheers
