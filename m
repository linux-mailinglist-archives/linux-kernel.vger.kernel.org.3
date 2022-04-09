Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79E64FA8A4
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 15:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242201AbiDINkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 09:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233597AbiDINkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 09:40:04 -0400
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09FE13C71A;
        Sat,  9 Apr 2022 06:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1649511472;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=A38jLkMhxB0aROCgv4/oyefD9VABl9BLTRNARBXZigo=;
    b=KXsyl70AyDNwepKNwhiqVA/4Pd/eVmogE6tRm5L9GkbpfTWmrMKkKIR/nae4QFKQVh
    VT9IahtUym14jkKxvPj9C7g0dzplboGMW6ZklsDsG6pEBV0VQMgAFjy2u4EDovx5rk54
    lrMwyeWs0af25yZuhHIctEMagB8BwyfapbG+eG+mtuZoT0JqrdDTplIdxpunW2PaMtxZ
    e3vIhgpKYtso+k3ubcXHmqfTphNcZ3VgeLYXZM+FT6kn7P7Lm/RnIPxveyged2dJnDIx
    D+FNTk0lI8w/72wVLXDxxCH0VvpfMBo1ZTuLg7PeMML15oUVvkIj2D6FfJV6BJnARWyz
    cwqw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7wpz8NIGH/jrwDepmg=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 47.42.2 DYNA|AUTH)
    with ESMTPSA id k708cfy39DbpuXD
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Sat, 9 Apr 2022 15:37:51 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH 07/18] MIPS: DTS: jz4780: fix otg node as reported by
 dtbscheck
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <2961d892-609c-c0bf-e9c1-c54306f608c7@linaro.org>
Date:   Sat, 9 Apr 2022 15:37:51 +0200
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, letux-kernel@openphoenux.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <51EEBAB0-849A-4AA5-80E0-B9FAC8FC5E14@goldelico.com>
References: <cover.1649443080.git.hns@goldelico.com>
 <298162bfa2e7225ccc753865e1ffa39ce2722b2a.1649443080.git.hns@goldelico.com>
 <bd19b6eb-d53a-b665-749d-46c275c85ccc@linaro.org>
 <3XN2AR.4ZAYNTAI4XBT3@crapouillou.net>
 <36C96109-0A56-4ACF-ACD1-367DAD9E3A47@goldelico.com>
 <2961d892-609c-c0bf-e9c1-c54306f608c7@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: Apple Mail (2.3445.104.21)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 09.04.2022 um 15:23 schrieb Krzysztof Kozlowski =
<krzysztof.kozlowski@linaro.org>:
>=20
> On 09/04/2022 15:18, H. Nikolaus Schaller wrote:
> hould have a specific compatible.
>>>> Please mention why it does not.
>>>=20
>>> Agreed. The "snps,dwc2" should be a fallback string, otherwise there =
is no way to uniquely identify the JZ4780 implementation of the IP.
>>=20
>> Well, there is no specifc implementation and driver for it. So no =
need to uniquely identify it.
>=20
> Specific implementation and driver are not arguments here. This does =
not
> matter. It's really unrelated argument.

The argumentation is in reverse: if there is no need for a specialized =
driver or implementation,
why is there is a need to define a specialization.

Your argument was:
"there is no way to uniquely identify the JZ4780 implementation of the =
IP"

My question is:
"what do we need that for?"

> Bindings are not about implementation in Linux. Implementation can
> change, so bindings should also?

No. Implementations should be agnostic.

