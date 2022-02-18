Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8874BAE55
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 01:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiBRAXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 19:23:15 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:42644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbiBRAXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 19:23:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F1032EDB;
        Thu, 17 Feb 2022 16:22:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B4D9618CA;
        Fri, 18 Feb 2022 00:22:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 018E4C340E8;
        Fri, 18 Feb 2022 00:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645143777;
        bh=QsBeAA9aTNAaKNuNHFHnjNCTfMKRWeJ2IgcV1QDP6UQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=MtTrrTosN5gB7KsMVMgDKo4BC87jU7/oyENy76PEal8cmw9XYQ1JPAqVyVHBtzfFB
         d7ETZfkaOW1ug4SfdTMfRPNhCVNj/ycPAl6rQQGUTCfBo2ekd4cfJ1MB7vzbGZgGGA
         3NuMD6wt0SgvzfULYoq2zypALmVkep5DJvORUa3fzr8+M1PMKYMkpKJfMCLepW+CxS
         wDwwYF+kBvFvvS/v+QcBN7Cr8tz+fQsKHmi7M1u8lR/VebLU0WjG6jdVAGgYRXXRCm
         JtwonqD6TjCjYG8GyiNs2AZBJD4sonCDWQlQtPOkzkq7NphDGUNQp1wYOmwK6Y+jkz
         lhaTo/aek1O+w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1644919338-27393-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1644919338-27393-1-git-send-email-quic_rohiagar@quicinc.com>
Subject: Re: [PATCH v2 4/7] clk: qcom: Add A7 PLL support for SDX65
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, manivannan.sadhasivam@linaro.org,
        mturquette@baylibre.com
Date:   Thu, 17 Feb 2022 16:22:55 -0800
User-Agent: alot/0.10
Message-Id: <20220218002257.018E4C340E8@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rohit Agarwal (2022-02-15 02:02:18)
> Add support for PLL found in Qualcomm SDX65 platforms which is used to
> provide clock to the Cortex A7 CPU via a mux. This PLL can provide high
> frequency clock to the CPU above 1GHz as compared to the other sources
> like GPLL0.
>=20
> In this driver, the power domain is attached to the cpudev. This is
> required for CPUFreq functionality and there seems to be no better place
> to do other than this driver (no dedicated CPUFreq driver).
>=20
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
