Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1964AD680
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350187AbiBHL0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:26:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356125AbiBHKMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 05:12:02 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692A2C03FEC0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 02:12:01 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id o25so13257940qkj.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 02:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=4hMay+JAuCcxTH5jMZax3EOAyZhyTNJ51MAkVpSdHBs=;
        b=i4ZEAgTc90KR2dw5789B2FZFjLub2YRebTF6tPbT8UxBNPxXvi4S0F5QkiPiPMcze0
         +dmks/Bz81taybpIJZTEUNr8JMKZfPWhCAakx5J4dKp/PeM5McPDFEjIwThD+Ky/pCrp
         kHiQsN4wZJtkPyjCNUoH4aCVzGtH886xCj5kX2VNdWxwuWXDr/I2nZl9nRuTJOndkCE2
         uNWb86GuWfSzhC5MTmVVCAsKgkKuCzttN0EcpfHL84zQf1ENEgEUyWq2HCClwqW1qGmY
         loeKSFERbYhWXFY9HAUIdtJof3WVDB17FgpZJrd7flB0dOFQ/5fIql/1D37nlX05SkmP
         T+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=4hMay+JAuCcxTH5jMZax3EOAyZhyTNJ51MAkVpSdHBs=;
        b=033GevmLNnjAaJ3oWaC8IQLJlQQau1lxTwAhrW9JHCS5TZaLuAKE2gTuofQR9yrakw
         J33i4lH95moQdpr2TRH6rMgWYZK0ufBpmVjF42WCxVEEycbv2AfcQwYLdc7s3u3yMuCo
         CNo0aTUajejzpG+ZWwG0xGSVXJNEm94T5dvHBiTMYxQ/8o/KY7lhkv7p20/KYufoK/SW
         aaKoOgXRfIFiwF/pm2EjpchXpWRDZTtYP2fnmo4r3LwXGXwdHp306l/oB9wu+vRfHbpO
         VkQmF5p5Or0+NK1uw5YdkyqWIit6p/DhNdE0dDY02mqOc+ri8MFkZnNkV3aonSOjIB4h
         ROXw==
X-Gm-Message-State: AOAM531rjzYnJYf5isbmHwG92QMOXeSCinpr91+QZ0PTWhRd5C0mLRAZ
        0xmG9DS7xy7aoTpiPPSQx3qs47JDOEJ4NU09sQc=
X-Google-Smtp-Source: ABdhPJxWIHlpJWwcc15rbBaUR2/0JqkECVm2vceWCSkxvQHnhlD086iKNyQelEsnmkpnjwpXzKc77amgMy9MnfsICKQ=
X-Received: by 2002:a05:620a:3181:: with SMTP id bi1mr2155197qkb.691.1644315120219;
 Tue, 08 Feb 2022 02:12:00 -0800 (PST)
MIME-Version: 1.0
Sender: hhm992119@gmail.com
Received: by 2002:a05:622a:34d:0:0:0:0 with HTTP; Tue, 8 Feb 2022 02:11:59
 -0800 (PST)
From:   Lisa Williams <lw23675851@gmail.com>
Date:   Tue, 8 Feb 2022 10:11:59 +0000
X-Google-Sender-Auth: 3Fx0cOb8FcAiKFE-wxAsfo7V6x0
Message-ID: <CADwJ9u=iaLPJpJAOaUrQDEOipGDakBFxemaAb9puuVg_tq8i3A@mail.gmail.com>
Subject: My name is Lisa Williams
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dear,

My name is Lisa  Williams, I am from the United States of America, Its
my pleasure to contact you for new and special friendship, I will be
glad to see your reply for us to know each other better and exchange
pictures.

Yours
Lisa
