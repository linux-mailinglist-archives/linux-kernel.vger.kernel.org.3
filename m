Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681DE4C1837
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 17:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242632AbiBWQJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 11:09:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242041AbiBWQJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 11:09:21 -0500
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72061BD2DC
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 08:08:53 -0800 (PST)
Received: by mail-vk1-xa31.google.com with SMTP id f12so12451001vkl.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 08:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=ndrXe7NYHF8Ev8ijd4FYUfXAzrl1uWWpQ7TDn8XsTTA=;
        b=HO+rgElVyks3m7LgA55xJaBNnKwXRAA3/pSORSjnkAiJp280bI8YkAmLn1zWlFyJp2
         VKy9zUoinUSPzNuss54A4htFymu7r0wU1ILt6XqK+bbLHaX7ZpN+SbGW9JxpVcmX8M08
         9+1Hmxup/BbHJgUDRu33sBFmAhByMaTkcCg1AjVeC7jaduuonoUqEHFD3sM3l7OfhsXn
         mIlQqn+RCt923FTzwbmAaq4cLku81q1p8aXwLxecFymIKXkglTFeP6JfdWAC72vSFI0i
         znKllTqdBW1jGqq1dxFE3F82cIpv7kI/u/D/6fpakNKJV7oRD37/7Psh6AFbx/0H8dDd
         /S5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=ndrXe7NYHF8Ev8ijd4FYUfXAzrl1uWWpQ7TDn8XsTTA=;
        b=g6sMWIIRAl+FY0Bc4jZTRT9iOtVIqhYgiTBAc4f0PU8IwIezExuRhF+q4atzUK2F/G
         VHnuDEhIrAUY5sRnqqiaqUNTarfuYBqK4qmvZYkjtqQ4MG3iKUmDjMlCVoGmckfPNtq6
         q9b5ik3i04B1LDQJTcyc8Py3fFzZ3vx7JUGxqVv0h6c2YDgFuwBW2W/er6Ikp1Bt/6GQ
         kwfCGrg5dgKFxEgctysJSdtqp4KZdXddAIdy0llOYGRfyMh7ad95sbOrz1nFmGMI9qMg
         DIr3ybyiUbt1mC1G9x3O+xutsEI1aRcQMtVlU++5ELvv6lTOHPgJRoVItXBrglYpzNYo
         yBmw==
X-Gm-Message-State: AOAM533q8+qw2kevuMaCflKcDyW47cnAmqArvAnj8QyAnDiTWwtdMQxx
        BIW6mXD+0GEYuP2H21iIupgtgBmRkFsheVzhCdY=
X-Google-Smtp-Source: ABdhPJwUUHQBarqataBhVEr3GQWmqpmekSm81fEPAI0IEGMcTFtnfvqnle7/31QqU+JXZBzY5vdy+O6Bo1/LIpRpdOM=
X-Received: by 2002:a05:6122:90b:b0:321:1905:7121 with SMTP id
 j11-20020a056122090b00b0032119057121mr76885vka.5.1645632532634; Wed, 23 Feb
 2022 08:08:52 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a59:c1e6:0:b0:28c:4a7c:5151 with HTTP; Wed, 23 Feb 2022
 08:08:52 -0800 (PST)
Reply-To: kofa19god73@gmail.com
From:   Ecowas_Law <barr.2000000@gmail.com>
Date:   Wed, 23 Feb 2022 08:08:52 -0800
Message-ID: <CAK6e4w3M8nk8FHO-9UD9V2VzyrhLvkhetODSLeyQGoi9dtxv8Q@mail.gmail.com>
Subject: Fr;
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Welcome, nice we meet my beloved one. May Peace, mercy and blessings
of God.in the unity of love. nice to meet you in legal and sincere
discuss.

Best, Hug
