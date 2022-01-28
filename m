Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 661474A0083
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 19:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350729AbiA1Sz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 13:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350727AbiA1SzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 13:55:23 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE7BC061748
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 10:55:23 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id d8so6728245qvv.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 10:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=DkhOJxPGb96XhBNxvczEuJ4p+whH3mGtofLewGhWrCU=;
        b=nN1TFc2BIbi+Qkqm/pkhdKRTgACS+iVJJscvLZT6YT2rs9dPFrpJrlw8L1IQlHaYEU
         gB+NUKYlmTuyPaekxHgtjegAJQkz6ycdlcNSVfb2OSMEMwYXgKmPTP9Q9KTOaGjWgNEP
         Hgm0sNc1u5457K4JgsFyrFIWQuXoSi+0zktNG1PgTmwR5e0pUvqi5Jaa3cG/Wf8Rbc1U
         +2ekwUGX49Orv+dVO8srlmEWQ+ulOk/s8wPZ30sthAYV5UNqDPP/EtUw65niZJRM+Fuw
         FW11j4ASLPOEC8pbY2HrJ7dwv1oZr4aEW5EUrsDYjSfl/CK2YJIN5e9zT4RsbEmdt0F6
         zkjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=DkhOJxPGb96XhBNxvczEuJ4p+whH3mGtofLewGhWrCU=;
        b=FpJgT3xF5PDQVp1XLpn19OHnuEtjUoSGrSIx9wAyOZvlBpacGVfeeRJm863maxhrI3
         bcToeU9Lb091tU4Xb6/zf4mtRBUAVLXaeZx3zYbNOTdNNE2wj5+/c8/m/afuvwwVAeYy
         hrmlbDYtEl2yoGl0oWoNJNosX7TP6+WvDtCHF8N4HmI128iNdQen0yRQKPf9LU1CY0yX
         MA/omRP17AK66LsUPFRfVNj3r88/CDliyZxeCWEtKoygUgFPabQGtvn7kbVHpKqG2BEn
         IEJ3w1o4upF3R86zKaGbbkEX5y49igcWniKA56pZF/zbrdIBT9ZYG7XuzfAL+aXhZRCL
         3Ofw==
X-Gm-Message-State: AOAM5321Va7yRjk4mLNEGkIFxcmGfTDSclHRMeD6Bg0bTpplAzWfaPgH
        xnC9eileRXAugHqb7+9nQZkhhKhq3gRMyA+QRKQ=
X-Google-Smtp-Source: ABdhPJwAnQx8Ez2ejHeq10OpiJGhPMk48dKszJD7u/uTYHKL4iFecnVDkJpAvoryPp/fxV1p1edHUD7GjnTeo7yj/GM=
X-Received: by 2002:ad4:5c64:: with SMTP id i4mr8941365qvh.62.1643396122248;
 Fri, 28 Jan 2022 10:55:22 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6214:2529:0:0:0:0 with HTTP; Fri, 28 Jan 2022 10:55:21
 -0800 (PST)
Reply-To: fionahill.usa@outlook.com
From:   Fiona Hill <ivanroberti284@gmail.com>
Date:   Fri, 28 Jan 2022 10:55:21 -0800
Message-ID: <CAKp8dfoU5_QOis_S=2C4aKWYjvfWPRtPYTZHfcQkERMdWxvo0A@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
did you receive my message i send to you?
