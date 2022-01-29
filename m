Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 636784A3070
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 17:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346024AbiA2QKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 11:10:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233274AbiA2QKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 11:10:48 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E09C061714;
        Sat, 29 Jan 2022 08:10:48 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id s5so27112021ejx.2;
        Sat, 29 Jan 2022 08:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xVPj+VEQQ3LYgC4VTa+CDcy/JvZdQrM76WmfxElEHv0=;
        b=pwnCMHwlg1pPWvaypMGET1gmill5PIBCUAOD244rVbZ1GLf4VERuyWGxuBeFuBUAn6
         dlmKvYFvUad4eUvgNCcUR/NbuBSxwzffOOr4LNNrRkahhScyYZyKFkKGZ8ZmBUHICBbu
         HFhR8JR/IhD2XyezsIHuW2rnwtd9ITkNY1QvbAI5NWK8WmsdJ2UDZY5FgQdb7S6r3I9V
         aGqYu9Ya8NbYOp/AMC1dQhZU66V4H3pM5jntBRvnD+4ZGzD/0WfaiIJ4Aoq3KgQ0NuBM
         QOPpKjGy7ERs1AJYG7cm3sZuWVjGT0hIwoSs+J4PIzdpBAraDHklUIOntDIlxnsqebnI
         HZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xVPj+VEQQ3LYgC4VTa+CDcy/JvZdQrM76WmfxElEHv0=;
        b=FuZxhD/AtTBVt8I6bwbNWKdkKIV82u3SJs1D8ujOChs55EHaCNVLs3ZJCPsLWtnXdt
         xovC2uDS4zdDm5McO0QIFgu5aZCDNrepPP3r/C5OT3ZwSZQh1lV4rqHBWOLgsxTq98Vj
         bzaisD47h/Lb/iUjW3W5H0lmpObzyNvaEdIgOPbN/WqfLCq9RNuTGVzrmM+gzuHsbkZD
         lFoqH0Wuw4igMNFAEoNUoOIe/shM8IkqIcPfQv3xJyyf1k6JOytbkZKRKGGSL5f5tcsQ
         hAiFZkeNFnXNxWe62z9PxgTq+xNI9zXIhu5/mY66wQ7iTXE7NP3LIr0dvRLfyDrtIQAd
         GnCQ==
X-Gm-Message-State: AOAM533cEzTvrXdCLDtne5syyLhJqBdrauWYR3e2rpq4TdDeiYFerhKz
        xhMQYhThIAjuGFy/mD2Y2nA=
X-Google-Smtp-Source: ABdhPJygDakt5EVlzgvPtffW4d6Yh34e0wGoY+6IpK+Bc2m1ePC/R7ukvhwI8vnXSO3DeAuPSUUDiQ==
X-Received: by 2002:a17:906:d967:: with SMTP id rp7mr3836870ejb.543.1643472646929;
        Sat, 29 Jan 2022 08:10:46 -0800 (PST)
Received: from kista.localnet (cpe-86-58-32-107.static.triera.net. [86.58.32.107])
        by smtp.gmail.com with ESMTPSA id t13sm11166528ejs.187.2022.01.29.08.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 08:10:46 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        =?ISO-8859-1?Q?Baltaz=E1r?= Radics <baltazar.radics@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        =?ISO-8859-1?Q?Baltaz=E1r?= Radics <baltazar.radics@gmail.com>
Subject: Re: [PATCH] Add ethernet0 alias in Nanopi NEO's device tree
Date:   Sat, 29 Jan 2022 17:10:45 +0100
Message-ID: <5534722.DvuYhMxLoT@kista>
In-Reply-To: <20220129154214.45629-1-baltazar.radics@gmail.com>
References: <20220129154214.45629-1-baltazar.radics@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Dne sobota, 29. januar 2022 ob 16:42:14 CET je Baltaz=E1r Radics napisal(a):
> This is required for U-Boot to generate a MAC address for it
> automatically.
> (Without this, the MAC address will be random on each boot.)
>=20
> Signed-off-by: Baltaz=E1r Radics <baltazar.radics@gmail.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Thanks!

Best regards,
Jernej


