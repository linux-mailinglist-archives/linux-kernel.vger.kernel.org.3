Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32484BA156
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 14:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240956AbiBQNfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 08:35:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbiBQNfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 08:35:52 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A84F2AED97
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 05:35:38 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id o2so10056958lfd.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 05:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=R/po0lF9mFOE6iJpyAWY9b0aDCDVYuuZScqVW68enm8=;
        b=KTMgKbuQx/oNmnHp1PV0yWKBdk0AK94UIHu7/k3JE8W9dBCfjCg4tIM4kJxXh7UT4K
         JDYfiT1HiiZaJDbtXT6S+by2luXlSYzNLST7mteEsBi4vuHNDS9xCQ15ofHgMrEl5p6L
         U3Z3B73tPcVZ+YRkrCU0A/q8TIul6h7BbOgNmb2p6l7o+gvMbVlKMH+DJ9oYOAetnmf7
         tc3RTNcxFOj6Q5D71jUbHcySZoferqn8k6diFjiwDRyr3D5K0hQLRs4ExsAfvPRICHZl
         SGAiK32j58GmIvj9V4pjoSUNABms5Ka/j7BaCeEYhgThpcvFaLp+G6GYQH8K9rkQ1EPT
         UT0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=R/po0lF9mFOE6iJpyAWY9b0aDCDVYuuZScqVW68enm8=;
        b=GtFGrFco6XvLx1E4Oh97pRPrVtm+VnIszWqmIng4CdJV/YeSpqa6l9dhV+HUTRjswE
         YdmT9c6yUAQm4w4+TAoslt4wJud6jrZo2GDkrc0iy7dZ/BcSH1jfUEzYXXuNOYwl98sb
         BBpb+H1rQQ5kXyq+6SCX+hOAvGKo1VaaE/Q5b/fTQV+RCoD9a+Ywmr7mo5d1psYzkPwQ
         3ET7xkTC261ZQGEXcTrKEon5RZ1PvEOmoY2Cv0RGhZe37iBt+74kjyEdjuzHnsYyVWCf
         Pc2j1UHPgSkJcWNu6Q64/BqDaWMM78sn8Pm/qv4I3BdbudcWlk0y4oaSpWCdI5JvFbkk
         hDjw==
X-Gm-Message-State: AOAM5300CVRjisOZbK0QZJUKVuJ9LNtMC4RlRiGiE/GtmLvqrTR51rR5
        a9RZTYACs5u9WXkWogei5HNDAV7avp/XMkBFjyA=
X-Google-Smtp-Source: ABdhPJw4EOApdIo/b0jMc9irPlY2O0AUBtAl7ceGxOimgQD+2g8C6QHLSyjAFNLQD2DFvngTQ55YLdMX2alDsGd0uqw=
X-Received: by 2002:a05:6512:3a85:b0:443:9610:6a63 with SMTP id
 q5-20020a0565123a8500b0044396106a63mr2057080lfu.507.1645104936763; Thu, 17
 Feb 2022 05:35:36 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a2e:1615:0:0:0:0:0 with HTTP; Thu, 17 Feb 2022 05:35:36
 -0800 (PST)
Reply-To: hegginskate7@gmail.com
From:   Heggings kate <heggins35@gmail.com>
Date:   Thu, 17 Feb 2022 13:35:36 +0000
Message-ID: <CAH=nmxaeEW7YDvWxjEgA+Zn8uC3Dc9QaYuiBQRTJ0PubwSaFAg@mail.gmail.com>
Subject: Halllo
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:12f listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4745]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [heggins35[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [hegginskate7[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [heggins35[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.5 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo, ich hoffe du hast meine Nachricht erhalten.
Ich brauche schnelle Antworten
Danke.
Katie
