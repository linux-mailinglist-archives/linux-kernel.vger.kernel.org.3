Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78CF587070
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 20:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbiHAShX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 14:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbiHAShV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 14:37:21 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D486D1056C;
        Mon,  1 Aug 2022 11:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1659379016;
        bh=XpvW2KGm+7Eri6BgmGU4YVNAdPx/qqDZZ5a0Ia/rFD8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Fw3fVD2WM08K/0HVTLZ2V7MVgR2Oxb4McHFcPbv0GxYM4G1R1tRSZTJjzg1GGaYpi
         dduj2WkceGMMkRN6Jy1Enbc69ErIgIbEyxn7SpubI/dD0RqLAKprDNTRo8j1Fgko74
         TV1jJSRvWjgzUJAMC9UAZL/53YdCe31soLgJ0hOg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.146.18] ([217.61.146.18]) by web-mail.gmx.net
 (3c-app-gmx-bap33.server.lan [172.19.172.103]) (via HTTP); Mon, 1 Aug 2022
 20:36:56 +0200
MIME-Version: 1.0
Message-ID: <trinity-851eda2a-519f-4ef6-ad2b-6870b3b682ff-1659379016837@3c-app-gmx-bap33>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     linux-rockchip@lists.infradead.org,
        Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Aw: [PATCH v4 1/5] dt-bindings: phy: rockchip: add PCIe v3 phy
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 1 Aug 2022 20:36:56 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <20220619082605.7935-2-linux@fw-web.de>
References: <20220619082605.7935-1-linux@fw-web.de>
 <20220619082605.7935-2-linux@fw-web.de>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:INYgd8sb5GwLhiYt1Oy6FRHG6fA+Q6hpN6/UBzkegZzsjpAhCC2fjEQUPhCW1MT5tuFLM
 2OYlXf415NJLSTb83XzGlZnZjaF5yD0W3Xk+cIaYwpwz4DKbaxeDwJDSl2N2kXBNEwcqPHYFAmIW
 NbaX2eO4Kqq2j5CTMBF5CmcFcW+YcNQiy3BDBQx1Liiebh3s/R48dnMX3AzVIkMFegBM5GIzTBTS
 /JB/AVB9L7Ld9wQCnuHu/vJzFiNThZz4xi3gZAJZXZpNtYoZMWOPza8Lbo4x5/3/LzJIIuvymiyn
 j4=
X-UI-Out-Filterresults: notjunk:1;V03:K0:Fx+Jw1pgeQ4=:D0VKvQE83yj6hlucNV3ytP
 lEOHz4WpPymLe7+Hpg56BICeU/8a5CB+EJ7TOzVImKqHq+nLP4BcVzzFynNAlUbuw7M+FiCXL
 G39E7XO1+3apzT+/7F5LJ/asHhKSAQgSTrYmWCV3bE64aZTmM9COoGmHeovmXxnyH1FldmlQM
 jkweOFPbR2osMbMD700ODlbhDFv3WbvIcD8p3SRSRL9qUpOl+vzrPnq/P92k2dgs/Znq+lj5x
 1+DbcRvLX9zuLb0PbZomlqBf5vkW/SP9m24cqB7fQIYG2F1CzaKk4KrW++xcbwPRRh/hHsyaQ
 YkTZ7/U+zWGzX5NqesQVhYyY3tueJ+B67Ts/hDOBVzyaYTqbB0QlwIHZoI4i+QWzP6j8iEuaC
 75MFF7CCPcxJuvdEI+wL0Ql0svnp5xlAx3TlPWaK6e0tKMgPkCouT+eVE7iZk2ZMfkbfsBP7j
 27a4b+Ft/IEnMuPgqk1ckXVwltUdy3rf7v2xWEOpEuVNnwOT8U0Ptc/xI5GJaaRgvuuOvOlRY
 9gZajBU/5H/hjs7H9rOC6g9jZHwPc1IVgc9CvvZ2Sq6a68N0A6OTvhz/xcOhCyAjnSKdkLTj7
 FFmNx7/bPDUBTGQu5cHup21HtP6y818kYS5vMdqjJtIyLyRIDvZwALAsc/myONlISlJJUlcRm
 54bfo93kBSNSI9F56nnhpiFGysNc6KGqPIcQGeGc28OWN5XQGatlw6IfdDxnd1zCkdASx2jRp
 1qkqmE3jI1sBpKVKp8WXeXmfw6lo7xTb4LIS0OO7JCZtV8cC2sBJ2i/r5FJkEakEf6/row2Zb
 Qds8BZb
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

this (and the other bindings) part is marked as "not applicable", but with=
out comment...it is not clear
to me why it is not yet applied or how to proceed.

https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20220619082=
605.7935-2-linux@fw-web.de/

Do you expect driver-changes which will change binding too?

should i resend it unchanged in v5 (when 5.20-rc1 is out)? or do you try t=
o move the data-lanes into
phy-provider which i have not got working?

regards Frank
