Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0DF59CE3E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 04:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239445AbiHWCDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 22:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239154AbiHWCDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 22:03:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A644AD6E;
        Mon, 22 Aug 2022 19:03:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 61A83B81A3C;
        Tue, 23 Aug 2022 02:03:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13DADC433D6;
        Tue, 23 Aug 2022 02:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661220182;
        bh=anRRH7wq2Z1xVfrAbT7RCctcDhQM0lI7BjZZ7PjcpRU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=m9cvtKZIIHqIuiIV9LdZt+jPdxVaOlBZN0yLhxgxv6KU2eK2tftbFerDSsv0a43Ou
         xExzYyoxADIbzbckuKIAptMjMK8BfgZNSgF/oxT6Idv9XAUlMV2LzaHvS7NOe4m9Cw
         /UCFnmtYMscO3oEJJTirPJkF5Hlqna3LLsXHxGFkCGKFd7+GsAtr19WKInutkw/S6V
         5hP1Lwo247olWAGfB60v3tKlM6Zsto9dQO3eBL1ZV9w33MHSV14KyIDs+gVF9GscUm
         jFAsHzZ1zw/n7oGagl5F2bMtXTyvoLAULRN6aGf8M783784OwJIyfMFC6peAEJSj3X
         oNMzo6F5DySQQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220411100443.15132-3-shubhrajyoti.datta@xilinx.com>
References: <20220411100443.15132-1-shubhrajyoti.datta@xilinx.com> <20220411100443.15132-3-shubhrajyoti.datta@xilinx.com>
Subject: Re: [PATCH v14 2/5] clk: clocking-wizard: Move clocking-wizard out
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        linux-clk@vger.kernel.org
Date:   Mon, 22 Aug 2022 19:03:00 -0700
User-Agent: alot/0.10
Message-Id: <20220823020302.13DADC433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Shubhrajyoti Datta (2022-04-11 03:04:40)
> Add clocking wizard driver to clk.
> And delete the driver from the staging as it is in drivers/clk.
>=20
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---

Applied to clk-next
