Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B25532893
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 13:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236500AbiEXLPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 07:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbiEXLPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 07:15:33 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6D66B09F
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 04:15:32 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L6s7P5KWyz4xbd;
        Tue, 24 May 2022 21:15:29 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     cgel.zte@gmail.com, benh@kernel.crashing.org, mpe@ellerman.id.au
Cc:     paulus@samba.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Zeal Robot <zealci@zte.com.cn>,
        lv.ruyi@zte.com.cn
In-Reply-To: <20220407090043.2491854-1-lv.ruyi@zte.com.cn>
References: <20220407090043.2491854-1-lv.ruyi@zte.com.cn>
Subject: Re: [PATCH] powerpc/powernv: fix missing of_node_put in uv_init()
Message-Id: <165339057982.1718562.14767905172605288710.b4-ty@ellerman.id.au>
Date:   Tue, 24 May 2022 21:09:39 +1000
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

On Thu, 7 Apr 2022 09:00:43 +0000, cgel.zte@gmail.com wrote:
> From: Lv Ruyi <lv.ruyi@zte.com.cn>
> 
> of_find_compatible_node() returns node pointer with refcount incremented,
> use of_node_put() on it when done.
> 
> 

Applied to powerpc/next.

[1/1] powerpc/powernv: fix missing of_node_put in uv_init()
      https://git.kernel.org/powerpc/c/3ffa9fd471f57f365bc54fc87824c530422f64a5

cheers
