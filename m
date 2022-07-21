Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63ACC57D521
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 22:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiGUUvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 16:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiGUUvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 16:51:44 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48558FD52
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 13:51:43 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 7so4915059ybw.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 13:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=PD7JchHLrzQcnQT2hOipJji6MOAs37dJEo83mlMSDgg=;
        b=nGr5h67LVKB/MvqUqZeJdfTwHk2Mm0s3QCzeuFs+t5dHmVzyuuyCZOZ+f8RjSG+j3X
         JAEBWVP+8CyqK2S4F7dqbIlLxG73o5J83b3O5V8gccw7TeEfQ5WKT28vB+4sSQRZBmBD
         CVctxWCFboD0AEDwreEhZoFceSPWIWswNf3ooEEjC0oIx2QOEUBqrvWPqBdtcB4IB9NN
         Ek2fe+6uKH/hDeegQOHOg2dwCwoVlk+C8bfmXmtD8ca62E+V7wirONexv1wCWnZjlleQ
         qxOtfoKsNNn4lzsNSQEJrDOxZUWOHD2k4q+eq/24gzwcRTQ63DhoBS54diR6IlvVxG1A
         xfSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=PD7JchHLrzQcnQT2hOipJji6MOAs37dJEo83mlMSDgg=;
        b=ka4DI1uiz0hqhIGCHQ4QTvvTo/udN7OUMKgI+evTYfFSho8u6jgjJ7bLgEdAgwMs4n
         /V7FzqUn39+MzILd+/Hr+tmEuitdKKhrpSnZdYh2OF9pSEB9z/31vFkhLuzZUJSVEQF+
         TL0UyIrdyn58LYDVcWByNFQFsE7jvQIM75ZssL/pt837QpDhTM4qXT0mNQrsSK+DYv8c
         Sa+RuYYMj4T08PK+yCslE0DOEElos1X144g3OOzAMhBBuVrKaud2paG9i58uCIU33rnS
         TFkfHqsfDX8BA5IPadhy/mpIUmSqhT0tqW0V15lprbxo4zXeIds/8b4r5050JNa5jeNB
         NUMQ==
X-Gm-Message-State: AJIora8gy7M1hIoaUzIfvjr4Kxwiwc3U6+3ftihszJ0lZ4/zTMMncvS9
        gUjGzQBg4C+MEMR4aMausEx7FBZ7AhPnZNY/4Bk=
X-Google-Smtp-Source: AGRyM1sKlhGrmW8XvVHq/lZbARq/T7AMQy2nR2XZ//3K0Qz8IzAuKBKDKwoOlfArxT6IVVMEe30RPgPDCwpH+1bFX6s=
X-Received: by 2002:a5b:412:0:b0:66f:f648:53b4 with SMTP id
 m18-20020a5b0412000000b0066ff64853b4mr415904ybp.280.1658436702824; Thu, 21
 Jul 2022 13:51:42 -0700 (PDT)
MIME-Version: 1.0
Sender: manoefe4@gmail.com
Received: by 2002:a05:7110:5801:b0:18c:5ae6:da95 with HTTP; Thu, 21 Jul 2022
 13:51:42 -0700 (PDT)
From:   Goodman David <goodmandavid565@gmail.com>
Date:   Thu, 21 Jul 2022 22:51:42 +0200
X-Google-Sender-Auth: mgxGurcwaqHRxUrItuijGctCXvk
Message-ID: <CAFL=yBkf=KmDcmv9AYmghPrt-xSxh6ApnaaFuXdNRpn_qok+Vg@mail.gmail.com>
Subject: Greetings!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
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
