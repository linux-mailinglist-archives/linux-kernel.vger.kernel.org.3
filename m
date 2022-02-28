Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF3A4C6C9A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 13:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbiB1MdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 07:33:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236535AbiB1Mc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 07:32:56 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2357874DD5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 04:32:18 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id v21so15185562wrv.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 04:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=WTndzSyXJ/sZW2lGxgeOIdNZEmLI+JWCR9Vf7oRpeXc=;
        b=JshKyLKPZDpcUDvy/Cp1+Qt7xzDG/MX++p5lIHkvrc7CCwPtM9AMEOi21DZC/PH/6+
         M/SAXe4DI7Qy8wLBRd884urzK5UMUMk2PCHoOwNesq7W8YWcYCHjiVjk4DGnQ/4ORfKK
         LuXBXgx1eDXNHgTNp92n2uZVNXacxgF043V/+FrkYVDAQ2x6JFvcq9UjW9IKUwRuRXvy
         O7BLerzy+MQkKKIf7uMocMEgzRP9mTUKl1GjvqFlZTFAiywTB85GYDVbhW6wOBTFIpai
         cI7qlyMp3vroTZ2Aq9oZxlOx4ytax18CgRgtSLIqf2aWoA7wtAJuZLxxbGil7KNH8xjw
         Xd9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=WTndzSyXJ/sZW2lGxgeOIdNZEmLI+JWCR9Vf7oRpeXc=;
        b=VkzioKwClLAU//eKPVncW/nv63mhIkrUGKs2FfZJAKbFcoqgzVQBJm/pg/4jYSuzSv
         F5MJ9rPYxHYBDf8smJRPN2KRJLyHOobEp2cajWwL5XBIrbmk103sbUDWh4eslfVDXEyE
         cNuR4vj4fZAd7dYAOrs36q5NHlMcxLYb2smkT/0n8dgU/glKO6+4CvAt/empulfvrW/n
         X9zXR8uWbcqrZrjbVoH6ip/umnT8ATAkqad9WMO3rOEM9teKcocsYjMXgP461SMQ+zG+
         +5U28k+tLDva+y1OdGcLv12IYXOHIySG+Z2u0R3OY3WvGJOA5TxLAdXTPz4MG9xkseun
         Qitw==
X-Gm-Message-State: AOAM530OFCKcWrSIMgNBz0Q9GEfk5mfpoHxz7Spqt5sYIQy502jw9z19
        3uRfvuNaBFFNhRpWs4W1BtcLcDPdcvSdM/VfSok=
X-Google-Smtp-Source: ABdhPJzhqugDuRb7GNNK0Fds7At8Le1GNNQpGAPmt2iYuO0xCP21PuQeITsDhfXntSMzDtXiFwBBd/zsQa751vsFYeQ=
X-Received: by 2002:a5d:5512:0:b0:1ef:5f08:29fb with SMTP id
 b18-20020a5d5512000000b001ef5f0829fbmr12419539wrv.653.1646051536533; Mon, 28
 Feb 2022 04:32:16 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a5d:584b:0:0:0:0:0 with HTTP; Mon, 28 Feb 2022 04:32:15
 -0800 (PST)
Reply-To: mmd475644@gmail.com
From:   "Dr. Irene Lam" <confianzayrentabilidad@gmail.com>
Date:   Mon, 28 Feb 2022 04:32:15 -0800
Message-ID: <CANrrfX7G=zGaTWrK07gbuReGgzfL0bj0Nkk3EmqCzKbcojDH=w@mail.gmail.com>
Subject: Good Day,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.6 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hope you are doing good?
I'm Dr. Irene Lam, how are you doing ope you are in good health, the
Board director
try to reach you on phone several times Meanwhile, your number was not
connecting. before he ask me to send you an email to hear from you if
you are fine. hoping to hear from you soonest.

Sincerely
Dr. Irene Lam
