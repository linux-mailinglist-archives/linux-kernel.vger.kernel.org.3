Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86124FA895
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 15:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242182AbiDINes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 09:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242084AbiDINen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 09:34:43 -0400
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [81.169.146.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F7A1A54E4;
        Sat,  9 Apr 2022 06:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1649511152;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=j43DOErzeD42TmNN/jzEMLB8mvqxdLFcFY7ph+usTRw=;
    b=QAubdMng9kvLWHlgiV/y2VxQOB3hA3+4dy1/ZMYcdz/QtvYUhGBKc1y5Cg6SuAo2GP
    G2fgT9aXf3HEBlaCt0noL5xBACnpHivaoZaO/fjnGsHMUbpgz2lsAAdy8EYWVHzkVYBS
    esMJzHz3umdhXA1/sbaAzsA0n9KId41mvSH5+MVJvHVXAbuGIZvwXmTHNu017jQqTkNm
    WzL1p1TQpknsU95dIlKxeoV8YZTjWDYDmQMs3w448ZOEUpKtQRNHrtGfW6gotEyVFO5t
    VgMgp7fZijqP7UvhzusaZfdzo5Aq5zzlyvFUHVJhQDp5LiIkos8uBieAPZ7+Bwwmuapl
    uHBQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7wpz8NIGH/jrwDepmg=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 47.42.2 DYNA|AUTH)
    with ESMTPSA id k708cfy39DWWuWk
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Sat, 9 Apr 2022 15:32:32 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH 07/18] MIPS: DTS: jz4780: fix otg node as reported by
 dtbscheck
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <535e3eab-a28e-46f3-2a7e-f1ffd1913470@linaro.org>
Date:   Sat, 9 Apr 2022 15:32:31 +0200
Cc:     Rob Herring <robh+dt@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, letux-kernel@openphoenux.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7B66AC66-EF73-4F75-A775-589A4F98BEFC@goldelico.com>
References: <cover.1649443080.git.hns@goldelico.com>
 <298162bfa2e7225ccc753865e1ffa39ce2722b2a.1649443080.git.hns@goldelico.com>
 <bd19b6eb-d53a-b665-749d-46c275c85ccc@linaro.org>
 <822182F3-5429-4731-9FA1-8F18C5D95DEC@goldelico.com>
 <535e3eab-a28e-46f3-2a7e-f1ffd1913470@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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



> Am 09.04.2022 um 15:15 schrieb Krzysztof Kozlowski =
<krzysztof.kozlowski@linaro.org>:
>=20
> On 09/04/2022 15:05, H. Nikolaus Schaller wrote:
>>>=20
>>> This looks wrong, the block usually should have a specific =
compatible.
>>> Please mention why it does not.
>>=20
>> Well, I did not even have that idea that it could need an =
explanation.
>>=20
>> There is no "ingenic,jz4780-otg" and none is needed here to make it =
work.
>=20
> Make it work in what terms? We talk about hardware description, right?

Yes.

>=20
>>=20
>> Therefore the generic "snps,dwc2" is sufficient.
>=20
> No, you are mixing now driver behavior (is sufficient) with hardware
> description.

No. "snps,dwc2" is a hardware description for a licensed block.
Not a driver behavior.

> Most of licensed blocks require the specific compatible to
> differentiate it.

If there is a need to differentiate.=
