Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED246485DFF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 02:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344270AbiAFBTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 20:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344233AbiAFBTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 20:19:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CB2C061245;
        Wed,  5 Jan 2022 17:19:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E319A619D7;
        Thu,  6 Jan 2022 01:19:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A0E5C36AE9;
        Thu,  6 Jan 2022 01:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641431988;
        bh=aEDBbucQ9AxwVaz+N6CkVDfFDXcSJb9PzV8k9ssp5sM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=kpfIPKTIAaeOY/GqoTBlMdCK77j4F6XmT6jmQiN3vA95FR8BmKmgo2TuYKfnkzVYO
         CpcoaKlIEvoHB3jRmLKi3FZGGVpBpbWnOCtbM2Y/xtaA1xMPKS683Fn1BMFFkPJp9Y
         iDp3b3Mu7ZExHS9AsJHRpKOuDqe2BJ9mHBepMS0JWHxgrasERcKIgmuzz3LEsoMbCH
         +7MDekYBRrSPPAQpZSiM22If52VV+Oj4C1bZcRr0MUyVLg/Pw6IUo06vboI52318fE
         RfKBOTyqyuM7tQIvSh5N1qv0trXnAdV/zTQzKmSR6PMmM7tOzur4cXAtfxMR18E32u
         80qyIdrrNMZgw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1640018638-19436-2-git-send-email-tdas@codeaurora.org>
References: <1640018638-19436-1-git-send-email-tdas@codeaurora.org> <1640018638-19436-2-git-send-email-tdas@codeaurora.org>
Subject: Re: [PATCH v2 1/5] clk: qcom: clk-alpha-pll: Increase PLL lock detect poll time
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org, robh+dt@kernel.org,
        Taniya Das <tdas@codeaurora.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
Date:   Wed, 05 Jan 2022 17:19:46 -0800
User-Agent: alot/0.9.1
Message-Id: <20220106011948.3A0E5C36AE9@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2021-12-20 08:43:54)
> PLL poll for lock detection can take more than 100us for certain type
> of Lucid PLLs and also the new PLLs types(Lucid EVO), thus update to 200u=
s.
>=20
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---

Applied to clk-next
