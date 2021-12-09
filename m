Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 515F346E40E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 09:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234640AbhLIIZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 03:25:04 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:45116 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbhLIIZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 03:25:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C5D6CB823D2;
        Thu,  9 Dec 2021 08:21:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C0EBC004DD;
        Thu,  9 Dec 2021 08:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639038087;
        bh=/epx/kj5/UGqlUpvoeF11GwQs9DJoP5bPmmJQsxb+Lw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=axTWbOD9oty4jLJP6aofzyvGPzvRzD5JbrmrEDLkyblqMgJL73uJpB9yRh8n2vZrj
         q94wObpXvhdyYkM1sl4SOTuQYx6HpliOY4IbYlWX0WgxzBbIeP/nL+HcbtsDRDlahl
         KcTZnyqDrwPNkAv+KNwkaP5mv1Qn/QKLAMt/tCs83wrz6RwpHfCcO84Y0wG/fM3Mdj
         rTHHxsQ5ST599jNzfa1o/iUoUyVqu87MQm0KaumHooJQ4OdkM4QYqjqgENelMOl4qL
         ho+zzcig5yOjGLWb/8CmJ+tgRLxxKatAOYVljrlKf5165YMf4bw8jQxkz9LaqFGOg/
         VSThHqtwb6jzw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211207114003.100693-2-vkoul@kernel.org>
References: <20211207114003.100693-1-vkoul@kernel.org> <20211207114003.100693-2-vkoul@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: Add SM8450 GCC clock bindings
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Vamsi Krishna Lanka <quic_vamslank@quicinc.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>
Date:   Thu, 09 Dec 2021 00:21:26 -0800
User-Agent: alot/0.9.1
Message-Id: <20211209082127.7C0EBC004DD@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vinod Koul (2021-12-07 03:40:02)
> Add device tree bindings for global clock controller on SM8450 SoCs.
>=20
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
