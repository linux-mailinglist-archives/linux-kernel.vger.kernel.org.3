Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6DF50C65C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 04:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbiDWCKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 22:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiDWCKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 22:10:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E97C13938D;
        Fri, 22 Apr 2022 19:07:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A9B761581;
        Sat, 23 Apr 2022 02:07:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BCD6C385A4;
        Sat, 23 Apr 2022 02:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650679657;
        bh=Hjoy/MGw9f0k9/2aqTPiEmWu2eaD4BY2AnpOdvDLAGY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=fn7LDR8PWloLKeb2pm4TPrApcLRZDC865eOSAbwBjgTLkdzBr4LIi5Amx2lh1gSVF
         1+/e88vJYHA1XrSBttWCwAGg26yxgqkupQiCBNrgb9i6bnfqtJiBQnHrsizTVEVEyj
         ygGkUVupgtmC7Fz5OnB6hZIugl1hTBbsxehkROTSxVPlLCqVWVz8lvmnFeffl/pTmU
         jc15Dvpwsaf8oEFAqcKOyTyPIDxvc5XhwDj3FDU1kkW0ZzbdD1eYasZ//OK6UZWhlw
         1fd8elPLHnXOm8kAcrdXdvSmSAPGeOpKFjVFVDBD9aDEoAFHyX6rfFq9DnZi1v7bJE
         GBpPB8bW7T6uA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220415190343.6284-3-g-vlaev@ti.com>
References: <20220415190343.6284-1-g-vlaev@ti.com> <20220415190343.6284-3-g-vlaev@ti.com>
Subject: Re: [PATCH v2 2/2] clk: keystone: syscon-clk: Add support for AM62 epwm-tbclk
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, nm@ti.com, vigneshr@ti.com,
        Georgi Vlaev <g-vlaev@ti.com>
To:     Georgi Vlaev <g-vlaev@ti.com>, mturquette@baylibre.com,
        robh+dt@kernel.org, ssantosh@kernel.org
Date:   Fri, 22 Apr 2022 19:07:34 -0700
User-Agent: alot/0.10
Message-Id: <20220423020737.5BCD6C385A4@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Georgi Vlaev (2022-04-15 12:03:43)
> AM62 has 3 instances of EPWM modules. Each EPWM module has
> an EPWM TBCLKEN module input used to individually enable or
> disable its EPWM time-base clock. The EPWM time-base clock
> enable input comes from the CTRLMMR_EPWM_TB_CLKEN register
> bits 0 to 2 in CTRL_MMR0 module (6.1.1.4.1.48 [1]). This
> is virtually the same setup as in AM64 but with 3 instead
> of 9 clock providers on AM62.
>=20
> Update the driver with the 3 instances of clocks associated
> to a new compatible: "ti,am62-epwm-tbclk".
>=20
> [1] https://www.ti.com/lit/pdf/spruiv7
>=20
> Signed-off-by: Georgi Vlaev <g-vlaev@ti.com>
> Tested-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---

Applied to clk-next
