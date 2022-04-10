Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3584FAFB8
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 21:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241256AbiDJTPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 15:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234850AbiDJTPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 15:15:34 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DC162117;
        Sun, 10 Apr 2022 12:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1649617981;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=TVm9M9yjsU+cDxKC68nwURli+QgGpcmGVMnrIwSMQOk=;
    b=b0pMNXG2+jfmCHoYRfJZ/Pbljo6gEOV9kaJ/n/CEtwBVoffvpFPzGR21+1s7WsI8Tt
    GDzo127ARlrH+ErCupE2hNfqVdDBGehec8NDdgQba0OAao6kS4Wilek6o2dHrvZVXB6d
    HE+knjFQwZqR7Ehoh/DTIYSmCdc33sNdfLEU0hgCJR6e6i1TezSqm2IDrolNhRMSlZKm
    RK1wHYkHEkkOeX9FTCV1Yp+pOE3K8hDrdKct1uRcWE3PqwZn3cX6I9NjCq3m8GiQCvJ3
    mJtl2ROHpYkJEZDV82ztHyDvcqWrLlry/BHMb/6JWb5aiF4nNOKi4FsjsVEcBus9WEP6
    RnEQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7wpz8NIGH/jrwDWqdw=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 47.42.2 DYNA|AUTH)
    with ESMTPSA id k708cfy3AJD1x1v
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Sun, 10 Apr 2022 21:13:01 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH 13/18] dt-bindings: fix jz4780-nemc issue as reported by
 dtbscheck
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <e10f0291-8252-fd12-5bba-f25f472cd605@linaro.org>
Date:   Sun, 10 Apr 2022 21:13:00 +0200
Cc:     Rob Herring <robh+dt@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, letux-kernel@openphoenux.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F13B9261-C990-4018-B2DB-174F604D44E3@goldelico.com>
References: <cover.1649443080.git.hns@goldelico.com>
 <84adfe6237cd4cfd52cb9723416f69926e556e55.1649443080.git.hns@goldelico.com>
 <036b66b2-c221-6e9e-6a56-510e7a0d20d3@linaro.org>
 <B9FD64FE-82B0-4DC2-B4C3-BE266DAB28A0@goldelico.com>
 <99a97b0f-19a5-136d-9160-c9fde6f3548c@linaro.org>
 <e10f0291-8252-fd12-5bba-f25f472cd605@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: Apple Mail (2.3445.104.21)
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Am 10.04.2022 um 17:35 schrieb Krzysztof Kozlowski =
<krzysztof.kozlowski@linaro.org>:
>=20
> On 09/04/2022 15:18, Krzysztof Kozlowski wrote:
>> On 09/04/2022 15:09, H. Nikolaus Schaller wrote:
>=20
> (...)
>=20
>>>>> @@ -17,7 +17,7 @@ properties:
>>>>>    oneOf:
>>>>>      - enum:
>>>>>          -=20
>>>>> -          - ingenic,jz4780-nemc
>>>>> +          - [ , simple-mfd ]
>>>>=20
>>>> This is not correct representation. If you really need simple-mfd, =
then
>>>> this should be a separate item below oneOf.
>>>=20
>>> Well, it is valid YAML syntax and seems to be accepted by dtbscheck.
>=20
> Minor update:
> Well, it is not a valid schema. Rob's checker now confirmed. If you =
run
> dt_bindings_check by yourself you will see the error:

I did run dt_bindings_check. Otherwise I wouldn't have seen that there =
is a problem
at all, before suggesting these changes...

>=20
>   properties:compatible:oneOf:0:enum:1: ['ingenic', 'jz4780-nemc',
> 'simple-mfd'] is not of type 'string'
>=20
> Probably because enum expects string, not another enum (so enum inside
> enum is not correct).
>=20
> If you do not see the error, you might be missing some packages
> (mentioned in writing-schema + yamllint for a different issue) or your
> dtschema is old.

Neither.

yamllint etc. are all the most recent versions. Updated just two days =
ago.

But my filter looking for ci20.dtb did not catch it because the report
doesn't mention that file.

So Rob's robot is more mature than mine...

BR,
Nikolaus


