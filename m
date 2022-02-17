Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099864BAC53
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 23:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243725AbiBQWIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 17:08:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbiBQWIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 17:08:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875E11275A;
        Thu, 17 Feb 2022 14:08:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2446761715;
        Thu, 17 Feb 2022 22:08:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76DB9C340E8;
        Thu, 17 Feb 2022 22:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645135709;
        bh=k6yECMX/H0ZutK60ykgRkuQjf0ogfls3PRMAvzZfsvY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=RLU/xan9m98c0kkEyQ2m8cYTCFNf5t7ceulsGVIpwUz9ehn6lZdsQF0/ChJnPcAMp
         7c12uP0zhB8l8NuUhwOny6s4Oeg9TlDn+oxj1Vlu7UtLsAewyOXGtApz9+OGaUg8ru
         YcBpWa+WgvoFSCMPhH6AxseW0UND3fIeytC6YxiME4zrYFeMhD5+URMBn0cz1yWNIY
         2tVZEqOBvr2MUINdcgbA9RjGcKwIooYfdH3OB/SaLYh+NpT0oFtgwA+o0/XZL6Z59r
         RJ5cdUDLnlLAAAUCEI6BYjmZbCgb1OBRY6rr5/U/RsyePGGMfzCQ76G1pwsOyPOAER
         trmo5q8KgC/uQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1644821540-17928-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1644821540-17928-1-git-send-email-quic_rohiagar@quicinc.com>
Subject: Re: [PATCH 0/8] Add APCS support for SDX65
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, dianders@chromium.org,
        jassisinghbrar@gmail.com, linus.walleij@linaro.org,
        linux@armlinux.org.uk, mani@kernel.org, mturquette@baylibre.com,
        robh+dt@kernel.org
Date:   Thu, 17 Feb 2022 14:08:26 -0800
User-Agent: alot/0.10
Message-Id: <20220217220829.76DB9C340E8@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rohit Agarwal (2022-02-13 22:52:20)
> Hello,
>=20
> This series adds APCS mailbox and clock support for SDX65. The APCS IP
> in SDX65 provides IPC and clock functionalities. Hence, mailbox support
> is added to the "qcom-apcs-ipc-mailbox" driver and a dedicated clock
> driver "apcs-sdx65" is added.
>=20

Something is wrong with your series. I only see a couple patches and
they're not threaded.
