Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44A1947CF2A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 10:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243893AbhLVJZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 04:25:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243882AbhLVJZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 04:25:10 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07326C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 01:25:10 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id j2so4748250ybg.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 01:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ORFzZVxyg8GODhOMMpOtv41PQGhosh0WLqrwBnhKeiA=;
        b=B/w6kerf9SdFia8Nkcc1UOpPuDDLMMpGU7/H1Zw29gLopNQpOryflYK+tiJcSBCrOL
         eXMSOgY26N32jKfX5yhm9UpKU9xgEFXZYCRq/cDMiCNaNTsYFjNVE1x0Ju0ESlHhJync
         3Qwz3Zm/3Nuk1Lq6QI8FtgiPjNOf8yzcP/MBVwTmC8wAm/5w0umIDjqcxmEdOkl1KnwR
         cII3MLjgT6VeqR33bJ0mwer+liZYP+D3zIOXxZ987tyY1uIT3teBdUjnBeeV7oi5qEKK
         nzqNOuzXMvA8TlrY7o6bpOVDmRmsOSMS0zja3YVu/FXSkHsQAqpoKmP+DQau4j3LHBUt
         qRWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ORFzZVxyg8GODhOMMpOtv41PQGhosh0WLqrwBnhKeiA=;
        b=eNbFm3qeYuMZD5PKnh3ERgbQmyW+bB0PCg3j0wUjetbw4MKs5wslinkLaRVltIapCu
         MVN//6wgWLN9NHykhiG877Jo+5Uo691pyXhQ/EcLZVcfISQEPBcHoOCQOSQcIN0rLrID
         yJHfDOmbxkWINT0o/0LEhIhkUnjcZMivQom9IQ0EMO9bdza14KPv8Oyrd5DZ3+OYgyfz
         zAseZoxF4oUl4Fn2ydAe3RHn60HJ1f2iStPZH0xQjcK73Wr91cB36mocdRUmguuM7bSS
         GL3JNrkipsc9qmOh2pKKTxwiqFmbnj6kWre9Cfa1zRFSfk0wQLRx/MAMIPxUK05rBiCW
         Ynmw==
X-Gm-Message-State: AOAM533D69TidWdbhhunExb1SXuwz7sQqwTadsxTM3YroILeVsDTcVy4
        LnL+MLCQBLwVr44bJFdcDY4QlMIoEh+7ESvrn7w=
X-Google-Smtp-Source: ABdhPJwU8VYZhu6V4H32fbpVDj0GoSIrK34Jtep5OL3Oo4KIzR0nr6pxIbOFV+2hHTfdN0xyrbMJZQNmbt9GqIcTMB0=
X-Received: by 2002:a25:a183:: with SMTP id a3mr3226180ybi.723.1640165109259;
 Wed, 22 Dec 2021 01:25:09 -0800 (PST)
MIME-Version: 1.0
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Wed, 22 Dec 2021 10:24:58 +0100
Message-ID: <CAKXUXMx0kMruMNfAv-Os1VSrgfg2vyKv17uDVq-QqB1Szwu+1w@mail.gmail.com>
Subject: Config REGULATOR_MTK_DVFSR depends on the non-existing config MTK_DVFSRC
To:     Henry Chen <henryc.chen@mediatek.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Henry,

In commit a0db6b0aa670 ("regulator: Regulator driver for the Mediatek
DVFSRC"), you have added the MediaTek DVFSRC regulator driver with the
config REGULATOR_MTK_DVFSR, which depends on the non-existing config
MTK_DVFSRC.

However, the config MTK_DVFSRC was never introduced in the kernel
repository so far. This makes this whole driver effectively dead code
in the repository.

Do you intend to add a further config MTK_DVFSRC for this driver to be
compiled or can we simply drop this dead driver code?

Best regards,

Lukas
