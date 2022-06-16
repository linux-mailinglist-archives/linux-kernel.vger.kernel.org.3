Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A73654D5D7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 02:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349165AbiFPAIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 20:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241580AbiFPAIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 20:08:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C53DB1F1;
        Wed, 15 Jun 2022 17:08:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30D07B82200;
        Thu, 16 Jun 2022 00:07:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0445C3411A;
        Thu, 16 Jun 2022 00:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655338077;
        bh=q8YzhSaafF/Ue74x1AOsaawzDagC4rLNcNc0vGwhM+s=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=B0FKjk4QfTq6yhSXcj65WKX3BZn7UBumKje7QHw7nZdu75US71YJkgErgGFvCGFSR
         mtz4EM6lBHI28F3HB2FTFbvzF06UgLZj0fPgZ7W5pem0AXAFQRfUon8IJHvXv85p7B
         p/YUpIN0z20/x3wSPjDlghT1720Yn65t2F75Og8WPfrR2mDxqPZmUgsIpRx06pTAZa
         ES7bjWpEdtfot+QDtszxJbjFGWvT7sx9a7YZKkAWqusJG5NixMhuY8D+x2RslmsBx2
         fa++65J6sxfrGyarVcNyYsSeMoyLRZmknzrV46pdMrKrcb5naOGaqDB/+c+vdM8WmI
         lsbU1FO0+zabw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220526101215.1519155-1-jiasheng@iscas.ac.cn>
References: <20220526101215.1519155-1-jiasheng@iscas.ac.cn>
Subject: Re: [PATCH] clk: samsung: Add check for platform_driver_register
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, alim.akhtar@samsung.com,
        cw00.choi@samsung.com, krzysztof.kozlowski@linaro.org,
        mturquette@baylibre.com, s.nawrocki@samsung.com,
        tomasz.figa@gmail.com
Date:   Wed, 15 Jun 2022 17:07:55 -0700
User-Agent: alot/0.10
Message-Id: <20220616000757.D0445C3411A@smtp.kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jiasheng Jiang (2022-05-26 03:12:15)
> As platform_driver_register() could fail, it should be better
> to deal with the return value in order to maintain the code
> consisitency.
>=20
> Fixes: b06a532bf1fa ("clk: samsung: Add Exynos5 sub-CMU clock driver")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
