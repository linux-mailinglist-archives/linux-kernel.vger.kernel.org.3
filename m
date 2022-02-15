Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F484B62C5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 06:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234022AbiBOFaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 00:30:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbiBOFaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 00:30:16 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53525123419;
        Mon, 14 Feb 2022 21:30:07 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JyV603PpPz4y3m;
        Tue, 15 Feb 2022 16:30:00 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     mpe@ellerman.id.au, Maxim Kiselev <bigunclemax@gmail.com>
Cc:     paulus@samba.org, vladimir.oltean@nxp.com, davem@davemloft.net,
        devicetree@vger.kernel.org, benh@kernel.crashing.org,
        linuxppc-dev@lists.ozlabs.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, andrew@lunn.ch, fido_max@inbox.ru
In-Reply-To: <20220121091447.3412907-1-bigunclemax@gmail.com>
References: <87czkmudh0.fsf@mpe.ellerman.id.au> <20220121091447.3412907-1-bigunclemax@gmail.com>
Subject: Re: [PATCH v3] powerpc: dts: t1040rdb: fix ports names for Seville Ethernet switch
Message-Id: <164490279229.270256.13940315690425244509.b4-ty@ellerman.id.au>
Date:   Tue, 15 Feb 2022 16:26:32 +1100
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

On Fri, 21 Jan 2022 12:14:47 +0300, Maxim Kiselev wrote:
> On board rev A, the network interface labels for the switch ports
> written on the front panel are different than on rev B and later.
> 
> This patch fixes network interface names for the switch ports according
> to labels that are written on the front panel of the board rev B.
> They start from ETH3 and end at ETH10.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: dts: t1040rdb: fix ports names for Seville Ethernet switch
      https://git.kernel.org/powerpc/c/5ebb74749202a25da4b3cc2eb15470225a05527c

cheers
