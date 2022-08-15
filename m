Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74595593128
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 16:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241909AbiHOO5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 10:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232761AbiHOO5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 10:57:18 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D7F1D0E2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 07:57:16 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 288355FD05;
        Mon, 15 Aug 2022 17:57:15 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1660575435;
        bh=eVmKsXilaaeaag+6Y+vf9YfiLDdi0kPlQA8ggC+dY5s=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=TPkbQQCiN5jyM3Ve4kMjTKswenYP+jMlop+SxBACkP6LmfpRMemwfIHiNdmA2o748
         eZa7mmUY/YVzPabn0egFLpOZHdOmtRCTQD5bsQMI7JBIraAVETe8vnc6XhPjJ0Glp5
         iy99C/+ALGRV/xr624wziuuwD9EDHJK9/zKu3LM9irNxzm64FSWbOFIcfjibw8MtF4
         hrfY0XulUVGbcChPTIh8Ir97UpzNkMNqXwsXdOk3MGoPAk3H3fg63FN10hxli7mHdK
         kEwcmafAdxHBMf03WhPa40tX9QyX5D1Aj2yhcorNH7eVanbXrNOmKxA8tl2xkQpTCd
         dwZjuL3+eAMmg==
Received: from S-MS-EXCH02.sberdevices.ru (S-MS-EXCH02.sberdevices.ru [172.16.1.5])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Mon, 15 Aug 2022 17:57:14 +0300 (MSK)
From:   Aleksey Romanov <AVRomanov@sberdevices.ru>
To:     "minchan@kernel.org" <minchan@kernel.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "ngupta@vflare.org" <ngupta@vflare.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>
Subject: Re: [PATCH v2 0/2] tidy up zsmalloc implementation
Thread-Topic: [PATCH v2 0/2] tidy up zsmalloc implementation
Thread-Index: AQHYsKP3svqZzORsXEKi9NYMzcnUs62v2wOA
Date:   Mon, 15 Aug 2022 14:56:23 +0000
Message-ID: <20220815145709.qptdso5bcuhlfnmn@CAB-WSD-0003100.sigma.sbrf.ru>
References: <20220815123930.37736-1-avromanov@sberdevices.ru>
In-Reply-To: <20220815123930.37736-1-avromanov@sberdevices.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C9F424A42CE8C94994FE780DDA8B0248@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/08/15 12:17:00 #20121227
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!=20

I accidientally send v2 patchset instead of send a single change=20
from 1/2 patch based on linux-next tree. Please, ignore this patchset
and see the change I send in a separate email.

Sorry for the noise.

--=20
Thank you,
Alexey=
