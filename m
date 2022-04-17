Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6B95045ED
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 03:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbiDQBcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 21:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233175AbiDQBcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 21:32:32 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF4413F84
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 18:29:58 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id o18so8143770qtk.7
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 18:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=bZjpwB+wNCLwsZCSnLxqmC4sXR2mJpModolDDWKFE0Y=;
        b=Icuk2Vd6k53Z24VEYSyEpoaAiwagDY+AVVu+JSk/zoXV95kkmaqyvV887SeWYEGbMM
         4Zo26HVXRXPjvrBfOQhI745rcWX2ebR1vv1ifaNY4fjJ4NCh9HoXRBKIG4BhwqXM+vKU
         gLKDwAZofe5OX4I8uM67/ybu9FR3eJyLDNYkcvOnUaic/vCxJgpN1khzcZLiT5pl//A/
         nUMdoNF94m3Bl/U2B/z79WEJZmpVvY7bC8tJG2t+WTajynlUtHmOmY5gPK9WTCH9+Nzt
         Hox+/T61Bn5iQVXqBvzodMuxS1LqeGsMmTgMhnIm0Et+Se44VRw7oRut6Oe1dKlmy1Lm
         sX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=bZjpwB+wNCLwsZCSnLxqmC4sXR2mJpModolDDWKFE0Y=;
        b=o9PUv0TBB++51+txvjnwtCOQqmRmG+VDve+F23x0gF9Xcxa043knl6osDodnPlzRuz
         CkYBhl5sR5lpwbx+RV9SiCTyfuWfttFN7/7OeoRXy3VvjLHRWng0S42vPorOAATEUzps
         nEPd1u8u/+w9MVfzvzcRfm5dTWQYvOKcnqbtxCRnhWakEKPlykagASCi6ujrNRnjI7j+
         LsnQY5dF6mzvWhX1ENbz92NS2ewv/rZRZ1InBry4vOVu110QDpl1SMcVP5laxGeGjK2K
         e9MguPUg2JGDOuw+vep1vtuJklAwmnHIibM3W+Y7vF42idiyveaVZ7lGfJB4LilvnKwE
         xTIg==
X-Gm-Message-State: AOAM532JuO4ihne6c0GQ7Lnzn830v5kuiFUV38Oho3FN4/Owbxvl4j8F
        r7A4RqDITAzMLL0nMJRqisMgoeEM2so7QDS4tI8=
X-Google-Smtp-Source: ABdhPJyfp6p4kPtqTYhuIjfdYY0ldHRt9/gHuq0LEDAreJsCUN9NVxgVrxUtXplZe3HUtZNCI/yyKEs/LDuURP/B5LI=
X-Received: by 2002:a05:622a:4083:b0:2ec:e9e3:1656 with SMTP id
 cg3-20020a05622a408300b002ece9e31656mr3477260qtb.529.1650158997347; Sat, 16
 Apr 2022 18:29:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ad4:484e:0:0:0:0:0 with HTTP; Sat, 16 Apr 2022 18:29:56
 -0700 (PDT)
Reply-To: wijh555@gmail.com
From:   "Mr. Jibri loubda" <gjibriloubda@gmail.com>
Date:   Sat, 16 Apr 2022 18:29:56 -0700
Message-ID: <CAO=FyH+Yx=awFZKs60ssVaDWMhEibqKLqtcLEZp-S1hZHvVwnw@mail.gmail.com>
Subject: Good Day,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,HK_NAME_FM_MR_MRS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:82a listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4853]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [wijh555[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [gjibriloubda[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  1.1 HK_NAME_FM_MR_MRS No description available.
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Greetings,
I'm Mr. Jibri loubda, how are you doing hope you are in good health,
the Board irector
try to reach you on phone several times Meanwhile, your number was not
connecting. before he ask me to send you an email to hear from you if
you are fine. hope to hear you are in good Health.

Thanks,
Mr. Jibri loubda.

Sincerely,
Dr. Irene Lam.
