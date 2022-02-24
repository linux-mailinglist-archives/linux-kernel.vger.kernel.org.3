Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24CE94C388C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 23:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235327AbiBXWMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 17:12:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbiBXWMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 17:12:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DE93B56F;
        Thu, 24 Feb 2022 14:12:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F68B61AFD;
        Thu, 24 Feb 2022 22:12:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6863FC340F1;
        Thu, 24 Feb 2022 22:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645740735;
        bh=xUkIovkz/u4SBckbtXcdEJ59AHtHdNQU3RREzoj5Yp8=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=pSYlnzNmG8wFO2zwP3Wo/JVtX1Hd098LTTHkQXm7B2sikfhhx0cpMB9wbarGVBK0W
         2bD6NoiT4nb7k56dcIMcSeQBdWLKYLDYyl7IoTsd6NB8Cq74rY85NhRa3LQoNNeHA6
         SyuF8UFnWsGmqqHRlQu61qRsT8LHgW362g8SFpwWpF6KHbeoCKOXqMQeU46p/T65RC
         IgjYdmbsJWKZ+KXsiDSrDmPQk5iZCWyNE+DF+xm4n6rIR+M3T9+UyyVApRuLmtBzc8
         BsJ1ngjGqbUX++bnunx2rledl2Fw+XnFlR97JO0rpoeA3Hbn68C+yQRE+Wq7aeMWTY
         sX7So5To8btmw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220224164831.21475-12-ansuelsmth@gmail.com>
References: <20220224164831.21475-1-ansuelsmth@gmail.com> <20220224164831.21475-12-ansuelsmth@gmail.com>
Subject: Re: [PATCH v5 11/15] dt-bindings: clock: add ipq8064 ce5 clk define
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
Date:   Thu, 24 Feb 2022 14:12:13 -0800
User-Agent: alot/0.10
Message-Id: <20220224221215.6863FC340F1@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ansuel Smith (2022-02-24 08:48:27)
> Add ipq8064 ce5 clk define needed for CryptoEngine in gcc driver.

Would be worth noting that changing the define is OK because it isn't
used.

>=20
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
