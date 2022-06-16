Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2EC54D5F7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 02:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349189AbiFPAT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 20:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349246AbiFPATS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 20:19:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B87C5641C;
        Wed, 15 Jun 2022 17:19:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1742461AC7;
        Thu, 16 Jun 2022 00:19:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F726C3411B;
        Thu, 16 Jun 2022 00:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655338748;
        bh=UtEwv1cvA9jVYc99dH2c2BoSn4oeWV5L7afw2w1hvyc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=W82xxpQTO0aDgAUM+Oz/HYqVu85BHy4aCF1bFj5xBC9SQyOUTJVBmKWr/KUMXDPJs
         8nkLDkvddQbaBWBJHbSP78z8ZUB0uc4GqWT7yxG+ENk90Ou2GtoxMZOaLhkJEPmq1h
         UQYYUKha6FPI/vOCGAa342hoFEFQaKN2pOwlsorjoXFui+5O4tcV2qVeaBqae3IYZO
         hVdlSioBDF9Obpop3DOX/Ic2YcPXieb9Y+oS+Lvw9te1OVMghrhJY8qIZxgBPjEcWd
         XWApCRmTeu2/AJ+SaoNTamNkqJQ8cEUgZcmVuC3l8UT59NbOOiQZVwqvPWwsNnH/3c
         56+V3/xn98HbA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220613085100.402-1-lukas.bulwahn@gmail.com>
References: <20220613085100.402-1-lukas.bulwahn@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add include/dt-bindings/clock to COMMON CLK FRAMEWORK
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
Date:   Wed, 15 Jun 2022 17:19:06 -0700
User-Agent: alot/0.10
Message-Id: <20220616001908.6F726C3411B@smtp.kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lukas Bulwahn (2022-06-13 01:51:00)
> Maintainers of the directory Documentation/devicetree/bindings/clock
> are also the maintainers of the corresponding directory in
> include/dt-bindings/clock.
>=20
> Add the file entry for include/dt-bindings/clock to the appropriate
> section in MAINTAINERS.
>=20
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---

Applied to clk-fixes
