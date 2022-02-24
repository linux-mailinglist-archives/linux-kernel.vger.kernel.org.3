Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009CD4C2290
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 04:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiBXDpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 22:45:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiBXDpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 22:45:34 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C5F25D24A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 19:45:04 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-2d07ae0b1c4so11026007b3.11
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 19:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=b+i26jACpHGUt7PiPDH5eeNKNhNYUz1/aWiveExwvXl0ceU1Ie1hYY0g8L94TpIbhJ
         4VKycSYT9iXWQzoecjC7HO4G1ExnYUrtf2VdY2Bkta9QtbB3NL5VV8883jq/Lo75ReKo
         kdQ8nMsT4VSywBSm8DQS56JSOxsDAKQyTJzx4klZiqZBXgDfgdL3VhzDbFTbmEB0Skz1
         TW1Zj6Zho3GyG5/z3nf69VFe8UmlkIz09yefpdxZqYQEo2vcJbe8WWGKmHwvi9u+GDtN
         SJ3jnKL6ySB9TTnZrRrTGkTb/X0F50atBIPZNDZqtijcCZqskXj8Y2xPrpOxRLU7r90e
         0fvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=DVU0DqTN/KnhSGUcvWF9M2XdIuyzdQ7hzCp1lEONLgLXUrVUl8wrnpfT3raoX9US0g
         MfvkxTAwlOl4/DVScM4vp0TujAe1687Pr2yeYSqaVO8A6AUlxdndRZvgguMWWETrYS13
         1Mc9QZcp6sCcbryp5cFHyelg+BK+hd6xw3uJgehl5/KNa7WHmkTcgZUg5B/gCUJNyB+j
         DItcmPMNQgK7wD50t+laJ0AckmL9cXCBieoJVLjp6idrVFaSCMPScengtQ3+kgO+JGZZ
         iZGW7jkp5XiugZbgfZUfGli7i2tODddRToVAO4FmnnUTyexydZcaQduByXwXO2GA/4Ey
         ERIw==
X-Gm-Message-State: AOAM532v22AZh2CpJf+cC+LyN+OOxBAMSiGtVFXRy0kuniphQgONUJiZ
        ptlK96CyAdUWvMGU0mzL56i5MvwLq3zSGh/2lZA=
X-Google-Smtp-Source: ABdhPJxO6mfwyWdmybD+ZKo1IdrIgjo8AuLe+10YPKmnKkbcAZChQrOHWKklntK2WC0rzi0smJkUk3a5apQn+9j4i0c=
X-Received: by 2002:a81:5bc3:0:b0:2ca:287c:6c31 with SMTP id
 p186-20020a815bc3000000b002ca287c6c31mr675609ywb.214.1645674303191; Wed, 23
 Feb 2022 19:45:03 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7010:738a:b0:210:6fe6:62e1 with HTTP; Wed, 23 Feb 2022
 19:45:02 -0800 (PST)
Reply-To: dravasmith27@gmail.com
From:   Dr Ava Smith <gracebanneth@gmail.com>
Date:   Wed, 23 Feb 2022 19:45:02 -0800
Message-ID: <CABo=7A0xmNOkHup5i1eJoTmVcLy5rRS+YukcgHfe2-qXDyv_Ww@mail.gmail.com>
Subject: GREETINGS FROM DR AVA SMITH
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello Dear,
how are you today?hope you are fine
My name is Dr Ava Smith ,Am an English and French nationalities.
I will give you pictures and more details about me as soon as i hear from you
Thanks
Ava
