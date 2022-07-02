Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 324D4564059
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 15:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbiGBN0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 09:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiGBN0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 09:26:52 -0400
X-Greylist: delayed 75126 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 02 Jul 2022 06:26:50 PDT
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A2BEE0A;
        Sat,  2 Jul 2022 06:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1656768396;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=ADhBACrz2Qr0S090wS1ZIeXS8nBhvOhWtGz98bfbjKc=;
    b=R2EZDoOxGYQL6npqnTUNFLU0N0ESBh2a/SC1H16XCaCAx4XMSGZeC3sAus7KN6KPLK
    86cT70xlMus+iqlYKDBgSTMFkylLoWvWNgE8jckxVWC/V1YvytrqrIsGOwlVYVUDjIpH
    B6m3nTaZYOp6tGlll/5qo3cPGKwSGLbbRAFrU+Q3fWmGG/MzZ7t7sRulvz8jyVhCiJ0C
    Ujmjv+Dsgnu2qLZ6BaY2JymHXVGC4E5ERY/uwuTDu5V+vY0wjtRAc8es54D/2yNCnuOA
    hXLk7gcx1vyZymkMp+vnFo8tds1kjp2wzMqW0PEdCir7ZzVBcxt0dyQ4UILz4EdhH1ti
    73eg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBp5hRw/qOxWRk4dH6mrCd8hjwtNJ1XR1aCfoW9lMn+10EiTZKVKiKo"
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2001:16b8:2d3c:9600:bc62:e093:3980:49eb]
    by smtp.strato.de (RZmta 47.46.1 AUTH)
    with ESMTPSA id x1817fy62DQXDwp
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Sat, 2 Jul 2022 15:26:33 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH v2 1/6] dt-bindings: leds: Convert is31fl319x to dtschema
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20220701134415.4017794-2-vincent.knecht@mailoo.org>
Date:   Sat, 2 Jul 2022 15:26:32 +0200
Cc:     Pavel Machek <pavel@ucw.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-leds@vger.kernel.org,
        OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS 
        <devicetree@vger.kernel.org>,
        linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <99DCB131-5A1F-4F8B-8E3F-1AE283AA591A@goldelico.com>
References: <20220701134415.4017794-1-vincent.knecht@mailoo.org>
 <20220701134415.4017794-2-vincent.knecht@mailoo.org>
To:     Vincent Knecht <vincent.knecht@mailoo.org>,
        Rob Herring <robh+dt@kernel.org>
X-Mailer: Apple Mail (2.3445.104.21)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

> Am 01.07.2022 um 15:44 schrieb Vincent Knecht =
<vincent.knecht@mailoo.org>:
>=20
> Convert leds-is31fl319x.txt to dtschema.
>=20
> Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
> ---
> .../bindings/leds/issi,is31fl319x.yaml        | 113 ++++++++++++++++++
> .../bindings/leds/leds-is31fl319x.txt         |  61 ----------
> 2 files changed, 113 insertions(+), 61 deletions(-)
> create mode 100644 =
Documentation/devicetree/bindings/leds/issi,is31fl319x.yaml
> delete mode 100644 =
Documentation/devicetree/bindings/leds/leds-is31fl319x.txt
>=20
> diff --git =
a/Documentation/devicetree/bindings/leds/issi,is31fl319x.yaml =
b/Documentation/devicetree/bindings/leds/issi,is31fl319x.yaml
> new file mode 100644
> index 000000000000..17635a7cf8af
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/issi,is31fl319x.yaml
> @@ -0,0 +1,113 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/issi,is31fl319x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ISSI LED controllers bindings for IS31FL319{0,1,3,6,9}
> +
> +maintainers:
> +  - H. Nikolaus Schaller <hns@goldelico.com>
> +

as noted for v1 you can change this as it is a new file (just same idea =
in different language) and I won't have time to maintain it.

BR and thanks,
Nikolaus=
