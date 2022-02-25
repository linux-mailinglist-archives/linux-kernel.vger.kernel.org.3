Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89D34C3B42
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 02:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236584AbiBYByt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 20:54:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236576AbiBYBys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 20:54:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339FD29DD20;
        Thu, 24 Feb 2022 17:54:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFCC461330;
        Fri, 25 Feb 2022 01:54:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1011DC340E9;
        Fri, 25 Feb 2022 01:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645754057;
        bh=cK99YgEIzZuMyH/Jeu869JzZeWo9rrtFHDUOJIZQFiM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=K8nwUr7OMeaujjyugRj27d9XfZb3sh89oTIyUO9ymVOt/Ap1YT2vdYt9r6LDYr+1u
         /f7ThpPC6IVXs/K5UC/20xR+r5elWfKgXdF2NP5tSZc98JoRFadDZhV5hx4P7ucJix
         DRvOv9vluVSYGgM9KsFRf09J3djjQ259uUCH/RBsTE+cHAOX/tj7kETeID9hpz/o9v
         Csbn3N1HDky7LUU9mYf3/2WU+KFkfuYEtaTMB7klYdBAlGHPmUhKZzRB6mZHYKWiV1
         Q0zeOo5PkTjwN96+vIT/lCIGSWl49h0BEd/FogvFtNb5GW3GdHkPxZl3hKJuJHTFZG
         laB3plc0FQVpQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220225014234.1766305-2-peng.fan@oss.nxp.com>
References: <20220225014234.1766305-1-peng.fan@oss.nxp.com> <20220225014234.1766305-2-peng.fan@oss.nxp.com>
Subject: Re: [PATCH V5 1/5] dt-bindings: clock: Add imx93 clock support
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, Rob Herring <robh@kernel.org>
To:     Peng Fan (OSS) <peng.fan@oss.nxp.com>, abel.vesa@nxp.com,
        robh+dt@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org
Date:   Thu, 24 Feb 2022 17:54:15 -0800
User-Agent: alot/0.10
Message-Id: <20220225015417.1011DC340E9@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Peng Fan (OSS) (2022-02-24 17:42:30)
> From: Peng Fan <peng.fan@nxp.com>
>=20
> Add the clock dt-binding file for i.MX93.
>=20
> Reviewed-by: Abel Vesa <abel.vesa@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
