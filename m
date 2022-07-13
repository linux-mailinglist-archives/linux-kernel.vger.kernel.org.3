Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 388365732F1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 11:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236096AbiGMJgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 05:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbiGMJgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 05:36:37 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622A9DF6F;
        Wed, 13 Jul 2022 02:36:36 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-31caffa4a45so106654127b3.3;
        Wed, 13 Jul 2022 02:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SXQGxMlZiGDV5DfoHS3oy/b53Aw0pi2XrxvR7btJDu4=;
        b=fGtMYPE1JzhAg0cPVVxu/PPLSc2kSOS5IoNwzOtAyu8n1wqELcerIi/RCWzSF91Z0l
         Npxv6lm5ZZRMnsMj93xgW055FOmMS2hHDFq949QbCCTGNXJP/7jScBu6NdDgJgesXNcx
         MaV4S9DuwJ+nfsWNh9+/qGTIQsPH9AHU/OD+6IDcxi4aGWArTIBE8BGDcGt3EqdMrBag
         Mj4ds4V+6p2nodu1+1ZyY/DI/j94E7V2j8xGJtIqlRNXHlOh0sNcHovx9KINtnBRA+0T
         hDequxDs7GadI9CEoZvRpYHT8HXrsvH48Gs6y49ZaYgMwg9mvpd+ZVkwgrXCkjFBaBaP
         aZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SXQGxMlZiGDV5DfoHS3oy/b53Aw0pi2XrxvR7btJDu4=;
        b=pXuKSHMlAmlGaotio6kS53dQq/AyDJ/MstVE38LBfwyaP79ZqSpOq06OYQENgwcOsj
         /O/4mjF0MFPUoBV8VxJTiMpKCpKMt+L3VgMKjPettuPAtLKggKqApNTc2i8RBwx6OAmr
         y7DS3Ho3MGGoC+Mw4DhssmaX0n83NUo25yijRaOA0F0DxWfTLT7pAEY3gbGRzuH7sGWK
         ggKFMY5pyB0FYkyxfAKDLrUcVynM4RqWiEuaBCZb9ueepp8KJNaxGqRnQPa6m+DUMlXP
         u2/RB9Sk1F6LnHTcX9FKzedEb6qP11lFBeRRYMqV8cN7AvXJmo5FyhHuvEwCwL1BaUbj
         mo9g==
X-Gm-Message-State: AJIora95LiPw54TVMYdu+a+RqXo3dedQPCGGf75H9fxTxNF60/klArH2
        8n2H1u7R8vp7TbXp6OkVqsnm/2LNH9zzg8PX+UlzZFePE8hW6w==
X-Google-Smtp-Source: AGRyM1sddBAxQ9eUSQFKjZ/gW4Zm+PBH0OnhPqkaWg+6wIlkqiw3WzbhistxLtjURf4xorFey2ZcG2T/gbVV6bCzTGM=
X-Received: by 2002:a81:108f:0:b0:31c:d7ae:9ff1 with SMTP id
 137-20020a81108f000000b0031cd7ae9ff1mr3074047ywq.18.1657704995629; Wed, 13
 Jul 2022 02:36:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220713040916.1767-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20220713040916.1767-1-lukas.bulwahn@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 13 Jul 2022 11:35:59 +0200
Message-ID: <CAHp75VeFNZjj3rL-Z_KuaNNQUEkzNzjDj7O_mzMj_H7Fnu802w@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: repair file entry in MICROSOFT SURFACE
 AGGREGATOR TABLET-MODE SWITCH
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 6:19 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> Commit 9f794056db5b ("platform/surface: Add KIP/POS tablet-mode switch
> driver") adds the section MICROSOFT SURFACE AGGREGATOR TABLET-MODE SWITCH
> with a file entry, but the file that is added with this commit is actually
> named slightly differently.
>
>   file entry name: drivers/platform/surface/surface_aggregator_tablet_switch.c
>   added file name: drivers/platform/surface/surface_aggregator_tabletsw.c
>
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
> broken reference.
>
> Repair this file entry to the actual file name added with the commit above.

Fixes tag?

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>


With Best Regards,
Andy Shevchenko
