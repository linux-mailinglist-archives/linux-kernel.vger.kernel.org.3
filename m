Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E93532898
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 13:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236539AbiEXLPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 07:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236399AbiEXLPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 07:15:35 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1998D6B09F
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 04:15:34 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L6s7S4TV3z4xbt;
        Tue, 24 May 2022 21:15:32 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     cgel.zte@gmail.com, oss@buserror.net
Cc:     linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
        Zeal Robot <zealci@zte.com.cn>,
        Minghao Chi <chi.minghao@zte.com.cn>, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20220225010737.2038781-1-chi.minghao@zte.com.cn>
References: <20220225010737.2038781-1-chi.minghao@zte.com.cn>
Subject: Re: [PATCH V2] platforms/83xx: Use of_device_get_match_data()
Message-Id: <165339058975.1718562.18046170909472116174.b4-ty@ellerman.id.au>
Date:   Tue, 24 May 2022 21:09:49 +1000
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

On Fri, 25 Feb 2022 01:07:37 +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
> 
> Use of_device_get_match_data() to simplify the code.
> v1->v2:
> 	Add a judgment on the return value of the A function as NULL
> 
> 
> [...]

Applied to powerpc/next.

[1/1] platforms/83xx: Use of_device_get_match_data()
      https://git.kernel.org/powerpc/c/8a57c3cc2bcb8df98c239d6804fd01834960b7d2

cheers
