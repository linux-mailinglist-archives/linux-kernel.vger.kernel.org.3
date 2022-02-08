Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2DE4AD3D5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 09:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352053AbiBHIoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 03:44:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351365AbiBHInp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 03:43:45 -0500
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176FBC03F93C
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 00:43:32 -0800 (PST)
Received: by mail-vk1-xa42.google.com with SMTP id 48so9386343vki.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 00:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=edeevZ54MxyNr2ONaDsC9jI+UtdZjrCL/LCuSFC70Ao=;
        b=QvjhunuNO8r16PKypuCdrachST6yXHIKLmrVAmm1fY9jgIyDx/5nuaO2Pwi2GiqW2B
         y3T9ScMXoknCi4MzeG0G4mYZV7FvO5v4AkTPMCsC30rz5vAb97o9IyGFE2M1jFci41zh
         wOytP4iaP2zv3wL+KEjK3XEvc8S3s/itCvuySs3WCmZXIU4wBzIdDAY4hb/oqG8VRWYu
         n+XhOcxWsv/r9vQ5BYoq7JNJKiQgQ/IzzgqncW1w/Tkor2GHYOHxI5AK+GKVNR+tqv1V
         2t703ywu9JorFFnpi4djB66Cf/056cbSXRmPhsAAxlMq/2WmkJMdwVn2CUpQSTsrFBjK
         RdsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=edeevZ54MxyNr2ONaDsC9jI+UtdZjrCL/LCuSFC70Ao=;
        b=yvacXA6d2psn7veXXCS3T+kw0eZSxiZ47G9WkhRpr7Xn6U9xQh0kBirt1EYstvQsAx
         cmMxJb9FPpxwj5OIKJaLpT/KTFUktlPzLH8nupsGupG+7AxNFglwwDhhd0NCySqJmC7q
         v92NwLkS6JHaAiKi/WPn3oRZ5Pl4qarQiYXXswF/oQ3An5gmb28BOU+MDLskBiGWTifj
         zLXxDsbUxBIgTWg1r58Ex34XK4FaO+GE4CdLJwVoFchAqo5Gwc/0hefcKiFDxBpxlXP4
         Aqm5Pvj+sA5w+8HgOwE2d0DLmTl7bwG2qioqpSWWBZCa9GHiuBikoBHJW7jDzlTdwLj4
         SDlQ==
X-Gm-Message-State: AOAM532SUrfMM14pouIkrYS4P3/yXROV4Vwl95h/K2J3/PmGsfE0qi0s
        7eIFUDYVVnSZFxBVpW+pDaZmZFXwagkuKHSo6FQ=
X-Google-Smtp-Source: ABdhPJzZQn1EaCqRMqsuYIcH+C7RpG+lwrJT+RNnO9Yiljp06wkeSVejZxXgkS7NBIOXb/H0s5Oh1fbTnACKXJVE068=
X-Received: by 2002:a1f:7301:: with SMTP id o1mr37679vkc.4.1644309811016; Tue,
 08 Feb 2022 00:43:31 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ab0:2bc5:0:0:0:0:0 with HTTP; Tue, 8 Feb 2022 00:43:30 -0800 (PST)
Reply-To: saeedmohammedsaeed085@gmail.com
From:   Mohammed Saeed <nzubewwwww@gmail.com>
Date:   Tue, 8 Feb 2022 11:43:30 +0300
Message-ID: <CAMj4HvTqbEjkDKhCipFXDZsqTQO37tQLsSKX=dgvTiL8KEB+YQ@mail.gmail.com>
Subject: Proposal
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:a42 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.0 HK_RANDOM_ENVFROM Envelope sender username looks random
        *  0.6 HK_RANDOM_FROM From username looks random
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [nzubewwwww[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [saeedmohammedsaeed085[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.4 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Salam alaikum,

I am the investment officer of UAE based investment company who are
ready to fund projects outside UAE, in the form of debt finance. We
grant loan to both Corporate and private entities at a low interest
rate of 2% ROI per annum. The terms are very flexible and
interesting.Kindly revert back if you have projects that needs funding
for further discussion and negotiation.

Thanks

investment officer
