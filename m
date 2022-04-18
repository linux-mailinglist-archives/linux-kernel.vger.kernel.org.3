Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C3A504DE8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 10:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233884AbiDRIeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 04:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiDRIes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 04:34:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9896167E8;
        Mon, 18 Apr 2022 01:32:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7F0FFB80E54;
        Mon, 18 Apr 2022 08:32:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E74BEC385A7;
        Mon, 18 Apr 2022 08:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650270727;
        bh=P2NdWkh7ANLrGntriy9pXp5aAVb9pf2tB9MolKSyazw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bD+4Rnk1eMoVY5LbC9EVp+Mc08r19hgjO2/21zpEAIBFsUsAe1pzMeVmokPs0bl1/
         clYaZI4kUjm4qPQBKXWtlC8k+9WA6F7FH3Igsl13ljl47+1qPANg4Oq+LsCN66xNe+
         BBejCgD8dFY51mWHJ0E3t2m6jykGeWOc2fz11OmSkMBVHfd2lvYN8e4WIOrk1eB6Hi
         G2Bs/57Lhy5E9J1mTjz8ykj80+9J7Fte2B5X7wp5wPpBfIoT0RHSwD5H3Gmn9UZj+S
         tR5ZoRRvaCo9+e/MqFReUmssrddyi8pIqESgZw2yTz/CxnTmjUY8eEY2uia3wJEQD2
         zEV0SWgRnvpwg==
Date:   Mon, 18 Apr 2022 16:32:01 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH v3] arm64: dts: imx8m{m,n}-venice-*: add missing
 uart-has-rtscts property to UARTs
Message-ID: <20220418083201.GG391514@dragon>
References: <20220411194638.5706-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411194638.5706-1-tharvey@gateworks.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 12:46:38PM -0700, Tim Harvey wrote:
> Add the missing 'uart-has-rtscts' property to UART's that have hardware
> flow control capability.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied, thanks!
