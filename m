Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8362D4E7189
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 11:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347529AbiCYKuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 06:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346407AbiCYKuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 06:50:35 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F05713F00
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 03:49:02 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id lr4so6103354ejb.11
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 03:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=5g4e3FoDZ04w3yN9r9/DrAhXMgzBOA3m1TJsZRCqpfs=;
        b=n6dKbdNCk//xuIWH5ZuCgomK8m3SmbjUTvscXKLp0DSJ1SGEAEG8bFJ2qPFX2Yw0s5
         23plW33mFPWCdonbZdo2vxY6hmodvGpM9LLHZDC0H1aTP/VmGBa1RrlxUSctnVIIaWmQ
         VcTHculCdSrHijXLmxB9xpBS20/8sC7gujBvtIRnI3XlRqu67abxZiKoTYwqyPZLlkja
         Fgzu9CX276ZYKL32Yb+ubH6r8h5I0axNsMmFawS+gGvubL2GX8jdwUPDsXsrGiuVsT4G
         3SJFyLjEZnes1W1hpkH2IGX9g/bW6zQtlBRPNbJTE3NXWwUIpYGl7nDEbidnWZZe3UD3
         X5lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=5g4e3FoDZ04w3yN9r9/DrAhXMgzBOA3m1TJsZRCqpfs=;
        b=Lk96HHigsKVK/LFt6VEianx08umJJmDrf82mCKumRiTKtFSs0W/aP57xmX/xxkhzBR
         PkfJRSSmXwqV0vw64C4NXx8J1yS1WnHpTRdVE/k9HrXgESiJfp31c+kex3WxT57yOUbz
         DuyyDvGobn7MDkX3q1+IQF4EjU/XU6pg1Eq3zsmhkDKNd8zZo3Ddy/5a4CuCC7B6/2JC
         NVlP6C/eADXIOUcUvw9d5q5XDhjBn4gIa7ZjaqAjHal4fcmMajEXWxY42Ac3Dp/Rb5uv
         LsLauJOjSkmZCl+mHurr5xAA1KtttuAClHNxkkCws3yOXaHcTgIPjLPW0wqrWRW0O0jC
         gufg==
X-Gm-Message-State: AOAM5335WRToyXR3Z+ekaX5o7VW7UeLC7R7X1u/bzkXtfpJ/pkzd8g7/
        inRg3p8l+8+wvgVKoR14knrTA8Bb1uFkHp7JDk0=
X-Google-Smtp-Source: ABdhPJzuf4mYz27UntRyklmEnJTabJthFi9ec1OZebVPqt2mLTOsDxlzLjy5uCzsk371D+lM5gi8Dhwq6B5O8mc8o4E=
X-Received: by 2002:a17:907:6296:b0:6da:745b:7b40 with SMTP id
 nd22-20020a170907629600b006da745b7b40mr10919713ejc.750.1648205340660; Fri, 25
 Mar 2022 03:49:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:907:eac:0:0:0:0 with HTTP; Fri, 25 Mar 2022 03:49:00
 -0700 (PDT)
Reply-To: michellegoodman035@gmail.com
From:   michelle goodman <goodmanmichelle700@gmail.com>
Date:   Fri, 25 Mar 2022 10:49:00 +0000
Message-ID: <CAL=4yxeHiBSrxsjQc8G8aGW8m_WwF=QPgK20QJ_vdTsq++hfuA@mail.gmail.com>
Subject: Thanks for your kindness
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:62d listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4948]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [goodmanmichelle700[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [goodmanmichelle700[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [michellegoodman035[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.8 UNDISC_FREEM Undisclosed recipients + freemail reply-to
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
Michelle
