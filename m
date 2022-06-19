Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C37C550806
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 05:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbiFSDVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 23:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiFSDVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 23:21:38 -0400
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E73B1F5;
        Sat, 18 Jun 2022 20:21:37 -0700 (PDT)
Received: by mail-vk1-f169.google.com with SMTP id s141so482714vks.0;
        Sat, 18 Jun 2022 20:21:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=yBdeGeJ0WFGZ4ZE4jELJxIMdUdGoISy84EToVKTTpv4=;
        b=r9HK5rYd/uwcvArQIDD4RThaSOoh0jHcJzH23y+PIDn9+cy6Ri6tIA5eHR8VDUjuKk
         LDBjsJT2zz9UDYk0YV7zx1lTx6Bukan8zj1VtdopYR5zf2zqLHPY2Yp1pQ1+6ovTytf+
         I5rZAfVIDLa9fme+Q0hSjReb3PxwK5/YvmCUKT3WGsSb85OKBIsoSJNR8Tv0gn+o2/DH
         aKc1A5mFUTPLn5elPKzKduHRwxOwKVOT/6k9aoDQa+qw1nasp4m7K3ZWbYXF2VMYipvx
         12sOj5/ye89Ih0VsXv+pa49JM8qG3laZrZ8j5LnpXFmbZfMYsBQfF0Uyq44vfRnDz3Td
         6zRg==
X-Gm-Message-State: AJIora8nbvAsY0GRYmbfBQ+ULQVqB80oGvWBL8rErzRw8AimI3TQWqQ+
        UzEh2zbFUQQ4dwuZLkDdldIGF7LwsGFz0A==
X-Google-Smtp-Source: AGRyM1sh7g/pJvlq3BQ3BqBgI7MoULZG0LzkGsr54M/sLr4M2wP9Fxdf65SaZqdpbP+dar18Mi02bQ==
X-Received: by 2002:a05:6122:329:b0:35d:b844:1f98 with SMTP id d9-20020a056122032900b0035db8441f98mr7392034vko.10.1655608896084;
        Sat, 18 Jun 2022 20:21:36 -0700 (PDT)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id t4-20020a0561020a0400b00349cfafb59bsm1224811vsa.9.2022.06.18.20.21.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jun 2022 20:21:35 -0700 (PDT)
Received: by mail-vs1-f47.google.com with SMTP id f13so7577755vsp.1;
        Sat, 18 Jun 2022 20:21:35 -0700 (PDT)
X-Received: by 2002:a05:6102:2134:b0:34c:40bc:aa4e with SMTP id
 f20-20020a056102213400b0034c40bcaa4emr7177578vsg.16.1655608895309; Sat, 18
 Jun 2022 20:21:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220618214009.2178567-1-aidanmacdonald.0x0@gmail.com> <20220618214009.2178567-4-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220618214009.2178567-4-aidanmacdonald.0x0@gmail.com>
Reply-To: wens@csie.org
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sun, 19 Jun 2022 11:21:23 +0800
X-Gmail-Original-Message-ID: <CAGb2v67e2kjrtNFFN_FJZLgH+PBWaKsu1GP6cnpy1Yc8S0pk0w@mail.gmail.com>
Message-ID: <CAGb2v67e2kjrtNFFN_FJZLgH+PBWaKsu1GP6cnpy1Yc8S0pk0w@mail.gmail.com>
Subject: Re: [PATCH v3 03/16] dt-bindings: mfd: add bindings for AXP192 MFD device
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>, quic_gurus@quicinc.com,
        sebastian.reichel@collabora.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>, michael@walle.cc,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 19, 2022 at 5:40 AM Aidan MacDonald
<aidanmacdonald.0x0@gmail.com> wrote:
>
> The AXP192 is another X-Powers PMIC similar to the existing ones.
>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
