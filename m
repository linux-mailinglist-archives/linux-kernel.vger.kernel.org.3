Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00F24A8CD7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 21:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353921AbiBCUBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 15:01:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbiBCUBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 15:01:44 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86319C061714;
        Thu,  3 Feb 2022 12:01:44 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id i62so4738972ioa.1;
        Thu, 03 Feb 2022 12:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eRblNJegboCG+i2EsjugPeMU0FiVsFIMNmO+UoooOjA=;
        b=DR73SbfoHawndl9MmDdSxj/hgAe8Jb3I6+WUPsfIaAkeoVSj8h9SgWZxO0JJSxXN2l
         VylXpcuX0h79K+MMtXaUxp9vaTg4VYpdZD5Y872z6XmsIDusiDFc9IHGeN4I20R/+tiK
         kjHin+9aqYqQh5k+OscqyKFnLprTmqRbP5ShSzv5njhlT9kwt27PXALfs7JrBl/fsPnn
         uckYb2p+TBSRpJCUtUa2aqc+ji/fMOtsTruY7Yn8qS0/uj5RpGHVhewybPVmr7JCDMs5
         fHsBWA5BAVWSmgQTToLn5rEiok79o9uZCu7We/C94m7nF4bFXog4pOjUqEnA0YRXHrOd
         pPVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eRblNJegboCG+i2EsjugPeMU0FiVsFIMNmO+UoooOjA=;
        b=77ObulpMDtGCPnSq9HcMOU3senBQJ+bXuK0uQBEUavG52YAgYbae+FVUW+8VceF+sx
         IWnIHVO37+4L2ZBd5DNYQQhyDofCN7vppVIWl9oL1ndVLPIdR2WgQAaFbiVaqR407o05
         kHv6iIs6fyOdVicQrsp790ZV7X5EYLxZLhsk/vsASIWhO7CnWqC4v0Et99pEhfMpABM8
         kIo41Y6GY4nGn1MidXy1zZxMpMrJPiExVsnOhCYCE+R1RZ5ssqKl5fEkv/1ybkQyhx6a
         fJuJoWf+yTsp4LL1EdnoonTP8d5eGJpVhl1+yAIvlBHa+LY/0UVERhll3cvkZbhvjaHD
         clNw==
X-Gm-Message-State: AOAM533k4TkNiiMhdz1CBNYP/rKit0rseO3dY+/Bmyym64sLLJjPed+a
        kQnmoJamOT3Ywyd8A/++FTbRkDWo2Vvb64o0UAc=
X-Google-Smtp-Source: ABdhPJziu9nSOSiyoZO2PLLg3TsphttGjYFb341qLRbUmxAwvMH5+exfoLb+Rb0+Qdp2BEOvSdV0SZtyYcJVbMXdJYM=
X-Received: by 2002:a6b:8e89:: with SMTP id q131mr19284770iod.77.1643918503934;
 Thu, 03 Feb 2022 12:01:43 -0800 (PST)
MIME-Version: 1.0
References: <20220124015658.687309-1-eugene.shalygin@gmail.com>
 <7c8f311f-a2e4-584f-eb29-7f0d2a335e8f@roeck-us.net> <CAB95QARyz_sp9MoMsakfAK+PRBnVVnyOQzm2ZwJwwLE5vvAUFg@mail.gmail.com>
 <8022383.T7Z3S40VBb@natalenko.name> <13a9d0fd-1b2c-b9c1-24a7-ff4fc5f4b8cc@roeck-us.net>
In-Reply-To: <13a9d0fd-1b2c-b9c1-24a7-ff4fc5f4b8cc@roeck-us.net>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Thu, 3 Feb 2022 21:01:32 +0100
Message-ID: <CAB95QATUK+q01TLuubqR9D1fLJM=C6VjxpabnkseQRUvsd-9YA@mail.gmail.com>
Subject: Re: [ASUS EC Sensors v8 0/3]
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Denis Pauk <pauk.denis@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >> Oleksandre, could you, please, let us know did you actually test the
> >> v8 code and if so provide us with the Tested-by: tag?
> >
> > Yes, I do run this version now, and it works fine for me.
> >
> > Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> >
>
> Ok, based on that I'll apply the series on top of hwmon-next with your
> Tested-by:.
>

Great! Thank you both!

Eugene
