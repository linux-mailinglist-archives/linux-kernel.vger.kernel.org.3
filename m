Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF0F4C3B46
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 02:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236591AbiBYBzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 20:55:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236586AbiBYBzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 20:55:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4B529EB89;
        Thu, 24 Feb 2022 17:54:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79B8561330;
        Fri, 25 Feb 2022 01:54:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBBCDC340EB;
        Fri, 25 Feb 2022 01:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645754070;
        bh=kycMrUN1WEI5srmmMPpg1iEqDcJ1sVjM56iKmh9KRqQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=qqmEUxXjecGbRIB02ZAcL+stxDi397H8AQPnEuEtgXq+axoxBU54Gfw6/ZnI5VvM7
         Rm5jY4Dn2Be0rp0WfRdKap+O8Q3QxemlccoWeSWGCjoAKxOiDpcF1EixCdBGEJEqfW
         FdjrEeVJEXeZOf0P0yxpX5CuAA4lhHiF5dQauFkx1R1UMqVitAlnXEXi1P0NPB/NDq
         VMYX6oTbjULMAIVASDgZOv2jd7PuKF3sHnuN3J06e1nNKT/NC0w+jKRpIP3ZoZT27W
         sqdUYiBJ1Y/2bS3kdiJwHzjStz9XHLFwsHzNlLUHcgvIYsi/UBsnuMS8wGt5+OVgzZ
         MZdSL5d4UDl5A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220225014234.1766305-3-peng.fan@oss.nxp.com>
References: <20220225014234.1766305-1-peng.fan@oss.nxp.com> <20220225014234.1766305-3-peng.fan@oss.nxp.com>
Subject: Re: [PATCH V5 2/5] dt-bindings: clock: add i.MX93 clock definition
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh@kernel.org>
To:     Peng Fan (OSS) <peng.fan@oss.nxp.com>, abel.vesa@nxp.com,
        robh+dt@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org
Date:   Thu, 24 Feb 2022 17:54:29 -0800
User-Agent: alot/0.10
Message-Id: <20220225015430.CBBCDC340EB@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Peng Fan (OSS) (2022-02-24 17:42:31)
> From: Peng Fan <peng.fan@nxp.com>
>=20
> Add i.MX93 clock definition
>=20
> Reviewed-by: Abel Vesa <abel.vesa@nxp.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
