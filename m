Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80AF5309A0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 08:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbiEWGnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 02:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiEWGnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 02:43:32 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5264E3B1
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 23:41:49 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id p10so1199516wrg.12
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 23:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=8r+4rT0z8Ytfh5JdNqoBX1R1KXZ5ArSe1NSavDgjBLA=;
        b=FYoiads97LYAz3iMBonmSZL96m57hDOncjNC3fb/1DqJnDfumX4DiDKDzEJyjbDMp9
         uf3qz16WdfB7Nrd8f6ODtl/Gg8IUxHWhgPAjtOYBziWuV2uPBLLOe2MEVTqZ0QS+YiuQ
         YGjMS5MH951n28MmBarmUWjEU2BFIN5V0RBpAVq6I+O7R3zCR9Rpw5XMQOCBRSu5hmnk
         qFxIN6No/eT+Fvati8Mo+GJ66l1n0Uoj65LE9Hq+a1kQey4rlsYjcx1D6Q4e7WNPGSRa
         VjPuiXkwK6G+YQ7ZA0058lkh3vuwlocw/jytZIgfE653Ks7+uMkBQovUfV6IvNtTsqBy
         WjQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=8r+4rT0z8Ytfh5JdNqoBX1R1KXZ5ArSe1NSavDgjBLA=;
        b=QeHWydz5jiAj7VRFeDH7Nc21SjhDPesRzXcyAgPkeU1P0zB9lqH+xkCYKWeOcv+M6r
         Ji5IDcpwCNzAiYiZHpyX8RPixFSMC5FHkv5VEkj35S9DOvNcHXyO2oBMzr0i6NOeiprC
         Wo8GT/NzDfGvoVphrHmczpz5KC1vD35Kxdcp/pH4992fFLdSub20/sNfhukV9rg4DJUn
         Hl/7LagxD95eS4DkZ3uC6+deQTyCGoMWB5yZAlEZwJ4S0ZCReBao20KHZkbpKcCFUvAz
         Q0ffdC6HHBKORQUS/lNQD3eW/xMRE5x/4UtXMQgAavEgGRyRHDs8EfI3EOrZwYTUqxy6
         vkww==
X-Gm-Message-State: AOAM5339ZH9WzGIZqdqL2pkNFCn+PfN+uS5irMRYrj3ULzkGhSfA5P3u
        NP8DRTYvAHhfUUjZ8rzEfUY=
X-Google-Smtp-Source: ABdhPJyz531sqHvVQe3igOo+6jZ/+a2ju0Yz+n8QfxHgHVVe3YBoFBj77YwYAsnU1U94kZOUG1p00Q==
X-Received: by 2002:adf:f6cb:0:b0:20d:4b6:10b4 with SMTP id y11-20020adff6cb000000b0020d04b610b4mr17484584wrp.669.1653288102523;
        Sun, 22 May 2022 23:41:42 -0700 (PDT)
Received: from giga-mm.localdomain ([195.245.17.24])
        by smtp.gmail.com with ESMTPSA id ay28-20020a05600c1e1c00b003973c4bb19bsm6956289wmb.16.2022.05.22.23.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 May 2022 23:41:41 -0700 (PDT)
Message-ID: <dd7437b9b4da3dfc6ef1b86cdff03d6a048e1c7f.camel@gmail.com>
Subject: Re: [PATCH] ARM: ep93xx: Kconfig: Fix indentation
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     Juerg Haefliger <juerg.haefliger@canonical.com>,
        hsweeten@visionengravers.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Date:   Mon, 23 May 2022 08:41:40 +0200
In-Reply-To: <20220523061051.8668-1-juergh@canonical.com>
References: <20220523061051.8668-1-juergh@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Mon, 2022-05-23 at 08:10 +0200, Juerg Haefliger wrote:
> The convention for indentation seems to be a single tab. Help text is
> further indented by an additional two whitespaces. Fix the lines that
> violate these rules.
>=20
> Signed-off-by: Juerg Haefliger <juergh@canonical.com>

Acked-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

> ---
> =C2=A0arch/arm/mach-ep93xx/Kconfig | 8 ++++----
> =C2=A01 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/arm/mach-ep93xx/Kconfig b/arch/arm/mach-ep93xx/Kconfig
> index 15c68a646d51..cd94079ce095 100644
> --- a/arch/arm/mach-ep93xx/Kconfig
> +++ b/arch/arm/mach-ep93xx/Kconfig
> @@ -121,10 +121,10 @@ config MACH_MICRO9S
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Contec Micro9-Slim=
 board.
> =C2=A0
> =C2=A0config MACH_SIM_ONE
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool "Support Simplemachines =
Sim.One board"
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 help
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Say 'Y' here if y=
ou want your kernel to support the
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Simplemachines Si=
m.One board.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool "Support Simplemachines S=
im.One board"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0help
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Say 'Y' here if you wan=
t your kernel to support the
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Simplemachines Sim.One =
board.
> =C2=A0
> =C2=A0config MACH_SNAPPER_CL15
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool "Support Bluewater S=
ystems Snapper CL15 Module"

--=20
Alexander Sverdlin.

