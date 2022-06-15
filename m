Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5DE54D238
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 22:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344720AbiFOT7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 15:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346086AbiFOT7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 15:59:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A9F377E3;
        Wed, 15 Jun 2022 12:59:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43613B82172;
        Wed, 15 Jun 2022 19:59:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D73B9C3411E;
        Wed, 15 Jun 2022 19:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655323154;
        bh=b3gdzIx2rCdJ0VJi1URiAC2eWBND9rhvdn4oKkHSk6U=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=c1g1ShxlhAgZGSR56Bax2ge/0+TLozQ0LKFH7lx/Mw4vrpxO/0yJfhLyXCU+FtnVV
         KGcDK/OACc7mdoZmBZyo093cQD5wHBfix3lSz0tE8+yxC7p06WbpBU/oaewoXsTLWy
         0JnNsblkl0+aZvzRc7a9cgVMApiDpK7L4F1CwDiv3rJBvN5BjTShVH/MuROjLHcAAa
         1gDJTRFY2McGho2vATRM2Ebg9unKoOo0uCkkEHaQBO2YEv/6hoSC2IvNL9pxgKGMft
         rmYZuNGZ9JYuNlNq96EaASeSL5eT5hjZEJx5+4XBZTUirVgjq0lJb6bgcliHPy0QPX
         GiJ0Fs8JALe2w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220614153306.29339-2-quic_tdas@quicinc.com>
References: <20220614153306.29339-1-quic_tdas@quicinc.com> <20220614153306.29339-2-quic_tdas@quicinc.com>
Subject: Re: [PATCH v5 1/3] dt-bindings: clock: Add resets for LPASS audio clock controller for SC7280
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org, robh+dt@kernel.org,
        Taniya Das <quic_tdas@quicinc.com>, mka@chromium.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <quic_tdas@quicinc.com>
Date:   Wed, 15 Jun 2022 12:59:13 -0700
User-Agent: alot/0.10
Message-Id: <20220615195914.D73B9C3411E@smtp.kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2022-06-14 08:33:04)
> Add support for LPASS audio clock gating for RX/TX/SWA core bus clocks
> for SC7280. Update reg property min/max items in YAML schema.
>=20
> Fixes: 4185b27b3bef ("dt-bindings: clock: Add YAML schemas for LPASS cloc=
ks on SC7280").
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> ---
>  .../clock/qcom,sc7280-lpasscorecc.yaml        | 19 ++++++++++++++++---
>  .../clock/qcom,lpassaudiocc-sc7280.h          |  5 +++++
>  2 files changed, 21 insertions(+), 3 deletions(-)

I'm still wondering if the binding is correct, given the overlapping reg
properties. Should we be removing a compatible or two and adding a DT
property like "qcom,adsp-bypass-mode" instead?
