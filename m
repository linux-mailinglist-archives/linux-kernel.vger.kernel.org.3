Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F644E89AB
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 21:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236507AbiC0TYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 15:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbiC0TYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 15:24:48 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0C862E5;
        Sun, 27 Mar 2022 12:23:09 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id w4so17381011wrg.12;
        Sun, 27 Mar 2022 12:23:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Zgcx8aJm5CfWxpMNK/GioBCzvGQ41eUiuqee3qCSfhc=;
        b=M9MWCLh6Wo9rGV3arzmTCJxyy6HDvwMGmNsUo13eH5gizftMNlzKw9TaqDIBpAzHM1
         /BytlUeTaDMskgzL6h5ytpSi9f/QOUwkUlnzEY6xMVROgRClNu7DhY3/+99eizQP027z
         eE6uunWLS+b7y50gquXyzkxUztcyhzBDmsUPY+KdIFtP3tbbacoHx8qRw3735cWuAVpq
         GBKaLsGvV/3JwvpFaeoAqtQV6s/js+JEomPu3I7/G5J2cahRc1+AprdDfO52b/IXqQ6p
         jM4EGKejmqqbLm5WPwgTBGO5AG1U5CGF7vAxL0AF1RunEiJF/p+Uavoi0moBisct8Nd3
         xbzw==
X-Gm-Message-State: AOAM532Zp/u/QbNREPSSTF5whX/4P75x4HxCAonyFKWZt7nGKFp2qLXa
        gF9K60QSmppNPsQGBB6+eJE=
X-Google-Smtp-Source: ABdhPJwz74EFMZa+aN8vziOQkfDg08cVKNG3OJ+6CvuTEeqEJYNYitYqQ29X3l9Zsc2s/FNi/3XGtQ==
X-Received: by 2002:a5d:6da8:0:b0:205:8537:af57 with SMTP id u8-20020a5d6da8000000b002058537af57mr18060098wrs.80.1648408987696;
        Sun, 27 Mar 2022 12:23:07 -0700 (PDT)
Received: from [192.168.0.162] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.googlemail.com with ESMTPSA id a6-20020a05600c224600b0038cbfb9cfbcsm11595292wmm.47.2022.03.27.12.23.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Mar 2022 12:23:06 -0700 (PDT)
Message-ID: <0ed1a650-d3e3-6ee1-05db-b3760b3cd245@kernel.org>
Date:   Sun, 27 Mar 2022 21:23:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 12/12] ARM: imxrt_defconfig: Add i.MXRT1170
Content-Language: en-US
To:     Jesse Taube <mr.bossman075@gmail.com>, linux-imx@nxp.com
Cc:     robh+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, aisheng.dong@nxp.com, stefan@agner.ch,
        linus.walleij@linaro.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        linux@armlinux.org.uk, abel.vesa@nxp.com, dev@lynxeye.de,
        marcel.ziswiler@toradex.com, tharvey@gateworks.com,
        leoyang.li@nxp.com, sebastian.reichel@collabora.com,
        cniedermaier@dh-electronics.com, clin@suse.com,
        giulio.benetti@benettiengineering.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
References: <20220326144313.673549-1-Mr.Bossman075@gmail.com>
 <20220326144313.673549-13-Mr.Bossman075@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220326144313.673549-13-Mr.Bossman075@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/03/2022 15:43, Jesse Taube wrote:
> Add i.MXRT1170 pinctrl, clocks and USB to imxrt_defconfig.

You add many more i.IMX unrelated functions, like USB gadgets. Please
explain in commit msg why do you need them.


Best regards,
Krzysztof
