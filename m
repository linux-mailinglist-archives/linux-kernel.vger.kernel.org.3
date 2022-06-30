Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF647561A80
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 14:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234656AbiF3Mkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 08:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234017AbiF3Mkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 08:40:47 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32F440E49
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 05:40:46 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id g4so21959365ybg.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 05:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=osSAgKM1j6DRNQcQXA842NXUQk2GubTJs0svjrfNTko=;
        b=kREFm2+iQtjCpuYAOCPRzKaiwTrx3JIeeJ2ATLdfzSATDH16jifI49cMHeJMTkNHbk
         KfIJjk4mwWivQ6y1bI+fTDJowPXTKsYQHFrGaVjkZIMlfhvksEQyme2fcdKld4HYMGMQ
         VKMbyUiKl1+79M+ENx+3647Okl/id6/Q1o2rnjxP/mJ6LBAf6Zc3FR3/0B/OTgYYCNit
         AwRhn+0HlLjN3i3kWcpQ5aWET/yT/X8xQU/KSV3a/VJBEqNAkFwChU708N6XtZiEvOOQ
         ZkuQJGX9UBOwWQ8WX4fn8wDT43ppUIb9AZOjJdo902ER709M3KBf8uV62M/FCddyWE0z
         r1Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=osSAgKM1j6DRNQcQXA842NXUQk2GubTJs0svjrfNTko=;
        b=SLlahDgVudFQ2VrvItsWohaNYG4U/n+LgZgusIJ0gZKFsplx9DISe+6MNiYklE7lZM
         1U9IxHgcEmWb+CA0zsYqO8704gZnKPHEde0OUlpor7kbbZmYhHf4Hr2M7lmZITG5Ofav
         rZj/oozJAGBXP6c7lVS9CtMFfHY+6oT5vmdQB7Xi0mQhW3mEee7CQvZkeU+k7MEXufqf
         /+Ph4m1YVXmaDGNI9iLO01G0aHprJrmpKvkZ+WbLLLxmWBMg5BtSrQCr5z3KJOMYsVN7
         gSWvXb2COrliFPB/hQN5p1S4HrTZJvYBJHzutSM4mh7GLiMgVm8pYX+DFddjXHtHR0WP
         RljA==
X-Gm-Message-State: AJIora8Qv3s+NPcfFJ0q3Nko2oqbMDttf+ie1XrBQRHzui4yanvcv6JZ
        L/GZLBCJn7GC5UyHQItJAqZB0gbQ9OCihGB8YwA=
X-Google-Smtp-Source: AGRyM1sdKApeTq6DwBWbauDmYmNJIs3o20Zu4Tkn9LzBbWNu25IciMTIIItW0KanYpgbWEfequqG3uAUW9uSIc8S2OM=
X-Received: by 2002:a05:6902:124e:b0:668:222c:e8da with SMTP id
 t14-20020a056902124e00b00668222ce8damr9377208ybu.383.1656592846140; Thu, 30
 Jun 2022 05:40:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6918:820c:b0:c9:57c7:d458 with HTTP; Thu, 30 Jun 2022
 05:40:45 -0700 (PDT)
Reply-To: michellegoodman45@gmail.com
From:   Michelle <michellegood044@gmail.com>
Date:   Thu, 30 Jun 2022 12:40:45 +0000
Message-ID: <CAJ5e1jZyApamzc6BTLrvje1Kf0q6VxBmknFXpuPCFzb6bokbBw@mail.gmail.com>
Subject: Hola
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
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

Hallo, ich hoffe du hast meine Nachricht erhalten.
Ich brauche schnelle Antworten

Vielen Dank.
Michelle
