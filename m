Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B7959CC85
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 01:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238842AbiHVXwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 19:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiHVXwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 19:52:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94674E62D;
        Mon, 22 Aug 2022 16:52:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54385613EA;
        Mon, 22 Aug 2022 23:52:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4D8EC433D6;
        Mon, 22 Aug 2022 23:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661212327;
        bh=L4GRVNZ05scWJPubkQNDt+rH5mz/MmSNbu92NuFqNuY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=tn/yKxrmPtV0+Fpe60ADbXYPJBWZ2/uuySFDZf7rYtknrl7oFfbzBe8gh3EWGLNGg
         iZc64ap5olRR79LYZc+L0c5GLgyqQDTXKZ/L8ru+fgaTFcuZvlSR42TWaEtH8qWkaX
         mGxLKF8QfjL6VqLqmWmUuskMa+Lnd5w2xGdbwtMXyhgDWZLcRX5F96XxgpsLOxysHT
         oy3TeGpy1LWGAklQaHkqa7vEe1SKSb+PGyjksGmR7hS/xZv6ESVb5/65S7v29vYkTs
         07J2w0Np4HZFUS76WrJ7V9/4YtzBpGxGASx10ZRxaD0/38tg6ySjPI3L4or4nthOVe
         BkLRHzSCLmGkw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220822115246.1.I45235b7c40997bc2abf813e4722b4dcdd6aecf6b@changeid>
References: <20220822115246.1.I45235b7c40997bc2abf813e4722b4dcdd6aecf6b@changeid>
Subject: Re: [PATCH 1/2] clk: qcom: gcc-sc7180: Keep USB GDSC power domain on when USB wakeup is enabled
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Mon, 22 Aug 2022 16:52:05 -0700
User-Agent: alot/0.10
Message-Id: <20220822235207.A4D8EC433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matthias Kaehlcke (2022-08-22 11:53:10)
> Set GENPD_FLAG_ACTIVE_WAKEUP for the USB GDSC power domain of SC7180.

Why? Does it fix something? Please add details to the commit text so we
know how urgent of a patch it is and why it is important.
