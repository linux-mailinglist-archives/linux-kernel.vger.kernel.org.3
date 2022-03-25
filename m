Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212D44E734F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 13:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359107AbiCYM0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 08:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359108AbiCYMZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 08:25:39 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30145E749;
        Fri, 25 Mar 2022 05:23:26 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id z134so4092401vsz.8;
        Fri, 25 Mar 2022 05:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WzJ4RYl/IiDljZ0/e3z9WtJ7iVXmWkFLySTizcuAnwU=;
        b=ScMDpgxeQrCQ0bpP0YyZ+eCD0lC0NTdpCqiVIaX3+BmHuMX9sOhKmWg0BOfGVZfCTq
         sWl+VvBgX2cE70YBMlPja1pgQL6TNdORmWegGc1lAbgP7WAWZfjxYAxZaaKmQQi6ZlAZ
         1/NdssbS6Bv7Cyzqy84HaWYK7U6nntiu6gYycnm1rDjPDBNJrHaqY0/+2+Bc5rKwWFSg
         Hp9AEOSoNTQs9FZRXwpNfDiI5a/X3CBBj/ykXjGj1+Q15tB7fDN/dcn+QzPqK5HBipJ8
         24bWJKxG7cwlLhNp/eLLDSC+LsPwPK/KC9kcIbwm7mV2WfSXNwnrg81gnMTZAaKoZsgo
         E54A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WzJ4RYl/IiDljZ0/e3z9WtJ7iVXmWkFLySTizcuAnwU=;
        b=weXFBYmeZz9uzL1BNK/nKwBmlgqQYAQuWbsFibQpmVdFcQODCZEF9cnzHVzGWxhlWO
         7vdcaXmUF1p93SzE4lHPgXb6yrg7ojTCrwT8hVuegHr3EeVDV5W1eXQlOtxHNVshJ6b5
         dRvoHvARw7t+kubQ0nHcg1IFgiTvbm6xqDx1Y2+E513NGkP1CSsmGHAXA5kty+Dh/dNr
         2YDcxsOiHAzF+I8Fcs9zsjejidD3Xpee7/Mzt1fFYLYodTPsoSZnyiKb6rQNokDTcI4e
         l4qAVUCO+S7TO1o6rVhBVuI/Y+5lyjb8a4kFA2K4i+KOfmD5gq/1IP+B19DBR1wtj5wn
         WTCw==
X-Gm-Message-State: AOAM530d1/0Ny6aUGdAz7xlbA2YfPeSgVSzWOu0pCgIKCkwSxJn6JY2K
        7+fsLYuK9ysXSDsCJ/BZ92uGbklMFajo50vQAQs=
X-Google-Smtp-Source: ABdhPJw3++l05A1j7WSiEEjv3Tjqk8YLk2NsaWWwpdpeQ0iZTJegjo2qhYtGm8uSSYrZ2s8LfjOCqTEkOuEFYHNNSZs=
X-Received: by 2002:a67:2d8b:0:b0:325:5a6c:819e with SMTP id
 t133-20020a672d8b000000b003255a6c819emr4744424vst.4.1648211005672; Fri, 25
 Mar 2022 05:23:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220324124402.3631379-1-daniel@0x0f.com> <20220324124402.3631379-4-daniel@0x0f.com>
In-Reply-To: <20220324124402.3631379-4-daniel@0x0f.com>
From:   Romain Perier <romain.perier@gmail.com>
Date:   Fri, 25 Mar 2022 13:23:14 +0100
Message-ID: <CABgxDoLg4cf8qGVAhnp4Tj1cWZ0X+vM0ueTy2wp68BbgRLGuNQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] ARM: dts: mstar: Switch pm_uart to mstar,msc313-uart
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     devicetree <devicetree@vger.kernel.org>,
        linux-serial@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        andriy.shevchenko@linux.intel.com,
        Jiri Slaby <jirislaby@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Le jeu. 24 mars 2022 =C3=A0 13:44, Daniel Palmer <daniel@0x0f.com> a =C3=A9=
crit :
>
> The UART used in these SoCs is actually a variant of the dw apb uart.
> Now there is a compatible string in that driver to handle the quirks
> switch the compatible for pm_uart over to mstar,msc313-uart.
>
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
Reviewed-by: Romain Perier <romain.perier@gmail.com>
