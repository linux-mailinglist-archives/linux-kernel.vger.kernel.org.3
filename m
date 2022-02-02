Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93E34A7C14
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 00:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348100AbiBBX6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 18:58:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348206AbiBBX62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 18:58:28 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC6AC061714;
        Wed,  2 Feb 2022 15:58:28 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id 15so742275ilg.8;
        Wed, 02 Feb 2022 15:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AdTtbIqSZjs9ClhOQAZBfTgtubt8OVGF8JKyL/jJ7V0=;
        b=Cu1prVIBVuddk030FRqPYJCdmpLFK+ZapKsL7G8Qki5M2zVktzCjGDafHdwe+wTk7c
         MWqzVSst22/op2BEIOcj2nOFqrz8MouzzkAJUiXrq3b1AKImg3DvshVb2QnqIGfbLp9b
         CYnNRcu065vN1Rq0qHgECg9kkPe5aKWVIwub2L2W7nJrGPXnhm51Juo1m5BaruYju1Y4
         1YqI6xLLPeUHJ8KqcMGDAPXaa7QAwfgDmmoWjzjqJp6Kl5/N73j4OhbUYwCfsqLUbHmD
         gc2g/S4uqguv1TLSnHI+59C5RKfanWK7X9wF1BdgdvlZdm3P/kMrxbDR0FI3VC/9V0Ay
         g2/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AdTtbIqSZjs9ClhOQAZBfTgtubt8OVGF8JKyL/jJ7V0=;
        b=ipLV7GqTfPFYdj96pbURTbnjmGcHBt23VabrbDCbHsUuzqd/iJ8rSxWWIf5B0SDjN8
         z350t64OmESgFmS4cYhQ9gtsVMAvdfydvIz/8SIJxUjc/+O5vMv2HMPfuG2adQziIDVm
         fyUwFL9IhL7yE8Ecw6t/fhn+jkAP8F6hqdH6JpWkZgaIp/c3wioOJ0FGcTITtwaZ5lai
         h7T74FW2Cduyo+M/bOn44IMGAq6GbBHnVJgJhePYkwab9EXF2zIcpCYnedetf1JFoZuH
         ww58IMBKeU4AJ5taZoutpQTnoiEqWrflC3cx6AHtk2Hm8iqOq46pPfkDTukVd+cqyxGe
         V1EA==
X-Gm-Message-State: AOAM5306auwAs3dgi3n+sJyOsWMBRNBIZrGtF+Q2eQBTMftUjkpPS/wW
        eFuK/OYQQzDuUMsFPJp6DgkPGFr5INj93gB/Tyfwt8XkxcNwV0Ry
X-Google-Smtp-Source: ABdhPJzmzB7VX5tXIealvb/Do4WUvYa0OUn0WDj3I1hGPakbCJ2Q+gYaFEZ5L+NIYPdrkd5FCWbc05TBgScswoFsKc4=
X-Received: by 2002:a92:d350:: with SMTP id a16mr19720157ilh.187.1643846308079;
 Wed, 02 Feb 2022 15:58:28 -0800 (PST)
MIME-Version: 1.0
References: <20220124015658.687309-1-eugene.shalygin@gmail.com>
In-Reply-To: <20220124015658.687309-1-eugene.shalygin@gmail.com>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Thu, 3 Feb 2022 00:58:17 +0100
Message-ID: <CAB95QASxE8Z_z046mnOBD1Zk1oeg=xB-wS+J8Oeuj=akm8171Q@mail.gmail.com>
Subject: Re: [ASUS EC Sensors v8 0/3]
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Denis Pauk <pauk.denis@gmail.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jan 2022 at 02:57, Eugene Shalygin <eugene.shalygin@gmail.com> w=
rote:
>
> This patchset replaces the HWMON asus_wmi_ec_sensors driver with
> an implementation that does not use WMI but queries the embedded
> controller directly.

G=C3=BCnter, I would like to add support for one more board model. What
should I do? Another version update or could you, please, merge this
patchset already?

Thank you,
Eugene
