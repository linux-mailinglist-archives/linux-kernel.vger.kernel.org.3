Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E2C4C9DCF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 07:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239713AbiCBGae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 01:30:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbiCBGac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 01:30:32 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7585C345
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 22:29:50 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id d11so783091vsm.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 22:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=/jtPWna49+ilTACF3yuz8A6a8AX5IHL0XkTLmK7g2p0=;
        b=BJyev2DVGxJYPzfB3LKf85fSZNMOklg4QAu/FbbK4KTkVfdKeq2ZtkkJWkiKzXHjLu
         naaPAnHaRvXLw612RkjHChy1ZXJRJ2vxuONYRIDeY9+VsIeR8DFZmvK9ZbBrzr3Yl5Id
         HaNcB9VfIwp9urKpuqcb2gnW8ik3+V9lrcdapIQUmnbSNhR9Z/uwps9uxyutO5zmgV0B
         bzURsdm7EdJjSYGToVuyr3zjXVQcMHRRfmPiWzcOyvskqmD0x+zdsELqEU2W6Ulqeyqr
         SzVpCVNVla6oQDxwZcM8cNVd5le3XUkpIlEA+ucA+aslPYwTPWTSvPemciCoBUNtgUl9
         3zwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=/jtPWna49+ilTACF3yuz8A6a8AX5IHL0XkTLmK7g2p0=;
        b=RFys+74q5oQ3aBi7vvE7xcsO7VU00kAHepgFEGlye9AqQmkMUC4/CnFS0JJRtrDefI
         cWKN3BC9/CYQulEvMADk3GnEhNncCHc15WW+YaOn5kzGaNgX+EZul82C4lX5734H0Vo0
         GEOoMtqwiwxfgd1GpjW6zGaMhOFY4XdtGWpQBg8F7tEohNQ1XtJ4B7pGjAHaGuGAjS7p
         br9a9OetUaDVczT8GKhIDyg0W0iQ8OH6EGh/ENptYckA1gXWP8DknlAkmZHfkG7yYFxS
         alefHW30BvkFwPTGmG7jCspRfxhkRZ0WHIJ0ZiH24EjHgvX+x1VRp0RWmG0mkGdNgOLh
         H0gA==
X-Gm-Message-State: AOAM533g24rS4yhjEcSNRH+lPp4UATRU6onu1Nw+hcRP/IHn7oebpcKw
        7Ky/RdCDgn98JA/xoMIMQhhXfAYjHIlxQYnCLaQ=
X-Google-Smtp-Source: ABdhPJzczXlkZW5IbVmmqILrfhMNj+bgEwUysVq9Rlbqmsaz7KgJ0gZZCxfM/NOESQWiPreQxrH1PcbKVrSqswZ+huE=
X-Received: by 2002:a67:e3c5:0:b0:31c:a:599c with SMTP id k5-20020a67e3c5000000b0031c000a599cmr11072685vsm.17.1646202589708;
 Tue, 01 Mar 2022 22:29:49 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac5:cde6:0:0:0:0:0 with HTTP; Tue, 1 Mar 2022 22:29:49 -0800 (PST)
Reply-To: jamesthomasinfo3@gmail.com
From:   james thomas <williamsjane347@gmail.com>
Date:   Wed, 2 Mar 2022 06:29:49 +0000
Message-ID: <CAFLGuG3Wz7Ski3iW36gwCVbeC9w+djumxv1uueYeCv8G=BevrA@mail.gmail.com>
Subject: Greeting
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:e2d listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [jamesthomasinfo3[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [williamsjane347[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [williamsjane347[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greeting

In a brief introduction, I am a lawyer ,JAMES THOMOS, from Northern
Ireland but now i lives in USA, I sent you  an email about your
deceased relative family , but I have not received any response
from you, deceased is a citizen of  your  country with the same
surname with you, he is an exporter of gold here in USA.

'He died a few years ago with his family, leaving his company,and huge
amounts of money deposited in the UBS INVESTMENT BANK  in LONDON.

I'm his personal lawyer and I need your cooperation So that we can get
the money from the bank before the government finally seizes  it, the
Total amount in the bank is =E2=82=AC6.7 million,EUR. but I will explain,mo=
re
detail if I hear from you.
