Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60C8C4A5B6E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 12:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237436AbiBALr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 06:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237425AbiBALr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 06:47:27 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D796AC061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 03:47:26 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id i10so50013346ybt.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 03:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=QExzY9UEef3OuwOpBclTczhPh/9Qk2/FQDckNskinOU=;
        b=hL/9ORPnMTvOEjSr1k0RXV/bK2ZfKLeyQOIRhVrqHJWSxzGPbyJ8RCsUWra5WKPDr8
         zPXi+3OrlGtjSlwGF4u6DOaLvBDFC24D3A/OCyGNwLYx6jq9RHliHtpsjQuN8Vrqz6U+
         yiWDU+meC/bvEQT4llPOaRgebHyUknT6yW+h+edwnX5pcGGZkLcrlDpvokvwI7bhHML1
         KP5ON72d0DGjaOYJNlC2+pJYZ0HHrC1ZlLkTBxU5UuLvbr4iTfrrc/GGlszIlnjgRZbY
         ++439mPNAfFgzpxj/Fxbt37xuhV5eAU1ordmnVBXqJK+lNqjfnphd6vnv0tCvD/r+Lsb
         YxLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=QExzY9UEef3OuwOpBclTczhPh/9Qk2/FQDckNskinOU=;
        b=HKx0Ym13aKHNZfXjQh2La1YmlTBKtOXQ7tqt6DcB1DRIO6Tw644IICoyQZKevT4ZzS
         xjlX315vfgj/W94yXd6ly0H7ZSO5yQmZmUWJSvxJVkCStncLDOrdNu8Gi2J+zoe2ALmW
         KzAQGgpp4CP5xaDopKc0lUeCiSzfNq/vDAJyxnZ0xSS6n5EtL3TXAUy0jdQeUzIPGhvL
         ToGmrKXAjO3AaTXOXTrgLcjrhZLV3v2as0PzvOp89h7TdDyqNpWlktz43SDWRq6iHmDJ
         fzT1KBgr0sseBpMZ0OIbuwQZM6jCt/T9atLXCQuilXexlZaWjG22UvmGx0P8dMUpE3II
         QADg==
X-Gm-Message-State: AOAM533i4oWNl7YRDpru+ImsavprH0illLxKJjagGHUR6/LvrPpKUo62
        Ryt4K8MYGmGP6tYuNo4VQy7SPgeV8q9TmEuVPNQ=
X-Google-Smtp-Source: ABdhPJxDMqb3NFmwPEIczeXMmD4vFW8o+5LoD51Nf/y5L07aYvT0bOrutX17MlY6TEsm8kIrg2W1wjhKdmvpLF/uYvU=
X-Received: by 2002:a25:4cb:: with SMTP id 194mr35094791ybe.388.1643716045767;
 Tue, 01 Feb 2022 03:47:25 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7010:4590:b0:203:7da2:3c41 with HTTP; Tue, 1 Feb 2022
 03:47:25 -0800 (PST)
Reply-To: orlandomoris56@gmail.com
From:   orlando moris <abrahammusa5561@gmail.com>
Date:   Tue, 1 Feb 2022 11:47:25 +0000
Message-ID: <CAOSWSEOC57ni_JuOjaT+QQdCvcJK6h6EOeMF3SYQwODNHz53Aw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hei, V=C3=A6r vennlig =C3=A5 informere om at denne e-posten som kom til
postkassen din ikke er en feil, men ble spesifikt adressert til deg
for vurdering. Jeg har et forslag p=C3=A5 ($7.500.000.00) etterlatt av min
avd=C3=B8de klient Ingeni=C3=B8r Carlos som har samme navn som deg, som ple=
ide =C3=A5
jobbe og bodde her i Lome Togo Min avd=C3=B8de klient og familie var
involvert i en bilulykke som tok livet av dem . Jeg kontakter deg som
p=C3=A5r=C3=B8rende til avd=C3=B8de slik at du kan motta midlene ved krav. =
Etter ditt
raske svar vil jeg informere deg om modusene for
gjennomf=C3=B8ring av denne pakt., kontakt meg p=C3=A5 denne e-posten
(orlandomoris56@gmail.com )
