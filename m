Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEE057C461
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 08:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbiGUG1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 02:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbiGUG1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 02:27:43 -0400
X-Greylist: delayed 602 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 20 Jul 2022 23:27:42 PDT
Received: from 5.mo581.mail-out.ovh.net (5.mo581.mail-out.ovh.net [178.32.120.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390496D2DE
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 23:27:42 -0700 (PDT)
Received: from player758.ha.ovh.net (unknown [10.109.156.29])
        by mo581.mail-out.ovh.net (Postfix) with ESMTP id BBEC923AF6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 06:11:49 +0000 (UTC)
Received: from RCM-web2.webmail.mail.ovh.net (ip-194-187-74-233.konfederacka.maverick.com.pl [194.187.74.233])
        (Authenticated sender: rafal@milecki.pl)
        by player758.ha.ovh.net (Postfix) with ESMTPSA id 6F8EF2CD0FAD7;
        Thu, 21 Jul 2022 06:11:38 +0000 (UTC)
MIME-Version: 1.0
Date:   Thu, 21 Jul 2022 08:11:38 +0200
From:   =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
To:     William Zhang <william.zhang@broadcom.com>
Cc:     Linux ARM List <linux-arm-kernel@lists.infradead.org>,
        joel.peshkin@broadcom.com, dan.beygelman@broadcom.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Anand Gore <anand.gore@broadcom.com>,
        Kursad Oney <kursad.oney@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 2/9] dt-bindings: arm64: bcmbca: Update BCM4908
 description
In-Reply-To: <20220721000658.29537-1-william.zhang@broadcom.com>
References: <20220721000658.29537-1-william.zhang@broadcom.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <a0fa14ba8c4782bde5148d389e2f2a37@milecki.pl>
X-Sender: rafal@milecki.pl
X-Originating-IP: 194.187.74.233
X-Webmail-UserID: rafal@milecki.pl
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 17160121956132236251
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrudelkedgtdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggffhffvvefujghffgfkgihitgfgsehtkehjtddtreejnecuhfhrohhmpeftrghfrghlpgfoihhlvggtkhhiuceorhgrfhgrlhesmhhilhgvtghkihdrphhlqeenucggtffrrghtthgvrhhnpeevjefhffffveeludejfedtvdfftdekgffghfegieeliedvfeeigfejteejjeekfeenucfkpheptddrtddrtddrtddpudelgedrudekjedrjeegrddvfeefnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehplhgrhigvrhejheekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheprhgrfhgrlhesmhhilhgvtghkihdrphhlpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehkedu
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-21 02:06, William Zhang wrote:
> Append "brcm,bcmbca" to BCM4908 chip family compatible strings. Add
> generic 4908 board entry.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>

Acked-by: Rafał Miłecki <rafal@milecki.pl>

(with one minor comment below)

> ---
> 
>  Documentation/devicetree/bindings/arm/bcm/brcm,bcmbca.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git
> a/Documentation/devicetree/bindings/arm/bcm/brcm,bcmbca.yaml
> b/Documentation/devicetree/bindings/arm/bcm/brcm,bcmbca.yaml
> index 6a64afa95918..4494a2c58c7f 100644
> --- a/Documentation/devicetree/bindings/arm/bcm/brcm,bcmbca.yaml
> +++ b/Documentation/devicetree/bindings/arm/bcm/brcm,bcmbca.yaml
> @@ -36,18 +36,22 @@ properties:
>                - tplink,archer-c2300-v1
>            - const: brcm,bcm4906
>            - const: brcm,bcm4908
> +          - const: brcm,bcmbca
> 
>        - description: BCM4908 based boards
>          items:
>            - enum:
>                - asus,gt-ac5300
>                - netgear,raxe500
> +              - brcm,bcm94908

I think it would be nice to keep enum entries sorted


>            - const: brcm,bcm4908
> +          - const: brcm,bcmbca
> 
>        - description: BCM49408 based boards
>          items:
>            - const: brcm,bcm49408
>            - const: brcm,bcm4908
> +          - const: brcm,bcmbca
> 
>        - description: BCM4912 based boards
>          items:
