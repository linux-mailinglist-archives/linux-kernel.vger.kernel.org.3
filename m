Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFBB24C321F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 17:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbiBXQua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 11:50:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbiBXQtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 11:49:43 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A852F1A94B1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 08:49:07 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id y5so2151868ill.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 08:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=1WmTiruYcLYjgfCVpwaSh4JcERuBX8rKufTgiQZnbQI=;
        b=m+6Am5etB5+aaU7SxU4uRdVvvNpwqDNnePJdqPMD/iaVl3HzdHKk5znodTtIHZCSzI
         VGTa6/S3tv05kHN1fvWXolzRgKeLfUGwUAVfjzfLslV5mloXKxk5JTrL0pBq7VYVJ+cx
         KIDAUbXTZCV8x5WatbRjlM3sSZXjjm8acIRFyVWECo7yvv62xcqW0I2QrsomAtM6TdHs
         ldSClEzFwXIOr1gre7kvRN7r7o6ktiDaaq4nh+jVQ5VwTimg0qsD7oU64ukPWJVpIvYm
         57Q1gkF6SwFhmbTIXRauwcTAyaJ8sSM2nkOouF+U/qhEe69UnYoJDk2TRnYKUWpz1a1i
         8l1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=1WmTiruYcLYjgfCVpwaSh4JcERuBX8rKufTgiQZnbQI=;
        b=Rm8vW3uRXHYHC2mjd/wIcAKOa1AMewinpXlE9LdPlU23xLU9wWyrN0sK5vtVzlkL7s
         roZubK50nsgqk7BmdJTVGPFHjjLd6sW/KiuxGYDmHksLfkewNIdzVhLaaEFlpWxSYTZK
         7De7JzqqjcmSatHWrMLk4U76dupVjXFF+PRa9Pss6sgojuFf6RMhEhbuMiKmUafOBsx4
         VuC16N7ljEZEcjqKmmUmzEmIvlnUiq9nb0e5EM7rJTCqe/3Luplx9bacs1vbD8NSxJWP
         wbXb7XZpLMyr10aJacs3uSerHytPTVP3aYw0mnlKzrc65O8ViAIRiRYzhTaH2+E88l5a
         OeAw==
X-Gm-Message-State: AOAM532h1JMHFOiynTieXAW/khfJJSwS4oDaufd8zr1iH5R5P/b0mved
        sOFd/mu/Y96iLvCfp+K6MVfNERzOm45isQff8rE=
X-Google-Smtp-Source: ABdhPJwHaItEL+gOJtdHobPBK10F8qOvIKCij1pGixJGYTtblYtMwjbNLN+VkV7BiRaleC7eDUpL5dSyJIdq3AMX/FQ=
X-Received: by 2002:a05:6e02:184e:b0:2c2:76e6:bbcc with SMTP id
 b14-20020a056e02184e00b002c276e6bbccmr3034339ilv.318.1645721346426; Thu, 24
 Feb 2022 08:49:06 -0800 (PST)
MIME-Version: 1.0
Sender: aishagaddafii331@gmail.com
Received: by 2002:a05:6e02:2195:0:0:0:0 with HTTP; Thu, 24 Feb 2022 08:49:05
 -0800 (PST)
From:   Aisha Gaddafi <aishagaddagfi@gmail.com>
Date:   Thu, 24 Feb 2022 17:49:05 +0100
X-Google-Sender-Auth: wbmh3mlB4OZfTbkAyDcWomDln7I
Message-ID: <CAMrsXqO4-rD-f0HBx6TWd5VU7pmYZeuPNcbL40U_E7+M0CfWXg@mail.gmail.com>
Subject: Greetings Sir/Madam.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLY,LOTS_OF_MONEY,MILLION_HUNDRED,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY,URG_BIZ autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:135 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [aishagaddafii331[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [aishagaddafii331[at]gmail.com]
        *  0.2 MILLION_HUNDRED BODY: Million "One to Nine" Hundred
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.6 URG_BIZ Contains urgent matter
        *  1.0 FREEMAIL_REPLY From and body contain different freemails
        *  3.5 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
Greetings Sir/Madam.

I want to invest in your country
May i use this medium to open a mutual communication with you, and
seeking your acceptance towards investing in your country under your
management as my partner, My name is Aisha Gaddafi , i am a Widow and
single Mother with three Children, the only biological Daughter of
late Libyan President (Late Colonel Muammar Gaddafi) and presently i
am under political asylum protection by the  Government of this
nation.
I have funds worth =E2=80=9CTwenty Seven Million Five Hundred Thousand Unit=
ed
State Dollars=E2=80=9D -$27.500.000.00 US Dollars which i want to entrust o=
n
you for investment project in your country. If you are willing to
handle this project on my behalf, kindly reply urgent to enable me
provide you more details to start the transfer process.
I shall appreciate your urgent response through my email address
below: madamgadafiaisha@gmail.com
Thanks
Yours Truly Aisha
