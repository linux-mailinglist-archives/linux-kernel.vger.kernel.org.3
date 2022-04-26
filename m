Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96DD851069A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 20:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353694AbiDZSVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 14:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353714AbiDZSVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 14:21:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F95D11C98D;
        Tue, 26 Apr 2022 11:17:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8F184B821AF;
        Tue, 26 Apr 2022 18:17:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 486CEC385A0;
        Tue, 26 Apr 2022 18:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650997072;
        bh=LTInLvgTo3+OPjN1U1BCrFe0lRcYNQO+WZM6UmJz01E=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=QTKJSkz85f2HnAn3fUrN+Evd1XfpCKXJMMhuU/A8jh1t8NqDedWdVXTcCQuf850a7
         SOorWAVz398djreaZUwUYbrMdyWqNentTR0OagBhYaEZHa3LZLhlSOrUbJxqzE0lKK
         dc4mbo70mYewMsN1jICaL1x2Ua0gBcsURAMu85bFE60JwP/nrJNHOQBlzULdHJ0K6o
         fNF+nwda64vPT9op6NMJs/cky24fExdCc53KNqwIEX0THyPlYW1JU+XAXtVxI+Y2DH
         SFWyfL7GLXbvUykjWnf50hJ1Q4XIXo7lZm0xECXdAw0JRB8aEdQ1t9qxVsqBxOho8u
         QXy+rjdJmS2Yw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220426131539.388382-1-yangyingliang@huawei.com>
References: <20220426131539.388382-1-yangyingliang@huawei.com>
Subject: Re: [PATCH -next] clk: en7523: fix wrong pointer check in en7523_clk_probe()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, nbd@nbd.name, matthias.bgg@gmail.com
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 26 Apr 2022 11:17:50 -0700
User-Agent: alot/0.10
Message-Id: <20220426181752.486CEC385A0@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Yang Yingliang (2022-04-26 06:15:39)
> Check the real return value of devm_platform_ioremap_resource()
> in en7523_clk_probe().
>=20
> Fixes: 1e6273179190 ("clk: en7523: Add clock driver for Airoha EN7523 SoC=
")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---

Applied to clk-next
