Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9B8D46ACF0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 23:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357955AbhLFWq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 17:46:29 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:55410 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351380AbhLFWq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 17:46:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DDEAEB812AC;
        Mon,  6 Dec 2021 22:42:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84491C341CA;
        Mon,  6 Dec 2021 22:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638830576;
        bh=O5L+ghmFFMRvIWQ8qFtFDE7wYKV/a9zmYcJ9rqPpDOY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=M4UUT6+RkTu2r8nwhcVzn5ME753yPdFJ2H7uxX75PGHVAtDjr6K6WP5BI3OHmlKk8
         QoWm3nhhXnojfa0lKxcZlY5O8UBvNUgaZ4fhhs5KDdNsX97UavaxImmYCNaMdXh8Ji
         IymAva91hdw65xZEyHLXk2TcC7AZRS2WuK1TnP5PQwzRyIVHNmDfngvxave75n8o9L
         TNb83a/BY/ILXOuHdMW+94o6Qv1XI0opIWakxGVMQW2ALgpt1nZQXgjqaEJ34+0s5l
         vWuvqACFDqJi0ExXbrGK4aM8BrbjuzcFueY/r7WiDUwlUC+UaaeEBfcJqd3nmUSHv0
         eAyzm77TY3INg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Ya6QgJ9kDuSReZGC@ripper>
References: <20211031020715.21636-1-shawn.guo@linaro.org> <20211031020715.21636-4-shawn.guo@linaro.org> <Ya4rtHSS1tLm7Gbi@builder.lan> <20211206222114.B47C5C341C6@smtp.kernel.org> <Ya6QgJ9kDuSReZGC@ripper>
Subject: Re: [PATCH 3/3] clk: qcom: smd-rpm: Drop binary value handling for buffered clock
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Shawn Guo <shawn.guo@linaro.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Date:   Mon, 06 Dec 2021 14:42:55 -0800
User-Agent: alot/0.9.1
Message-Id: <20211206224256.84491C341CA@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2021-12-06 14:36:48)
> On Mon 06 Dec 14:21 PST 2021, Stephen Boyd wrote:
>=20
> > Quoting Bjorn Andersson (2021-12-06 07:26:44)
> > > On Sat 30 Oct 21:07 CDT 2021, Shawn Guo wrote:
> > >=20
> > > > The buffered clock binary value handling added by commit 36354c32bd=
76
> > > > ("clk: qcom: smd-rpm: Add .recalc_rate hook for clk_smd_rpm_branch_=
ops")
> > > > is redundant, because buffered clock is branch type, and the binary
> > > > value handling for branch clock has been handled by
> > > > clk_smd_rpm_prepare/unprepare functions.
> > > >=20
> > > > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > >=20
> > > Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> >=20
> > Does that mean you picked it up? Or you want me to pick it up?
>=20
> It meant that I reviewed the patch, but as it's not a regression I then
> went on to pick it up for clk-next - there should be a "thank you" from
> a few minutes ago.
>=20
> I'll ensure to include a note for you in the future when it could go in
> either branch.
>=20

Ok, thanks.
