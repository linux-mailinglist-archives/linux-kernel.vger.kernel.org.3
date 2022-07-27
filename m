Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6BA581D17
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 03:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbiG0B2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 21:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbiG0B2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 21:28:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C570A39B98;
        Tue, 26 Jul 2022 18:28:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 612FC61739;
        Wed, 27 Jul 2022 01:28:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF47AC433C1;
        Wed, 27 Jul 2022 01:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658885308;
        bh=FJHTwPVjwUpLkqZKc7E29z9sO9QFIWVvIvMN6Mf8vwY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ubeD/7m2a0mqR+EUJEF3wXDBN83w+s7CW4m3Iu1wOYWHSQr1VTzsPToLR1u+SEQxU
         hEYp/YVpIrLzSB7UFfYJxR/bhn7v396TqD+tV82jtY0ttjVezxKPGPQNkxtgs+LGMb
         3YZek5j9Q6Xadfvirc1PFgL1U0eO7FK6tw3bVqRCNTJZuAa5DDrt/QA5VguJ72PEl5
         UnUpa/zMDAlpNOAzb18a9a/Lk1HT0oom+Aodmq3tHyXWRzLUan9vFQZPv2ls9iQl5L
         8BOAIBBWT9CbsiadxQE8HIO0mzJ8Ty3oYSsEwTaw9UgPwLygncMxhmaKr8cI/iIpGQ
         NiW7lePqH/Egg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1658315023-3336-3-git-send-email-quic_c_skakit@quicinc.com>
References: <1658315023-3336-1-git-send-email-quic_c_skakit@quicinc.com> <1658315023-3336-3-git-send-email-quic_c_skakit@quicinc.com>
Subject: Re: [PATCH V6 2/5] clk: qcom: lpass: Handle the regmap overlap of lpasscc and lpass_aon
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org, robh+dt@kernel.org,
        quic_tdas@quicinc.com, quic_c_skakit@quicinc.com
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Satya Priya <quic_c_skakit@quicinc.com>
Date:   Tue, 26 Jul 2022 18:28:26 -0700
User-Agent: alot/0.10
Message-Id: <20220727012828.AF47AC433C1@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Satya Priya (2022-07-20 04:03:40)
> Move registration of lpass_q6ss_ahbm_clk and lpass_q6ss_ahbs_clk to
> lpass_aon_cc_sc7280_probe and register them only if "qcom,adsp-pil-mode"
> is enabled in the lpass_aon DT node.
>=20
> Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
