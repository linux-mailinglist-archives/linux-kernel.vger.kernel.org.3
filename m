Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32C15397F8
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 22:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347750AbiEaUcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 16:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240755AbiEaUcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 16:32:10 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE1422294
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 13:32:07 -0700 (PDT)
Received: from mail-yb1-f174.google.com ([209.85.219.174]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mofx1-1nTtGx0Qkj-00p12a for <linux-kernel@vger.kernel.org>; Tue, 31 May
 2022 22:32:06 +0200
Received: by mail-yb1-f174.google.com with SMTP id t31so12992175ybi.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 13:32:05 -0700 (PDT)
X-Gm-Message-State: AOAM531OCBn3Kr/TCtqZMAecA28AboIg+SLrlEM3VPki6htzLIYIBwA1
        g9yveLDZxZsBOL6KXU1LJala+szVJmfke49Tl7M=
X-Google-Smtp-Source: ABdhPJwjtZlEHUDtrRgInqT8PUMnSYWeIpr6O7uPiFgcfh3m+qQsGvklVZcEBIzDXwGJS1Kt8XGU3Bi7zIGSW73tXxQ=
X-Received: by 2002:a25:1209:0:b0:65d:63f9:e10a with SMTP id
 9-20020a251209000000b0065d63f9e10amr3017293ybs.480.1654029124925; Tue, 31 May
 2022 13:32:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220531202404.70282-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220531202404.70282-1-andriy.shevchenko@linux.intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 31 May 2022 22:31:47 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3mq+ACjJqfoqwA2hqrzRMEmiOpWiqZGRtRDX9rftLbTA@mail.gmail.com>
Message-ID: <CAK8P3a3mq+ACjJqfoqwA2hqrzRMEmiOpWiqZGRtRDX9rftLbTA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] syscon: Use %pa to format the variable of
 resource_size_t type
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:97e6kF8LhA+Jjgp1MEA513MjR14P2It7aBGA0MEvwV4dbSpjtCy
 hdmzXYnABIXrNTDKHsqgRh2hkOo5D46G1SsW/00q7BZtk8QiwS0t8nAYYy/j4lO9VWD2RGW
 zL6suZbh2h1A0QoPtWHLGLBi2WsivTKfbtO0hyPoxZe2p+ffKRmUu2NFXlNLhHtH4jby+ZJ
 jzDBiFvuZ7lpPj66cEFhw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Or2DaDQX1JE=:oTk20MTQZUKr7AgTzxPtBU
 2bu6sMKxjWvr/Z8wzB0afdp2Cjo30Wvi7hd7RPsqjZh9wJUzNJ0wOImzDxlybg+Sn+CeXfc1E
 Ch8NGxiQCGTBKyj0MMWN0S+dou2e0AlanaM/b+EE2nNdOkLCpuwSi6TWsdvYUo+RYfTK+oR5N
 q8MKD117O2VskspaXL47Yk8xkX9onBktfT4zfLw+P6Uq43xBrbNiRl4K/u1NPFN0fwQnyOiSY
 vspewi8GIP28bgglK475+Wj0QD10kme/UnAud3vcu/t3YB/ZRApGyKiATzsJGaOYVB5zkRCSI
 rE3w5E2z/ndJq98sapxTchI4V3LfcQqOygpBIPUtF09p7EPXBgRKoWSEiOZumCGSXGLknUFFd
 pg7Fy4bh9DMOxs0HBqMeXiufGBIdLGpMBLx5r31ovmqRL6YZYVWI4A02GpPlKk2RorSfuYUP9
 kCEEdwcmNQCkAWqdln/LwWX/qBBemMSuYVYA4MudZuY3rhB266w3CdQXRuaJMDx8LGqii4Vnv
 Cj+p5JZALc7q3wxfQM4aOz8q+hkIiiz6CcCvMO8wK0RtXg3VoCoYveYeYqG7QIOK4cNSzeFhE
 Bo86J/OxdTT3WLhRgFHGizkhWCR3Vq67E9OaccADeHnMBXokXlz/6zo4sfg191GySXBxkPpog
 XE+jjw+g3DoTan4I9iSL5vgMhFw6BVbcu77bQl3s9OubIy8WEnOjuZEYZZWsQ22wl1EGBLSuK
 +Sap0g13u2SNm0NGQZ17SslWwtwUQQ/DAwkE0Q==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2022 at 10:24 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Instead of explicit casting, use %pa specifier to format
> the variable of resource_size_t type.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
