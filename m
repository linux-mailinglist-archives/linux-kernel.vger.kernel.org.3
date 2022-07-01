Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853C4563813
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 18:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbiGAQhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 12:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbiGAQhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 12:37:36 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9E04476E
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 09:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1656693268;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=eMe8iN2pQOflR+UL23Usvst9NDxt1a4K3PcAeZQiaV0=;
    b=X7vDSqkF3JURad5JnwL5Dsdr3emSpYz4moerSpPLxI6SZpR0p4HFLzTo2zq5SVzrEz
    trJhNX/dCtVZrVnI7GaK5QR1gtJfKDpuW2K20kxBWtEiLptQLx0G3M9g5Gjv16SdS1Db
    5ya7dfIVfpxgSlFZCJrGHq5t3cN+OozCxyBjr2aT6y8JjAqzXuYkfVpANPxAcRlM123Q
    /UYq4LVkElv8TtP2GKzOzn3C8Mi2Pigl0WByOuD4/Tv2cvdXi4RbyFyHBSqP4/NKU2HL
    bw9l3SqWVjdA5lPCq27yeg8bTe14mQi8vEA7kBO+uhtUa3k7ehPMpjFz/qjKrDCSKEjv
    WRJg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw9iZeHWElw47sdXM="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 47.46.1 DYNA|AUTH)
    with ESMTPSA id x1817fy61GYRBka
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Fri, 1 Jul 2022 18:34:27 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH v1 RESEND 1/7] dt-bindings: leds: Convert is31fl319x to
 dtschema
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <dcd817c8a3852f3e6bad0c221a284fb3e69e1ca9.camel@mailoo.org>
Date:   Fri, 1 Jul 2022 18:34:26 +0200
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <24FA86F1-9601-4431-ADE5-3EBF8149E128@goldelico.com>
References: <20220628182147.2837180-1-vincent.knecht@mailoo.org>
 <20220628182147.2837180-2-vincent.knecht@mailoo.org>
 <1656468579.884791.1403671.nullmailer@robh.at.kernel.org>
 <20220630152806.GA2732671-robh@kernel.org>
 <dcd817c8a3852f3e6bad0c221a284fb3e69e1ca9.camel@mailoo.org>
To:     Vincent Knecht <vincent.knecht@mailoo.org>
X-Mailer: Apple Mail (2.3445.104.21)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Am 30.06.2022 um 23:43 schrieb Vincent Knecht =
<vincent.knecht@mailoo.org>:
>=20
> Le jeudi 30 juin 2022 =C3=A0 09:28 -0600, Rob Herring a =C3=A9crit :
>> On Tue, Jun 28, 2022 at 08:09:39PM -0600, Rob Herring wrote:
>>> On Tue, 28 Jun 2022 20:21:39 +0200, Vincent Knecht wrote:
>>>> Convert leds-is31fl319x.txt to dtschema.
>>>> Set license to the one recommended by DT project.
>>=20
>> Do you have permission to do so? The original .txt file is default =
GPL2=20
>> and owned by H. Nikolaus Schaller.=20
>=20
> No, sorry for the mistake.
> Adding to cc, which I forgot to do in the first place...
> For reference: =
https://lore.kernel.org/linux-leds/20220628182147.2837180-1-vincent.knecht=
@mailoo.org/T/

Please go ahead and change as you suggested. I won't find time to =
maintain this (new) document.

BR and thanks,
Nikolaus

