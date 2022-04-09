Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 938984FA890
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 15:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242164AbiDINcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 09:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241119AbiDINcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 09:32:20 -0400
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131BCBF977;
        Sat,  9 Apr 2022 06:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1649511007;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=oAzQjHGereel9cPw5YcrcnatGr4FxuPzR5R8fQE+Qsw=;
    b=E0VaIi6HW92DX1zBa1ilMGgsFIrhHBybVs2B8dkjbXNufksopLFa4E5Fko9624RXNf
    ubOPIpjB3CQ571PaR3de5sSfqwhVWQwVVr5BvmsQCRNTvtIl/sOJq8xQbi3vcIZa6mo+
    wW6US+Fw+u3sdhHvmQ9q1Lkg38/rsCdkxHA6NXtMRpg/KB1ZHNTWFmb1uJlPt5xweMQU
    NVjM5jj+JtA1PS/m863Utd/fbhyTCE+6rESWr69M3O0JC+3hCpoYFRrvnFm+Cm7fQ81e
    3jaMWebBcn+LoAvobsDTWsr6CLXFi1Gd2099daDD7i0B3dS7UfqSwm3dYYfHQ7+IdvnR
    M0Zw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7wpz8NIGH/jrwDepmg=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 47.42.2 DYNA|AUTH)
    with ESMTPSA id k708cfy39DU7uWc
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Sat, 9 Apr 2022 15:30:07 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH 03/18] MIPS: DTS: jz4780: fix tcu timer as reported by
 dtbscheck
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <2729b85b-1c54-d446-baf4-2c41bb04b3b2@linaro.org>
Date:   Sat, 9 Apr 2022 15:30:06 +0200
Cc:     Rob Herring <robh+dt@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, letux-kernel@openphoenux.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <47A20D89-9E6D-4121-A162-76C545904BE7@goldelico.com>
References: <cover.1649443080.git.hns@goldelico.com>
 <c48277625f0ab5afc86d89deb1b87537e9c592f6.1649443080.git.hns@goldelico.com>
 <e5ea96d8-f8c9-b925-04ee-81e80e30a5d0@linaro.org>
 <A023438A-B8A8-4F91-BA25-7BE9A76C6730@goldelico.com>
 <ef1674e5-2347-fbb4-52c8-5170faa84690@linaro.org>
 <9BE666F8-123E-4062-88F8-D266CCCAC43B@goldelico.com>
 <2729b85b-1c54-d446-baf4-2c41bb04b3b2@linaro.org>
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



> Am 09.04.2022 um 15:22 schrieb Krzysztof Kozlowski =
<krzysztof.kozlowski@linaro.org>:
>=20
> On 09/04/2022 15:18, H. Nikolaus Schaller wrote:
>>=20
>> Well, again, my assumption is that bindings and .yaml files formally =
describe the actual
>> hardware components. And they have been reviewed.
>=20
> The bindings try to describe it. They are pretty often incomplete or
> might have mistakes.

Indeed they have. But what If I have found that they are right. Why =
should I comment on that?
It should at least be the default assumption.

> The true reason of doing a change is not that some
> tool tells you "do like this". The true reason is because the change
> properly describes hardware.
>=20
>>=20
>> So they have a higher level of authority than any current driver or =
.dts implementation.
>> Unless there is evidence that the bindings are wrong.
>=20
> This is just a tool, not an authority.
>=20
>> I.e. if the bindings feel right why is there a need to argue for =
that?
>=20
> Because doing things "just because bindings told me" hides the true
> explanation and makes the code review, code management more difficult.

Well, I always wonder why schemas were done that way they were done
since their introduction. If I would write down commetns every time =
nobody
would be happy...

> Later person will look at this and wonder why this was done like this.
> If you write "because some tool me" this is not a good help. But if =
you
> write "because hardware is like this exactly" this is proper comment.
>=20
>>=20
>> It is like test-driven development model. There you have to write =
code that passes
>> the tests. Not argue against the tests.
>=20
> Again, don't focus on the tool... Tool is just a tool...

A tool I can't ignore because Rob's robot tells me it is "the truth"...

BR and thanks,
Nikolaus

