Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE745310CD
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235151AbiEWL5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 07:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235148AbiEWL51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 07:57:27 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B2C5251C;
        Mon, 23 May 2022 04:57:23 -0700 (PDT)
Received: from mail-oo1-f46.google.com ([209.85.161.46]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N17gy-1nhb8l2T6I-012XMt; Mon, 23 May 2022 13:57:21 +0200
Received: by mail-oo1-f46.google.com with SMTP id f2-20020a4a8f42000000b0035e74942d42so2681036ool.13;
        Mon, 23 May 2022 04:57:21 -0700 (PDT)
X-Gm-Message-State: AOAM532YIqqlyrk3mbC67RSmeRmG15pMXndJUdh6ynMuzCJmLtYXDxKq
        XJZRRBLguVyJBUnvoNrQkA/U9AaTMSXtrZ1jwDE=
X-Google-Smtp-Source: ABdhPJz25Gt24MhXl+E72qufCOdw4x39awhhvsl+Xnqa65r2iahWrusogj8vUUSxWLBZ/N0deY8KYQbSs9eoO99jFuc=
X-Received: by 2002:a05:6902:1143:b0:64f:9ab6:691e with SMTP id
 p3-20020a056902114300b0064f9ab6691emr8642845ybu.480.1653303099023; Mon, 23
 May 2022 03:51:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220516163310.44842-1-nick.hawkins@hpe.com> <CAK8P3a0914=TM9f1CNcg_PXfHvt6nHDPyrvLp=0KO4hZM2GT5w@mail.gmail.com>
 <DM4PR84MB192761B3970E4934D059C3F188D19@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <DM4PR84MB192761B3970E4934D059C3F188D19@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 23 May 2022 12:51:22 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1Pvn46kMoAv+HtRAOGDYcL76jPN2Wk-MqyJSPm--0sGQ@mail.gmail.com>
Message-ID: <CAK8P3a1Pvn46kMoAv+HtRAOGDYcL76jPN2Wk-MqyJSPm--0sGQ@mail.gmail.com>
Subject: Re: [PATCH v8 0/8] Introduce HPE GXP Architecture
To:     "Hawkins, Nick" <nick.hawkins@hpe.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Olof Johansson <olof@lixom.net>, SoC Team <soc@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:9PY63lXD/LiNRAm3aMHCQC54S3LsvnAbSYvFl+xG6YXZfXH+xga
 6spKXnE5J1vAqgHRnvbccWt75G+TU01YfpRh+4QgITPb7WQFU/fRdLlTAketmmjx1uOIDbA
 UHbMYSWqFlZh00QZtCrvictXFJBkpLsmTIfLGgqbY9s1op5ACunJ/QUXD3Q9CtS6+ScOjii
 ty656h5YLqjAiW/sHjiUQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/sJgCILkmTo=:xx5jLIHQD7Mqh6bNiUR1T+
 Q85BKPvNwu7+zVqGcaZEAIqg2h9SHFk5UCpOcLBt0vKBx0zU1BFT9ZXJ0YT/hO0IYdhllGW9O
 STGZzfc3Af59x7qhV3jhbW4THTkxpgwMA+RTUpIow2c+6+8dVdG11g/hJ1cUBhPUxWFq6zq4I
 muZLuW52F2/Bz11BO2X2S/0CQhKNd1WkLxGPcIAxuuRPMIwRyh+7LNeWTvs47/AG97t3Y3p7U
 jfAg11oAAWMzrTaHjMYdR42805tKjG/cbSzIG3ELyjmtrPmmNexgg6rlbgz/BM6FW+YdTD5KE
 vkxz77wJX7mOTh7G0krZDCMdI4qsT5I0EZP4kd1XNKtv8X7xFuWQo24dt3Prof/OjDrjapBev
 0oeWzaUGGevMXH1nuRs4hDcqQZXW/2jfCD2yoPW1eHD3ZuMuVqr8LbzyroKuwxJgKvFrWSblu
 51fOdPwOlJsZzMbi8PqafsdC16YLrmBHdlMJDoc4leMEvt2LQD/QqDKMEb8fN/pvPRww6Vh1f
 7pc0dl3EGN5YoYiX6nuseNJ15Xu9ixwAyPGZzN2c7JY04xftbtjIuwn1P2LAcqwEnoQtMmczy
 YL0LbdCtTA7e7yJposRc1yxEmhmlpy3CSlCzTvbZ86Plg2e1PQz6w6VN6ue0OYdFTxxgh01It
 UXNYPpJsmhsZFAgsuCMQiWSYltX154i9Lmk6UyUCH6RDiTCrP3Lp0JkUlZDdpQu6FMd0zlH0s
 RU5SMhN/hJoJdcUWt3uC67lRgIObrS7HmMpF+SwvQrVQxAjIsmmIMGPRPKcmeJ7/LtWWc4d86
 1eght4I0CKgXiyas3xT67sBEnc2WFeiHBnsJx0+7J3T8nSOL3Fg/QCv/BG7dYyQAf8UzvhtZk
 RFbPcUWOXgx/lEMn23QA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 3:12 PM Hawkins, Nick <nick.hawkins@hpe.com> wrote:
>
> We have a talk planned for the North America Open Source Summit (June 20-24)
> and it would be great if this patch set could be in Linux by then. If it is not possible
> we can handle that.

That's a good enough reason for me, I'll see what I can do, and will
keep it in the
arm/late branch until next week. If everything goes well with the soc
tree and your
patches, I'll send it on then, otherwise it will have to wait a release.

      Arnd
