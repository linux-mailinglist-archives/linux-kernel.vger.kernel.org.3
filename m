Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAFD4A9D5C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 18:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376741AbiBDRGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 12:06:14 -0500
Received: from mail-yb1-f175.google.com ([209.85.219.175]:33471 "EHLO
        mail-yb1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236336AbiBDRGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 12:06:12 -0500
Received: by mail-yb1-f175.google.com with SMTP id j2so20817440ybu.0;
        Fri, 04 Feb 2022 09:06:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ykQKn4BV7RcKAt21Vj/n7D8KAzQLDp1YNMkx+NwczxI=;
        b=TrAkbSJekITrW24j/Qo5OzhJ8ne2RdiGyDKtZH0VfnvgLs/aALg5m1LJkWyesJDHPZ
         jCHe+sL1yRqWLGFznrVSKl3zSava29531PDL58Cttru6jYNq3WN7+x2YCyL1V9f+hwN2
         3y8RUAdfVokHhsdwKDFeojmzpXDa0ck8Z81R/MOSqgo0+/u2jKsiCFrxc9Vkmeb0eaLe
         C2DrYEmxUNcjr8OmFsDRt6JFD3e0RyJuJMEEmThJDLDdnavIvlR+zOuoYQnSzutpdpiw
         PtGdwPsVG1JBDg/bfTXsYjKkz/ofz0uJdtXr4nUsTqv9K3UrnyzGDxnjZzw52TxR7VGW
         NEzA==
X-Gm-Message-State: AOAM531tN7e/uSgiqOyfSTV6+iO0i1dI8twqeo4FOfVHvlBp5I8yHt7q
        dW+k8lKm6LiiYId6c/W6g/kV+7UZICyL5nazBDVzOymP
X-Google-Smtp-Source: ABdhPJxRgP/78MOMSf1H3kbca3prWFz3c9WwGjsLkUVay5a+29kZU2u188xUoF2Dp8n81KT0mom2oQyEZfvV1KadVhc=
X-Received: by 2002:a0d:f1c4:: with SMTP id a187mr3813871ywf.149.1643994372062;
 Fri, 04 Feb 2022 09:06:12 -0800 (PST)
MIME-Version: 1.0
References: <1fbd35ba-4921-9dcc-959d-ff8f7270d3a7@linuxfoundation.org>
In-Reply-To: <1fbd35ba-4921-9dcc-959d-ff8f7270d3a7@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 4 Feb 2022 18:06:01 +0100
Message-ID: <CAJZ5v0jUEQdETrx5G_PGzGc_rs48bozCXm1sNpio5fpDq6sBeQ@mail.gmail.com>
Subject: Re: [GIT PULL] cpupower update for Linux 5.17-rc4
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 1, 2022 at 10:22 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> Hi Rafael,
>
> Please pull the following cpupower update for Linux 5.17-rc4 or to be
> included in your next pull request to Linus.
>
> This cpupower update for Linux 5.17-rc4 consists of minor typo fix
> and renaming of file TODO to match the kernel naming convention.
>
> diff is attached.

Thanks, pulled, but is there any particular reason why this needs to
go into 5.17-rc?  It looks like it can wait for the 5.18 merge window
just fine.

Cheers,
Rafael
