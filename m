Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B748508DEB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 19:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380826AbiDTRFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 13:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbiDTRFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 13:05:50 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE74D35A89;
        Wed, 20 Apr 2022 10:03:01 -0700 (PDT)
Received: from mail-oa1-f45.google.com ([209.85.160.45]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M60HD-1nocem04Kp-007VIm; Wed, 20 Apr 2022 19:02:59 +0200
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-e5c42b6e31so2561299fac.12;
        Wed, 20 Apr 2022 10:02:58 -0700 (PDT)
X-Gm-Message-State: AOAM5310TG6N2w3sGL0co5AYCEC7O0jyUs+x8r5pYCDgBIn4/uqAx+iU
        Bpy7iJSeGcGKAC01wr+t9yZt0shuQ3TGLDlmJfY=
X-Google-Smtp-Source: ABdhPJxz6CgjfinOQS1TDRri9Cm3kEssQiWnp6KDkTTbtVxh17jBXPydyZsxE5/5beeTet6sV5HJn89SHelO8Lpy/nw=
X-Received: by 2002:a05:6870:8896:b0:da:f5e5:5b62 with SMTP id
 m22-20020a056870889600b000daf5e55b62mr2054271oam.229.1650474177531; Wed, 20
 Apr 2022 10:02:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220420150156.47405-1-nick.hawkins@hpe.com> <20220420150156.47405-9-nick.hawkins@hpe.com>
In-Reply-To: <20220420150156.47405-9-nick.hawkins@hpe.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 20 Apr 2022 19:02:40 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0CgyM6Mwo0P-Qqej671PNW2qS6oun6dpQh2VHCCy9yJQ@mail.gmail.com>
Message-ID: <CAK8P3a0CgyM6Mwo0P-Qqej671PNW2qS6oun6dpQh2VHCCy9yJQ@mail.gmail.com>
Subject: Re: [PATCH v4 09/11] dt-bindings: usb: generic-ochi: Add HPE GXP ochi binding
To:     "Hawkins, Nick" <nick.hawkins@hpe.com>
Cc:     "Verdun, Jean-Marie" <verdun@hpe.com>, nick@hpe.com,
        Joel Stanley <joel@jms.id.au>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:d1Ipr9Wrkucsr07DWdDP48j5aOehmhWGlTZrVyAs/DF0Q57OGV6
 2AR5vipNQTt1U9dHFIWAoclRdsoNscNbfr+j3vqVXe6x7N22BnOKScBvyoRPghF7T/VrPMb
 JTHP/hTpkkC92wQwx6rb10KRSAg1fRT2zfhGvxG55NSnPfrNHsudW5ZQ+hMAWoBq2PguBA2
 vuEQX1L2Dn1Mfa2KYpv+A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MmiqQx5ObuM=:hw1frHTBYLSQrbKEl0u7xx
 9+iDjIxU94U0pgwRcsPoOVL9iI9pHI0KU4Mw4rWE+REyaL0F98dbQqAGmQKg091jCu7l73Gvn
 LQWJWKl1++LFTNYi+xQTHuHoDhnNnj/H/7sGROH/UNEYuNQs0WjFW4jaY9at9s/HFl08TQKpL
 Mc2iubExBWab1mbwSs2oOm7TUIj0arHX5Bt+VG2mYNrgm8WmqIlmNyTqcKH1XW0yjXf38nAAF
 XcThu5zwmifJentM4dCIc21JqZlJX7dWRdqmDVNWy2EMCT7HPlmFfkMOWPCmsO9lyrxfJCyKC
 jy9YbBUWxzE9vuEb5WZOkFPKGTalc000AUh2/GiNBJOKhY1+e+iEB/KdZxFJzG9DIwKF1ojXm
 iSXiGq5B3CFwLTLNr7Pg3JX2koK9YL3+YwXCU76JCRprkqoRcLAJMvADrJOcUUfBBKumRz1r7
 At0uGyGKn4Qe6Xit4s9DRn+3OZX8+8hDmik6VHzjT6A992ciKATxS3iNGGgYm83COADMJyvqM
 IhytB5WLxoG54Y1KbP+zw/ZLSXSNxYUOaVBnyV8xhcA+8QXM78SrbtY55mgtwiGmnxlXrPKO9
 3SFARYimt1EFFsdM0K+K62SHnueHUfNyEMO5xvvmvpazl0I4YPSsdahuCfYEgQKc7d0h1TEBB
 Uk0dKpGTGpgOQpaHRVVReMPO+TwnkFsC2KYWMXPSeV0GEP8xTxSrZYHCGkGTXChW1FzI=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 5:01 PM <nick.hawkins@hpe.com> wrote:
>
> From: Nick Hawkins <nick.hawkins@hpe.com>
>
> Add hpe,gxp-ochi to the generic-ochi list. This is to
> enable the device tree support.
>
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>

s/ochi/ohci/

everywhere
