Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B881F56BBA3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 16:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238055AbiGHOVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 10:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238064AbiGHOVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 10:21:41 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FE2326D4;
        Fri,  8 Jul 2022 07:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657290076;
        bh=6lhQbMhE6Tq/JsXBUhi3e+zhcqO27HN8eOz+uNLxVak=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Qu8KxQ7va/kQoThEw5wcX6AZ+LOCulHcyvKRJiHoBxoLvr9kuCA6a4qs+Nc4Bpl5h
         wecj1UMnBgTjPCCY1Sr4i6On96bzMKhWn0sH1dY+qeNcVRIYTWKXRQ6ZXc3/2p3jo3
         g/3BXNJS4wCI8fA3ONdu8JdZr0SSbfIuKjroJzik=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [157.180.225.69] ([157.180.225.69]) by web-mail.gmx.net
 (3c-app-gmx-bs34.server.lan [172.19.170.86]) (via HTTP); Fri, 8 Jul 2022
 16:21:16 +0200
MIME-Version: 1.0
Message-ID: <trinity-23d198fe-40f0-40bb-8d95-2a64ae047a7d-1657290076363@3c-app-gmx-bs34>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Frank Wunderlich <linux@fw-web.de>
Subject: Aw: [PATCH] arm64: dts: rk356x: fix upper usb port on BPI-R2-Pro
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 8 Jul 2022 16:21:16 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <20220708132706.81450-1-linux@fw-web.de>
References: <20220708132706.81450-1-linux@fw-web.de>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:6POgQ4vFo6v2yxUWKuL4B/SKN+XUsFnyRZLUJ8RKpuNVB+CVRgUrtdqsuKTkX6DYgczdM
 S79MFaUYh2YAHCctg75rCXezG2XeG6pSK72EuX6BaIiUykX1x9lVwIAUUgFUkoOPjpD5EqR6fUDl
 go6/5GkbcWukqZ5Xv2tic2OdfZeeiwtMAiMkp1YxBJMudGPAC92m3KqlIw0RiMiA+LgQfn3zIbiF
 UKzcgEK4EnU/Ccjn3f7QK2hNolEB93PTxFV4c2q1U2Me8VQuhKQ3Y9SNhyUP9cVWGo63AzzZpmtZ
 yg=
X-UI-Out-Filterresults: notjunk:1;V03:K0:2Ss00Y/hSzk=:W+x06xOV3HSvSsYyXdbK6F
 5sjv8mfCSOOHEOg6rxQHgGX/yqo9n/Irjw6ctZ9iYnFsjlASDEQ0anJ6kl/q+N0hIuMunTRh4
 AUWZy2OJuiQoynH5m/huT/LHorj0WAUnYB04wT9JyxFyAjY8ONrOULoPO11I0uMmSkzS0WCm2
 mv9NIIftZbU19iLpdoPTzFuibq+2PBwrPrD6OEks2V2icsj27YYhxOnYW4hdcP7UjPkyrgtn1
 bOuEGeQl4ayrDs3jI+0n6rm3HUGxBONnL2v7MPHZXErdXWxYzFVC4pLk0V4U6elUDuce7V6VL
 2Vhl6wfvsI6q+222HDdV/fzEiERFnatmjY2RBX5HcjBefCYsmGPpO3tzISbJuty3EdItLalW4
 mhpS81gsaLGM6RSEN9HZLmzglApx/rWoO+e3q3an9Zlpg+63LlsvcX8WioMNhlkSitiwnkJCR
 WALLV2rjor6Whr6lyQK/jFBsh90gGRCz9e0Ja0YCkx9GAH9iyOIQvcZq0yzNfD0JcTk6cbOWy
 /q1+Q7txmkFcADCG9oCjsaXZE2UpyeX9M+URxSQq3mWPqxndZPI1s3UUeWwDKOk5QDvynKSfn
 BPDv3+foeeT3YfgeZ99QJVwrCBJQOPfJUf73G92JmPkaul70935GSvSATHdC61pH6WNxXw+Yr
 BkjyB4sAF0eGx8JTpYHKSiwJWM43rKJ3MDP6mWBZ297YyCtOKajWUnCHRodmudp9CmYCGDdr5
 DyXQaqSs5rxgXBrC3fuYbN8/e2HobxejxhbmPbA72ZHGRnnA5bXkXak03NtvsGaWJ7lfpBeXz
 8r4KUoU
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

noticed that prefix should be "arm64: dts: rockchip:", should i send a v2 or can this changed while applying?

regards Frank
