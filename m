Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3E24FA6C9
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 12:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238443AbiDIKf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 06:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbiDIKfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 06:35:24 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CC4342025;
        Sat,  9 Apr 2022 03:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649500371;
        bh=80ShU/imSauKnxZdpb2X4iH7Da3hJPqr1WSV5c7Xd0c=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=kWwQtdAxoYn9n6Wk/3UoEfvMS4X69f1gzv5w4Sz6dfUpjA2JWUOscaAf/Dw/hy4Gw
         PrjqitX2gVqxWmmdIthJcCO/abH4aoZHC4fAWFXgV4atVzm/US1cFgU8a4i2qFOYPJ
         ynwS3esOn2ijkfr1zthFM7rNIEVIEkhZ/S4raZng=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.154.105] ([217.61.154.105]) by web-mail.gmx.net
 (3c-app-gmx-bap35.server.lan [172.19.172.105]) (via HTTP); Sat, 9 Apr 2022
 12:32:51 +0200
MIME-Version: 1.0
Message-ID: <trinity-8384790e-d2aa-4041-b4e9-aba1130d8577-1649500371045@3c-app-gmx-bap35>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Aw: Re:  [PATCH] arm64: dts: rockchip: Fix clocks for rk356x usb
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 9 Apr 2022 12:32:51 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <9183927.T7Z3S40VBb@phil>
References: <20220409075147.136187-1-linux@fw-web.de>
 <trinity-71c38625-1a00-47d7-8e23-4f33f25a997a-1649499268581@3c-app-gmx-bap35>
 <9183927.T7Z3S40VBb@phil>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:YHhLoSof6i+xBTstqjx6wPaSnP2y8nSyNqN1gxczYGErIYWVv1iuh5Wzjyl7EzuD3MKNX
 o+PqN+1dm2X7LwZ55lC6iMXrLOaOqY5xM/WOPfsOYOqWt5BLKOJgkCxlr64vcdq39IPJnZ4ZLGfU
 CqTFmXgeQpB1JfynYuQBq+ZWp9vZXhXoFimNwpTd1qHFEGcR5B7Kls9GjxubZSgWTYIQ8osBg6FE
 tHz9s0zWwVYcPoU1aaoRBRtyO+ibwotmmnJpo8FI3MEy1DJNMp7Zi3vRLvjAfVHw78lntub7cqWb
 gU=
X-UI-Out-Filterresults: notjunk:1;V03:K0:C7Jy2Y/6wnM=:zALfx/JatwlapeMTvG9FHB
 e4ingMaVFJLYvoN+xgNK0FpmQs3DKjI9GincKL9CiRGQNz04vwb2utK5PCKVa2hwdV9cNHJa0
 Kdi+cUtwJ/peeTNa8mvOJN9Db1e94lHFChSz9rynUk3NehFHfVqQ5ocd9EGiX9TxerBxauzK5
 ZSpup7UKTtRgLKVKkE5VzQFXS+NO8F9I2hxtGgLoVC/mO+CjZ2tk17+YTogNOwC2YCZyXc98W
 qfTNKT7f2YMDg/PmJjT4LRRYB86DAJE7FJujYbz83Cgqcrt+VD+chtHD65CUYsVyyiyPFDw0g
 /ujkTGR59zXTBYQU6Y92d/Ck5jIUhRWo/ymcM7qKbosVlZmVTNl617FujOAj43hM2GyM3YHRY
 MGLmHya2RQWUT+da1Nzgyle+ntE9GgAsbn5ODh3JlOiDyHeCMj0aKY0Ux5kKXpDocCDwNIl7y
 tS9xkJFkRXBqubgMYlMhbeqwNa6m3PgqxC1e41m8uZJudcQMhM3syqDy1YL6OtS0neiJPFnz4
 2yWGzHwQFlppmE9utYQYX8TraDHDe+vJLH+d391XkDYJYPkyoYHVQ5lCw0zgs4AaW5z5bp03B
 z0KRjZQ1TXie7Og9Y2doPyvvx2LlUYJfoo8CUkGffvFAXfrzyjKozVHvi/KLKXXspECcDmYem
 /Bxkni2NDJywXpUuczKdUX0ELG3Qek2XBXsfQa69RnxRoS1qgRoh9RK/H3aSyGnIg7PeIn/cH
 4EvewMIS95Ktj9LGOsMQm9leIKkNh6QpAfsREn+ITOEnZtm0lTODvIkxM0krahu8lxrI680yI
 vIQHBMi
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

> Gesendet: Samstag, 09. April 2022 um 12:23 Uhr
> Von: "Heiko Stuebner" <heiko@sntech.de>


> ok, so do you want to send a v2 including that change?
> Alternatively I can also add this change when applying.

imho the best way will be that peter includes my patch in his

"arm64: dts: rockchip: add rk356x dwc3 usb3 nodes"

https://patchwork.kernel.org/project/linux-rockchip/patch/20220408151237.3=
165046-4-pgwipeout@gmail.com/

i just posted the fix for those who want to test his series on 5.18 includ=
ing himself.

but of course if this is not the right way, i post a v2.

> Also for educational purposes, the format for referencing a commit
> you're fixing would be
>
> Fixes: 33fb697ec7e5 ("usb: dwc3: Get clocks individually")
> Signed-off-by: ....

as the patch not really broke current mainline state, i thought Fixes-tag =
is not right.
Imho only the rk356x-usb-patch is not compatible with 5.18 due to this cha=
nge, but this is not applied yet.

regards Frank
