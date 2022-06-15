Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF1554D226
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 21:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350438AbiFOT4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 15:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350416AbiFOT4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 15:56:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DB02F027;
        Wed, 15 Jun 2022 12:56:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5E6D60BA5;
        Wed, 15 Jun 2022 19:56:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 381A3C34115;
        Wed, 15 Jun 2022 19:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655323001;
        bh=hTYG6s1u5kGTRIJKtbzopTzVK9GFB8oMOCCuo9hUAAU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Wqt97L1LQeSMYjrXVRa3+bbiKckk9wya+TCSwIsa9GXTEzMM1SmDmM3+uevKiQ7HG
         G3E8IcCgB1nYTbzsaDmLCLm7DRy7TrPL3FWUmolbM6gTMhzatB2XevsRtl5LyYQKs6
         SnrnDZ/l/GUUqCJlzWDYBaSMLqTZfooBQazu3cC2eTaNyhbDic1tXPOusM2h5OyWj/
         fK81BGSfGyoq8w5+ekHGk3lFD7JhidnaPPygOVZ0n5A6gTjcJR/opOTKx0b0o3RNcy
         Qlwrfa/whjm1HXWc0Obn0jV7RvBUWt77dqXQyiyPgK4Q5xoOPuv3uDsjV07a6R44j6
         cavceXfBNE8/g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220614153306.29339-3-quic_tdas@quicinc.com>
References: <20220614153306.29339-1-quic_tdas@quicinc.com> <20220614153306.29339-3-quic_tdas@quicinc.com>
Subject: Re: [PATCH v5 2/3] dt-bindings: clock: Add support for external MCLKs for LPASS on SC7280
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org, robh+dt@kernel.org,
        Taniya Das <quic_tdas@quicinc.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <quic_tdas@quicinc.com>
Date:   Wed, 15 Jun 2022 12:56:39 -0700
User-Agent: alot/0.10
Message-Id: <20220615195641.381A3C34115@smtp.kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2022-06-14 08:33:05)
> Support external mclk to interface external MI2S clocks for SC7280.
>=20
> Fixes: 4185b27b3bef ("dt-bindings: clock: Add YAML schemas for LPASS cloc=
ks on SC7280").
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
