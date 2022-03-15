Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 243D64DA596
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 23:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352332AbiCOWqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 18:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352303AbiCOWqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 18:46:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7796911A15;
        Tue, 15 Mar 2022 15:45:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1560E61414;
        Tue, 15 Mar 2022 22:45:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 730A1C340E8;
        Tue, 15 Mar 2022 22:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647384335;
        bh=cYclWpMxswvt/yfS3sPBTJxa4eBcQg9zM+hFxSEdXSM=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=jbfCZMD2H2ftEG9x8xLSn/CNBktQV5PDxEC7hGDay8N9wqCh+ApYymzz3TMWwuXJU
         jrDLP7Ugrrd7Nk9vHf9PXKj/DP8++4WjEaywcB+U7CoHnw9t7q67w6YtIk5lDMdopW
         HZEi2rMn+BgOIRGjBAiWqs7g9RLWYdBi1IqvdZmxEJR1h0YZDmC7vzneJb39ttkI/y
         P/1dHohXtoQ5ZlyR99x0q1LxhpEnum23nwTfNnFZOseRyT/62B1YTUawqZi9dyeLjb
         nBJ1MlJsD9ym8rGGj7wjFEGPXS4UXCFaYM172vBFje86b5X/F0pnV3sXrDEiKY3A37
         FL0UN/Sodo97g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220313190419.2207-10-ansuelsmth@gmail.com>
References: <20220313190419.2207-1-ansuelsmth@gmail.com> <20220313190419.2207-10-ansuelsmth@gmail.com>
Subject: Re: [PATCH 09/16] clk: qcom: krait-cc: drop pr_info and register qsb only if needed
From:   Stephen Boyd <sboyd@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Date:   Tue, 15 Mar 2022 15:45:33 -0700
User-Agent: alot/0.10
Message-Id: <20220315224535.730A1C340E8@smtp.kernel.org>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ansuel Smith (2022-03-13 12:04:12)
> Drop pr_info and change them to dev_info.

Replace pr_info() with dev_info() to provide better diagnostics.

> Register qsb fixed clk only if it's not declared in DTS.
> Also reorganize variable order.

Please don't reorganize variable order.
