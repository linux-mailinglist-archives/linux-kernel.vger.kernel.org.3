Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCB384AF71E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237403AbiBIQpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:45:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237436AbiBIQpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:45:21 -0500
X-Greylist: delayed 330 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Feb 2022 08:45:24 PST
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC9FC0613C9;
        Wed,  9 Feb 2022 08:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644425112;
        bh=23VcDO1UBkUQfDfSRRv997yJv60exeA4uC8n5A+TDxE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=E6VWgl1hdzxhGU9Zr8EJ7+LuqCMotcq2Z9BYIn3nfVviWUMi1gnOlgVomLss/m602
         g+RQFKHsEVQyxBINLERnum8B4kBaqoS2B/JOdefP73OF/nX0AHyEF7wrQnNfO8VxTZ
         9YTQZyBWf25YeHW+dvNWuYTCeP59D5ypX5bXnfwY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [80.245.77.2] ([80.245.77.2]) by web-mail.gmx.net
 (3c-app-gmx-bs62.server.lan [172.19.170.146]) (via HTTP); Wed, 9 Feb 2022
 17:39:21 +0100
MIME-Version: 1.0
Message-ID: <trinity-15c80db0-29c1-4cea-be14-794d9a02debf-1644424761490@3c-app-gmx-bs62>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Yifeng Zhao <yifeng.zhao@rock-chips.com>
Cc:     heiko@sntech.de, robh+dt@kernel.org, jbx6244@gmail.com,
        devicetree@vger.kernel.org, vkoul@kernel.org,
        michael.riesch@wolfvision.net, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, kishon@ti.com,
        p.zabel@pengutronix.de, cl@rock-chips.com,
        kever.yang@rock-chips.com, lee.jones@linaro.org,
        wulf@rock-chips.com, david.wu@rock-chips.com,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>
Subject: Aw: [PATCH v8 0/4] Add Naneng combo PHY support for RK3568
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 9 Feb 2022 17:39:21 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <20220208091326.12495-1-yifeng.zhao@rock-chips.com>
References: <20220208091326.12495-1-yifeng.zhao@rock-chips.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:MM7Nx0+88CSi+CDhES/hxhcnP//1RXCCnodnqkxCyHMOIysSJnTzv+d82Mt13iCGAncX8
 DgZq7W20vZbLm3xrY7uJN7LjQMf7VkEYdBuxa068oT0hSc7uaWya6GHwx0FG0exoqY9wfgQIvdtz
 z/33dMmbL+E7IUjtCgMmZa1XUE7DeO1od88KOma67UbRir4X3wo24XXsrZ8wLyWJnt3cQlWVEEaT
 sp0T2QHcIVYTwUfv5qMBAaQky7saSPMPuCJfKHnqB/DtCt3D5DgGhBR4tU3I4IbQIfi/3CGRJZTN
 h8=
X-UI-Out-Filterresults: notjunk:1;V03:K0:yO48XHWlAEg=:w/S5bj4TX2IHTk3QFbdfMl
 8UonBQztscoOoXdeO7Imuot6orUUq0viFsTTOfzJEOHhIoACPgID6EfU9Epoq+PqWxXV84fhv
 N1qc3QfY26wFnvXje1EgRvaYsv7r+sECRIBQkS2+Su3SCVPhOJm6kEBShyAUjMDv5bKv3kle7
 01rgMNuYrDSPc1iC2lVQLY4duuWNIY41QTLppt6WSERfl98gwLoeObBU/erl9A9Iufzl9+uOc
 ecv6I4dGmjGQWxh0Vh03g0tk8Cmf8Q/9XQUGLs04wNq0CdgZNaHNw1y2/7FKfSYx3va5oPe88
 P5v85N3n2d1XxUd0OOx6hPzN9ZQLiQOMAL8dwYXd8fgWKYQN5oZ8sZT/JhbWBok6IZ3ao2psP
 OgJZSsyebyKWcuR44TUJckyzFpwc3MYv64Bjze7rwxMNMWISnJd7Gn7VENFlf7ob5+V64D1dk
 SczpxwQAiwV+H773x6X5tX2urZLQ4+co3ErfCkrmoIlXs7j0diZ3GdJXlt42rlCe+lbcIe4gl
 DCSjHIfYGhzXY/fivYfAH00/z8ilSzN+tFGIUhgdDwZaFhh5ke14k3I9mXQKR4a7ZMKfsdGRA
 ami+lD4knYeptm4IoSkyga5bwjBSkb41TSVUbFVEDciV6j5dMKrg/vI/YQ7g6McBtVATPjbI7
 c36UYPhlmh8fOPRzymZpCS8JuUCgd6cKx2sydzP95vRZUQrgr28Z/EtwqjqS8AX0CS2r8IJ04
 cpdAVOR4+nyUFYmk7JSY9vaXYEU2wPaIw6s83irMAQqc2MXO+dsBsjnG7Eu5qnmVzHt1cBNhm
 vsykxOy
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Tested complete series on rk3568 based Bananapi R2 Pro

combphy0: usb3 (usbdrd3_0)
combphy1: usb3 (usbdrd3_1)
combphy2: sata (sata2)

Tested-by: Frank Wunderlich <frank-w@public-files.de>

regards Frank
