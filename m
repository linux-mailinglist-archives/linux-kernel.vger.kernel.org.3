Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB94546AB55
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 23:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356465AbhLFWYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 17:24:47 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:39780 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236193AbhLFWYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 17:24:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 27597B815AE;
        Mon,  6 Dec 2021 22:21:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B47C5C341C6;
        Mon,  6 Dec 2021 22:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638829274;
        bh=F8ejg9ujilnXLjN5vbT63HubpoxPpXXzuMEESv4d67U=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=jkYt58Xa3kuSS9fJfeEPEXJ/6T1lSPT+39FQSw5I1gqLweDsYjI/rsEpb+UeU2Yzb
         5LcLGxyDrJihkAGqe1hbolCR8vq/MT14pSFwEKCkUKgfmhj5AzBFELX/aQ0Xuw8yHI
         pICL46wRODVlVjpFXWLQGmIfuGxRqMJZcSTwZI+6ckgO2T8gSBXwKcZAsJfQzxCTxF
         ZKrhV+Joerp/6Nnc0KdLWWv3zBtFji0CmV5DW7wQkan/NxdMzPD1Y2nwnJZ6m2EX4V
         /A63auMXVuGOoiZDWr9V1ZLgdMTjSg3kTcIAuWB3FxDDEZtUyW0KDFTmRvRtz44SZL
         t8Zrmrzj33BCA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Ya4rtHSS1tLm7Gbi@builder.lan>
References: <20211031020715.21636-1-shawn.guo@linaro.org> <20211031020715.21636-4-shawn.guo@linaro.org> <Ya4rtHSS1tLm7Gbi@builder.lan>
Subject: Re: [PATCH 3/3] clk: qcom: smd-rpm: Drop binary value handling for buffered clock
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>
Date:   Mon, 06 Dec 2021 14:21:13 -0800
User-Agent: alot/0.9.1
Message-Id: <20211206222114.B47C5C341C6@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2021-12-06 07:26:44)
> On Sat 30 Oct 21:07 CDT 2021, Shawn Guo wrote:
>=20
> > The buffered clock binary value handling added by commit 36354c32bd76
> > ("clk: qcom: smd-rpm: Add .recalc_rate hook for clk_smd_rpm_branch_ops")
> > is redundant, because buffered clock is branch type, and the binary
> > value handling for branch clock has been handled by
> > clk_smd_rpm_prepare/unprepare functions.
> >=20
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
>=20
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Does that mean you picked it up? Or you want me to pick it up?
