Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6423568B1B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 16:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbiGFOVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 10:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbiGFOVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 10:21:43 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81C416586
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 07:21:42 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id j6so15276111vsi.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 07:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=mr+iAGjByavtVLAQKiAQDHpjl6ae/h58WRbLzWLbqk4=;
        b=VXG1Zc0nmwQDFHrO1ctMcS+KBC6B4O+4I6MEpNukeCiKofkIxH8l23boU9XaVIQTc1
         fW0K9UQIP+ruSDkPjmLr/97R1IZp8/WfAmllM8E63pu51JU6LXaD/LEPrlklGvh4GaGB
         eSYJ/tON2yogrvwOdTYlFNYfhG21Hju40YMHCOKuey3RfwH2Vg2iKxukAPN+9ZlBsewm
         2+ZxCjKDhWBU7WIqlxnCMFtdFarWJ075qscG56PwRLYx3V0iM8kcVctlAE1t93k7j/Kh
         VC6hRp2lqMZznM981XipN+FKb9WRsEfSg+5C+BbkLkS3pjB3hWIqCsFjrVo0+GL1/lyh
         74dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=mr+iAGjByavtVLAQKiAQDHpjl6ae/h58WRbLzWLbqk4=;
        b=prcm4slIVERj+IqYaUbnuO07icNL5Uh6r+Wc/P/uIJJL9KSM9xEB5PEkXclvTdPE6y
         8uDn+5Wy97s6o0Gz+mSt+KrmRXuwm4BfsCw8Lv5dmUw9O6cNiZROkxYOBlP961sPM+na
         rpKDtrl8SpYGPyYf/ndfSFydqeU1d4dVy+A7vUA0b8Ov9Npx3TPX+I76UBYeHUysgmXN
         Y0jmFpaT2RnRWWiExBnj9k8zkRsJ92DeFxc0KXwyk4GLeh6iXr2vjm0Ay5Yhkk77PHco
         cNCE6c+Vg/YOe+SZutip3y7VF4BQWImd6kaqZsXEH9QKcuFIgWKSCYYV7CkzNiq/Y25b
         z4mw==
X-Gm-Message-State: AJIora+4qEk5XkdBppnspKVVjFRtycXxjMskeWUdyRgus2v2V3qi82eR
        G8DbYZ6ylaAns0NFNhewR7uv6W5dnk16oW616l8=
X-Google-Smtp-Source: AGRyM1sa2bqKPsrT2vlzYuHD3mdK1uK6ZW6HE3vNe+nzgMqRmxOub2sw8pYmE5PM7na9XpN+JP3LXYg2+WapPlAevbk=
X-Received: by 2002:a67:6e47:0:b0:354:52a0:8ac2 with SMTP id
 j68-20020a676e47000000b0035452a08ac2mr23478502vsc.65.1657117301649; Wed, 06
 Jul 2022 07:21:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:d911:0:b0:2d1:df97:7e86 with HTTP; Wed, 6 Jul 2022
 07:21:41 -0700 (PDT)
Reply-To: aminataabdullahi270@gmail.co
From:   Aminata Abdullahi <mpbvcg@gmail.com>
Date:   Wed, 6 Jul 2022 07:21:41 -0700
Message-ID: <CAHpgNGGg=f6TS6gUw8KBgTgSe_Uf11pYPzDOLtPH2uTx70w3Zg@mail.gmail.com>
Subject: Good day
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.7 required=5.0 tests=BAYES_50,DEAR_FRIEND,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:e2c listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5006]
        *  1.0 HK_RANDOM_FROM From username looks random
        *  1.0 HK_RANDOM_ENVFROM Envelope sender username looks random
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mpbvcg[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  2.6 DEAR_FRIEND BODY: Dear Friend? That's not very dear!
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.6 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear friend, Greetings to you. Honestly, I got your email through the
internet, while searching for a reliable person I can partner with, I
believe you can be the right person to partner with me in a genuine
business transaction which I will be delighted to explain in detail if
you grant me the opportunity. Note the benefits are fantastic, very
attractive and risk free.
Warms Regards
Mrs Aminata Abdullahi
