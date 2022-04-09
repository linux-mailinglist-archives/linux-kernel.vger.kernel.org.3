Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720174FA7FA
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 15:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241861AbiDINHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 09:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240058AbiDINHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 09:07:15 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06F21689C2;
        Sat,  9 Apr 2022 06:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1649509498;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=MHp3hQkTnYwGib275bEgr4tWcu5Xdj2zI31TXKbFIWs=;
    b=lzI0j+bwTtZ8vyfgFjmKJ2Zu/YViURxoOzYauhCdA/AcGSN1/ao2IhNK0zMbUI0jbQ
    aqQa09K6RS8NqyQlOEpa1FCeuYpum/KQ78pHi0PWrb7stgJQ2SkeW2JSdtkhBsym2RJ7
    tiYhrGwFD9GboWzS9OH2hyzSPfWSGxZtpwmaq0wUqNTg/i5YHdB7TQWwfQVvWt6Ehla+
    KWZ2uXvZUXKiyyX+IdJL2p4PGU3M6Fcv3Xxj9Jyt4WqCoUXnCk4TjfolrPN2uFgdloPO
    QPmKZ9aWNShjgx5ccEF3QnMpkWN2CrUdjn2EoqrzsUByIpJKZvqGoGoaDaX/iqpqbBVk
    nAlw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7wpz8NIGH/jrwDepmg=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 47.42.2 DYNA|AUTH)
    with ESMTPSA id k708cfy39D4wuU9
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Sat, 9 Apr 2022 15:04:58 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH 06/18] MIPS: DTS: jz4780: fix rtc node as reported by
 dtbscheck
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <c41851c5-8f17-4ac0-d4c8-a3aaa7f7fb8a@linaro.org>
Date:   Sat, 9 Apr 2022 15:04:57 +0200
Cc:     Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS 
        <devicetree@vger.kernel.org>,
        linux-mips <linux-mips@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A01C0C5E-AFA3-424B-8205-F96158F88700@goldelico.com>
References: <cover.1649443080.git.hns@goldelico.com>
 <5b4831407a68c22fbc63c7d29dd608ebfdd4cef2.1649443080.git.hns@goldelico.com>
 <c41851c5-8f17-4ac0-d4c8-a3aaa7f7fb8a@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>
X-Mailer: Apple Mail (2.3445.104.21)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Am 09.04.2022 um 13:14 schrieb Krzysztof Kozlowski =
<krzysztof.kozlowski@linaro.org>:
>=20
> On 08/04/2022 20:37, H. Nikolaus Schaller wrote:
>> arch/mips/boot/dts/ingenic/ci20.dtb: rtc@10003000: compatible: =
'oneOf' conditional failed, one must be fixed:
>> 	['ingenic,jz4780-rtc'] is too short
>> 	'ingenic,jz4780-rtc' is not one of ['ingenic,jz4740-rtc', =
'ingenic,jz4760-rtc']
>> 	'ingenic,jz4725b-rtc' was expected
>> 	=46rom schema: =
Documentation/devicetree/bindings/rtc/ingenic,rtc.yaml
>=20
> Why? Maybe the schema is wrong. These devices might not be compatible.

Here you may be right that the .yaml is wrong. Paul?

