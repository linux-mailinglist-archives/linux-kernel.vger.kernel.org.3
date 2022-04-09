Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10034FA717
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 13:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241547AbiDILQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 07:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232215AbiDILQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 07:16:21 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8922DA93;
        Sat,  9 Apr 2022 04:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649502829;
        bh=r4QPZ7P+JSWjbxzSFG/dUb+wYaS6UUhjdOjY0v4Vfbs=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=DU3LuFHrU/gW48ptv1UOGw+oSobVivH08YztRTI0bTIRT3vTu1lP2C9h/1o3T8iZR
         oTLAiLlb0AsXBni9zZ2LFaUEbbgqpsDN9d8Hn7TGghERawluRR5jFT64uxIXcdcO7P
         uFXVmFYeGBgbty24+vdfNWePmhAgHJFN5mNG1HIA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.154.105] ([217.61.154.105]) by web-mail.gmx.net
 (3c-app-gmx-bap35.server.lan [172.19.172.105]) (via HTTP); Sat, 9 Apr 2022
 13:13:49 +0200
MIME-Version: 1.0
Message-ID: <trinity-70f1133c-e884-46a1-979c-e795e0565db4-1649502829040@3c-app-gmx-bap35>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Dan Johansen <strit@manjaro.org>,
        Frank Wunderlich <linux@fw-web.de>,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Aw: Re:  Re:  Re: [PATCH] arm64: dts: rockchip: Fix clocks for
 rk356x usb
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 9 Apr 2022 13:13:49 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <4559790.iIbC2pHGDl@phil>
References: <20220409075147.136187-1-linux@fw-web.de>
 <ba60121a-a120-b717-6a2f-7883685d17e6@manjaro.org>
 <trinity-b6d141b2-264a-4a57-9707-6a38a80cea16-1649501859874@3c-app-gmx-bap35>
 <4559790.iIbC2pHGDl@phil>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:XmO92UdPHNajPI1GQn4Dt1Lx3o/weDo9Kh6/BvMjOREB4aDTqn5E6pWbnLLUc16OindS5
 i3cp8RcmnShSSatN7g+a2pyHs7c7ExjFk6MFPuTSsMPx8nUxhddK7svZVnnofqCxlWWmLef4R/in
 M0UG0yJ4goaPlkEdCp4qc/XB6JRXPB6P6xEn6t7Kx19WNkFzW4wMDBRhFN05wdZ4shZ+RgX3sUnL
 0hjKMY+bbmlyIajLF3M6PS5A6tydXKGtKIIdCoNRSiq7uFJNmJtCan48iEhCEKsLpt33nxoZxGM6
 v4=
X-UI-Out-Filterresults: notjunk:1;V03:K0:TZMhXQBu9M4=:YUbMmexNbc/0jx+ncY64Jt
 iwyZt/0rj1BMuOOOur7/4ADqq0aYu4SyF5jxRfNzPTGbtaoezsJu3+vzEwlhiRLzpBeLdsD5n
 fm5b+R1AaiQcGXS90lwpwnP2+wQs9SxzvC8RyaCgakGdq0klI3ssRmkWeJQcZUIphNI0KV0Hz
 yJSA7NXxpbG0UErMofPLWN8ZiJxsGqH/4Wxhf6cdePjp55LUNAWSajkhwX663HzR+/JivGy78
 ipK2RKGZ9VNelJxKdUBDEnivOmSSeXgL/e8JAPIEsjcyHZwlBlbg7zV3B80J9g7Ud6CKaVWT5
 3ArxajbkDIHT/efKZMfZ56TG8gu1/zHmvKijPhKO0cpgYNIsUaJBMdiAIZV8BI2b/ksF+gV7i
 hm8NnlQeYUv0ER3NfUgCrDDpU4li1hvZgJhLsKLiu0ujwmDOg095igtW0Y/AEZy980zxYzX4x
 vks5FuqWsWIg4ocB1ecafstxOrYpmyVaKax12IS8A3GwMiAYs8loedhP91xUfKktxbz6jT7qe
 NJv5Gi0mPKBXf7iBsdsYWilU8QW+YBRlORBISji+MCRUyXOBQw7NfdLMUxhHtzsyoSbFqL26I
 Ljt+4Vh2kNBjd/5hcV8JhUTX47RCBttGKBE3XtVdqCPfeCPql9qyYexq8Q6S9ytPb5WSl3rqF
 edF8HvkibEHT+/hWj0ufiC2I3DOiAy2fNiJUbGQH+yJctU05TroheJOq6spzDzD5OBYCxHlBW
 to5Vk7R1oRKtpBqHmE06QShJEZxKmcPDbF4Fqzn8tAx0EjijMBCKVceZgvSUGKlprBPZaUcmi
 WGoSu8x
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Gesendet: Samstag, 09. April 2022 um 13:01 Uhr
> Von: "Heiko Stuebner" <heiko@sntech.de>

> As far as I understand the issue now after checking the code, this
> patch actually fixes the usb3 series from Peter, right?

right, due to the change the patches from 5.17 were no more directly compa=
tible with 5.18.
for my board without having standalone usb2-ports it breaks both as usb2 i=
s passed
through xhci controller.

> I.e. the usb-nodes that are fixed in this patch are not yet present
> in the main rk356x dtsi and only get added in
> "arm64: dts: rockchip: add rk356x dwc3 usb3 nodes" [0]
>
> As we don't want to add broken changes, this fix should squashed
> into a next version of the patch adding the nodes.

right, that was my intention, but do not forget the suspend_clk change i'v=
e mentioned in [1]
but to leave all know that this bug is known and how to solve it i've post=
ed official patch but
without fixes-tag as the "breaking" commit does not really break...more li=
kely introduce a
incompatibility for the not yet applied patchset.

> [0] https://lore.kernel.org/r/20220408151237.3165046-4-pgwipeout@gmail.c=
om

[1] https://patchwork.kernel.org/comment/24809714/

regards Frank
