Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D84571795
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 12:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbiGLKvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 06:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiGLKvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 06:51:38 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D7FAE384;
        Tue, 12 Jul 2022 03:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657623065;
        bh=c/mYNYqyEwH1d8z86lve7tR3491KdxL9/uAjUeWIz4U=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=d1jbbaaqjQDgJv7yKK1aT4BYA6yXEAUnZmk8SnC1TSzFLla4gJ9XaB6aSFhIxrfDJ
         kCWUwBx167M46fHzU7shs8dlHAl6Qmx5ucCtPk29xjM6Ou5BXoJ1iq5Se/BEd9qXwn
         WCFtsjOCofVfxHjNF2qvjDeH0EakMzvY9zN7CvD4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.147.102] ([217.61.147.102]) by web-mail.gmx.net
 (3c-app-gmx-bs14.server.lan [172.19.170.66]) (via HTTP); Tue, 12 Jul 2022
 12:51:04 +0200
MIME-Version: 1.0
Message-ID: <trinity-460cb253-7fc2-438e-9e65-5c6da18c8f6c-1657623064606@3c-app-gmx-bs14>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Frank Wunderlich <linux@fw-web.de>
Cc:     linux-rockchip@lists.infradead.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Liang Chen <cl@rock-chips.com>, Simon Xue <xxm@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Aw: [PATCH v4 3/5] phy: rockchip: Support PCIe v3
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 12 Jul 2022 12:51:04 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <20220619082605.7935-4-linux@fw-web.de>
References: <20220619082605.7935-1-linux@fw-web.de>
 <20220619082605.7935-4-linux@fw-web.de>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:Ggue+5HxNF+HyF06ttMUnhvQbrt1IvmExsTURARRr4aRh8Ks8HyhWhSvWH1y6g+7+ylZu
 vU/tQJJsTkG4WOcA/7HLS8aezW3ykiCrnA/7eDOntz4QuhGJ6BpRrxN+hEAF239FU/w4SUTCb2WT
 0qsFQR62hxWMur5C8Ie+rkfdBdfcKcUU+5+vVEyWZFp248dbQ3yMigghwKPzkg3ChCZ5kE/kairp
 QLLjjLJxnpwx/5IzvCdJbkKH+qzS64xOuwVTZgalpfSIMCLkWKXcQEyTtF54oykWmLjJ14ymQJGs
 xk=
X-UI-Out-Filterresults: notjunk:1;V03:K0:CEts49WrzYQ=:PfqATTz4enB2mCtMa3pHA6
 4ZSug7dqIHMLNvPDFljw3T4N4kcy1v8U2AB5sB4ONneyh9gzSs115+Bp+hDtWfggwwljWe9YQ
 sGzH0np8lnOUTI9Evt2huKVMSVkLGOaQ1uTMWgXX1i9XvQbVP3101CPowrR2lS1Z26XYpHRBc
 Oi5E7sqk1MQ9cEplg20P6vf/deu3vK6HmT+cUI6ALAq8WBXTaBMfrYdY58qfgxVHYWQfyktfn
 vSe9JxhvVPrA8p9FVSQ6eLr5iy7Othm2rouIe7GJshSZsRyYpe2d3qrOeeFsMyHY7ueF1hoge
 dAPRdML/lgoHB7e0SGBz8mzrtqqgmRvp7LEl2uPc7fs5Cqbt5Bnqp1BpQS+UaoAU86VUMfe2l
 jc8ZyyxvlsKqaKuOr8fHESTWdXt2IzI3VaVvFgN31fK/LWFdAc3hu1h7ufXRVAbLh3lqIuLYs
 S/K3YZGm85aar7kQmZ/GNrfnZhsv5KGd82aJVc4pUMYA5ZBD/cX8plK/KF4pdTbqPmByvnlmL
 /jH/vU1VI6HC6l1s4yLNLjmu0XoX7r0JY7VXBq32bu5TDb4zT0kwJhSR+ORVCEqJ+h0PgLyLK
 EFRjrK61nb4DFy6krnEKTLIF6O0oJt+ZNHHxEVRCiPWHKteS2FamaxAmOb95RzvfDpuGWfmIF
 XcBvLsv0bsNtGPj49f62EW9do2UykWtfxh/3QbAaIhJDiNPrgE+r45wdln0THHFX0vN1Xqu8m
 y7bJeW90BAbJLN50psQBMJSfootzyddbhwPdYFlb5LUCoK0d7bYNGEg2ILTSJNF+3R8Ou5EPb
 Ay3WKcE
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

just a gentle ping :)

regards Frank


> Gesendet: Sonntag, 19. Juni 2022 um 10:26 Uhr
> Von: "Frank Wunderlich" <linux@fw-web.de>
> From: Shawn Lin <shawn.lin@rock-chips.com>
>
> RK3568 supports PCIe v3 using not Combphy like PCIe v2 on rk3566.
> It use a dedicated PCIe-phy. Add support for this.
>
> Initial support by Shawn Lin, modifications by Peter Geis and Frank
> Wunderlich.
>
> Add data-lanes property for splitting pcie-lanes across controllers.
>
> The data-lanes is an array where x=3D0 means lane is disabled and  x > 0
> means controller x is assigned to phy lane.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> Suggested-by: Peter Geis <pgwipeout@gmail.com>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

