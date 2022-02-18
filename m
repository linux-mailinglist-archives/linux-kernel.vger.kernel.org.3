Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A0F4BAE52
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 01:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiBRAWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 19:22:14 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:38540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbiBRAWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 19:22:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9AADECD;
        Thu, 17 Feb 2022 16:21:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 618E361B18;
        Fri, 18 Feb 2022 00:21:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD55BC340E8;
        Fri, 18 Feb 2022 00:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645143715;
        bh=avOzWfAlv22MRwZJspRmhyj/pOnSsNZHtgRFvg0cZ4s=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=rJXShRFAcO9xfoDxZu32Jx6jR/w0AVEHg61Vwe4mYymmYH2OHNaTSVK6011W9czT9
         X6r3O5Q92DrNtD7QKJvhEjHZq6k+O9A3BiP6XjK/7j2ANJb+lFguXE+R5bzWGsjeZa
         rpvqnXEWui51MiuUC4eEn9uzHwD+PeH+DUjgm6dMDuCIeNpS9/R8F4e9o7gfXFMb7k
         aSqgcd2lv0tRLnf9mxtH+dbqGZ4p/INhuZ8MVurGO+PQllwvH4ciUN+8p91OKomxMb
         eT8JxKBpHLYy7CqOM1O3g52rTUp/jYnJtgmc15ELIvOerwbjDy1g0TO8XbHbdajVud
         A3/8Fi/3/I5bA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1644919753-28855-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1644919753-28855-1-git-send-email-quic_rohiagar@quicinc.com>
Subject: Re: [PATCH v2 7/7] clk: qcom: Add SDX65 APCS clock controller support
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, manivannan.sadhasivam@linaro.org,
        mturquette@baylibre.com
Date:   Thu, 17 Feb 2022 16:21:53 -0800
User-Agent: alot/0.10
Message-Id: <20220218002155.AD55BC340E8@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rohit Agarwal (2022-02-15 02:09:13)
> Add a driver config support for the SDX65 APCS clock controller. It is pa=
rt

Maybe "Add a driver config" is a little strong for the patch contents.
More like "Update APCS Kconfig to reflect support for another SoC".

> of the APCS hardware block, which among other things implements a combined
> mux and half integer divider functionality. The APCS clock controller has=
 3
> parent clocks:
>=20
> 1. Board XO
> 2. Fixed rate GPLL0
> 3. A7 PLL
>=20
> This is required for enabling CPU frequency scaling on SDX65-based
> platforms.
>=20
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
