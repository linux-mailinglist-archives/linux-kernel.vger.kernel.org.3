Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C2D5A5E26
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 10:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbiH3IcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 04:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbiH3Ibv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 04:31:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37912A5985;
        Tue, 30 Aug 2022 01:31:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0181B61544;
        Tue, 30 Aug 2022 08:31:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8525C433D6;
        Tue, 30 Aug 2022 08:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661848308;
        bh=qvjvjxIMAdSikhigPbaLJR7QXVbF7fZM/vc2EUcvDNk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=rQBkiMTaQU16mALr+TH+Sg05ehXQJTVoPB6yidy/nYB7xEBcngqFg1ixgLVrnISgO
         kgThYmrsE7nSEI77eJpcDUjwRQyoSi90Qa5vqrPtAXpZPM1Vsyll6Qnr5Ui6JRzfQr
         fpwag/rBk03Ez9taOM1pxOHgYpOInkulwE/cbeYIm5fmQWqPiBSj9lwos4GS/konhx
         0tapGnxuJ0yZcU/3uaqrQFLONDJCETpwaonleWA/agQWTLpNFslIC7BnT3x+X4S3Fa
         b5iJGxGc7GJ2qWDhB1ZPlfb/K/Gu08d2BdnrVTe5knj5xG8BNHbSM6maMaNgQj6WRY
         O4ET0FFhendkw==
Message-ID: <8a12d593-4f67-956c-352a-58d8f6c1bc43@kernel.org>
Date:   Tue, 30 Aug 2022 11:31:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 0/2] arm64: dts: ti: k3-am64-main: Add GPMC & ELM nodes
Content-Language: en-US
To:     nm@ti.com, vigneshr@ti.com
Cc:     kishon@ti.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220802104456.11069-1-rogerq@kernel.org>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20220802104456.11069-1-rogerq@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Nishant/Vignesh,

On 02/08/2022 13:44, Roger Quadros wrote:
> Hi Nishanth,
> 
> This series adds GPMC and ELM controller device tree nodes to
> AM64 SoC's dtsi file.

Gentle ping to pick this series. Thanks!

> 
> Changelog:
> v4
> - Rebased to v5.19
> - use 'ti,am64-elm' compatible for ELM node
> 
> v3
> - Rebased to v5.17-rc1
> 
> v2
> - Fix register sizes for GPMC node.
> - Disable GPMC and ELM nodes in board files. They will be enabled in
> NAND card device tree overlay.
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

cheers,
-roger
