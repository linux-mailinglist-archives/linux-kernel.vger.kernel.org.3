Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABC54E6704
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 17:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351694AbiCXQam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 12:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234980AbiCXQah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 12:30:37 -0400
Received: from sonic306-20.consmr.mail.gq1.yahoo.com (sonic306-20.consmr.mail.gq1.yahoo.com [98.137.68.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5C088B2E
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 09:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1648139343; bh=UXKrT12a3DzKh+2zloU1ZQGM6ZmFTDIcHcEdgd5rtCE=; h=Date:From:Subject:To:Cc:References:In-Reply-To:From:Subject:Reply-To; b=SpD496npca3OWk7NJfUyz2hn6xVaBe1HsENuvuh3UR3PBAs2xuc7eDYECXSFIridlK/PUAOKX2Oc1gTYzA2P6+VFSyYrNHu18hC27gIcfePNETWDQ9KrZf2pYuKsucprR8yxj9uGUz0mi6LO2cMbU9Om2IENMWltw6d3RH+29CK2zxscI42bWtVMD7iXbqESCgFvBuIwxT9Z0wtI3/T0Nrdqv45LI+Gf/0FLjVuqJFnFm6FkWcvFVPRSK3Qr2DTuLEDRv6GjkNlD+UR/9vTmQC88ipK1eUKpt4aPXflbctC68nW50urCSHuPCxHb5CHO5z6/BDKbqXEFQWioeHKUJA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1648139343; bh=aumSlAenBaTUgKziRCUvNevO7sKIELeaGbhUjKjyyTL=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=XkRcMHVCRr7W1CtP47RathZmm43vWMCXhKhOBeh+NrYxACalodd0KO9YcguO8c2rN9MCAbituco1sUEeVLPzvqKwZvO4+uVN30fUR25nh2qLkGA70RFYA7tNoCd+VG4BMR9irGWtv9DkvedK4Ene/NgaHBS+uy4pql4TKapep0adReBxT/f5r74rb/FF1E2DKXiGqC5P+450WNlJ6etHuje6WhOnHENAq4ch+xPmAN/zRgUBQmlikTUPon5zDQtfUiqN0a5LEkJCJgXhIjV8P+BI6ghkqwQNdbhSbFnxjgej/QylD9ZlRrMSK1Am/E0zxDQZHoSoE9S4F8AvuDhmYA==
X-YMail-OSG: ze8S4cMVM1letCAw46Ei7hgeZ7VUgXN8.j5mkprIv4RR8ENyxPPCQoXc42hvsvJ
 YrChXB1DqhWPopCohFYWUkohFl0LpPgfOs5irK5xltrv9c2wQPtaNq4.iitq_WUxglMqKSxns7b.
 01qD25HnS5I9qw1fUg7lIp63JMDm8L0SlflQGT7ED9B8lQ_x1mDjBfFcDnWicoVJwKXQ_MQyyThK
 q8UNMhq54V8bush_f.w7LxVTRGsfbR_HvgJjmamomYE_YPg0zgAyTTYM0YHknP0Zm2k7n8Q.paVB
 BOSuaUrqknTmWHV90XIKg9N5Zhsuw0eFejtcI2bGqyfQv5mJDtxTaJezeF2ssFSzEAEqCeY0Azks
 mGebK41Lu7oGnAPkHlTHE_Hh5PqpNVow.OxF0ZME2h.FlzwmuVPz6XXstYKW8buOUoM45_gKG4Gz
 qAjc0D2uozs2GTmvEDsuKBcsKvdus2XFVV9FpHMSLodPPb0Td6pi9aEAN.q0eDTAkTMG_6OFcgUJ
 k2zjfg65YoFhj.X.d1JOL01CAhmafzubPEeb_fvgOe5vpfDDX3P_b_TpJLFUqiznQtynNXao8zQF
 v8BU35f8Uh8M1P4dBlNm3xIpFoAm13veCOdTFwPZiYiPyjenZv3i9rjNxZFRWxBRxU0JW6N3n82P
 cZHkSV66imZxm8ig138gTNIyvdSbKNUocuTbhf15HBW1vN66SpcbLQDDZRWVtchdexkvC6CnAl7C
 fKe_UwdXpO214FKfUadnVQWRofhRTKK3LU862zfJM8j8L3Xy8HNge5R5dyIs7FfQ2zKQJP75uc0w
 EE1G3Q4ElVH0rr8DYB3sPPX.h71AjaB7BhWW8pP5D.Q2Ij6kUvWt7zAzWbDQjwaa4PGSK.8pCGsH
 frmXWgBp9WNk6uH_D4NtH9m2rEN.pdZ_45dwrywKrFHDfa0qlbuhiokpDEBV0H_yrbeFqWLREn_o
 JbNVK7lX0jxZE1UEiR3uinJ57qVV1DVJK_qV0PX8geRb9rbmSHRftLuL0T6M616.hOTwSu_Ntto3
 3G96cJPK5107_H5lD4atW.bwHOOVkCcncg6341VhYNwZrTMZqMPKyC.b35aYGE.vubNoUdlwy8Jq
 u4Lv_nkpiAGoyR4nLKRQK30..JbS5HaKv3oYstzX7PR5j9.JQI5bq77Yl8VdCYolXPeynjCPSIi5
 6hEcrm99zLuDv7k8p7olKqdnLi5fAANofNYDZhEcT18GwxKoZOoJ9XTreco6K7yyEqT0rgzy4jIC
 br74Z23.8pPpGdUcoSPRnRChh2wnGFfoCSZRPaZDVEkvWOBnsk8mzRevNpf7G1nrvkzJ1Kr1ixQK
 xvzlB3F22t2_mzJC57ZLjBQ5BhplIqxmzCEzm.dZ681nprLtlNtJFeVANbfgAweFhQ4lj6J.kGdR
 Fmi4UmetRSLyN5ALjhXu81zISpUfQ16HXy.ffrrpFT.LuSc9XNl0UztAKNQOJiYfVKjbylemA769
 Kt2JyQd7ycZSZSiIIAJoXlNz6I0Paqmr28XvlJSydygLJ2MmGudv.xqOsvp5FXg1vS4IRn6yJPXO
 gCJ5R9gZOiGWurbshf7BpMrIjFBF7rpDbU6IL1Wh7stFVpn8lz7FTzc3s7GgO3cokogZo_OaX1bc
 OsNwMaG3FCOct7tzTdLXKG5rfsv8WqctkQQTKdzAEp8gzHsdOWWR9_rsT3AcSdE8rLkZJGrl0v1g
 adCdsloFegjHqYQGkWIh_GMIfx11tADf3qQziUfumjCYCvJDk.haEft7f9F.oji2xY.LSYfEcDBL
 oPnrZ.Sdf4KPIV7.Jq73OFCaRjtDR6TDY4eeFJ3SzJBBCmK.O5.MhIeSIAbUo0j71dPIUeS2aImN
 cdDMzXI9V0HVtl9oaOMdlw9UMksqxdceahee9GxqTo_Eth87Uoiz25CwnPmxV8CRqmt0hdi7fajS
 dfWsZ8eT1ViZvh9ZeYFKbaqzhQJNsczz0W8keMasNRjGUYxdoUSxbBiXaZWgVz21ze7Cp8dM02Os
 ROr7MYKi02mip5IXcH.84iKg5qPnP0q1OgyPf4jL9hRwT_v14Z_5yGOShR7N_Yi0Suuzxu4nXGEv
 pvSUN8wtwki5klaQWAgPniM6kuzyvl991k8KCqpuah.pKPwUQMekTt9dVHY0fC9sfX81GJal.hdM
 kDlaOAnJe_k4uDn4b7TfMB4lVXxUR_8KzJClN8QhKLSPGgAQ2YSmrLN5TBEHwgam7nh97KI7P_OF
 Jzx2zezwg.4Bqj5H7qAG3fb9g_jgpHTU3l.3U7IXkn7L6eoFGclTPLHBSZsJROyCk2h2osSZT6i9
 GPFLErMEFnQ--
X-Sonic-MF: <alex_y_xu@yahoo.ca>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.gq1.yahoo.com with HTTP; Thu, 24 Mar 2022 16:29:03 +0000
Received: by hermes--canary-production-bf1-665cdb9985-6hz22 (VZM Hermes SMTP Server) with ESMTPA ID 69cdc785063c6e607374d345053147b1;
          Thu, 24 Mar 2022 16:29:00 +0000 (UTC)
Date:   Thu, 24 Mar 2022 12:28:56 -0400
From:   "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Subject: Re: [PATCH] random: allow writes to /dev/urandom to influence fast
 init
To:     Jann Horn <jannh@google.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220322191436.110963-1-Jason@zx2c4.com>
        <1648009787.fah6dos6ya.none@localhost>
        <CAHmME9rsvxczJrhPwRX6nyrh9NB2AuJqkEKrTLx-G-T1J6_czQ@mail.gmail.com>
        <CAHmME9ovJpdcuuZhNKrOTUc8XvKDDdC+axhAmOD9iESnRR7JqA@mail.gmail.com>
In-Reply-To: <CAHmME9ovJpdcuuZhNKrOTUc8XvKDDdC+axhAmOD9iESnRR7JqA@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <1648138746.2zrnsqdlu7.none@localhost>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.19894 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Jason A. Donenfeld's message of March 23, 2022 11:18 pm:
> Hi all,
>=20
> [...]
>
> In light of that conclusion, I'm going to work with every userspace
> downstream I can find to help them fix their file-based seeding, if it
> has bugs. I've started talking with the buildroot folks, and then I'll
> speak with the OpenRC people (being a Gentoo dev, that should be easy
> going). Systemd does the right thing already.
>=20
> I wrote a little utility for potential inclusion in
> busybox/util-linux/whatever when it matures beyond its current age of
> being half hour old:
> - https://git.zx2c4.com/seedrng/about/
> - https://git.zx2c4.com/seedrng/tree/seedrng.c
> So I'll see what the buildroot people think of this and take it from ther=
e.
>=20
> The plus side of doing all this is that, if the efforts pan out, it
> means there'll actually be proper seeding on devices that don't
> currently do that, which then might lead to a better ecosystem and
> less boot time blocking and all that jazz.
>=20
> Jason
>=20

The issue, in systemd developers' opinion, is that counting seed file=20
towards entropy initialization potentially causes repeated RNG output if=20
a system is cloned without resetting the seed file. This is discussed at=20
length in https://github.com/systemd/systemd/pull/4513. A few years ago,=20
I wrote most of a program to check machine ID, disk ID, DMI ID, and some=20
other things in order to avoid this issue. Since then, systemd decided=20
to store the random seed in EFI variables, I assume on the basis that=20
machine cloning typically does not clone the EFI variables? In my=20
opinion, since the same argument applies to machine ID, ssh keys, and=20
any other persistent cryptographic (or even non-cryptographic) material,=20
this falls outside the scope of random seeding and into a general=20
machine cloning "sysprep"-like utility.

Cheers,
Alex.
