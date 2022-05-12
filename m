Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E855247AB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 10:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351361AbiELILe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 04:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233612AbiELIL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 04:11:28 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF17A4C433;
        Thu, 12 May 2022 01:11:26 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id bx33so5478431ljb.12;
        Thu, 12 May 2022 01:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IT4+ZL64oTTNdkAnINgvpnUEBANf9bbEzcBz3oDssZE=;
        b=dIG8FRU8MCYcHd5Y7xBSUD3HNg/0MdYKgGMgIpFhx8qFn7HSfM3dHfjCewzE7Dx5Jf
         YM6NResLXt/kXRttUOKKI2ADsOnLzfU1ywg4qXoOmooa/jFxItVb4Mx9XxjKV690rfMN
         qRCGhb7hlIFBM9ASn18SQoneSKCR2Kqix4hHCfgya+04Yq+Z/n1AtAL2cEg5Ja5AUy6C
         xmOXIluEDL4qquYUvC/LDFT9ROPuBcJy2Gd6vTvDdUU02Mn+KWzdTefzOsX4H7MDLt3/
         keXWvZgdRl+EyIJt5v8VvqqTHf+xgGc66hluWJpgffUvqMFa9lo7onSglJZ9Ho5f0jy9
         nvTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IT4+ZL64oTTNdkAnINgvpnUEBANf9bbEzcBz3oDssZE=;
        b=RZrBlHStqr9fW3MkDQFHO6XR/DR+ZfK2GgOAAwwn4LAIntpupWb0b4sZUNk66yUZIx
         xB9FNZI96Um1Qi40u4UX6BQMoYv1isebsd7kt5Z+7I1daPPimAumusqnWHGBqjUA9iLZ
         MyMMl2sb8VJXjROH8C+ZOxQoBc4nXJQ2twS3+Qn8WmVJuiLHOdqUZtTla1CW2oNEvl+9
         zMNF85759MyIw+RMDAAvLS7cJjmhUl/7xjiCuo7kS3sP4JUzDnHgh7QvvxS8ZGqdbTKX
         J3b+7wExEGYgfByyUm5gi8/mBL/G6CeatI3y3kA5/C/+N6p3vb3InY8iJmV4SCNaK+ML
         zNqg==
X-Gm-Message-State: AOAM532GqZ6epYXalmhPu4AyujOKvvmTj9LQG+s0tzEQMUe5M0EYgUSl
        QR7rmG88T3vnklUJCjbnjFvA8lpDoAk=
X-Google-Smtp-Source: ABdhPJwCT3OLpL3yxeUTBokf861h6vE2qpINykhuZEe7e6iXUQ8sm+sXh4KKjLAv7oIMKjcsahbBNA==
X-Received: by 2002:a2e:8759:0:b0:250:6afa:78e9 with SMTP id q25-20020a2e8759000000b002506afa78e9mr19691006ljj.225.1652343084776;
        Thu, 12 May 2022 01:11:24 -0700 (PDT)
Received: from [192.168.1.103] ([31.173.83.174])
        by smtp.gmail.com with ESMTPSA id z6-20020a2e9646000000b0024f3d1daeb7sm742266ljh.63.2022.05.12.01.11.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 01:11:24 -0700 (PDT)
Subject: Re: [PATCH v3 03/23] dt-bindings: ata: ahci-platform: Clarify common
 AHCI props constraints
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220511231810.4928-1-Sergey.Semin@baikalelectronics.ru>
 <20220511231810.4928-4-Sergey.Semin@baikalelectronics.ru>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <68d51092-1a4c-0d42-e28d-c3b5316d580a@gmail.com>
Date:   Thu, 12 May 2022 11:11:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220511231810.4928-4-Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 5/12/22 2:17 AM, Serge Semin wrote:

> Indeed in accordance with what is imeplemtned in the AHCI paltform driver

   Implemented? :-)

> and the way the AHCI DT nodes are defined in the DT files we can add the
> next AHCI DT properties constraints: AHCI CSR ID is fixed to 'ahci', PHY
> name is fixed to 'sata-phy', AHCI controller can't have more than 32 ports
> by design.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> Changelog v2:
> - This is a new patch created after rebasing v1 onto the 5.18-rc3 kernel.

   This normally goes after ---...

[...]

MBR, Sergey
