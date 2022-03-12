Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C7A4D6E21
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 11:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbiCLKcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 05:32:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiCLKb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 05:31:58 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53A823C0F4
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 02:30:53 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KFzbc2DdTz4xcq;
        Sat, 12 Mar 2022 21:30:52 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, tyreld@linux.ibm.com,
        Hangyu Hua <hbh25y@gmail.com>, paulus@samba.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220302021959.10959-1-hbh25y@gmail.com>
References: <20220302021959.10959-1-hbh25y@gmail.com>
Subject: Re: [PATCH v2] powerpc: kernel: fix refcount leak in format_show()
Message-Id: <164708098533.827774.691952258403804628.b4-ty@ellerman.id.au>
Date:   Sat, 12 Mar 2022 21:29:45 +1100
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

On Wed, 2 Mar 2022 10:19:59 +0800, Hangyu Hua wrote:
> Refcount leak will happen when format_show returns failure in multiple
> cases. Unified management of of_node_put can fix this problem.
> 
> 

Applied to powerpc/next.

[1/1] powerpc: kernel: fix refcount leak in format_show()
      https://git.kernel.org/powerpc/c/d601fd24e6964967f115f036a840f4f28488f63f

cheers
