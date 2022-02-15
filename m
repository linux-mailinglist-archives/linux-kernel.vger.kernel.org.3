Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545B84B62BF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 06:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234104AbiBOFao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 00:30:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234102AbiBOFa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 00:30:29 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A1C128DF0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 21:30:17 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JyV6G39sKz4y4j;
        Tue, 15 Feb 2022 16:30:14 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Laurent Dufour <ldufour@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     Nathan Lynch <nathanl@linux.ibm.com>, tyreld@linux.ibm.com
In-Reply-To: <20220106161339.74656-1-ldufour@linux.ibm.com>
References: <20220106161339.74656-1-ldufour@linux.ibm.com>
Subject: Re: [PATCH v5] powerpc/pseries: read the lpar name from the firmware
Message-Id: <164490278732.270256.5912946204648546254.b4-ty@ellerman.id.au>
Date:   Tue, 15 Feb 2022 16:26:27 +1100
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

On Thu, 6 Jan 2022 17:13:39 +0100, Laurent Dufour wrote:
> The LPAR name may be changed after the LPAR has been started in the HMC.
> In that case lparstat command is not reporting the updated value because it
> reads it from the device tree which is read at boot time.
> 
> However this value could be read from RTAS.
> 
> Adding this value in the /proc/powerpc/lparcfg output allows to read the
> updated value.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/pseries: read the lpar name from the firmware
      https://git.kernel.org/powerpc/c/eddaa9a402758d379520f6511fb61e89990698aa

cheers
