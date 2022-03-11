Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3C64D586E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 03:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345794AbiCKCzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 21:55:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345789AbiCKCzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 21:55:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493D31A6F92;
        Thu, 10 Mar 2022 18:54:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E55A60F0D;
        Fri, 11 Mar 2022 02:54:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E73CEC340E8;
        Fri, 11 Mar 2022 02:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646967274;
        bh=HyZvlBTOgYYysoaSfGBGWuGpPH4RVL4n473mGCaquGo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=rutk+9kjTS/MhFhU6vOGU1U9bbAm4I71fmpQ6pAyvN7DAx50REWBiSxVVtRtfVMkp
         S2ryjpJwty+RmsioLTFFLjMs7URswsTf7qy8WbGV3H7KZ77x4RBo8y77KbMfTRJmxW
         f9T4q4mmb1wGs9u9ujN9/GtVfd9vp8E0xRZxHLLMvgbiz60dlrY3Y11HDxXkfRKmnD
         UEFPWRSHcZ3BB7jLu5UDTe74SGcz4eA/nr/xgdsBIeEl254J4+vHlUpOLe3dM/OM8z
         PgSW16pTfFM3UjE+Cja64wz2g29HTbpL5eNkZHKd6Fw1JHJRRk4Mkoop0RlCDhG5GV
         H955jXTzNLvuA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220126173953.1016706-8-kernel@esmil.dk>
References: <20220126173953.1016706-1-kernel@esmil.dk> <20220126173953.1016706-8-kernel@esmil.dk>
Subject: Re: [PATCH v1 7/7] clk: starfive: Add JH7100 audio clock driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Zhu <michael.zhu@starfivetech.com>,
        Fu Wei <tekkamanninja@gmail.com>, linux-kernel@vger.kernel.org
To:     Emil Renner Berthing <kernel@esmil.dk>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Date:   Thu, 10 Mar 2022 18:54:32 -0800
User-Agent: alot/0.10
Message-Id: <20220311025433.E73CEC340E8@smtp.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Emil Renner Berthing (2022-01-26 09:39:53)
> Add a driver for the audio clocks on the Starfive JH7100 RISC-V SoC.
>=20
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> ---

Applied to clk-next
