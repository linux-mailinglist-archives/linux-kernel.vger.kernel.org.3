Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90F2547D59D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 18:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344233AbhLVRMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 12:12:07 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:47440 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbhLVRME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 12:12:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5D6BDB81DA5;
        Wed, 22 Dec 2021 17:12:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4442C36AEA;
        Wed, 22 Dec 2021 17:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640193122;
        bh=YyQpIii70JjHEhkKuOoqalVoZnVwEjyLEqWLGi8hF0c=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=N3L22agxhoJDeZnG+j9EUdqi/LyejvaUQNv0nZetgCzho+dIzxXRw2QtkezWn2lNL
         vg6L3NOkS5VKRxnaVLjNLQP4UoNsP3S2jNKqiOX387PqNU44OAk3p3a32B+BGwGKFN
         pZO6QjrAeaRdgnVkzCtmJMAx03y0gckvdNLSYatf6ouBb9heYGjQVTjMoqjBYu/5ue
         FWXKx6suKm6Ys+XfOr6MhM1n9TqGxi+H29PUw7dzvuLIIvrDMzUagMlC8tU3yakCtr
         nqOPysGQNe+AJQZGsR7U4TqhowO1hY5MeXYObVt9IGfI19rN4PHstnpH0/ZMbzmevd
         oDjoA/gapFa2Q==
Subject: Re: [PATCH v2 0/2] arm64: dts: ti: k3-am64-main: Add GPMC & ELM nodes
To:     nm@ti.com
Cc:     kishon@ti.com, vigneshr@ti.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211208131536.23667-1-rogerq@kernel.org>
From:   Roger Quadros <rogerq@kernel.org>
Message-ID: <9250e5ed-6d4a-9eae-93d4-90e5906ae166@kernel.org>
Date:   Wed, 22 Dec 2021 19:11:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211208131536.23667-1-rogerq@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth,

On 08/12/2021 15:15, Roger Quadros wrote:
> Hi Nishanth,
> 
> This series adds GPMC and ELM controller device tree nodes to
> AM64 SoC's dtsi file.
> 
> Changelog:
> v2
> - Fix register sizes for GPMC node.
> - Disable GPMC and ELM nodes in board files. They will be enabled in
> NAND card device tree overlay.

Gentle reminder to pick this for -next
GPMC + NAND side patches are already in queue for -next. Thanks.

cheers,
-roger

> 
> Roger Quadros (2):
>   arm64: dts: ti: k3-am64-main: Add GPMC memory controller node
>   arm64: dts: ti: k3-am64-main: Add ELM (Error Location Module) node
> 
>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 28 ++++++++++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-am642-evm.dts  |  8 +++++++
>  arch/arm64/boot/dts/ti/k3-am642-sk.dts   |  8 +++++++
>  3 files changed, 44 insertions(+)
> 
