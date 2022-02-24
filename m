Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56A64C39EF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 00:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235141AbiBXXzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 18:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235029AbiBXXz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 18:55:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8792C29A560;
        Thu, 24 Feb 2022 15:54:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24F1A61CC5;
        Thu, 24 Feb 2022 23:54:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74BD4C340F1;
        Thu, 24 Feb 2022 23:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645746898;
        bh=h0W0ihc7og3/qJx0Lf4+tLkr6K8fm1aa6d2ppR0HTP8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ZBJVAiNpy3oz2xChv65YCHcJV4f8m9xepdeeRt+E6qJecxAKJFugHSwc+ERLmt7gQ
         rNR3ytjy5Sjsonlvk+e8qItYAZu5fjY+0aMNbl35gyF66+/dtBI8dSs8l1Xi+8LeRz
         vijuZSj59Axm1kuGrtv/KXf1D1PYo9OZc4plTQW49zoSOTvBqdWiUOuWXdqfUbZ3Ku
         6CUj0GYUes5EbQ9sO8CrgzldwhcXT5PCNuqAM7MaabfMR/XYaqlfzmf2PcZTcGVeVq
         sL+fnN4xzPFQUd/tweMW2PaD2dINNw4b2sNQBHX7qLuWMewPGj9Bm1UEqrNFyGap5T
         voT9HaoHMxqvw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1645505785-2271-2-git-send-email-quic_rohiagar@quicinc.com>
References: <1645505785-2271-1-git-send-email-quic_rohiagar@quicinc.com> <1645505785-2271-2-git-send-email-quic_rohiagar@quicinc.com>
Subject: Re: [PATCH v4 1/5] dt-bindings: clock: Add A7 PLL binding for SDX65
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, manivannan.sadhasivam@linaro.org,
        mturquette@baylibre.com, robh+dt@kernel.org
Date:   Thu, 24 Feb 2022 15:54:56 -0800
User-Agent: alot/0.10
Message-Id: <20220224235458.74BD4C340F1@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rohit Agarwal (2022-02-21 20:56:21)
> Add information for Cortex A7 PLL clock in Qualcomm
> platform SDX65.
>=20
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
