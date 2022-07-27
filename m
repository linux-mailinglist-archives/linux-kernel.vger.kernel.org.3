Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF0A581D1A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 03:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240047AbiG0B3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 21:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240107AbiG0B3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 21:29:10 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6D03AE4D;
        Tue, 26 Jul 2022 18:29:09 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Lsx5H2RCVz4x1b;
        Wed, 27 Jul 2022 11:29:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1658885347;
        bh=0wLCU6KVFK8sCwiTFwyp4hSX7lEdkn+aAk3mmd25b0w=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=gvkVpMGZT+BRc747FlJCRE9ousWZoC+3Q2mFZC8PjqNCpsOM9KLUcTJ1qpy8g/WIL
         GmJ1Tfyf+M2aKBUWXhigh8ih1UsBTaYfCVyHPxLwlX0zGb56WOvF132bSmPINw+lmG
         v0upwQ7lITaalbvE9jEhHWNygENR/g0wUNKumaVPlankOef8t4aha6ENbiGwfacCx0
         HYgh3J9ZuO43YA2vDi8ZjxDANzdOIY1YPOBx5mYdpFtqKAElAGPKJpyddzgeHjxmhB
         7wFIfQD1kO/4sHD7h5hFbWyBdVDHzS9njKErpyYXu/tPyMMYEsVyuROAlRj2KDyTGL
         ULVhtRlQo01eQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Alex Deucher <alexdeucher@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the amdgpu and
 powerpc-fixes trees
In-Reply-To: <20220726205458.0b5ca446@canb.auug.org.au>
References: <20220726205458.0b5ca446@canb.auug.org.au>
Date:   Wed, 27 Jul 2022 11:29:02 +1000
Message-ID: <87zggv9wdd.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:
> Hi all,
>
> After merging the amdgpu tree, today's linux-next build (powerpc
> allyesconfig) failed like this:
>
> ld: drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.o uses hard float, drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.o uses soft float
> ld: failed to merge target specific data of file drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.o

What compiler are you using?

cheers
