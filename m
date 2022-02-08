Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2287A4AD269
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 08:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348557AbiBHHlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 02:41:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237648AbiBHHlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 02:41:46 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C30EC0401EF;
        Mon,  7 Feb 2022 23:41:45 -0800 (PST)
Received: from mail-wr1-f41.google.com ([209.85.221.41]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mt71D-1oAoGP1Qgz-00tSqo; Tue, 08 Feb 2022 08:41:44 +0100
Received: by mail-wr1-f41.google.com with SMTP id s18so29062642wrv.7;
        Mon, 07 Feb 2022 23:41:44 -0800 (PST)
X-Gm-Message-State: AOAM530GE+mfRIufNAVlDXE0bIg6nZn2YIwEQ6szSTd6g3pMebjQfMg1
        Z9CGkELCbbkHkXtofGA68sf2oYk/S/34sL+BNww=
X-Google-Smtp-Source: ABdhPJwSN/RUlrPrmkpZbmWEmlsZtj8WZCi5YXxWOOSj9Q39433eqrfugxQNfyVR5WUl9iWtCZ9J5roLsYcDSDBre7Q=
X-Received: by 2002:a05:6000:178d:: with SMTP id e13mr2313626wrg.317.1644306103969;
 Mon, 07 Feb 2022 23:41:43 -0800 (PST)
MIME-Version: 1.0
References: <20211203031332.902485-1-jerry.huang@nxp.com> <20211203031332.902485-2-jerry.huang@nxp.com>
 <VE1PR04MB6477BB08C1AF9F1E5A0B0C1BFE2D9@VE1PR04MB6477.eurprd04.prod.outlook.com>
In-Reply-To: <VE1PR04MB6477BB08C1AF9F1E5A0B0C1BFE2D9@VE1PR04MB6477.eurprd04.prod.outlook.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 8 Feb 2022 08:41:28 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0dr_Qe47MnuAJSuEPiuzBMfnC_7gDZN0MsUiYE2bqrOg@mail.gmail.com>
Message-ID: <CAK8P3a0dr_Qe47MnuAJSuEPiuzBMfnC_7gDZN0MsUiYE2bqrOg@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: Add initial LS1021A IoT board dts support
To:     Jerry Huang <jerry.huang@nxp.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>, "olof@lixom.net" <olof@lixom.net>,
        "soc@kernel.org" <soc@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "krzysztof.kozlowski@canonical.com" 
        <krzysztof.kozlowski@canonical.com>,
        "linux@rempel-privat.de" <linux@rempel-privat.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "dev@lynxeye.de" <dev@lynxeye.de>,
        "cniedermaier@dh-electronics.com" <cniedermaier@dh-electronics.com>,
        "sebastian.reichel@collabora.com" <sebastian.reichel@collabora.com>,
        Alison Wang <alison.wang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Y1XQD3ttRgW9Wgwx/euX2wGwhlQ+SrjeqQQeQ+6QQOMdVdAh/GA
 D9xW1v095WAUbkCh7ZJcCNUQTnNEdauxT1KM636rk6IAUUD+CbgVyYui5jJmhY3gae0tV5b
 yqzZaZwZynLBeGaQwF7xPJYKpDXT3CeXNPW0bcutSmc5gvhe/4ugOccozptqo8l3pCAsUZL
 0tkULrejpWRJwXtAQpjGw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QxW65tKqB5o=:E4ki8ByPG7R6TsheBK9EIJ
 cs3d9BhbxqNmFFJJdPsZituUW0wi2wxC2QvBLGyaszdd233W8MZNTQ2QA7NubutxE0VudYRdB
 GNOioM/R9ovvCl50qOTXYwTcIHCD9uLHJ+EnjGGkHWfSCRWGDrbW0yYy5FOyG+gAJXAseF5wu
 1+v++hUTzpksNYTqUzr6hHcjExttMAMMdP8HaTHOGLBPmte6/Q2X6txNwlI6I1gjDq1k2RItC
 Ke+n+3c0wD3nTUlpgJYTE+GW2xz9rL2lvCbzl9aUyIDq2W2AAc/Xrt76fg1BbMP7Ey3IeNZSz
 CVbNwrm3iTjerGqozYZg4q/PgIrDqQz7HYUd8lOPI2wZS89/UeChKt1Mw1YsI73E7ZOoyC88h
 87J8NVeYsBhlbBttPMoOaM/6PK8IUw0UZD66OrBClDP3yv+ihH8dtLW1meMtasueiNarK2ly3
 Z1UlGCJ73AjtC3ON9EbbZYPPYsWw/ojoI1ROP7zrpcemtUf3R9SI9/1EprI9NAbK8CvVGfTSg
 zVMbqxAuS/Ioa35ng29nKr9TLsFgIrqYgnlmxBN8M0TVQubhiRyHeNNb5znpja9HxibbcDxCy
 tkU85+4mk0oIUr5cmAP8POeD0xZVjxF87LFZJF4ktKfgGa0oVnLkBBJ0Fm4o4W8hMR2ZBG9r/
 1LZ1G12+mV820zYsJHQNFojRVOtO+jmLroxauwHBPQM5xmpmNxmLN9YS3QC2DNi8TJK6S4JS5
 T+TRFUMrHIxmrqy8vANvGPvCSOBR8V2MYXvlRR4OqK2rUpoiW57zqGRVC6naKWIXw5G6M742Q
 pd8N2YPDBpjUCAAHaBxV/m44plKZduG42wtwYAOrOBAPJgCQPU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 8, 2022 at 2:49 AM Jerry Huang <jerry.huang@nxp.com> wrote:
>
> Any comment for this patch?

Shawn gave a detailed review in December, maybe you missed it:

https://lore.kernel.org/linux-arm-kernel/20211214040228.GD10916@dragon/

         Arnd
