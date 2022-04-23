Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF76650C65F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 04:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbiDWCKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 22:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiDWCKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 22:10:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7282113938B;
        Fri, 22 Apr 2022 19:07:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65F7E61567;
        Sat, 23 Apr 2022 02:07:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8EDFC385A4;
        Sat, 23 Apr 2022 02:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650679635;
        bh=MExnA3LKJEUispCyI3iv9+WS+kRHS7vEc00i0B1h/Hc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=mR1Y1HKNss4OupagS2acmXNgRzQ56ciBYy88RleOg9L17pcEQLzkp74kE4KTEOMEV
         DfDVI2IuRX8GSpw+4VhM5PPSdiE0w5elZVqNHSuFYICKr+swHrd9RppjuueaXzt7pL
         mn+CM22MZ2XLR78eCh59qeEHuiJdd59kObULhw0WDPYDJ4K0wDNkZicPD8Rw18H75i
         OMOm0gzs+fPgYYS6bcAQ/RaY+9hUW5wZrW4cx1Z3lt2WS7sccOI2cdZpT2GL3FcLMr
         tYGZjkRHflSeAII+CEmbXeWQyaWBdBMFewKxp2zJnBqQpqQ90FcXdtMnbW8DOMO/I1
         +clqhiiOu3Usg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220415190343.6284-2-g-vlaev@ti.com>
References: <20220415190343.6284-1-g-vlaev@ti.com> <20220415190343.6284-2-g-vlaev@ti.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: ehrpwm: Add AM62 specific compatible
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, nm@ti.com, vigneshr@ti.com,
        Georgi Vlaev <g-vlaev@ti.com>
To:     Georgi Vlaev <g-vlaev@ti.com>, mturquette@baylibre.com,
        robh+dt@kernel.org, ssantosh@kernel.org
Date:   Fri, 22 Apr 2022 19:07:12 -0700
User-Agent: alot/0.10
Message-Id: <20220423020715.B8EDFC385A4@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Georgi Vlaev (2022-04-15 12:03:42)
> Introduce AM62 specific compatible for EPWM time-base
> sub-module clock. The time-base clock setup is identical
> to AM64. The only difference is AM62 provides 3 time-base
> clocks instead of the 9 found in AM64.
>=20
> Signed-off-by: Georgi Vlaev <g-vlaev@ti.com>
> Tested-by: Vignesh Raghavendra <vigneshr@ti.com>
> Reviewed-by: Nishanth Menon <nm@ti.com>
> ---

Applied to clk-next
