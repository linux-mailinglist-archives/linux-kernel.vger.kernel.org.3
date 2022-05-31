Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1281453935B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 16:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245679AbiEaOv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 10:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbiEaOvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 10:51:25 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478CBF43;
        Tue, 31 May 2022 07:51:24 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id c5-20020a1c3505000000b0038e37907b5bso1417136wma.0;
        Tue, 31 May 2022 07:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=9qJkg5Z+wIWpmyUb7QfLD447DoWpF3sHM+p4Olw2jtM=;
        b=LY85b+YelwpSeFQZmBU5Cb3ei+4/tViwA3UXOs2DvXuGlYS0lKwjqBTxIqxtPNYbDA
         nyYrWaah0MmhHsH8wtFS/RuegPBOWNcUXKkIXs6LK4EPQn0AgDmRIRBzqDmrRYJb1ELb
         GDK3m+1LRYEwuZaeVzCAMk45mXZlo0/xWZoeiaqb40vv9WTUva0cKMdnJBYbPYbvkNio
         /H13pYse2UUK21O6SN3TsA9c+40icCHUHxI2j+oY2bc0Z+n6gI56fX0UamKEc79iOQ1T
         vf5HC6iEZJ1c90FJKYRHXqSMY/SfoOWb8fRTIGjBGWI0XZ2fTiLrgIKoLskNMiGXCyYP
         JxVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=9qJkg5Z+wIWpmyUb7QfLD447DoWpF3sHM+p4Olw2jtM=;
        b=0oiQ66pz0s2QM1c0bzcwym2mKoVZcDV4OPGHTbPcJj1FbHqZnZ8NSEkW2wLxikldKE
         qq0vsal6/iCYHKGndnGKD15DiSvPfD8hOBzSnOxelnLFKqo639AE9prtgvyIWBZs68YU
         Q0f2beR/SFcNH3CXzyh7bD3qADGqXx9wqay9ncLVYVDGuyM1D0oCxVXL73/zK2RuLo8A
         sBIMqj5kW0qvXVGi/ljUF99hMjx/HIKCOZ8ol8tclQRwGeiFIGRKBgE8nP6Upf7itZ4D
         KC1utdFuS7X0SozG+qOIsWjC5V6ULOTd/E8rv1xVfRJ3D7JbLZEmyEVsfkP7DTnD8FYJ
         WIHA==
X-Gm-Message-State: AOAM530JD+fnc/6kVGAl8uuA6W6Xyc6yEZw2c94wcdGUJackNvCWcDzV
        hVZ8KwbUqGyHOfeLW+uAvkorC/QivQfmCQji
X-Google-Smtp-Source: ABdhPJzlWMsUxHsZQj24GsdATDucKR12+FP0yqwmjYff3C64vwQ5rRnd1rzxoFfDAab0ekepqQRHBQ==
X-Received: by 2002:a05:600c:4f96:b0:397:652a:69d0 with SMTP id n22-20020a05600c4f9600b00397652a69d0mr23718450wmq.16.1654008682863;
        Tue, 31 May 2022 07:51:22 -0700 (PDT)
Received: from DESKTOP-SGSHA6E.lan ([102.134.114.193])
        by smtp.gmail.com with ESMTPSA id 26-20020a05600c029a00b0039bc95cf4b2sm2345333wmk.11.2022.05.31.07.51.13
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 31 May 2022 07:51:20 -0700 (PDT)
Message-ID: <62962b68.1c69fb81.c16eb.a54f@mx.google.com>
From:   Jerry McCumber <nm8086908@gmail.com>
X-Google-Original-From: "Jerry McCumber" <jerry@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Greetings Sir/Madam.
To:     Recipients <jerry@gmail.com>
Date:   Tue, 31 May 2022 14:49:18 -0700
Reply-To: info0817155@gmail.com
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_50,DATE_IN_FUTURE_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  1.5 RCVD_IN_SORBS_WEB RBL: SORBS: sender is an abusable web server
        *      [102.134.114.193 listed in dnsbl.sorbs.net]
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:341 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [nm8086908[at]gmail.com]
        *  1.9 DATE_IN_FUTURE_06_12 Date: is 6 to 12 hours after Received:
        *      date
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [info0817155[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [nm8086908[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings Sir/Madam.

Kindly write back   As I am going to explain in detail why I contacted  you=
. i am a lawyer and i have a very vital information that could help both of=
 us.





Jerry McCumber
Jerry D. McCumber, P.C.: Law Firm=20
