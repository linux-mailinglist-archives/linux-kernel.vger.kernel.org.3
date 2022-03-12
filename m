Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFA74D6C7A
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 05:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbiCLEuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 23:50:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiCLEtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 23:49:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0315B2C2;
        Fri, 11 Mar 2022 20:48:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6CE6CB801B8;
        Sat, 12 Mar 2022 04:48:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D56FBC340EE;
        Sat, 12 Mar 2022 04:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647060523;
        bh=S0bWRsxYFtupOFptAFXrymcTV8mDH/7x+mVBM89HJM0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ofU0J3Y/WbDhhAfzcuyLflxy9IRDe1z3xVPT4mmFNbOh1vcfdXEbEZNGujA7lm5mf
         7iNHD1bgNC87c1OZsgpGi1txmoffQrRBOTnJAFa6uHv8Fw8gtj3axs0EOvAq/PxNE3
         blnC/Ez1aBN1kDPqjprBqtCPOQToMl2Bb2TxZAeOdpXGQAoJI51VWEmG/+8s1pJErW
         BwSTRMkHmGB6hxBerB1WcCMEDLsh2Xv+MR3I3MRBUxEW+mZ1EPE28SLnQU4EFhEMjp
         J0P0BSaPREPRfn7SGg9LcPagSkjM0rJ6p8q4KL0pJtRMqw9S9CljTp1a/n/hFCisdN
         3xO0a14FK+xFQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220208183411.61090-2-povik+lin@cutebit.org>
References: <20220208183411.61090-1-povik+lin@cutebit.org> <20220208183411.61090-2-povik+lin@cutebit.org>
Subject: Re: [PATCH v4 1/3] dt-bindings: clock: Add Apple NCO
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Kettenis <kettenis@openbsd.org>,
        Martin =?utf-8?q?Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Martin =?utf-8?q?Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Fri, 11 Mar 2022 20:48:42 -0800
User-Agent: alot/0.10
Message-Id: <20220312044843.D56FBC340EE@smtp.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Martin Povi=C5=A1er (2022-02-08 10:34:09)
> The NCO block found on Apple SoCs is a programmable clock generator
> performing fractional division of a high frequency input clock.
>=20
> Reviewed-by: Mark Kettenis <kettenis@openbsd.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Martin Povi=C5=A1er <povik+lin@cutebit.org>
> ---

Applied to clk-next
