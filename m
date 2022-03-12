Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8AF4D6C08
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 03:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbiCLC1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 21:27:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiCLC1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 21:27:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E261189A36;
        Fri, 11 Mar 2022 18:26:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DBE1E616B6;
        Sat, 12 Mar 2022 02:26:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DFE7C340E9;
        Sat, 12 Mar 2022 02:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647051988;
        bh=Zeuyx2rScKxvxKWuM9DbkDmX25CXsaOKuUUw+F2iox8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=UvD4fcz/4JGB2eJcG6rzFnxIOpqdtRmvZDCzo/gafOuvMkWADyXt8k6srrZjVjLf/
         Y5mqCmiIJPz89x67DVstxzT5PTEmaMRyRKktZIvCXDpEq4gdM6WpdtMlN3Tw7jjjco
         Q2upYOV0E/QXnzClIqLWX81Oz5sSX2Bi8+AWYQAwZINopgcREcKsXWFAiIVm1gKJkZ
         jTNkuICBjDA3Ll1S9sOlUvpHdatlZ3L/rcfqHdTUJyjO3vjX41aSnMgOU5Ud1+hSQt
         SH0rd94m4gZodnRVHnoUP2LKz8upGe3uVY4HXQgo3buzQ0J+sioZDYTIoRy08t3iM4
         iAdO0IMpPD7Ug==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220222130903.17235-3-shubhrajyoti.datta@xilinx.com>
References: <20220222130903.17235-1-shubhrajyoti.datta@xilinx.com> <20220222130903.17235-3-shubhrajyoti.datta@xilinx.com>
Subject: Re: [PATCH 2/2] clk: zynq: Update the parameters to zynq_clk_register_periph_clk
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     git@xilinx.com, michal.simek@xilinx.com,
        linux-kernel@vger.kernel.org,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        linux-clk@vger.kernel.org
Date:   Fri, 11 Mar 2022 18:26:26 -0800
User-Agent: alot/0.10
Message-Id: <20220312022628.3DFE7C340E9@smtp.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Shubhrajyoti Datta (2022-02-22 05:09:03)
> In case there are only one gate or the two_gate is 0 the clk1 clock
> passed is not used. We are passing 0 which is arm_pll.
> Pass a invalid clock instead.
>=20
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---

Applied to clk-next
