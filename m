Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 382D6581D20
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 03:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240053AbiG0BaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 21:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240070AbiG0BaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 21:30:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B013AE6A;
        Tue, 26 Jul 2022 18:30:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 32F46B81EB3;
        Wed, 27 Jul 2022 01:30:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7110C433D6;
        Wed, 27 Jul 2022 01:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658885400;
        bh=QDY/yWrZjdSOOdIGN3ttLd/Q3v4Yap/YbD5J8bIhcIM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=DMy2+260JVZ33qZTJrHfBYHvMvnjuhSvmlhFdhuZaNmWjKOtYXW+IFcrhOWPN5pu0
         2hFQfYLZ/arft2Fnwr7/NfYbcW2R0jCyfbb5Ca9O+NsoSKMr7+AAvonl4TMWYfg2ry
         rZNnXeVUbHUjmqUNizmehas+v9E2chfUD/jA/7Ez9UoJPlmUpcYyUzMJ9e0zOmrZol
         FaEP6B0kNoVrdnsuMsfe4a5MgbGdT8qlUWEOwiaY7cSXT6QALlDaSbBYEE8P0cU1ZE
         eRl7eJt5qiic1sHiXfhm/gZf4VDsJNcuMTDcSU+xPzeZ7N9YP2txTRK3SwpfhgHQr8
         G9ctmDlz6o+1g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1658315023-3336-4-git-send-email-quic_c_skakit@quicinc.com>
References: <1658315023-3336-1-git-send-email-quic_c_skakit@quicinc.com> <1658315023-3336-4-git-send-email-quic_c_skakit@quicinc.com>
Subject: Re: [PATCH V6 3/5] dt-bindings: clock: Add resets for LPASS audio clock controller for SC7280
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org, robh+dt@kernel.org,
        quic_tdas@quicinc.com, quic_c_skakit@quicinc.com
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Satya Priya <quic_c_skakit@quicinc.com>
Date:   Tue, 26 Jul 2022 18:29:57 -0700
User-Agent: alot/0.10
Message-Id: <20220727012959.D7110C433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Satya Priya (2022-07-20 04:03:41)
> From: Taniya Das <quic_tdas@quicinc.com>
>=20
> Add support for LPASS audio clock gating for RX/TX/SWA core bus clocks
> for SC7280. Update reg property min/max items in YAML schema.
>=20
> Fixes: 4185b27b3bef ("dt-bindings: clock: Add YAML schemas for LPASS cloc=
ks on SC7280").
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
