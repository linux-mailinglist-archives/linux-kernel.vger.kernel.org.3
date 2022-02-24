Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 474CF4C39FB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 00:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235988AbiBXX5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 18:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235986AbiBXX5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 18:57:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58DABC91;
        Thu, 24 Feb 2022 15:56:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6588961CC4;
        Thu, 24 Feb 2022 23:56:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC79DC340E9;
        Thu, 24 Feb 2022 23:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645747013;
        bh=pIurI+giQoreEeuxLlI/A9Pe8Sl0d1w/lXwipiwdJcc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=NilsZ95kv75uBSSaQDrZGdZjj7GS0MSD7suHZYp67/R8agRY+xX2EpH8NUfkhtXzY
         hMRZP0PFuIvzFz3iyAZDx3EyiFGotZQGZkV6DWzbxW4d1IGxjz8pIhfqkdX7DG5b9u
         fNa1Y9S/Kyp7nuGsS8oFyH0H6iK0x4u915+62eCNzL8/gc4j+R84pPmigyjlcrm0Fw
         p9qnnFeI9PkaVYMBxhtvhpNuX8AA/4BF2cN5NNrryFM7gKfnUP24YNoJlN9AXq3iaR
         +CEKKd6/kjS8U26WBHn/r/be1neQNJNG6LLtxXNaalXMSTEXiw/vsK5SgVE+9AiUBn
         3I1noFCDI87SQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1645505785-2271-4-git-send-email-quic_rohiagar@quicinc.com>
References: <1645505785-2271-1-git-send-email-quic_rohiagar@quicinc.com> <1645505785-2271-4-git-send-email-quic_rohiagar@quicinc.com>
Subject: Re: [PATCH v4 3/5] ARM: dts: qcom: sdx65: Add support for A7 PLL clock
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, manivannan.sadhasivam@linaro.org,
        mturquette@baylibre.com, robh+dt@kernel.org
Date:   Thu, 24 Feb 2022 15:56:51 -0800
User-Agent: alot/0.10
Message-Id: <20220224235653.BC79DC340E9@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rohit Agarwal (2022-02-21 20:56:23)
> On SDX65 there is a separate A7 PLL which is used to provide high
> frequency clock to the Cortex A7 CPU via a MUX.
>=20
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
