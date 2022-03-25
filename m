Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3140A4E6BA2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 01:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354759AbiCYAyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 20:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240383AbiCYAyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 20:54:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38365BB912;
        Thu, 24 Mar 2022 17:52:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DE10CB82707;
        Fri, 25 Mar 2022 00:52:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 908C5C340EC;
        Fri, 25 Mar 2022 00:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648169561;
        bh=afPIp7Wrn5gwJbTJiqcA+R1yT5EH2pA1hoHZRxAkLCA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=PFy+CkxgdWyDtLongKwdzQazC8tQP63vGDlcZxHaE7sTdRLqDa+eeafQGbIB0tW74
         bgy/Ti5BTXUAc5cJ9BE/x9ssmCbM5ePK+xHsjpXglIn1wTViM9UHwJTSyZ3sZ0FzvT
         XcpTWKG94kTulAQD9N600t4uZS2pyuIh6o+YtjjyOSMVvcBS1MRfs/sGU+b+jMtxC1
         sMpu4DqQVDQBTUHg7yOxgR1XDF7+zSNq/vzZjxRtYz3if2wsvZERsqK4cwjNMJIF9M
         dMws6rxxzcTP93fH/uXz5TNlAo9owGV5acRyr7ek1Ph2vfJNfOJ+YfWm+9XalRijGF
         QbB9BDOAtDcHw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220319174940.341137-1-konrad.dybcio@somainline.org>
References: <20220319174940.341137-1-konrad.dybcio@somainline.org>
Subject: Re: [PATCH] clk: qcom: gcc-msm8994: Fix gpll4 width
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Petr Vorel <petr.vorel@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Bastian =?utf-8?q?K=C3=B6cher?= <mail@kchr.de>,
        Jeremy McNicoll <jeremymc@redhat.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Date:   Thu, 24 Mar 2022 17:52:39 -0700
User-Agent: alot/0.10
Message-Id: <20220325005241.908C5C340EC@smtp.kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Konrad Dybcio (2022-03-19 10:49:40)
> The gpll4 postdiv is actually a div4, so make sure that Linux is aware of
> this.
>=20
> This fixes the following error messages:
>=20
> [    0.804491] mmc1: Card appears overclocked; req 200000000 Hz, actual 3=
43999999 Hz
> [    0.805057] mmc1: Card appears overclocked; req 400000000 Hz, actual 6=
87999999 Hz
>=20
> Fixes: aec89f78cf01 ("clk: qcom: Add support for msm8994 global clock con=
troller")
>=20
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---

Applied to clk-next
