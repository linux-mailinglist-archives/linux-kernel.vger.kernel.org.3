Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B308052F82D
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 05:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354505AbiEUDvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 23:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239084AbiEUDvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 23:51:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5A1DF66;
        Fri, 20 May 2022 20:51:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 00D87B82F13;
        Sat, 21 May 2022 03:51:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A94B7C385A9;
        Sat, 21 May 2022 03:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653105071;
        bh=Xco6TDsstzeb8QGFaDEm94Qv+grXMuUeEmeIJgPyqeI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=XmnKdCDY+i5JbiJ7qwyW3AcnBgAPXj/NulbjpXx/DirO+9Ydh10sAZWGHjyqDFWWM
         5iLwEa7EkIDJ6sApIFkIQHmGIdwrTjuDWxG6k5/gxSNjYpiIhknqCoGnoHmW42Z66m
         IRKLrGcHUAxrldEb+rs4lF/EK0PoREAHy9MJ84CDSO+qOyAEOp5V9+kToA26dEtRTU
         0AJJDEhTlWIHwC5bmmItwb+bvIoYneJ2r4XtXe9VRsAm8wxKjzuGu4HMM1ANzTG74D
         VPVmvDwMyc2p+b+d7PNPUzFSo6eRmtSyGu/oKZjKzg/Ax7U9N92uw70NSscSQkxLzD
         ZEg0btM72ly7g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220520100948.19622-1-johan+linaro@kernel.org>
References: <20220520100948.19622-1-johan+linaro@kernel.org>
Subject: Re: [PATCH 0/3] clk: qcom: gdsc: add support for collapse-vote registers
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>, quic_tdas@quicinc.com,
        quic_rnayak@quicinc.com
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>
Date:   Fri, 20 May 2022 20:51:09 -0700
User-Agent: alot/0.10
Message-Id: <20220521035111.A94B7C385A9@smtp.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please add Qualcomm on code for their hardware :)

I did a translation from codeaurora but I don't know if Rajendra's will
work.

Quoting Johan Hovold (2022-05-20 03:09:45)
> Recent Qualcomm platforms have APCS collapse-vote registers that allow
> for sharing GDSCs with other masters (e.g. LPASS).

How is it different from the voting logic that already exists in the
gdsc file? Now every subsystem has to vote for off in addition to voting
for on?

>    =20
> Add support for using such vote registers instead of the control
> register when updating the GDSC power state.
