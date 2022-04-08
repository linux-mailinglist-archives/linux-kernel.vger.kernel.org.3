Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC664F9A50
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 18:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237980AbiDHQRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 12:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236939AbiDHQRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 12:17:09 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB153192D;
        Fri,  8 Apr 2022 09:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649434480;
        bh=M/wORagk9F6eEZAHAShAnzR7ugdTzdqnJRbwzPJoTyo=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=VLJb29bfnyWRwZGJDxu1bT/B2ePmqJodp0jdQlvJj0eFHhsdW82Ksmp4gN+L7eX7J
         kLMNTQRyKENs4HDhnplV05ti/u4lC7h/SltEO77H/V6G7MH4/8Zk3BgFzdLGmt3/RH
         6hRT6bazOsG3Oz6fvfmZGEuDvxz6t25E/Qs4H8uk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.152.139] ([217.61.152.139]) by web-mail.gmx.net
 (3c-app-gmx-bap48.server.lan [172.19.172.118]) (via HTTP); Fri, 8 Apr 2022
 18:14:40 +0200
MIME-Version: 1.0
Message-ID: <trinity-3ae2b0d1-a3f0-4c64-acb6-2fb4fa0b36b3-1649434480623@3c-app-gmx-bap48>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Aw: [PATCH v5 3/5] arm64: dts: rockchip: add rk356x dwc3 usb3 nodes
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 8 Apr 2022 18:14:40 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <20220408151237.3165046-4-pgwipeout@gmail.com>
References: <20220408151237.3165046-1-pgwipeout@gmail.com>
 <20220408151237.3165046-4-pgwipeout@gmail.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:4EazFF7mfT+8p/kITM7n4WxfCwb0CQccEauJrFW8h8EOkdz+MsWy9IZ1bTy6CTr35aOPR
 8apVvZpo5gs0BKRqH6giqH+rHXqLt/LZS0xrAsr4Sa0LSXTL+zzKqF5kfnPy4dOH07WWxeDzOYT1
 b01Oo9Lg+3aAoe1+6cv7FHWHvf1B2wBrxOi3Jg6Dz6Os80tJAQdy8RwGRsG6JCVrHobLvZGMggyg
 w8tWCMXakOiE9ZAXTNsKz1MnXvoIRwDzQO2bSZqYV6zOGJF5AbioBONlLGBd2234Debr/bARY1Yr
 4g=
X-UI-Out-Filterresults: notjunk:1;V03:K0:1XaxmLoTN6o=:FpRa9nz83qJjs46sFl81aH
 8Ior15Sk1jHzwIrb9zhM7JX0b+WT06aovGbjFONxflnVinUWax3aJkByXPuAugt7xmh0GRHH3
 tQ4ocBiMtTEF658BIqCwNLZgs5ILj6XcQbBjqq7e+TJbl/j8Rgr0sonCeMY83vqOPOSDJxilH
 ZhWuJ477vmjr+BMQxkIBxJtgs+NKxewEHXh23vyhg7Z7dwVp3NVTfrTU0jvbpXIUWmZnqztlp
 0j6mQjSf39f/yfWw3h6T1IrfXy1v8VUjNJA71T0N38qD7l/0AgZEe9zSo0NrJrMsR5588hwVt
 +/q4kBDqEIjVsnwzjBDnr6jHRyjXgTYgRsbUoFqR5bHqIyEfFJJy7CT0QX3hU7HRQm5seH/sW
 dEUYZnLu2KpUWhf5N7fc7RXXfPXB73Kd+tCTG/K5W/TN4WDtxD3Hi0y2DG8f7XoEaNkdYMmX6
 M3X2WcUXeD+wuSBt2ElC8Vm9Zp23ihKOlOEhioZxUEc79TDJtNNgiTyc9uOrIl1oo9Vie9ZL1
 bheFQnTo+Ky5qyf+3f5ozaHEikY1cAI5+U23Hc9TXpdVByngMCuwAeY9CajpRWyJU/yTFxfmh
 3OF0pjAiOPtcIHMSyzjO4vFDzihMjyhLZKAj0Dc4mo+JTqz2Pgv40UsK3mXq3Or62fTUmy8/L
 grYrpDcKVSn+H0JQbGixbutKLsSZ/j+QSElTvfhWzOyt/IX/RdVvqfanVI+IyXr6F4ZEjHkqE
 7STOO2eOxHz3UDhbB/R6jjVp5i82Elr/UbugBDNaoQ9BFRCtZVu2a/jfIAiDlmITaICkHSLj0
 03gu+ZW
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

seems like usb (2+3) is broken in 5.18-rc1

i see controllers, ports are powered, but no device detection.

maybe anyone else have same behaviour with different board?

regards Frank
