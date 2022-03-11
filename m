Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2B74D5867
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 03:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244324AbiCKCzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 21:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243632AbiCKCzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 21:55:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594B41A6F8F;
        Thu, 10 Mar 2022 18:54:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F34EC60F18;
        Fri, 11 Mar 2022 02:54:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 574DFC340EB;
        Fri, 11 Mar 2022 02:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646967247;
        bh=HACx15T+mBlgml99r6Ys+29UgLuxiA4FliAiJATMw8Q=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=lHjQcQGYK7Eb9iJCw/aycdnAoVRujUp8U8q91sdDqzePZYnDsmBrVcPWZvC1VGS50
         hyHjBQ2U/pgDWWwPEt/z0KO7JbRBMXCerpYPVQB8J9TN8yQHqNTSHrIIu4uhj0iKc8
         4yilLQBlyy3+QJVzINUY7S8pkXd7vkOTPYQeh1VKjnno8PhuPsHohNDlkioyUKZ/lQ
         Z03s9UhJmY0ccbAQjwEJ3fclmrMI39zbj7gGSVZsWLkgfj6OWJcYckCO0xfxHArZOU
         6aHakYl3lN3QiqboZym2AihMhzxXrEVGC12r8KgDHfTss5FAn9EeaD2fr8cSXX4DvH
         fa6ydFog/T+Jg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220126173953.1016706-5-kernel@esmil.dk>
References: <20220126173953.1016706-1-kernel@esmil.dk> <20220126173953.1016706-5-kernel@esmil.dk>
Subject: Re: [PATCH v1 4/7] dt-bindings: clock: Add starfive,jh7100-audclk bindings
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
Date:   Thu, 10 Mar 2022 18:54:05 -0800
User-Agent: alot/0.10
Message-Id: <20220311025407.574DFC340EB@smtp.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Emil Renner Berthing (2022-01-26 09:39:50)
> Add bindings for the audio clocks on the StarFive JH7100 RISC-V SoC.
>=20
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> ---

Applied to clk-next
