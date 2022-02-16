Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB794B8E63
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 17:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234972AbiBPQn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 11:43:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbiBPQn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 11:43:58 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E7F1802A3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 08:43:46 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-2d62593ad9bso5229517b3.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 08:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7pPS/hYRkCRPGGua9ECUYGBT3soi85FDOaendYlmnG0=;
        b=HOVu2CoZ6B81VIx1frpUitN2RJtUqhv5uKe6zNJVkKESsWAMi1VHXBWF5ub+o/RuXq
         HVM9GjtZGI7UTU9309vEi3eyMkbRBLgxsUuJodl7BhiWpxafPSbaf5qf7E6iw2UzxBL4
         QfRJVm0Dq+TwijpPg1PQ+3ygWgkjv8zwusKl/Rj1+jVwBHp/Oi82Yhmp+awFgb54K2nz
         gV8jT+luou52rVSq9LWJZvVw5BA7PGsmZrkAUc4qhrUYkaTfn5uKYeCbbomHLR+moAmV
         RvrLdVFME5Rv+aBjhwIfAKGSotFEM3zwKa6HCQcPzLBwzLScfoFeAcPIP0Wqq8nFdYhu
         YOSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7pPS/hYRkCRPGGua9ECUYGBT3soi85FDOaendYlmnG0=;
        b=oYaoYS2tGF4XuI4zIXnxYiq3b8TtCXRLVbaRcZsln1aniQWC2jmhanTf0iw56cyG1V
         Si3t1TEu8BCNsoV6seKK6ZGhnaMYrPFU3OcnQCKwSL048O/vcTpmNPXSndmdsICWDyuv
         0p4LjFIDIg8B7IFm0iFdYyhNlPaDlA8GyEmOaTW3vjYiFKeCAVdHN/4jprDuzGF9gSrS
         Ik3/OqnObP59IHSRsXcEz4CMOSrysUGXJ/tRVbQBELNSWSvQQdYHWSYJ8imWKB67/ci6
         hKH6Bo+HAgdpahgiGg+PVPQ+Y0ij9WOEJcOXxthtQxJkW6e1LHP4zPIyFGBpnuVlIqU9
         EK6g==
X-Gm-Message-State: AOAM530+Kdgu4Q5z24g4yAo9DM0WVNkMrOFaLi8oB9eeB8yUb6XpMx27
        tKHU5a5mXd2gGh/D/HSaMe4X8owU1gOD0IPOnbDDztXjDqeTJg==
X-Google-Smtp-Source: ABdhPJwibeXo/z6ose6W+m3Mo5JKTr/sv4Ea/7CspFnSdTYUMo+A6s5xYZXZobdEiz1qZzOsXl/5so7o/WmRbLxCR8k=
X-Received: by 2002:a81:df07:0:b0:2ca:287c:6b7e with SMTP id
 c7-20020a81df07000000b002ca287c6b7emr3184461ywn.35.1645029825136; Wed, 16 Feb
 2022 08:43:45 -0800 (PST)
MIME-Version: 1.0
References: <20220216062601.779690-1-ztong0001@gmail.com> <CABXOdTcZoGy3w_aVPju0DLr+Ab0C8XUsMs0+XsTW0QacR53iug@mail.gmail.com>
In-Reply-To: <CABXOdTcZoGy3w_aVPju0DLr+Ab0C8XUsMs0+XsTW0QacR53iug@mail.gmail.com>
From:   Tong Zhang <ztong0001@gmail.com>
Date:   Wed, 16 Feb 2022 08:43:34 -0800
Message-ID: <CAA5qM4DaAHc2XyMwej7V3VzzoGa8uW+Rrg29C39tkeLrYnYhmQ@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec: honor acpi=off
To:     Guenter Roeck <groeck@google.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SCC_BODY_URI_ONLY,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 8:12 AM Guenter Roeck <groeck@google.com> wrote:
>
> On Tue, Feb 15, 2022 at 10:26 PM Tong Zhang <ztong0001@gmail.com> wrote:
> >
> > when acpi=off is provided in bootarg, kernel crash with
> >
> >  BUG: kernel NULL pointer dereference, address: 0000000000000018
> >  RIP: 0010:acpi_ns_walk_namespace+0x57/0x280
> >   <TASK>
> >  ? acpi_get_devices+0x140/0x140
> >  cros_ec_lpc_init+0x25/0x100
> >
> > Driver should check if ACPI is disabled before calling acpi_get_devices(),
> > otherwise acpi_walk_namespace() will dereference null pointer since the
> > acpi_gbl_root_node is not initialized.
> > This is a common pattern and should be fixed in ACPI framework to prevent
> > such crash in the future, but since many drivers are already doing explicit
> > check(acpi_disable) we do the same thing here.
> >
Thanks for the comment. This is no longer an issue since the ACPI
patch I mentioned is staged in ACPICA tree.
https://github.com/acpica/acpica/commit/b1c3656ef4950098e530be68d4b589584f06cddc
