Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A5559CE3D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 04:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239469AbiHWCEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 22:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239143AbiHWCEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 22:04:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D5CF590;
        Mon, 22 Aug 2022 19:03:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B56DEB81A3C;
        Tue, 23 Aug 2022 02:03:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 561D0C433C1;
        Tue, 23 Aug 2022 02:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661220236;
        bh=cOzpzcKwrveIkFiLJWWAeNTdKFJlgGFRv/2yzXjhD20=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=dqRY+UHsveRX2pI7lbX7amJvq6fArjhvbXuwePDzeCYQIKzAczBJGoA4mHG22c8LG
         bz/HNqN7oL1Bt7ApDlf8lAGUR6T8tkz+n8Yfd7ptOGgr7De4QndM8FaZ9H/oW3NwIt
         BEngt4rREz5CCfVU+E1D5PNwx/hTIUqCUzvVpZ7xbUZjN291YW2yu2zi+dLEEa6hPT
         fTrKHH2qNBV+mcC/6u71C8mHt3dcJreGMI5pzNJ3x7rzFqt8djv5WJbpzBTWWmy29K
         ozp5FRKItmTOU0ZFAvvJoJufKKiS7b62+tXgJici5NkedQiwG5VxFk+faET/ox5oYg
         BLbde+rwEE5BQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220411100443.15132-5-shubhrajyoti.datta@xilinx.com>
References: <20220411100443.15132-1-shubhrajyoti.datta@xilinx.com> <20220411100443.15132-5-shubhrajyoti.datta@xilinx.com>
Subject: Re: [PATCH v14 4/5] clk: clocking-wizard: Fix the reconfig for 5.2
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        linux-clk@vger.kernel.org
Date:   Mon, 22 Aug 2022 19:03:54 -0700
User-Agent: alot/0.10
Message-Id: <20220823020356.561D0C433C1@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Shubhrajyoti Datta (2022-04-11 03:04:42)
> The 5.2 the reconfig is triggered by writing 7 followed by
> 2 to the reconfig reg. Add the same. Also 6.0 is backward
> compatible so it should be fine.
>=20
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---

Applied to clk-next
