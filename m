Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5214BACCE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 23:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343936AbiBQWlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 17:41:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343899AbiBQWlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 17:41:13 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883A6169222;
        Thu, 17 Feb 2022 14:40:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 04150CE30B9;
        Thu, 17 Feb 2022 22:40:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B12DC340E8;
        Thu, 17 Feb 2022 22:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645137655;
        bh=yoTB+6/Yc1ALwNbkIdzFCVW+ORJTwmp5y3hdBLcMKHM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=FBis+/IP9pl4fr2BzA6QOFnz5xXZG2wScA6yOJ+bmxwNBtgqRktc7M5HkXrFoKAy+
         rpCVe02qXyWLBL+38g31Srpk98DFeTGPqf7SCqu9SLJ7xPniz0Lf8194NNbIIlylaU
         sL4g/L8sUU7QR/vO6xzsyGUSii4FwKU3k6F8+bpIRrcOfuHSgppLJKq2Bw9DORZz1y
         9JLSrgfE1CM/xLfF51IAOtrp8b+VYLiEh0JEdPv5/KolpYB2vO2VL6xqvmsQV/hx0n
         uIQfETbClephaK2cPi1HSE1KQ3wI7Nc3Bd6WAm6VGo2/0YkmpPHMIV6JccalPNrNF4
         hHNBePc8+QbeQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220126081236.25255-2-tdas@codeaurora.org>
References: <20220126081236.25255-1-tdas@codeaurora.org> <20220126081236.25255-2-tdas@codeaurora.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: clock: Add YAML schemas for LPASS clocks on SC7280
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org, robh+dt@kernel.org,
        Taniya Das <tdas@codeaurora.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
Date:   Thu, 17 Feb 2022 14:40:53 -0800
User-Agent: alot/0.10
Message-Id: <20220217224055.5B12DC340E8@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2022-01-26 00:12:35)
> The LPASS(Low Power Audio Subsystem) clock provider have a bunch of gener=
ic
> properties that are needed in a device tree. Also add clock ids for
> LPASS core clocks and audio clock IDs for LPASS client to request for
> the clocks.
>=20
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
