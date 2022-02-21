Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA194BEBEE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 21:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbiBUUhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 15:37:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233778AbiBUUhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 15:37:04 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45899237DC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 12:36:40 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id d26so14024436vsh.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 12:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=6oHWX8sH3tohS1DPDLSFcUzMKYSwL6J87hX19yyB3G8=;
        b=BV+XmE1vfdF2igz5bbd2CVN9CrwQ3JIwHNyoO5NhHoaIefv6piEHusGJfNBP4lWOKm
         nQK/exMv8l91c9RpVp66aMYFA2oCvDBlpf/co/ZQ+M4qGUbIYlPZBC/R7g2LDp9DZDyo
         U4udBWEY8MhzVC/rS9LZtkwhSqWmusgmp5KkDLWmDiGg0hKN9BoZb1t2UG7FBzyY1w7k
         r89oIggjhNEnPrFi2jefYqBsw1c7lXf2LGKx4L+EyeLyI9cfskSlCyGdJZQTIfusmiva
         WVCrJXecG4biTNV+CCF8ln+KUazo/EI3dKmTzjTMQOV2HYFfCgX6QgIjgWBL/S0dzd5e
         EYug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=6oHWX8sH3tohS1DPDLSFcUzMKYSwL6J87hX19yyB3G8=;
        b=03VuvBgsOglCofkKe6ePOwoqoH7fwpAiEb3BI8Ifo7wQ+3f74P17ezZkt6crY7Q76N
         GjMSGwBrjEMWIclhj8tphMQkPq9DhfdJ6rVdgEdYlhcreVHonyCLT58CaG7GBKWGJR3c
         VpMjyWD/c/EW6sqpaCqzHMW9a49pP1CGzpUoikVhb8QZnfSo2QVM0iBnxqkVoBIMZbGZ
         Sp6cynuRCLqtwsTCmyZPmCv9wYGMK4Sm/lYPqKWzqbQ8mXLhQ4IQTXFIa+PmGNSzpREs
         qElQk33v4cxlKDdOwRkwh8VD+3ObBT0e6V58jea4QmypmSYN990thB73LLl1dqeSshWv
         9kAA==
X-Gm-Message-State: AOAM533jsKgqLYQTrehEenMzfl1mfzQp0kmmfGzO4zZTS/2lHgG8B8mK
        bRe8zxpF/QJiArmsrJ4oBGywcq66S/ikrkT5/QQ=
X-Google-Smtp-Source: ABdhPJyRQWoryF8pLOGiohnKAp6+T991W+LkXPJ9veJmmWxVFdV0OTOWgwbWmFEu5KTgQ0wWUh8sJtebcZvKnXXm2J8=
X-Received: by 2002:a05:6102:7ba:b0:31b:f0c6:adf9 with SMTP id
 x26-20020a05610207ba00b0031bf0c6adf9mr8106492vsg.16.1645475799282; Mon, 21
 Feb 2022 12:36:39 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9f:2592:0:0:0:0:0 with HTTP; Mon, 21 Feb 2022 12:36:38
 -0800 (PST)
From:   "Capt. Katie" <basilesotoume@gmail.com>
Date:   Mon, 21 Feb 2022 20:36:38 +0000
Message-ID: <CAL897DgOu6eBuey7=hCWtOikXnFk7_g0PzNAmQ=nOsRY095bXQ@mail.gmail.com>
Subject: Re: Hello Dear, how are you
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo,

Sie haben meine vorherige Nachricht erhalten? Ich habe Sie schon
einmal kontaktiert, aber die Nachricht ist fehlgeschlagen, also habe
ich beschlossen, noch einmal zu schreiben. Bitte best=C3=A4tigen Sie, ob
Sie dies erhalten, damit ich fortfahren kann.

warte auf deine Antwort.

Gr=C3=BC=C3=9Fe,
Kapit=C3=A4n Katie
