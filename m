Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632B24FA8AC
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 15:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242214AbiDINqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 09:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235301AbiDINqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 09:46:19 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A085A939D2;
        Sat,  9 Apr 2022 06:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1649511851; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YLnpjWKWdJSzyYl1QcHeDFBttOq+hxRx+fuv0aLpL/g=;
        b=Dn9raXykAtJqjunhLTgxl1TKU1h5UmANNI/XkZqMaClk7KqzF2l7lD4scQhvcm+xwitEV6
        7+XUWC3LaRM9mrhgjt0IFGiybWGMitvAhKbknvhcqWGKbKCVn7Vdy1EDrMu6ZWKgeadQ4j
        pQHbC0L6h9Gdhhnf7ng+sTXKTIHFsZw=
Date:   Sat, 09 Apr 2022 14:43:57 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 07/18] MIPS: DTS: jz4780: fix otg node as reported by
 dtbscheck
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, letux-kernel@openphoenux.org
Message-Id: <9HR2AR.5RNNT3NES815@crapouillou.net>
In-Reply-To: <51EEBAB0-849A-4AA5-80E0-B9FAC8FC5E14@goldelico.com>
References: <cover.1649443080.git.hns@goldelico.com>
        <298162bfa2e7225ccc753865e1ffa39ce2722b2a.1649443080.git.hns@goldelico.com>
        <bd19b6eb-d53a-b665-749d-46c275c85ccc@linaro.org>
        <3XN2AR.4ZAYNTAI4XBT3@crapouillou.net>
        <36C96109-0A56-4ACF-ACD1-367DAD9E3A47@goldelico.com>
        <2961d892-609c-c0bf-e9c1-c54306f608c7@linaro.org>
        <51EEBAB0-849A-4AA5-80E0-B9FAC8FC5E14@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le sam., avril 9 2022 at 15:37:51 +0200, H. Nikolaus Schaller=20
<hns@goldelico.com> a =E9crit :
>=20
>=20
>>  Am 09.04.2022 um 15:23 schrieb Krzysztof Kozlowski=20
>> <krzysztof.kozlowski@linaro.org>:
>>=20
>>  On 09/04/2022 15:18, H. Nikolaus Schaller wrote:
>>  hould have a specific compatible.
>>>>>  Please mention why it does not.
>>>>=20
>>>>  Agreed. The "snps,dwc2" should be a fallback string, otherwise=20
>>>> there is no way to uniquely identify the JZ4780 implementation of=20
>>>> the IP.
>>>=20
>>>  Well, there is no specifc implementation and driver for it. So no=20
>>> need to uniquely identify it.
>>=20
>>  Specific implementation and driver are not arguments here. This=20
>> does not
>>  matter. It's really unrelated argument.
>=20
> The argumentation is in reverse: if there is no need for a=20
> specialized driver or implementation,
> why is there is a need to define a specialization.
>=20
> Your argument was:
> "there is no way to uniquely identify the JZ4780 implementation of=20
> the IP"
>=20
> My question is:
> "what do we need that for?"

You may not need the differenciation now, but if you need it in the=20
future and you had only the "snps,dwc2" compatible previously, then=20
you're screwed, since your driver must support older device tree blobs.

-Paul

>>  Bindings are not about implementation in Linux. Implementation can
>>  change, so bindings should also?
>=20
> No. Implementations should be agnostic.
>=20


