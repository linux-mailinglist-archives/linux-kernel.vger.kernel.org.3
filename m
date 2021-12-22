Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 633A647D30A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 14:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241187AbhLVN3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 08:29:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241120AbhLVN3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 08:29:48 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDFFC061574;
        Wed, 22 Dec 2021 05:29:47 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id q14so1137318edi.3;
        Wed, 22 Dec 2021 05:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6mz9mKXhthiMp9uod4RylTzdhkx9DUKWmtKeQhYTqFE=;
        b=XZhfKD4djxCuA0zOwiQymC/6ud1PQTqb5xArDVLDF4Mx8CXa4KYVcTBvQBhLNsk6cZ
         3nIiZzMogoVRc+Zyhg1vy2OJwjJegXE/DwCJ5w3J9G8a0ZA1XKuOl5ivpaqFWHKiUz2G
         gkd0Au0C/gS3aKzZELbscBvpSztqdbjGK0GC/qXtFkB6HTs8JHwdOaNfc4ddrIhDsukx
         u5nagLVaylIH7lhfESqkjDd7tcrFdqzITJ25vlNFOELuGFMAHd4t6uuKEqIIb7u3VuXQ
         uZDXIyOo3pZd6t+2QFhC7bCgmEMLQpVRv/bUewfs6CFuv/n2Ib8kpPHLDr3v9qoA5Fbw
         onfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6mz9mKXhthiMp9uod4RylTzdhkx9DUKWmtKeQhYTqFE=;
        b=vmZ0vI//5Pyl6kfoWi8p5tp/VMON1uHWcWSDYq8KUWJDsfjA7H8/BoXrmT2FRF6zXl
         0hENhFLJaMsrrK2nr1UVkupadAnnRK97KWOvl87M1j+ZM0xguc2Y1IeD3rLHHJPxeBbW
         OlDDwuLig0DeNmXO5cGKdV8Z29iAxvw6zaYmSO7RdgQVgCmo22qxT90cGv4y9R1PQGNU
         tY10xi1CaTJjVcPH4tW+FYAE2nNKoxzNMd2FXmfXuviKj67yt5gePZfZFc+KNORxurhO
         NYeD+fiGB/JnozBsKRF+d8oFfOghkiPcvflUSyR+1+x788OglW6ynFTQoxeE22yzOxvU
         qlpw==
X-Gm-Message-State: AOAM530Fsc7PxEjyYCPoKiOOi2WRpTiXGzT63PkCiFugmuYOJcPSIP08
        BwvZY8CB9XgGLZbi1+oZMXGxdagGw7sUUVicaw==
X-Google-Smtp-Source: ABdhPJxxriRxyKYzBYvTdUDYNRMVnvcEsBszrhDroFotMEvj5A/odI+0bpSzgdPEz8wZXfX7CcJhVutmRtdnzaflsqo=
X-Received: by 2002:aa7:dc07:: with SMTP id b7mr2825876edu.327.1640179786483;
 Wed, 22 Dec 2021 05:29:46 -0800 (PST)
MIME-Version: 1.0
References: <20211222232448.012801f5@canb.auug.org.au>
In-Reply-To: <20211222232448.012801f5@canb.auug.org.au>
From:   Rob Herring <robherring2@gmail.com>
Date:   Wed, 22 Dec 2021 09:29:35 -0400
Message-ID: <CAL_JsqLzY7pLht8ytma4UcdHSK4Et54L314bt1RYN4M7TM=Q0A@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the devicetree-fixes tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 8:24 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the devicetree-fixes tree, today's linux-next build
> (htmldocs) produced this warning:
>
> drivers/of/fdt.c:980: warning: Excess function parameter 'node' description in 'early_init_dt_check_for_usable_mem_range'

Thanks, I've fixed this up.

Rob
