Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4CC4B62B4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 06:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233963AbiBOFaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 00:30:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiBOFaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 00:30:14 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7CD1216A9;
        Mon, 14 Feb 2022 21:30:04 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JyV5z0rVRz4xsm;
        Tue, 15 Feb 2022 16:29:59 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Maxim Kiselev <bigunclemax@gmail.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org, fido_max@inbox.ru
In-Reply-To: <20211230151123.1258321-1-bigunclemax@gmail.com>
References: <20211230151123.1258321-1-bigunclemax@gmail.com>
Subject: Re: [PATCH] powerpc: dts: t104xrdb: fix phy type for FMAN 4/5
Message-Id: <164490279029.270256.18216882664058931903.b4-ty@ellerman.id.au>
Date:   Tue, 15 Feb 2022 16:26:30 +1100
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

On Thu, 30 Dec 2021 18:11:21 +0300, Maxim Kiselev wrote:
> T1040RDB has two RTL8211E-VB phys which requires setting
> of internal delays for correct work.
> 
> Changing the phy-connection-type property to `rgmii-id`
> will fix this issue.
> 
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: dts: t104xrdb: fix phy type for FMAN 4/5
      https://git.kernel.org/powerpc/c/17846485dff91acce1ad47b508b633dffc32e838

cheers
