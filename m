Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E15C510C6C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 01:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349575AbiDZXL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 19:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbiDZXL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 19:11:26 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662B24B42D;
        Tue, 26 Apr 2022 16:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1651014486;
        bh=shewSG54MMny8witZLV8cLk8Z2rcTmgZSjSmk4pCCKw=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=hJp20dF0IGMDAEW9TSMlyxW0DVWjx3SyMoeBvx4C3Itkvdydz6z/3RGX5BtdX+7I2
         gzb4u6f98mAhR7J0TU0+uapsWUqUXTn0JuqOxr8gNsS9kKbatvKavmIg0mshAARJyD
         DpBDnBh6aNMxKrgTw+sQ8y94e5D4CQyp18ILLWVA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MeCpb-1oKkVt0ITv-00bN7u; Wed, 27
 Apr 2022 01:08:06 +0200
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Armin Wolf <W_Armin@gmx.de>
Subject: parent device of thermal cooling device
Message-ID: <c56e3ae9-835f-4a23-f8e1-764a9a8c3e84@gmx.de>
Date:   Wed, 27 Apr 2022 01:08:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:fxB2D5FqIMEIC4syizCmaHRpZY493rL2e5BBqzlzB/om8UzNKcM
 pYHWEdJMJ+3Yc/7ahBbqJSeYen2lAtHLblwXirc7t1kUIwfrWp9cQKdQumVqPtOtwwNw0LM
 s3KnprJWIEVPXwRqZ77PzGRO9ZxdOENylTyQSJ44jaKstPWuuaZ0KU3bSVm7shAsB1Rn+X2
 dCXTYjb6io3fviRYpM/gw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BTgOQA1clU4=:fHGJe8OljMfcbcMOEa3Lt3
 5juxfmtOhY2F//sHUAYIbKYhhbA/Eb0/eqa6uvFgbsW3KLTBidAG64x1tUHEKIOgXx4Jhgf+J
 NSr1w6HKOrMFZmJgyy1+WiJibWDUf4iwKIjP1LESFHFhlTo9X11sU8YR91c4ZWTiXlqIs8hii
 IWGuwlwLq7T12STYcCsZCG9FuIJ2eBOjaMfkC9OyeOle11PJ3uN8C1TNszZB2yYfyNzMargAh
 dVvBbTQixxse5GddqkwZ4b/XV50LMHisR/eWGuD/rM1FeWQNOH7qHz3AZmTNzFf087Qa1exGZ
 91SWBqzNs5zRoozeiY5OIJE8xTH68zLchzSaLtntPZut6+CgA2OGbQxRzh3RAMX88BdN1Su3P
 NywySL3amHKiFsbVqj07qF+ILZ6X5yUOgUaF8Q7iJVuwwr14F9CbwYwvZBTbGwlRA1m4SxYZR
 v1p/WYaDPamnGYStqqRpLwrEIXJ6ZS3ahEjOAiH0/jNYoJOYW3JtBlUVAbyZw/8oqtUFy3HVp
 PsolCAPcmFURjIqvSW8ASMkfRzojStGMCMWTNqXotKrgdJiCymYLuCby1J1y/OPsBY89q1cVc
 BFC+bRSpKUvKdA3koulbNtNoKV0NOfErlMhgw/VlHZTsjvlwQL7iTJ6BomwlTNkU7Fsc3viln
 M1GO3Q2J8X56K0yVA6NJQnSFOedsUO8AHlIPXssXWODqlAd4iekjruTFGugt8RjJnXOJmoYqD
 TxALFC+T8bXq5X9yTErogIwPN9LX7EccVhv4+F5H0JYthlwCcB00cZi0YbnFG3nEodYawxVdV
 U5s3Gnsvcs+smwfAIHFk5akcYr3mDPgG5pz5JuQmK1rnl7ru/qnYYzyu4bL5jL5KkRhgWXATB
 3Cy/4nytGU2usi2sCnV/uDuSc0ShjXHJcQqBXitM5wN8aQSFe/of2OZqYxwEbFU4DeBXZXOtu
 8SDoV59shDzEfhWotkC7UTMfsoNSIwmrA+rY6Vhm+8vi2NBlHxo9efT9xWPh05EfbhkAkc4Cw
 AoSVYbjTFigb2l4xnCreMuPw/26voIE4kSe1rcCxxk7P4FbbTJQRwVLP4RV6CJTRaqcmZ2dT8
 hI4ChI21ZwUDvk=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

i am currently working on integrating an hwmon driver (dell_smm_hwmon) into the thermal subsystem.
While doing that, i noticed that when registering cooling devices, the thermal subsystem
does not allow passing a parent device, so there is no "device/" symlink being created.

This creates problems for example when a thermal driver is instantiated multiple times while
creating cooling devices with the same type. Without the "device/" symlink, userspace is
unable to tell which cooling device belongs to which device.

The acpi fan driver is already inserting a symlink between the cooling device and the ACPI device
to avoid such issues, but such a symlink could be created automatically by allowing the driver
to pass a parent device when registering with the thermal subsystem.

Two approaches are possible:

1. Pass a separate device struct as parent device to __thermal_cooling_device_register().

2. Replace the device tree node argument with a parent device and use the device tree node
from this device.

Which approach would be the more feasible one?

Armin Wolf

