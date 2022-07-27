Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22552581D13
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 03:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239766AbiG0B1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 21:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbiG0B1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 21:27:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A2618B11;
        Tue, 26 Jul 2022 18:27:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1D4A6173F;
        Wed, 27 Jul 2022 01:27:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D561C433D7;
        Wed, 27 Jul 2022 01:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658885236;
        bh=1EM03A7cgT10t6ETsDv24Y36NvsARnyAHgi7fActhFw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=s/CKhG3EBG3qoYOcnzw/yjwBi0/jRDqSbkveZJmjMPCw2Q1OEf9OCHTiUmIbYtfme
         YkvbgoXWl0sttZjJ/ZilFX5tCE25TBCG+0s1znLgSp2aui8Tbb4zzSdPojndZM+cOq
         bQqm2LbjOPeI1a29HhByXnNZPIUFhSna8nn4J8PF0XCTkNbPYzMK70rW9FqJOKy3Dw
         w2r1VYYjJ5ASpsbUq+FTCEWW3awdM+7Vi0UZCUit3hOwcw13p9oVjL6CfePyZdueyO
         v5wJSbf7ys1gwMULlU8sgDMTODA6F59Kaa0oBT4WrNeIYppij3STDbN/ePNwzwII0R
         gRVYUt4zfaXAA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1658315023-3336-2-git-send-email-quic_c_skakit@quicinc.com>
References: <1658315023-3336-1-git-send-email-quic_c_skakit@quicinc.com> <1658315023-3336-2-git-send-email-quic_c_skakit@quicinc.com>
Subject: Re: [PATCH V6 1/5] dt-bindings: clock: Add "qcom,adsp-pil-mode" property
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org, robh+dt@kernel.org,
        quic_tdas@quicinc.com, quic_c_skakit@quicinc.com
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Satya Priya <quic_c_skakit@quicinc.com>
Date:   Tue, 26 Jul 2022 18:27:14 -0700
User-Agent: alot/0.10
Message-Id: <20220727012716.1D561C433D7@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Satya Priya (2022-07-20 04:03:39)
> The LPASS Peripheral loader clocks would be used to bring
> LPASS out of reset, when this property is present.
>=20
> This is a cleanup done to handle overlap of regmap of
> lpasscc and lpass_aon blocks. As a part of this, remove
> the "cc" regmap from lpasscc node.
>=20
> Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> ---

Found it! Can you mention dependencies between patch series?

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
