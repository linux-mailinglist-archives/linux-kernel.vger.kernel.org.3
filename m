Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D112D46BC86
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 14:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237132AbhLGNcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 08:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237092AbhLGNb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 08:31:58 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22832C061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 05:28:28 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4J7h2L3sWtz4xgr;
        Wed,  8 Dec 2021 00:28:26 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <3eb14570612eef17e01bb67f14a4450136001794.1637840601.git.christophe.leroy@csgroup.eu>
References: <3eb14570612eef17e01bb67f14a4450136001794.1637840601.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc: Don't bother about .data..Lubsan sections
Message-Id: <163888361204.3690807.4937169274874065902.b4-ty@ellerman.id.au>
Date:   Wed, 08 Dec 2021 00:26:52 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Nov 2021 12:43:33 +0100, Christophe Leroy wrote:
> Since commit 9a427556fb8e ("vmlinux.lds.h: catch compound literals
> into data and BSS") .data..Lubsan sections are taken into account
> in DATA_MAIN which is included in DATA_DATA macro.
> 
> No need to take care of them anymore in powerpc vmlinux.lds.S
> 
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: Don't bother about .data..Lubsan sections
      https://git.kernel.org/powerpc/c/57dd3a7bdf311e4a499fe0decabcdf2484e2538a

cheers
