Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 439BA54BA61
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 21:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357680AbiFNTP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 15:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344784AbiFNTPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 15:15:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3239764E;
        Tue, 14 Jun 2022 12:15:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 700E160A75;
        Tue, 14 Jun 2022 19:15:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAD49C3411B;
        Tue, 14 Jun 2022 19:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655234153;
        bh=6hbdX0woT8V0SmoPGKiyf3mxXcYsvphTWfMcAMjl43Q=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=aqvqshr66xDqYRSEtNNm7zLiKChU1xH9iKqGyCCVjEOD1/jahmYP6xVVQ9uCZ3KLE
         p9jArETIGRcEw3jCqpqQkYt5qOBsdvLhiUVr3FaSqREyqPGCUvLOfUZCTM2hPj6Luu
         l9UBAzIjbPapadYDDO61Ubvsc4E48RUb0dctLKGALUD02bFL0dHVljnAkfAb2IpEHr
         jSCpsU40+jrF2InbQKugDeflkQ+wanigH4Idaz2t55UAF0y1crB/jVEbScV943YIrU
         K61qIWHFuprdTSprG8BY77aVF+b5azATeBX2iR4ZFb6FX0wwSTNRNvxRQXpHVZxu/4
         9F2LiQDsrJwYw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220613063327.89320-1-lizhengyu3@huawei.com>
References: <20220613063327.89320-1-lizhengyu3@huawei.com>
Subject: Re: [PATCH] clk: qcom: clk-rpmh: Remove redundant if statement
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Li Zhengyu <lizhengyu3@huawei.com>, quic_tdas@quicinc.com
Date:   Tue, 14 Jun 2022 12:15:51 -0700
User-Agent: alot/0.10
Message-Id: <20220614191553.CAD49C3411B@smtp.kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Li Zhengyu (2022-06-12 23:33:27)
> By the clk framework already reference counts prepare/unprepare,
> this if statement should be never true.
>=20
> Signed-off-by: Li Zhengyu <lizhengyu3@huawei.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
