Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40A3E481DB6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 16:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237816AbhL3Pbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 10:31:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbhL3Pbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 10:31:51 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4348C06173E
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 07:31:50 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id v15so41422307ljc.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 07:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
        bh=Genm2kBwggT+tRKC4Ww57neAip8nzQoAltuiY/IW1e0=;
        b=i4Is1732XNx32bu2kA8eXy5A7BN0qPFh3CigW6tT3QrbXoy8P2a0itEX2bWtYC69eq
         2d+Z4xc0BZYfaaNhEKzcMev2OdhLyKR2T/qwCzTarbVvhafOFAFNLQRz2nbGbsuZgNC5
         8R10DFRXuM10Ppx1ep13+uIZOg4IN9ijxO+AEXom8kwogZ+3Jh84FwE6NGdL1PyRaWGN
         QtsqQyE4gHnC9wcKrHZPJA01Ux88z57PrKIBuZdv9O9mQyod7h5xgLVGuH7ZH7vlasxT
         wMf1r5u+xCnWpcZoJp1wKDK7ZJyyfJnnE+kadqlKsyApnY/82HKhokDWwTe2J7Zp88Ui
         FI6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=Genm2kBwggT+tRKC4Ww57neAip8nzQoAltuiY/IW1e0=;
        b=GksVtrYOWLRPPGF40TcFC2NeeeOz5Vg1Z4EkmYL3bVBI5uRCa2nMqnkU2sCnjQGNzp
         j1+vlUvC0cPRxbxyrr7Lpd/IJUyGhDgF7UjcBjCL+fD1Aq4S1WsxobhBPv0Jps9eXLMJ
         QAT6ge8jgzPepmZuX0QHiOjeVERKYs6S/RJaFlp0RXxn92V1DH0EIZ/BmaQr3MjXkxt8
         oCz9D2fCsv51NwIdN5UehXmpKRK7X+sl+mi4GXYzu7hlflPzUbqkpeofBvfGkUgfSrho
         UnMpCl+7FLbp+sUJGiJkUgTrG8cbAMFB8/H3QER+wlSJiQjT9aJsCsfmpnBh840u48Mr
         v+gg==
X-Gm-Message-State: AOAM5338s55+32K1n+4s3/wsu+e6rh/rhMrnC/Leulir2xPgSNX59WMf
        1NPurnceRx2APcs/Lp5iqR1AdVU7bqzsi/Gu0Kc=
X-Received: by 2002:a2e:9886:: with SMTP id b6mt8950323ljj.526.1640878309241;
 Thu, 30 Dec 2021 07:31:49 -0800 (PST)
MIME-Version: 1.0
References: <20211207133603.4947-1-peckishrine@gmail.com>
In-Reply-To: <20211207133603.4947-1-peckishrine@gmail.com>
From:   Desmond Lim <peckishrine@gmail.com>
Date:   Thu, 30 Dec 2021 23:31:37 +0800
Message-ID: <CAHEqh5GQSpyxaZtsNSh477VBpj6Jfyc9g+4CTs+ycgFhFuG94g@mail.gmail.com>
Subject: Re: [PATCH v2] HID: sigmamicro: Fix modifier keys for SiGma Micro
 based keyboards
Cc:     Kinglong Mee <kinglongmee@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Superseded by "[PATCH v3] HID: add SiGma Micro driver"
https://lore.kernel.org/lkml/20211230152758.79104-1-peckishrine@gmail.com/
