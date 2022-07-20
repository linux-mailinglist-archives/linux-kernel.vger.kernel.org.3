Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D114C57B622
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 14:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbiGTMIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 08:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234502AbiGTMI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 08:08:28 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E5773580
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 05:08:27 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id f11so14785548plr.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 05:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=TQR1b+nzyuc8ov+hBmAb0rAfJyo96VnisRwO/RamCmo=;
        b=itsKGTAB1QtJK1dMrFFs0cB8NySDZHM8rrB6jJdH1VYysXmhk2lEMjsXZuob4Avm8z
         pyN0wfpiXoJRoM0/FimuEIiRKpZbbxlyAEWqkVYmr7p7k5AVsYEXhvYJY9ewc8oqxFrD
         9piZzwFPj+LrKk3/BOk9O+036X0gQOTcnjBmPuW4k74Xu26PJNnjK+FgEMkkYoOLvZcT
         6oEJ4R8eWNXwA1nYwdT1+mLI72qgWHFWE4tg+LxpytHFfbu5ybNuAaaJGtZBbX0qSwDU
         1xgzAmOIeyUiGf6rw3LTcZzTCtz4OQsoIP7vi/XJpyU83MCP1jWEVZgAYtwnJpIGMAtZ
         UQWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=TQR1b+nzyuc8ov+hBmAb0rAfJyo96VnisRwO/RamCmo=;
        b=kecq3bkW7pTaQK7xgOhB2tLryecRRYI4fU12HjcChamqWzsJbxJ6JwTWyR7wfM7pNM
         +HakNpfcWuuN87nipgdijy0aW1VDTvKRTXuxMW3FGy/pdrAbu72wje+PFpA6cIw/XcNV
         qzXHoKZ6aQtyxBfX71iLWuu2I9mNb/PPHskNWc2wL9CQ5y3JGg+DQsuEkQFcR3sfK4Ry
         KeSmZyAPOWBS7nbsxuOptekQX33/JyFJj99L7SvEcYIxNZWn1LlYJNyZok4WzYZZiLcv
         iyyuOU5L8eFqBhFdMrouw6jID1DgnDjvYFdqvIKAuRTIwABl+hwejBQQ2gUhH4ROwc7c
         4U5Q==
X-Gm-Message-State: AJIora/8OzH0LknZxUBiPV/RQ0Ipn3oa+AaaOyGcidE9cD+/6OKqZOz8
        mmHb3VGJ0uBnXhNIgzIimZ7NL5yGf1GDbtV34XE=
X-Google-Smtp-Source: AGRyM1t8wj4aH0mrlkKt95FMpu/XqFW/HEgX0j6OOeU6vhNs5Pj93p5ETRXn1H3Iy8t9rrYy1+25mbYZouSs+aobuE8=
X-Received: by 2002:a17:902:e1d3:b0:16d:be5:4b3c with SMTP id
 t19-20020a170902e1d300b0016d0be54b3cmr7848574pla.8.1658318906667; Wed, 20 Jul
 2022 05:08:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:b64f:b0:2b8:ed48:c31d with HTTP; Wed, 20 Jul 2022
 05:08:26 -0700 (PDT)
Reply-To: michellegoodman45@gmail.com
From:   Michelle Goodman <michellegoodman358@gmail.com>
Date:   Wed, 20 Jul 2022 12:08:26 +0000
Message-ID: <CAAnwc9tngBYHCDNKikpGzUnDeKdgprwWqzW0t8kCgydt2KEqOQ@mail.gmail.com>
Subject: Hi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:62d listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5307]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [michellegoodman358[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [michellegoodman358[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [michellegoodman45[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
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

Ich danke dir sehr.
Michelle
