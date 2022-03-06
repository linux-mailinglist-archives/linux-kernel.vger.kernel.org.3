Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E77D4CEA62
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 10:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbiCFJtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 04:49:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbiCFJtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 04:49:21 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B1315A28;
        Sun,  6 Mar 2022 01:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646560070;
        bh=OD9fC9I+jhM8Okh3twd8v6eVvZwsGcKGQ/IgKak8Gv0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Ny5UjL1sTdiqrIRD3wdU7tqzCN4lUZru1dJUCIRnKTmN6xcyx5SmRkhxv8IEgbQG9
         StdwseJ272DQcBXAXCYlVGGK4ct+XstTGKsg6xLMOjBff/XferX08EL1cUoBzgtV6e
         zRtzz0bjaKKyJrk/BAV3PJK+cmUHxysOpADXtyI8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.145.243] ([217.61.145.243]) by web-mail.gmx.net
 (3c-app-gmx-bs46.server.lan [172.19.170.98]) (via HTTP); Sun, 6 Mar 2022
 10:47:50 +0100
MIME-Version: 1.0
Message-ID: <trinity-9ef9e0d3-e70c-45d9-bdd8-e43d1c89a8c9-1646560070497@3c-app-gmx-bs46>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Frank Wunderlich <linux@fw-web.de>, devicetree@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Aw: Re: [PATCH v5 1/5] dt-bindings: ata: ahci-platform: Convert DT
 bindings to yaml
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 6 Mar 2022 10:47:50 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <a2839b00-d195-131f-b2a7-d2f030a5bd95@canonical.com>
References: <20220305112607.257734-1-linux@fw-web.de>
 <20220305112607.257734-2-linux@fw-web.de>
 <a2839b00-d195-131f-b2a7-d2f030a5bd95@canonical.com>
Content-Transfer-Encoding: quoted-printable
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:Echz34LhzOW5lmBqLmmb4P7mnPgqTTUheGQ31g1l4cvCB7QgzRtTYu2fQgCY6tYwBeroz
 bkiKXu1NYcjP50rVa7bvFlK05WbKn34j5J3LeomEbN8mZHBor8Z9e28tvxyU13X+a1B0VMcEo3Is
 0c0SW2QymXtdzlA+3Qs7FfKYs175VGlLw9j2We/yhu1/F44dZQpZMdH6WaBV5zgfbEXy9abRCjeQ
 DusZRjUvBrwRp0/hkZr1HHgYogx4mFESNDB/LGNEl/HZTSYqypdTFzqW+nkovm4U4zLCjm+2iuI8
 es=
X-UI-Out-Filterresults: notjunk:1;V03:K0:EowYyED6Quw=:Z01UPjyHuVxost3uxThyxc
 ozZn7Bq/AJadPhkzyUmulvBAuWzvsO5W3OMUpNO0YksneTyUgNH9j6cdGxoLDJJMpQhgEa5r0
 iZ1lMnk5aXliO2O4GQgH2NuaEAFVYV/4C3fIHC7p2wsRLGhsynzhz4IqITYN/uN2sIQ6XvrfP
 wu92vavFMgcD+otN+pZxhhdAVUWuwsHZiVwtY8bKhbvDEVbnUh0f3svL1u2dWi0cCcEXVHHSU
 UZrM7kXHfO474b4HE1QgZUdfQgY97n7fTuNzzP6v9mq2TOIjjUvyFr5TkxNeGI3vZrH/tt6v6
 PyUgdKaj8qGR0IDHvGogajmD7i+t1WqfPh6QrWrkFhcpuy7Z+w5zKNIdE3du+yymkHFFDNHk2
 3YQS0yVgRg8ezuyQ10swPa/GdqYoGnKfMXC0i7jjH1wajvnRhshKRtxTCy2CtRL0dEO2FRwey
 WFoVaJFlYriuZ4Hu7e1kmCYpbxFTf4frCUC7RvY4dMUiYTMTXNaDigbA7+J+LTVrG764N5EJ7
 u2KkQ7ekRZrjH1FbhdwgROx+Q0LQSrzgWc0gjNOlPsk95dxjpnqy5Vt7YryeT4PebHNgt/3CM
 7wrwruTI0TxxG81/zyYzIT96eB2rbFe0Ipu8ZUkHLpvy2qczvvlAQx9aX5xAemMDXRln4XvtF
 qeU4NcZcPfO5nmqFSa+2SqwLHW7QvdZR1Yn+YsEg2gDIjLpFAktTlvRoIT0SnlsTEcqBCOmks
 NTdRv10cnMvpSQmGXXEwB1CKjmVrB9cE42vPy7dXJScAKy7sakNygTCNVmspFw2QqJF8W2XbE
 p8XvUie
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

have seen some warnings in Robs bot for arm=2E

imho have fixed them (and the indention you've mentioned already squashed)=
 in my tree [1]=2E

    add compatibles used together with generic-ahci
      - marvell,berlin2-ahci
      - qcom,apq8064-ahci
      - qcom,ipq806x-ahci
    increase reg-count to 2 (used in omap5-l4=2Edtsi)
    increase clock-count to 5 (used in qcom-apq8064=2Edtsi)

can i still add you reviewed-by to v6?

[1] https://github=2Ecom/frank-w/BPI-R2-4=2E14/commits/5=2E17-next-2022022=
5

regards Frank


> Gesendet: Samstag, 05=2E M=C3=A4rz 2022 um 18:43 Uhr
> Von: "Krzysztof Kozlowski" <krzysztof=2Ekozlowski@canonical=2Ecom>
>=20
> Thanks for the changes, all look good except now I noticed that
> indentation of example is unusual=2E It's not consistent=2E Starts with =
four
> space (correct) but then goes to 7 spaces=2E Please adjust entire exampl=
e
> to use 4 spaces indentation=2E
>=20
> With that:
>=20
> Reviewed-by: Krzysztof Kozlowski <krzysztof=2Ekozlowski@canonical=2Ecom>


