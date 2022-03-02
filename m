Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0ED4CB194
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 22:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245426AbiCBVtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 16:49:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbiCBVtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 16:49:42 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F5D32994
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 13:48:55 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id p20so4257569ljo.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 13:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=t1Pb+V+SY3o/7hN4naxlbLDHV8QER277N4EQXLdstAE=;
        b=fjoOTS2/How8KTj4ppEx0zCD6qTB3JekNscLsc+Auh6OOXPn/xTCqkRN2wBC/6xfH5
         +qMEFGaqXrWxl/0wz7NJ1R8vALW90XpyrXSInWHgPzfduHiw6K2WQMyJfpIYxgzktC9O
         lE+jT2ZKZ0sqE3wigrDfaxjMYCATaKmvKC9VIMoofSq3tUfwsoKfRw5zwED/M+VZx7lq
         KASCRApzVMK0m3z8k4GFaHPaAZChnY0V9rpXb6mT/Jl/BDhaTGL3oSwWWgktLlEcpQHH
         aEyqJi25xf31ZFjxfI7LdidBKoP9mJ1C+7ZKdmtLCsGybqHHYkW/ZbpBI1n9JoY4hKTQ
         9qzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=t1Pb+V+SY3o/7hN4naxlbLDHV8QER277N4EQXLdstAE=;
        b=PZZfax8LfbnuIH84cbiOM6uD4lMAKP3ZeqNquqkB5d4J09totLjuHzxusD9TV8bGDl
         22Rj4eWDGbZoHiJKhwDJ45iUJzyxwFb2I79G95sgg7sas0Cdx/rzRT/5sGsOJtuZa+1D
         vwyp7SRNWvlDUnn1R+EY/ShKmwoyPDHgrsy1MtHfzj95GBqMHxvFyhcYVn4C6bXGaNdI
         CaAf5QoBMqzoUFOj6nFf8z9amM4RwijaCu52rhKpj5eFT2shTtJKR790QUGx2uxKJUS/
         wC1l6zYQR1b7brc7hTTLNPY4rUJWUFLJNaatclI0QXZPXBgZpneG05U7NK+ULxRDGTKB
         aisQ==
X-Gm-Message-State: AOAM533DwoTb4uCvQaek/YZ3158UzUvP2vIik+gi6xXH0d8wZfu3MWpN
        KXXzVXO9Ykb9TQCWElvnVDQMXZtZj3cEpWL5DYI=
X-Google-Smtp-Source: ABdhPJwojXyEybYCHHUXKmMfHA3QiiIOO96xjrjGRYolNEYDDXUjWEaSRKbbG6NN9TIm9nVkdAsalWBofDbXD8h50UQ=
X-Received: by 2002:a2e:731a:0:b0:246:4742:2c5b with SMTP id
 o26-20020a2e731a000000b0024647422c5bmr21753608ljc.13.1646257731219; Wed, 02
 Mar 2022 13:48:51 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a2e:2283:0:0:0:0:0 with HTTP; Wed, 2 Mar 2022 13:48:50 -0800 (PST)
Reply-To: hirokiarisawa@gmail.com
From:   Hiroki Arisawa <amesata8@gmail.com>
Date:   Wed, 2 Mar 2022 22:48:50 +0100
Message-ID: <CAJR0EqOdDsZuWMyPj9S-z=HyAROmPGPy=VDZCLrsnOp6qdeQoQ@mail.gmail.com>
Subject: Buna ziua
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
Vreau s=C4=83 vorbesc cu tine acum, mul=C8=9Bumesc
