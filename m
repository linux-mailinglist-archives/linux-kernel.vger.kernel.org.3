Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87CB558F28D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 20:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbiHJSxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 14:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbiHJSxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 14:53:02 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF928C02F
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 11:53:02 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id y1so9398509plb.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 11:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc;
        bh=PD7JchHLrzQcnQT2hOipJji6MOAs37dJEo83mlMSDgg=;
        b=pHxqZCQ8OfstdSj5jcf/XVK5sIdMkjIvLMZWAN1p/sN2QvaVNLWnPosjQ12h4Maz7B
         9GzQeFJlSrc78uCdiGbqUnsE/+qFDZ9CmUF1Lhyb7t57ODdzXiNkjx2ejDNHkGlrgtGG
         yXyWAOM6gIOJmQYAz1X41KduWPR5qpreA21Lfu8f4zZ3gpw69kEy3VkEk+mY9oOkm3Jb
         4qZIQrHKEnOT3t3lIMNY1OYl8OzSkHtQFL24/NrHwhAGUDbwdifKKrYuZJZz2/yY03Vk
         98XPa/ElJNoE6xgCkuqagxaEJkFjbHh331jNF9tKHMEfIAspXgs3zC5jQk0JjSaJZDvd
         vkuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc;
        bh=PD7JchHLrzQcnQT2hOipJji6MOAs37dJEo83mlMSDgg=;
        b=TA+r09VEeQffTi7T0nuWeNPyiOu7MbKGRfiaJy9akip/FNwUgOxeOmGGgS/OASdjiT
         RALk2e8wSWObyHD2X0eKq8cX5v2hdNrieWCbbrdEQPG1VgRCgiXu5XvjpTPflLRCHF01
         hqeYKoxYC0D/KTor3AR0awAENapZdnjTTRl++X8JGRvOdFcMtzciggu1JBGsOhQ4BpcK
         wWh/MrZFvrj93v+UKCYwAATBZHGg/zXKBegYjANM9gzkvX2JoVgz3rCBRgvfJerqvxXN
         WZfGe0KupYYKddcJOFsj3TqZk3iCdOLAc0YMhH3c4tgUjRQ2PTaruj8o3IYcuDeag+f/
         fbww==
X-Gm-Message-State: ACgBeo008ejA8JO5jyxcMD5oDIHMZyJs1f2b/Ev4YIj9gnYaOa9ofC1X
        WwoBiPU1LIO0gmIsRm6fv5Kvq72fcNZWUMWX5DA=
X-Google-Smtp-Source: AA6agR4OLY2MpwlLJc7JZOaWiEOw/H7i9b8JEgIYBLG+F565r6a5gq1rKFPYN735LslqVhk9nngXkwT1DUPC3bLWy5I=
X-Received: by 2002:a17:902:f7c6:b0:16d:c795:d43e with SMTP id
 h6-20020a170902f7c600b0016dc795d43emr29366893plw.162.1660157581887; Wed, 10
 Aug 2022 11:53:01 -0700 (PDT)
MIME-Version: 1.0
Sender: lxavdezrm@gmail.com
Received: by 2002:a17:902:d4d0:b0:16f:3d1:f6d with HTTP; Wed, 10 Aug 2022
 11:53:01 -0700 (PDT)
From:   Goodman David <goodmandavid565@gmail.com>
Date:   Wed, 10 Aug 2022 20:53:01 +0200
X-Google-Sender-Auth: yCCEv3NunMZ_Zhumb4AUzLOS4pw
Message-ID: <CAOdXT+kF5vK08m981375MFKx=2_nmo0LRSte807b8FJ0GyuRGg@mail.gmail.com>
Subject: Hello My Dearest,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Dearest Friend,

I Am Mr Goodman David, I have something important discussion
for you, please reply
urgently for more details give you further information. And I hereby
advice to contact me by this email address  goodmandavid565@gmail.com

REDARDS
Mr Goodman David
