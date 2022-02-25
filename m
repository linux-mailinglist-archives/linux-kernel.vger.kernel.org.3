Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19A94C51BB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 23:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238814AbiBYWsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 17:48:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiBYWsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 17:48:10 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC5563BCF;
        Fri, 25 Feb 2022 14:47:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 380C7CE2738;
        Fri, 25 Feb 2022 22:47:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63E24C340E7;
        Fri, 25 Feb 2022 22:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645829252;
        bh=ZWAUhBJxg8NCTwiRaWSx+UQdJz9T7y5h3/hdV7NXs9U=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=YIAkmATeuQzv7tkGWIScYHZZ6X2DrOIsvq4GuH4oBPUhEMCaj+zPL7ocfOhL/Fwxf
         WnUOhkOkjTpC7oq++3Nb/TEkpy0mqSx75efEjSp8pJDoUHcIs+ZN1tq1htO5HJ/XBM
         dofFrC4gabTV2DBBZ1CsOFovnCV1DDEFbxAILwbiHNEobym+SIVb50rH6BLVgCMjzs
         XvQo+z8+GyqgL20Z9BnSWHQ43PoPs98NmRYyPPe52JU6y/bavi0eUU3RSdiF5xUC84
         D20TAWbZm5vvIwE4pjzkjaBZwZ8j5+C+g3sJ4l5QLyaiFQ6zuS72k75CdbcqcCxPeX
         o2TF/UsZBmsiQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220222082140.2073629-1-abel.vesa@nxp.com>
References: <20220222082140.2073629-1-abel.vesa@nxp.com>
Subject: Re: [PATCH] dt-bindings: fsl: scu: add imx8dxl scu clock support
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>, linux-clk@vger.kernel.org
To:     Abel Vesa <abel.vesa@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>,
        Rob Herring <robh@kernel.org>
Date:   Fri, 25 Feb 2022 14:47:30 -0800
User-Agent: alot/0.10
Message-Id: <20220225224732.63E24C340E7@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2022-02-22 00:21:40)
> Add imx8dxl scu clock support.
>=20
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
