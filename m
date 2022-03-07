Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4D94CFDF5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 13:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238000AbiCGMSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 07:18:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237282AbiCGMSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 07:18:09 -0500
X-Greylist: delayed 746 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Mar 2022 04:17:15 PST
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED887F6DB
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 04:17:15 -0800 (PST)
Date:   Mon, 07 Mar 2022 12:17:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1646655430;
        bh=UITEfrh6N0CqbUx+jw3oX1vThs4fJt+qEMpZFPC0orU=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=p25tnIMgsnK1/hRQ59Y3wk1hpB8EI0Aik5mIgqP5p9WsML8fbq8wDswc1KEI4e/xl
         THc2wD8WiM5LwTfyiszInRNsoO2BzW4DfuvcsClPlPYJbtc3/A060YmrqtzjVwSDnk
         +38t6AYY5Bx8HsdCq/CS7mthx6SCRUB+0n3xOciHA9LqQd4kbi0yajWKLYuRdviVv2
         ASxdBXEjj8J/rjPNk2C9UsEk7DjUVOVwBYB4wA6agb3sggCnJyG3wZ0LieKHnfLA+M
         Z1ANe/uF3YwcL6YKN7UrT+vzBFFgjlqhmvEI1wZLuVUekZ88r0+X9/NxkITiBlKTJu
         rDyIaCbvuCG4Q==
To:     Turritopsis Dohrnii Teo En Ming <teo.en.ming@protonmail.com>
From:   Turritopsis Dohrnii Teo En Ming <teo.en.ming@protonmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ceo@teo-en-ming-corp.com" <ceo@teo-en-ming-corp.com>
Reply-To: Turritopsis Dohrnii Teo En Ming <teo.en.ming@protonmail.com>
Subject: Re: Do you know which version of the Linux kernel is running on the Cisco ISR C1111-4P router?
Message-ID: <_fJ91ZCt-IEN6F9OuuBhgig9QMVDWpyqYIW4eRG5_VgF9AVzOBNUrfsIz7cjYeEB4kjRDD0dfPmzCUybLru9-JdyfZm9PTvBlHU9A9Gtrn8=@protonmail.com>
In-Reply-To: <AB0feU9l_r03jGQuU1pL3oQcUz6tYy2ZboVlYuDj4R34X5rzjHCQMzxqtx8Rw-e_bmV67wZdMCJRlwofm3dF-CJAxk6zAcWjxi14pEGtUJc=@protonmail.com>
References: <AB0feU9l_r03jGQuU1pL3oQcUz6tYy2ZboVlYuDj4R34X5rzjHCQMzxqtx8Rw-e_bmV67wZdMCJRlwofm3dF-CJAxk6zAcWjxi14pEGtUJc=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,TO_EQ_FM_DIRECT_MX,T_SCC_BODY_TEXT_LINE,URIBL_BLACK
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I had the opportunity to reconfigure the Cisco ISR C1111-4P router on 3 Mar=
ch 2022 Thursday Singapore Time.



Sent with ProtonMail Secure Email.

------- Original Message -------

On Monday, March 7th, 2022 at 8:04 PM, Turritopsis Dohrnii Teo En Ming <teo=
.en.ming@protonmail.com> wrote:

> Subject: Do you know which version of the Linux kernel is running on the =
Cisco ISR C1111-4P router?
>
> Good day from Singapore,
>
> Do you know which version of the Linux kernel is running on the Cisco ISR=
 C1111-4P router? I saw the following lines on the console output.
>
> Cisco IOS Software [Fuji], ISR Software (ARMV8EB_LINUX_IOSD-UNIVERSALK9_I=
AS-M), Version 16.9.5, RELEASE SOFTWARE (fc1)
>
> Line 366: *Mar 3 03:11:12.681: %IOSXE-2-PLATFORM: R0/0: kernel: CPU3: fai=
led to come online
>
> Line 367: *Mar 3 03:11:12.681: %IOSXE-3-PLATFORM: R0/0: kernel: CPU3: fai=
led in unknown state : 0x0
>
> Line 368: *Mar 3 03:11:12.711: %IOSXE-3-PLATFORM: R0/0: kernel: coresight=
-etm4x f0f40000.etm3: ETM arch init failed
>
> I have 417 lines of console output, but I only provide 4 lines above at t=
he momennt. If you would like to see more console output, I will provide at=
 your request.
>
> Looking forward to your reply.
>
> Thank you very much.
>
> Mr. Turritopsis Dohrnii Teo En Ming, 44 years old as of 7 March 2022 Mond=
ay, is a TARGETED INDIVIDUAL living in Singapore. He is an IT Consultant wi=
th a Systems Integrator (SI)/computer firm in Singapore. He is an IT enthus=
iast.
>
> -----BEGIN EMAIL SIGNATURE-----
>
> The Gospel for all Targeted Individuals (TIs):
>
> [The New York Times] Microwave Weapons Are Prime Suspect in Ills of U.S. =
Embassy Workers
>
> Link:
>
> https://www.nytimes.com/2018/09/01/science/sonic-attack-cuba-microwave.ht=
ml
>
> *************************************************************************=
*******************
>
> Singaporean Targeted Individual Mr. Turritopsis Dohrnii Teo En Ming's Aca=
demic Qualifications as at 14 Feb 2019 and refugee seeking attempts at the =
United Nations Refugee Agency Bangkok (21 Mar 2017), in Taiwan (5 Aug 2019)=
 and Australia (25 Dec 2019 to 9 Jan 2020):
>
> [1] https://tdtemcerts.wordpress.com/
>
> [2] https://tdtemcerts.blogspot.sg/
>
> [3] https://www.scribd.com/user/270125049/Teo-En-Ming
>
> -----END EMAIL SIGNATURE-----
>
> Sent with ProtonMail Secure Email.
