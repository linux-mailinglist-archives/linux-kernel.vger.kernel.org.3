Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96EF59CE38
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 04:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239458AbiHWCDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 22:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239154AbiHWCDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 22:03:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0590BA45F;
        Mon, 22 Aug 2022 19:03:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A55E1B816BF;
        Tue, 23 Aug 2022 02:03:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 618BFC433D6;
        Tue, 23 Aug 2022 02:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661220215;
        bh=uwXh7vpM16iG9pRVfhklSlG8A4y8HJmYrDh4KVV3/WM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=QHZsAjx/Vt5NKxITtZCygnZaBw2V1JDMk+mnXWE1Plg+FP48CrjfMPeSU1DV+jvBG
         xvkCZMhj9yHWdGl04dCdENonu3p9220Bo+m3whwwxYnN30/0Mt8QUv7hAURHAnQKZD
         q2w+glGqD/g+vAJ4oZctIvfrL8wFcwJWxhTyfqAgcF0xRErUXru/gmsWA/XSL+vkfI
         2Nl4x+rCqON3jaMcCIHj4wxzoeyKkqxQzZ6Mjjn9gJn0clILr/Ezs9MSWMl/U7Rw8f
         ELq3+VUoOZjPSDHkmM8f9KDRhej5nZuD35fJ0+BUOFgEXk7Lzat7z5ctrWEoavWf/i
         kPrxqwNo6vRGw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220411100443.15132-4-shubhrajyoti.datta@xilinx.com>
References: <20220411100443.15132-1-shubhrajyoti.datta@xilinx.com> <20220411100443.15132-4-shubhrajyoti.datta@xilinx.com>
Subject: Re: [PATCH v14 3/5] clk: clocking-wizard: Rename nr-outputs to xlnx,nr-outputs
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        linux-clk@vger.kernel.org
Date:   Mon, 22 Aug 2022 19:03:33 -0700
User-Agent: alot/0.10
Message-Id: <20220823020335.618BFC433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Shubhrajyoti Datta (2022-04-11 03:04:41)
> Rename nr-outputs to xlnx,output.
>=20
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---

Applied to clk-next
