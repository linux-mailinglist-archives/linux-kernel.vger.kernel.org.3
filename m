Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7D14C1821
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 17:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242269AbiBWQHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 11:07:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234332AbiBWQHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 11:07:39 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBC3427FA
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 08:07:12 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id z7so2821344oid.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 08:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=Zr7FJr/ROqrH3KPFcIbpCq/ZL9h+i4UX28KOdEhJPUU=;
        b=I8GL9KB17GANpNg8Fgm7/L8CRlyNCmfFa5dkquALuJK0aAIXjnYwyqO86pS8lOPFwo
         O6iNMoeSPK8GrBLwviWwFrBBCcd/guMNo9umy+ZNsAg63fx8X6zADtGrserGRt1I11+c
         3qr0VU5aNNfAe7vavGn+Z/ySedywX8JL4FKjR9SzimlvV4fonQQX7XYYsKCuoCer959E
         v7+7NWyxUwzGynnnDeQa676djQGR654f6ode7KUSj/Qzri7ymMh19QL4WeHxhG4EW8C8
         sex2XoI4R3Beg7MKnKvt79vdOk8EkqJGsV7FhdjguCG3/3a/QGlvzM4ILlXuZriEW2wj
         ONjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=Zr7FJr/ROqrH3KPFcIbpCq/ZL9h+i4UX28KOdEhJPUU=;
        b=AQeT3MDBGy82FBDS5tYyPlQJNQ2eaP+Bd/XmPFQbrHmjieQJtz8872m4X6KqBNhV+r
         fBgct9VAqmRDQkYav7oz9E5cz6+XPPEna8Ocl0vbltOQCdxsfKzKOGzP8ZORuUYNMN7E
         iJjy6VGoiKlXoeGMBlaPSWjO0KY1Vi5DcQnBJsmFrtDw2w1Nzi6tyyivLhnI3b1xBs81
         xPxV7x63brRiedbHJiEeA1ixfBuI4uWWMryBg4+l+3uQkUEPqd5QvU/+j7Xnljxbyear
         6uH40FrWoG75o129Xd+8CozaBqxAMLitR0LeX3WXBnut/eR1IuUVt5iDp3i9v84IlBRR
         Oz/Q==
X-Gm-Message-State: AOAM532u0pZBvwLZIeDtNrZF0hkqOGl8XpoIuFAIhwqIqSz/Ad1bpcoB
        BF7gmH+Ueffs0SBawYK+2HjyPL7Kwv/qbZR9CuI=
X-Google-Smtp-Source: ABdhPJwcNI7lOdaTnCrjhaIUsHSuWgr5Mpgydbx+/f+sxOo3TP4RNpQ0GWKJjUbuQqmBTLX46Af2tAbX5SY4d8wloN0=
X-Received: by 2002:a05:6808:ec6:b0:2ce:6ee7:2ccc with SMTP id
 q6-20020a0568080ec600b002ce6ee72cccmr4725236oiv.250.1645632431304; Wed, 23
 Feb 2022 08:07:11 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a4a:b912:0:0:0:0:0 with HTTP; Wed, 23 Feb 2022 08:07:10
 -0800 (PST)
Reply-To: mariam002musa@gmail.com
From:   "Miss. Mariam Musa" <abelphillip243@gmail.com>
Date:   Wed, 23 Feb 2022 08:07:10 -0800
Message-ID: <CAFYUzGM0XdrCqKPsnx+mYRivPQ7d4m5TW8ofJ6ak_CDHcaNX9w@mail.gmail.com>
Subject: Please I need your help my name is Mariam.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:22c listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4376]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [abelphillip243[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [abelphillip243[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  3.5 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good day,

Can I write you here? I have urgent information for you here, With
utmost good faith?, as you know that my country have been in deep
crisis due to the war,

Miss. Mariam Musa.
