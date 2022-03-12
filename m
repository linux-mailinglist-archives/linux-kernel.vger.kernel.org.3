Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041AC4D6C06
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 03:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbiCLC12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 21:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiCLC11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 21:27:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C8937BE2;
        Fri, 11 Mar 2022 18:26:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 86D73B82D86;
        Sat, 12 Mar 2022 02:26:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 156C7C340E9;
        Sat, 12 Mar 2022 02:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647051980;
        bh=OyzWWhJZ/FOGKF9SCYZwG4ZqaksUleOGRHiM9v7SQ4M=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=g7Ht/wlCTxzHj/gMAqongUZZqw0V198LBfu5xjrsmur3u3gAqiazpneVT3nwStqHX
         PbdGFpuNdhPxtm7cPPsBeH7zQs5Tu4HGybmdROEnV95FvjWu0HyYXr2kkYLKd0RNn0
         u50eRgk4dP1Y1l3L1O1lNYty59kMh//J6b2O+Z/aSBK25dyGWX6G7oyYJ57KDIGQNT
         6qA5Y4R2FmiPdpEskCq9lCUtsqTlSNuNNouJIrEGYkTUgPS6KgGyvBLxPFFfxTkbFa
         5vEpIlAYQEwZM98essk5vVAcs1Z/acMuSmIufJQoJJlpTM/KAye5Jd2a7HKNPsqfmG
         G3x923MYiozwg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220222130903.17235-2-shubhrajyoti.datta@xilinx.com>
References: <20220222130903.17235-1-shubhrajyoti.datta@xilinx.com> <20220222130903.17235-2-shubhrajyoti.datta@xilinx.com>
Subject: Re: [PATCH 1/2] clk: zynq: trivial warning fix
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     git@xilinx.com, michal.simek@xilinx.com,
        linux-kernel@vger.kernel.org,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        linux-clk@vger.kernel.org
Date:   Fri, 11 Mar 2022 18:26:18 -0800
User-Agent: alot/0.10
Message-Id: <20220312022620.156C7C340E9@smtp.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Shubhrajyoti Datta (2022-02-22 05:09:02)
> Fix the below warning
>=20
> WARNING: Missing a blank line after declarations
> +               int enable =3D !!(fclk_enable & BIT(i - fclk0));
> +               zynq_clk_register_fclk(i, clk_output_name[i],
>=20
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---

Applied to clk-next
