Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E61A1485D6A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 01:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343908AbiAFAn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 19:43:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343934AbiAFAn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 19:43:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03FBC0611FD;
        Wed,  5 Jan 2022 16:43:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A4F1BB81EB7;
        Thu,  6 Jan 2022 00:43:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CAFDC36AE9;
        Thu,  6 Jan 2022 00:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641429835;
        bh=jG2RGlWhXUEUSTiW57VcCVXKTF61soCXqkkZyoFMAhQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Z4mRspc0W8d9NNVqZE8KNiGAUeRAZv1DfpKZ42N1C96y2YHYz97QnLuhXUSy+ppTE
         KACstyvhcxkidn3k3USx5VQIo+/redxj/yW8MDkscBgV79afeHZmIztBPTzodHZbge
         my47lYCpwFq/zIxxPot0kRnCdbuW5V2pjhMyd4Cz6WCd4x37qakeRWlVZ87u4iSzoS
         TIHggG6GqNJJcTeo/HDKnTA7Llqoh+Zw61nsh/VFGHNT5TZf/s/8Y21BhhqzNNk/MV
         9JudKj1I+stkJrx6ETYOXOazy9wQeLXaidfKrnyiOahaWOH5bK+Zav6S2owKSOCN7W
         rRJ5V+Oaw957w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210907085144.4458-1-caihuoqing@baidu.com>
References: <20210907085144.4458-1-caihuoqing@baidu.com>
Subject: Re: [PATCH] clk: socfpga: s10: Make use of the helper function devm_platform_ioremap_resource()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Dinh Nguyen <dinguyen@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     caihuoqing@baidu.com
Date:   Wed, 05 Jan 2022 16:43:54 -0800
User-Agent: alot/0.9.1
Message-Id: <20220106004355.4CAFDC36AE9@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Cai Huoqing (2021-09-07 01:51:43)
> Use the devm_platform_ioremap_resource() helper instead of
> calling platform_get_resource() and devm_ioremap_resource()
> separately
>=20
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---

Applied to clk-next
