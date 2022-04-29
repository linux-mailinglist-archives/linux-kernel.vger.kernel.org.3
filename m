Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA57515320
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 20:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379860AbiD2SF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 14:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbiD2SFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 14:05:25 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD52886E33
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 11:02:06 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id gh6so16951263ejb.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 11:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=CZjU7e2a0fCf/XEsO8nJVQl+HPFT9L7SSPvqpdqz67U=;
        b=XaYdk3J8GSC7rtUf+KrVI5DWQhFSmkhDm/wOowyxSMLcdJVa+tDYZ9mi34Shvi8th0
         qqsO5giFZnyJeGcY/JWqL2LC0h1SnxhIy3i4Ggpe0VIdu34OvBctNT00cDV2Ij2NbAq2
         lYHLnS4H0Jz866KSyyUqmlXmKq/DyJDqPkW7Sw7evQ5WLMjLQ1GOpK0CGmxsei+fwUC0
         2bcHb9mSuwgQ0WDne1pXs3C9uZ+6WW/ov6vNddaGm2EKHXxsSJTC+4ZRAJUSeSqv5ZR0
         dEV1si5rLwsNFsa3KCUuMYaK+8RQiFEuAekx/DizgVHo4nmWDQu5ePqzzC18mwPQKa2j
         07fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=CZjU7e2a0fCf/XEsO8nJVQl+HPFT9L7SSPvqpdqz67U=;
        b=B9Pf3TcapeKSUHronFlzQcu5/o0PtLV9zX3rwtqY4V2z87ZjOjSf22DH5+iDcGP+PM
         jpl4OSK87fJswX48bkWKOLYMxAE3ujggI6H8zpUteLCWby8t890MHraWQxTa8v86Qcao
         S5dhRtOJf8jq9cAflTyFnSIdh+S/8qVE9O+fX4HLfnX48ITJaNd6bmXP5JfFuMWqLYWE
         gUO+oxOawUpWHqMDOvwfZbZylYreIQiWB9r7xNum5efwgbjMQM92JfEI7sBA5+rCRLO9
         9pdaSIoLX96TdnjTC5zg/5cs3da1edLbm2m5I0eA8lDRi/4GdAcwasGzwMWxOsDLP729
         cBvw==
X-Gm-Message-State: AOAM532ZJ8X6rfTINcfFgAKZ/JkK/JHfD3VPLEybPcm8mfnlzsWWjvml
        OF15eLg7TSCHP4XuqGViryJ4DWjnYsj8vhenyJM=
X-Google-Smtp-Source: ABdhPJxjCJw+5OIrRPRcZGwaCc+/jaacEn7Of2Bk3H3NJD+bd1pTXQK7P8RusgAJ8RaWRNKkO92gBAaUlknlpj/QqK4=
X-Received: by 2002:a17:906:a089:b0:6ef:e9e6:1368 with SMTP id
 q9-20020a170906a08900b006efe9e61368mr484228ejy.626.1651255325431; Fri, 29 Apr
 2022 11:02:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab4:a741:0:0:0:0:0 with HTTP; Fri, 29 Apr 2022 11:02:04
 -0700 (PDT)
Reply-To: abrahamamesse@outlook.com
From:   Abraham Amesse <gmark3575@gmail.com>
Date:   Fri, 29 Apr 2022 18:02:04 +0000
Message-ID: <CAPG1wpN29Rd56LmsVGHUfCAr=feVE9p5Lg78Ezy56-Cgj-ZX9Q@mail.gmail.com>
Subject: //////////Greeting,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.6 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have very important information to give you, but first I must tell
with your confidence before reviewing it because it can cause my work,
so I need someone I can trust to I can check the secret
