Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250274C39F5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 00:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235488AbiBXX5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 18:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233412AbiBXX5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 18:57:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B1BCF4;
        Thu, 24 Feb 2022 15:56:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1597D61CC4;
        Thu, 24 Feb 2022 23:56:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC86C340E9;
        Thu, 24 Feb 2022 23:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645746991;
        bh=Bcw8mhZnxmHb7B1GOp2cD6Lk6Ab6pk8FChUbZq6MsAw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=SoCrKuP/DYwSeLZt1z2EcFbpR4KSYDL+nIkHkBmjVmBtz7shUJ2pDi3RI8a7gcW6c
         h1hO2eqYriq/Wq9SpVTiDvfKnSC5lfGOr3R+HqgJfXkciCnqFf/RJHrfcHVYSeCtie
         v5yl1HYlJaePLyLtjAovbgXjIhTvcATkJ8m+kDT4WT5VmI0vzYN/7ho7AvLTsTAWi1
         IEdRUOEUcFVGHInNsYkJVy3W2txKBq0OLMnc6xebKNF8FbB7c7awZisJA3ANSIEwlI
         3P2V0eNaJ/7+F+MPRDlj+QtvJwCi0qVAUrTGI/CxEnb1RSD1Tt1lX6eaG8kGm4fSzT
         otIeAzBKjXTJg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1645505785-2271-3-git-send-email-quic_rohiagar@quicinc.com>
References: <1645505785-2271-1-git-send-email-quic_rohiagar@quicinc.com> <1645505785-2271-3-git-send-email-quic_rohiagar@quicinc.com>
Subject: Re: [PATCH v4 2/5] clk: qcom: Add A7 PLL support for SDX65
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, manivannan.sadhasivam@linaro.org,
        mturquette@baylibre.com, robh+dt@kernel.org
Date:   Thu, 24 Feb 2022 15:56:29 -0800
User-Agent: alot/0.10
Message-Id: <20220224235631.6FC86C340E9@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rohit Agarwal (2022-02-21 20:56:22)
> Update A7 PLL Kconfig to reflect support for SDX65.
>=20
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
