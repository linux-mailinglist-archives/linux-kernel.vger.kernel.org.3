Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6115D50B847
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 15:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234087AbiDVNXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 09:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234077AbiDVNXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 09:23:25 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706C55675F
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 06:20:28 -0700 (PDT)
Received: from mail-wm1-f52.google.com ([209.85.128.52]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MDykM-1na9z52EGS-009w2s for <linux-kernel@vger.kernel.org>; Fri, 22 Apr
 2022 15:20:27 +0200
Received: by mail-wm1-f52.google.com with SMTP id 17-20020a05600c021100b00393a19f8f98so2342709wmi.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 06:20:27 -0700 (PDT)
X-Gm-Message-State: AOAM532t0cXsi4jBUQKB+WLq9mN0ZqKTfwHv/4OVRDOecOkG+CVrReig
        aNGeOmxuSc54arV/SetezmN5i3Dtc2Luek785rg=
X-Google-Smtp-Source: ABdhPJzf/DWY7IjQmD9EMZpdSip3IO7TepL3hX4HNfMH3eMN5Wr1vB5Co+iKQNZfzMg9VSbLcZ66wrZAMeetcjbrF3c=
X-Received: by 2002:a05:600c:4ed4:b0:392:90a5:b7e6 with SMTP id
 g20-20020a05600c4ed400b0039290a5b7e6mr13716628wmq.33.1650633627153; Fri, 22
 Apr 2022 06:20:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220421192132.109954-1-nick.hawkins@hpe.com> <20220421192132.109954-2-nick.hawkins@hpe.com>
In-Reply-To: <20220421192132.109954-2-nick.hawkins@hpe.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 22 Apr 2022 15:20:11 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0E4=8Drn_x19MkauNL_WC4vEL6wqkDqrafbT-n8cZpDA@mail.gmail.com>
Message-ID: <CAK8P3a0E4=8Drn_x19MkauNL_WC4vEL6wqkDqrafbT-n8cZpDA@mail.gmail.com>
Subject: Re: [PATCH v5 01/11] archh: arm: mach-hpe: Introduce the HPE GXP architecture
To:     "Hawkins, Nick" <nick.hawkins@hpe.com>
Cc:     "Verdun, Jean-Marie" <verdun@hpe.com>,
        Joel Stanley <joel@jms.id.au>, Arnd Bergmann <arnd@arndb.de>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:HHZb/dSf2uI0vlbQ6e8ER49qDtomMK8A0heqJ1xj8Mbg3Oe9fpZ
 umAbwrQddJkUHuLUVOyd6v3gs5WxGsfwQNIuJVWsIfZU/z7XTOJfZmzngWnCL+31DrPzOpq
 xUeDzhY8V9Jbgk4IlJNin65q84t/st8l6AP0C7bnbWfa3MkkQanR73NOGG40neKkbcqiJ85
 uCvyzTunC2mwgkq6AkOog==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZfFoGBGji6Q=:5rEyGioGbRetw+KE3HlOqf
 7593IfLxMaL4Jrn/qHDoJucyEFGdqVmiS8sWDr9BzWNWFGok+Qt1TMMj1sqSSp2URmzxbrwky
 zu7TKoeCbGhMA6htqEzujRp4WqSO9ORbsxsaPNBP3Ms3lFTdhUhiu36pbkqBtIqP6kv7dtdg/
 rt/201dVbSOCr2auhOEkyf0JzUI0gBXBcYLTWvKgJ3eVRTZH16OCnCPXqKSCZSofi2q0BILEu
 ThcpFg0YXf2qQsE5eofJrkynXq+inUImxPthggst1sYBYtbc7nUNGy2YHmPFKaTSaY6HTU1be
 F6H15DHJosyOGQXgxBUFBPhcggGhe1M+wgwTAgZ+/sm/OLHi7K0rlCXwG95xQaGGe74l2nJSi
 08mZXTQ3KKGyCDn4gMHo7YJ6vlYUa5EC9b9bXHT+LpLUmvOuuq6h6r5ZrTceVNn2EYUi1EykJ
 tC0496DMOXeOuyJvpuGbTQo9V4TNdAAL7v6RoCXNEaJC7ThLPijzQo7f537QDHU3EG/Y/sSNZ
 Q/TAz1QZpl0HnYNhPjhTsgOBXgaoMOYlpc+MQL99cPIX46ogwQCUhFbdC7nuGGeAbPz0FQJYB
 UIpMH058USPoiEAUhsuOGzQwqTWJE9jZN5P/p2uwVfY3sYmSh/pFWd2XPfTXJsglSV09Jy2I0
 ztxWmJs6Qmw+4JnIS7nq4eleyPB6fvrnJhBJQZJwqHSoL6n9+vrXQ/lK1/L/DzKVN+0DkbWsh
 GfBKUDCKvO2gpfLYMKQlQXl+YEGiB2Uc1LlkrR6YwSo9EF3vrZ/7NDUB77B2jMg+k2QlPV6Jw
 1sBFMYwWRaS+8i9ibUCzf02WsE/NgJqV/gZpHr+eAldLMP5zm0=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 9:21 PM <nick.hawkins@hpe.com> wrote:
> +
> +DT_MACHINE_START(GXP_DT, "HPE GXP")
> +       .dt_compat      = gxp_board_dt_compat,
> +       .l2c_aux_val = 0,
> +       .l2c_aux_mask = 0,
> +MACHINE_END

Ther l2c initialization looks wrong here, where  you are saying here is
that all the bits of the aux register must be set to zero.

I also see that you don't have a device node for the cache controller, so
this is probably not actually used, but in general there should be one with
the correct properties.

        Arnd
