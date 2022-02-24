Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 072D44C3869
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 23:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235216AbiBXWIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 17:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235206AbiBXWIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 17:08:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CF21A12B4;
        Thu, 24 Feb 2022 14:07:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 033EBB829BE;
        Thu, 24 Feb 2022 22:07:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90BA7C340E9;
        Thu, 24 Feb 2022 22:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645740462;
        bh=NWQAkw8h6/6wHlusCYYmtiO9h8ml+L20No4ItQVfjfE=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=hCs4e9Dk8PkpIvry+Xx1zChnStmmAhvcA9GHHk7Qf2TeTcvKkZiHpi8wO6R54MC8+
         gpuHrL4wMjz/g2aRWoi3i0SAQS4tieswYlp9XVRPkDtHfx6HKRROEqewOeTcjJH93H
         c6R4Zg+ytHSBgtmGOClL3n1TTDFY7cD1rgaOri/z1pZLjN3cIiwJKKkyP+/0ebgrks
         2wlVMM7SzmrgLOJNzLCra5C0fi67RwVMR6nyzKRjSXofYeyUFcRCYCBLn5QH/a5So3
         tWycJWhtHlowJ/wcn2m0lIYVuFnjqev9+ucjU7kCtlSQmo/aZsmKI0xkFkXKkC2WEX
         biyDqZSL4w78g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220224164831.21475-5-ansuelsmth@gmail.com>
References: <20220224164831.21475-1-ansuelsmth@gmail.com> <20220224164831.21475-5-ansuelsmth@gmail.com>
Subject: Re: [PATCH v5 04/15] clk: qcom: gcc-ipq806x: fix wrong naming for gcc_pxo_pll8_pll0
From:   Stephen Boyd <sboyd@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Taniya Das <tdas@codeaurora.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 24 Feb 2022 14:07:40 -0800
User-Agent: alot/0.10
Message-Id: <20220224220742.90BA7C340E9@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ansuel Smith (2022-02-24 08:48:20)
> Parent gcc_pxo_pll8_pll0 had the parent definition and parent map
> swapped. Fix this naming error.
>=20
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
