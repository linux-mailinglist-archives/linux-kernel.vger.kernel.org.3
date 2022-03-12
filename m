Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 548DA4D6C80
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 05:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbiCLEuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 23:50:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbiCLEuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 23:50:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018C1314;
        Fri, 11 Mar 2022 20:49:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 84AD060A76;
        Sat, 12 Mar 2022 04:49:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D240DC340EB;
        Sat, 12 Mar 2022 04:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647060539;
        bh=J8NQh13S5v2vpddLJISI7AP6ZNVa8WkorQTN/M+/6E8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=kQyvBw/K+GwRi4gANm9Qo237AwTL95BycA6KPyfbG+x+R6qhgQo9y+09ZIjWnaSAf
         488cAbJXL5BCdBlUSIFERi6M+WTbOymW4nXyVKS5M+8RkjxncDqKDos+7UqYWuioLt
         6wmVYRipey2s52ag/qrP+KkYOZOBLPeFytOPFLWeEhR14FBMAMEncaH3KIVbDoHHWr
         IzEpLNlsokAataK+EKglDIjzr1rozmu26OibkynAxNdAGfPyrm44YHwDVfQCSExpw5
         4VG3pbzpH9mgtREheXXV8uK7qJbTdnILJV5Y0LrBBzi03glSf9i8Rg0hwUKf5GwIMG
         yqotF3SDdg/AQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220208183411.61090-4-povik+lin@cutebit.org>
References: <20220208183411.61090-1-povik+lin@cutebit.org> <20220208183411.61090-4-povik+lin@cutebit.org>
Subject: Re: [PATCH v4 3/3] MAINTAINERS: Add clk-apple-nco under ARM/APPLE MACHINE
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Kettenis <kettenis@openbsd.org>,
        Martin =?utf-8?q?Povi=C5=A1er?= <povik+lin@cutebit.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Martin =?utf-8?q?Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Fri, 11 Mar 2022 20:48:58 -0800
User-Agent: alot/0.10
Message-Id: <20220312044859.D240DC340EB@smtp.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Martin Povi=C5=A1er (2022-02-08 10:34:11)
> Acked-by: Sven Peter <sven@svenpeter.dev>
> Acked-by: Hector Martin <marcan@marcan.st>
> Signed-off-by: Martin Povi=C5=A1er <povik+lin@cutebit.org>
> ---

Applied to clk-next
