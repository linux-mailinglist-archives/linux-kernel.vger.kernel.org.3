Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B9251127E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 09:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358823AbiD0Hcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 03:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358815AbiD0Hc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 03:32:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFA87DAA0;
        Wed, 27 Apr 2022 00:29:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 85DFBB824B0;
        Wed, 27 Apr 2022 07:29:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4C8BC385A7;
        Wed, 27 Apr 2022 07:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651044557;
        bh=C2ptwWy8eBtL0+IRwpAfnTThad/PS6GU4Cu3msgQJiQ=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=SEhk+2ORaHP4Q6rHgqflWbPczxWXIzZ0exYgops1kjW0YuSdvilVQl7zzTMDimkNe
         cofQs7q2ZoE8iMZAt2iuhopI/+IVRU4dyOkA3BvIe9IKADUBOuJ/upT7Dltz21Y32N
         BhK6oLESmk+R4XPps+nv1bD7BVkV2lh7jVfcAcufNmsY0KEANSNyj13bPGHg92/Bgn
         ZVmb+QNZQ277YFSXA9rZp3/kRyacDhMbLHcqI1sMo7i6ah0qSmDHw87oe8KpnBTv2a
         ofKWNy9PqC/pfm8b+3rzneH2C8+7WBRhMXSG20r5DNePajR3FnnLRgA2fjSViedK/8
         UDDPtzUYx3kWA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220427070349.388246-1-juergh@protonmail.com>
References: <20220427070349.388246-1-juergh@protonmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@protonmail.com>
To:     Juerg Haefliger <juerg.haefliger@canonical.com>,
        davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org
From:   Antoine Tenart <atenart@kernel.org>
Subject: Re: [PATCH] crypto: inside-secure - Add MODULE_FIRMWARE macros
Message-ID: <165104455443.3327.8052402101857118285@kwain>
Date:   Wed, 27 Apr 2022 09:29:14 +0200
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Juerg,

Quoting Juerg Haefliger (2022-04-27 09:03:49)
> +
> +MODULE_FIRMWARE("inside-secure/eip197b/ifpp.bin");
> +MODULE_FIRMWARE("inside-secure/eip197b/ipue.bin");
> +MODULE_FIRMWARE("inside-secure/eip197d/ifpp.bin");
> +MODULE_FIRMWARE("inside-secure/eip197d/ipue.bin");
> +MODULE_FIRMWARE("inside-secure/eip197_minifw/ifpp.bin");
> +MODULE_FIRMWARE("inside-secure/eip197_minifw/ipue.bin");

There's also the old location when the EIP197b firmwares were at the
root of the linux-firmware repo. The driver still supports it, so I
guess those two should have a MODULE_FIRMWARE entry too.

Thanks,
Antoine
