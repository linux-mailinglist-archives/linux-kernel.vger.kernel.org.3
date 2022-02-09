Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F4F4AFE2B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 21:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbiBIUWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 15:22:14 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:49066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbiBIUWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:22:12 -0500
X-Greylist: delayed 317 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Feb 2022 12:22:14 PST
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53257E011172;
        Wed,  9 Feb 2022 12:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644438132;
        bh=23VcDO1UBkUQfDfSRRv997yJv60exeA4uC8n5A+TDxE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Zgdtg2z5F2obroxAmRdfIBqrnpL3GLo5hPzc+t0XnF19Hpb+0trtJIPCblAQEfSA+
         rC7erf5o6k4vfcs7AA6rFHB8GPJanZA5UdHGY2eq9TrvLXFfI4K28Hqd8RM0VrehAn
         GXklFyvGhtT3optYujMezvO9cgEggptfKDA/87P0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [80.245.77.2] ([80.245.77.2]) by web-mail.gmx.net
 (3c-app-gmx-bs62.server.lan [172.19.170.146]) (via HTTP); Wed, 9 Feb 2022
 21:16:28 +0100
MIME-Version: 1.0
Message-ID: <trinity-5a9379ec-3c81-4459-809f-7d0c8bd67d5b-1644437788730@3c-app-gmx-bs62>
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
Subject: Aw: [PATCH v8 4/4] arm64: dts: rockchip: add naneng combo phy nodes
 for rk3568
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 9 Feb 2022 21:16:28 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <20220208091326.12495-5-yifeng.zhao@rock-chips.com>
References: <20220208091326.12495-1-yifeng.zhao@rock-chips.com>
 <20220208091326.12495-5-yifeng.zhao@rock-chips.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:9+TRw0BVUlgbzdQz4c/U8MCWL0dkdLvBqsfMaJL1wl7G+RYBTmCeniFA7SGXJtAHcV0h2
 9GF3k3FhOR+9+X2SyUDlD4x/+5UYhlKnxyslUNR+kysThy2Sh96YZSrqTtPTnZTKFt/aqdRWLw9+
 lR4F6K6QnSHqtEQDpOeceO2tzOYdj7Y/NnrakFZmwOFwMxS1JziRjPrCeYTrQEOkx4v5vlic0H7g
 qDh0C7AMFMvR5YOo6nxFFNUjWeyn+uKuGNDnNy2Qv8BbxoNYGNowWHDi03fv8rTe0KMAXJj5K12x
 kw=
X-UI-Out-Filterresults: notjunk:1;V03:K0:2w5mnw2TF7s=:VXkCKNLFaDSPo9Tomwz/Xv
 rYANgHuaLSVowsVuMmXGAOwxGtuHAUO4G1RNd+eN2pbpUX8wx32/ZB394t4fHlXpw1rfzYJ/O
 /HJxsce5iW/1T7uNAXxJaFxm1dR9OtmC2JOFF1qOv3hEvznortEdsgWa27jqGPnQC2gr0rWr0
 QhuZ0tcKCGz4+vV3h6goGziRdfHjNv8YYIBc4dzZZrXAWT17rMbDzp0QBqQLcR5FohSxzwHoO
 vBHXXLTec4QEZRiMSYFvKUPTXW8yVP+BkXnPHWldPvsQqk2DXRQZZIFpn9ulvLqcaS2knhiTK
 mRdwXn9rd68+n3npEh2i9bw607FfqEAtm4NpTNKPhBQ2OcFegTxRNAJzpYYDbcEb4LiNB5tuS
 og9nTM2fBbhImiDnXe9jSlH8WK6GADDoULZ34Zj1GpdpAaoo+7dcVPbfdC45+xQJJzHaP3i3u
 mVzmU5Y+29uVA+tPOT/aVH6zC8Xvdm0hCZ5uLCNsJY2nMloCjWSlKuMlH93TMdmLJxVrzouE7
 RuYf1P3nZvYRFhwhYlMQ14L3xEiEGmfi/wgzXiKor8PWjoMr5pBhDP6MKDO9nBU7il72prDzS
 KM9bD3zRE9+VHEsoCe2SxhcnfdN9BGjKPz8gZWdtDdp5/oqvbR2JGNNjYuG0oN9VMe+CHV/8u
 MAMpFrNNhKzBnTrsMLtva+DQJfreWu4NyYhqZ5UPw3wL0vRpIU7RUq/vi9SXrVy1d6Je8sOUb
 XFdL+QL6SqwnmIo5r6BM8v0eZX3nBa0ML+NqX11NytLyvUiuebU2ITVDru6yfBkthUM7dAK9Q
 IJpb3LB
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
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
