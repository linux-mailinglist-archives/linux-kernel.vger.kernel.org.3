Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBE452C876
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 02:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbiESAOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 20:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbiESAOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 20:14:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAF0179C2E;
        Wed, 18 May 2022 17:14:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 357B2B8224F;
        Thu, 19 May 2022 00:14:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E534DC385A9;
        Thu, 19 May 2022 00:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652919279;
        bh=iTyhK8U+MkJRWfeD8wOcBcPwiMNEHKyjiBE/3WoYw3c=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=Uc38jGw2845WXFlzTQ+iMt5vuRORQdjbZXlRrpefFPjD7MwefZhRzBhWXlfGsT/mh
         DhFx+i0K34Fas545M+WZRn0ccQSmz7UK7m4FLwMKJL5XzGy9zJfAkFLD4MWVNYEiHj
         mJJY7Q6f7JvY7Ovsx88lZgQe4bdBnhDw6roLAfoLdPTOXP7R6zQEjxsDnBRZK8YaZE
         vxjPbkIkzi/o9bRfFnVq9LRgyGI6VVFNWaE4zMXn/+FKCkJciIpPB4WyjyRzoOAjgv
         vL5HWHwkY2Y4JvbV2DMrq72IFi5wrCTwjN5tAJp2g0GGJS/mdpw3iS3BIBTU46Jk3s
         +WggMdDjYuvYQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <2f73874b-430a-48d2-4739-b06eebed1ea8@linaro.org>
References: <20220501103520.111561-1-krzysztof.kozlowski@linaro.org> <2f73874b-430a-48d2-4739-b06eebed1ea8@linaro.org>
Subject: Re: [PATCH 1/8] clk: qcom: alpha-pll: correct kerneldoc
From:   Stephen Boyd <sboyd@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
Date:   Wed, 18 May 2022 17:14:37 -0700
User-Agent: alot/0.10
Message-Id: <20220519001438.E534DC385A9@smtp.kernel.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krzysztof Kozlowski (2022-05-17 09:46:49)
> On 01/05/2022 12:35, Krzysztof Kozlowski wrote:
> > Correct kerneldoc warning:
> >=20
> >   drivers/clk/qcom/clk-alpha-pll.c:1450:
> >     warning: expecting prototype for clk_lucid_pll_configure(). Prototy=
pe was for clk_trion_pll_configure() instead
> >=20
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>=20
> Any comments on entire set?

Please send a cover letter next time. Also they're simply "qcom" related
but otherwise I'm not sure why they aren't sent to individual subsystem
lists. They don't depend on each other to build, right?
