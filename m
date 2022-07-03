Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C002C5647A4
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 16:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbiGCOAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 10:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbiGCOAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 10:00:42 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8727E2185;
        Sun,  3 Jul 2022 07:00:41 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id g4so12404635ybg.9;
        Sun, 03 Jul 2022 07:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q4UT8rsZ3usHBxENgRzFNvJGhv2Wm97iAnFiDWdFYFk=;
        b=XuWQQMavd1Eellhv+zHIDsVkPTuGUHLJvk6NPD+V3c13Sz1jqo/Dopgz5DR6IEcTZx
         38eHA214J8RjRDSUVZTYRb+cgjlrK1O+T7Z1bgOIJP+UkbuGrL3tVp5hQUwJCfpcg1Kl
         yhNUZeZ79/dQymmE7+8R4vPsgkMc7ew+5IxlpKWWvQsO/4+Xpm58GarS9D+9Euoy/N/V
         Q7dkJEBU+s9NKsSJMLUQzKr0G/3ZJBjPnjciCTZ//iWvlpOfnL7Ma1NIhVByX+YLtllz
         lxabVKkRhViOrKv1b/+HMET8wGt03/SoAHHut/EaP1uIAQ8pIUEln2Vbs0zjlHp6mseW
         FnpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q4UT8rsZ3usHBxENgRzFNvJGhv2Wm97iAnFiDWdFYFk=;
        b=J3F5BtBX1vFOXi4HGnylGXkCphtVAQ4T7QNcEugFrq6zJMuGq7BpCZKCK8XGoF9J0Q
         g94qF1iyPByuJGxYPwqXhoPovr1Xr3JY3RA7hjmh9lG+LDD6hQTJOFgio+dQjBeDqrZB
         naH8WsR/xxrJ/Ew2NXFoq+KrQrI9SJhf0/mF2DVS6JxyhZC48YqDcS6IckxTYcYuzh+v
         YkeHPn9VNTOfhzU8N/U/ETsl6BqP6cCWdCv+NqAavFUJpiz/rCPz75WI1UuKBQPkuuLt
         rh0xjbth9sW2RdChR0wHgIYsxRl3L+d9YCfQKbVxNBF8iebgzTzHsU1lKsF3n85679ry
         mBRw==
X-Gm-Message-State: AJIora9be7ca5tPbnHB15amVKESSuodFnRF/dhnMATu5qE2fFBNPsZG5
        rmLuFzrOq4hGKBU/+xCf3tb8BkKV3fbKEKXlqIU=
X-Google-Smtp-Source: AGRyM1vKt057dpiKMcFPH9HSDZJE+XEG1+tqdb5e+RqDVK7l7u+jZ0x1TjwdgmRNYqFQnj3TMcuPxQw+tk/eYJi3rA0=
X-Received: by 2002:a05:6902:c4:b0:64b:4677:331b with SMTP id
 i4-20020a05690200c400b0064b4677331bmr25846878ybs.93.1656856839975; Sun, 03
 Jul 2022 07:00:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220613120534.36991-15-andrea.merello@iit.it>
 <202207031509.DlBrHyaw-lkp@intel.com> <YsGVa8KFmdvGY92e@debian.me>
In-Reply-To: <YsGVa8KFmdvGY92e@debian.me>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 3 Jul 2022 16:00:03 +0200
Message-ID: <CAHp75VfDYRZMiz4j9KN5+ZJnudT0jfh-o_f7HBk5yc+FHqvXZg@mail.gmail.com>
Subject: Re: [v6 14/14] docs: iio: add documentation for BNO055 driver
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     kernel test robot <lkp@intel.com>,
        Andrea Merello <andrea.merello@iit.it>,
        Jonathan Cameron <jic23@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>, kbuild-all@lists.01.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        jmondi <jacopo@jmondi.org>
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

On Sun, Jul 3, 2022 at 3:11 PM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> On Sun, Jul 03, 2022 at 03:58:15PM +0800, kernel test robot wrote:

Please, submit it properly.
You may add my Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

(I deliberately put it on a wrong line so no tools will catch it up
with improper commit message)

> From bb8524aa4719e54389065548c86155cbee638357 Mon Sep 17 00:00:00 2001
> From: Bagas Sanjaya <bagasdotme@gmail.com>
> Date: Sun, 3 Jul 2022 18:37:44 +0700
> Subject: [PATCH] fixup for "docs: iio: add documentation for BNO055 driver"
>
> kernel test robot reported htmldocs warning:
>
> Documentation/iio/bno055.rst:2: WARNING: Explicit markup ends without a blank line; unexpected unindent.
>
> Add missing blank between SPDX line and the page title to fix the warning.
>
> Link: https://lore.kernel.org/lkml/202207031509.DlBrHyaw-lkp@intel.com/
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: lars@metafoo.de
> Cc: robh+dt@kernel.org
> Cc: andy.shevchenko@gmail.com
> Cc: matt.ranostay@konsulko.com
> Cc: ardeleanalex@gmail.com
> Cc: jacopo@jmondi.org
> Cc: Andrea Merello <andrea.merello@iit.it>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Documentation/iio/bno055.rst | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/iio/bno055.rst b/Documentation/iio/bno055.rst
> index af21376d7a2533..9a489a79d8f5a8 100644
> --- a/Documentation/iio/bno055.rst
> +++ b/Documentation/iio/bno055.rst
> @@ -1,4 +1,5 @@
>  .. SPDX-License-Identifier: GPL-2.0
> +
>  ==============================
>  BNO055 driver
>  ==============================
>

-- 
With Best Regards,
Andy Shevchenko
