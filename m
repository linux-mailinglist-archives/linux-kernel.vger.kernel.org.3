Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E725AFAA8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 05:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiIGDcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 23:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiIGDcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 23:32:14 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2BE8C00E;
        Tue,  6 Sep 2022 20:32:09 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id f11so6411463lfa.6;
        Tue, 06 Sep 2022 20:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=fNlTaauOCv00NkMf5wKTGx7xLqnRUF5exfJxC6A7vcA=;
        b=UKk56UGJo388H+uhAijKuTUSQQLkQwmtyUZUT+ZBgpZ3Ps8HncEwNZAsuagzcthtlp
         iPCoaq4oPZX+qyJtFrDpddfBUP2p3/DK2eBaXHnOUUmOqdyUvcn7tyipSZxkhn+HdlAB
         GpphW1XTWviHybCUz0nS5qdsHJvNJf7188k601GBHznvom3K8kKvM/NDMBhTB6VWb8Dp
         9IAK9LXWfGnCdV06kqeUDYcQ/kbspMTJxCGGYfl5soR+6tnQNa+of1p2Cb7PyB5gh7f/
         o/mfK+LRjXBIKan4Zb8Z91VShJYrmawfghJaFfnoRBlAqYjf9hHrARQaVGnrhY19c+oj
         5Jvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=fNlTaauOCv00NkMf5wKTGx7xLqnRUF5exfJxC6A7vcA=;
        b=PW7s+tBWqlHiQnid18X+rNuxEmUOkK0hLu8O5rkzN2Z+zq5rQ6LxH4iMrvNio8YS7K
         mwUWKYHpY8ty+SzYz+/AKRNhz1RUVZYxmjppcE3rjX5gj3mvskRVwi4+HFIdnKXxeeaz
         2H7I/2yfCl7iNXsYm6rq/eW922jEaTRde23Ok4CneJiwOUMRgVKom3X/Ehu2fr0wi3P4
         xR9bXznUMs16IKGM+ufHrzEZKKqq2RMym92JH2dS9GuJB5iNEVmkGPkZFvkD80SCPyo+
         qFOOSWQhLz5/XEThn22hVw6SI1kP3f9cnMfx26a/6rs5YyRoy6QokVXfvsgglE7XvaWq
         eFLA==
X-Gm-Message-State: ACgBeo3y7p/Iud+4F1bpwUufDC89DK6OELE6BXLOU/cko8P2oVXFSvKr
        ht/IdEjocMLBnEIrRfrxxdEiwORpCG+uKaNtq0o=
X-Google-Smtp-Source: AA6agR4Jk1Lk1O18XLzodLspyTFUsKyssvPWuHR8tmWcEaF+3OrN8vFT/kyZwrJCxzXfpIXqd2YXqXWS3kMdhZZP6io=
X-Received: by 2002:a19:2d0d:0:b0:491:63c9:5a5f with SMTP id
 k13-20020a192d0d000000b0049163c95a5fmr414920lfj.629.1662521527977; Tue, 06
 Sep 2022 20:32:07 -0700 (PDT)
MIME-Version: 1.0
References: <SJ0PR20MB433741383E64BA84B372BE0DE97E9@SJ0PR20MB4337.namprd20.prod.outlook.com>
In-Reply-To: <SJ0PR20MB433741383E64BA84B372BE0DE97E9@SJ0PR20MB4337.namprd20.prod.outlook.com>
From:   Alex Shi <seakeel@gmail.com>
Date:   Wed, 7 Sep 2022 11:31:31 +0800
Message-ID: <CAJy-Am=g02Ua3u5nVCZSekdWPN=F=qTkPR5_BLHubzSA0wfMCw@mail.gmail.com>
Subject: Re: [PATCH] docs: zh_CN: Fix typo in process/howto.rst
To:     Whye <whye314@outlook.com>
Cc:     Alex Shi <alexs@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBTZXAgNiwgMjAyMiBhdCA4OjQyIFBNIFdoeWUgPHdoeWUzMTRAb3V0bG9vay5jb20+
IHdyb3RlOg0KPg0KPiBDb3JyZWN0IGEgd3Jvbmcgd29yZA0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBX
aHllIDx3aHllMzE0QG91dGxvb2suY29tPg0KDQpSZXZpZXdlZC1ieTogQWxleCBTaGkgPGFsZXhz
QGtlcm5lbC5vcmc+DQoNCj4gLS0tDQo+ICBEb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy96aF9D
Ti9wcm9jZXNzL2hvd3RvLnJzdCB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKSwgMSBkZWxldGlvbigtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi90cmFu
c2xhdGlvbnMvemhfQ04vcHJvY2Vzcy9ob3d0by5yc3QgYi9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0
aW9ucy96aF9DTi9wcm9jZXNzL2hvd3RvLnJzdA0KPiBpbmRleCAxNDU1MTkwZGMwODcuLjRmMTJm
OTllMDQ2NCAxMDA2NDQNCj4gLS0tIGEvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhfQ04v
cHJvY2Vzcy9ob3d0by5yc3QNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhf
Q04vcHJvY2Vzcy9ob3d0by5yc3QNCj4gQEAgLTI1NCw3ICsyNTQsNyBAQCBMaW51eC1uZXh0IOmb
huaIkOa1i+ivleagkQ0KPiAgICAgICAgICBodHRwczovL2dpdC5rZXJuZWwub3JnLz9wPWxpbnV4
L2tlcm5lbC9naXQvbmV4dC9saW51eC1uZXh0LmdpdA0KPg0KPiAg6YCa6L+H6L+Z56eN5pa55byP
77yMTGludXgtbmV4dCDlr7nkuIvkuIDkuKrlkIjlubbpmLbmrrXlsIbov5vlhaXkuLvnur/lhoXm
oLjnmoTlhoXlrrnnu5nlh7rkuobkuIDkuKrmpoLopoENCj4gLeWxleacm+OAgumdnuW4uOasouWG
kumZqeeahOa1i+ivleiAhei/kOihjOa1i+ivlUxpbnV4LW5leHTjgIINCj4gK+Wxleacm+OAgumd
nuW4uOasoui/juWGkumZqeeahOa1i+ivleiAhei/kOihjOa1i+ivlUxpbnV4LW5leHTjgIINCj4N
Cj4gIOWkmuS4quS4u+imgeeJiOacrOeahOeos+WumueJiOWGheaguOagkQ0KPiAgLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gLS0NCj4gMi4yNS4xDQo+DQo=
