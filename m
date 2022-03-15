Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712424DA5AF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 23:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352375AbiCOWuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 18:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350376AbiCOWuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 18:50:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CB756C21;
        Tue, 15 Mar 2022 15:48:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 00EC5B818D3;
        Tue, 15 Mar 2022 22:48:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AED3CC340E8;
        Tue, 15 Mar 2022 22:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647384529;
        bh=AbKXXpWtIybMeDJAnL0pTXEGeuf+WhH1XeWvboxWJfw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=FCY/KOAuxadBlAw2dOhF565hovODg4HmxRtqT7Je0ujCg22wNMmW8lpBFHNzVC/OB
         DfXxAw8/QqRMXTrfAu1Ab+nIhsS0gRanjRKjqyTodO04v+rtiRipHzvxO4DubCIekG
         PY2mCwp2NcMMr0Uq9hrrYrznQtoSUTT/uE7GMFAjSEBC1vKARtH5C/Uvw/Ycd4RJYV
         KFYk8TRCudblFrNbRnRwQjphkTygEFqPrDhymMg/g01njMPQdOpYf6kC90fpnk1/62
         HBysgvu1Key2fTmvKbYnXaTdn0LRkU19wJYCSw15D6XLCUTCyRRdOMv/UK8sQKDT0j
         QU4z9MJIsC2MQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220314115354.144023-15-Julia.Lawall@inria.fr>
References: <20220314115354.144023-1-Julia.Lawall@inria.fr> <20220314115354.144023-15-Julia.Lawall@inria.fr>
Subject: Re: [PATCH 14/30] clk: ti: clkctrl: fix typos in comments
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     kernel-janitors@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-omap@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Julia Lawall <Julia.Lawall@inria.fr>,
        Tero Kristo <kristo@kernel.org>
Date:   Tue, 15 Mar 2022 15:48:47 -0700
User-Agent: alot/0.10
Message-Id: <20220315224849.AED3CC340E8@smtp.kernel.org>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Julia Lawall (2022-03-14 04:53:38)
> Various spelling mistakes in comments.
> Detected with the help of Coccinelle.
>=20
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
>=20
> ---

Applied to clk-next
