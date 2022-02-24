Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1334C3A01
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 00:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235983AbiBXX6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 18:58:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbiBXX6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 18:58:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14553BBD2;
        Thu, 24 Feb 2022 15:57:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C8F561CCE;
        Thu, 24 Feb 2022 23:57:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE475C340E9;
        Thu, 24 Feb 2022 23:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645747052;
        bh=sNTYtPi+6hAgPaC/LiwoHJXsz7tSPi4IB1Cl9XDMDio=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=WbBdSpyffyWlomu85xizVE8bw0OA2h93ZckJVBYFR9Xr0eGNIChoJfRYkaPcn1Uko
         Db1mp5I+2MekLBbI9O4zftL2oh55iSzKt/3YhHDwIOT8l4NaIbKQiZ1z4fPDMgYw2c
         fLPN+7GHo3hbg9q67b53DNFkW5zZJEGnjYxIQGEDTA7MRy5weOD704DwPkgob4ZXKK
         Ye4LIQyertL9v1OZNvcVTugjUIKHtF3oLXNd1X9dSzuPVHdlLS9tBV3kMKgpI5sSdC
         heWc3wnX9PHrKlS5SiH4IrwtpudZ/2OH6DS2Ia/LFOv/6I53Iyn+i1YW1IXCrG+CGm
         s6aoXqQzYoKlw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1645505785-2271-6-git-send-email-quic_rohiagar@quicinc.com>
References: <1645505785-2271-1-git-send-email-quic_rohiagar@quicinc.com> <1645505785-2271-6-git-send-email-quic_rohiagar@quicinc.com>
Subject: Re: [PATCH v4 5/5] clk: qcom: Add SDX65 APCS clock controller support
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, manivannan.sadhasivam@linaro.org,
        mturquette@baylibre.com, robh+dt@kernel.org
Date:   Thu, 24 Feb 2022 15:57:30 -0800
User-Agent: alot/0.10
Message-Id: <20220224235732.BE475C340E9@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rohit Agarwal (2022-02-21 20:56:25)
> Update APCS Kconfig to reflect support for SDX65
> APCS clock controller.
>=20
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
