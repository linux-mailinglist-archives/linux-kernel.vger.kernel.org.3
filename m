Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6731B511ACB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238492AbiD0OoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 10:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238319AbiD0OoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 10:44:08 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EB4340DB;
        Wed, 27 Apr 2022 07:40:55 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id r17so90117iln.9;
        Wed, 27 Apr 2022 07:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RIP0odJ8FMWTLgnXtzkMr+Uyp/bX3hgDcgXzYlSMea4=;
        b=AAvSou3Nm0D6ALb5dyylq5aoEcmbA2/xvLmdzqtWL3bNWGX20nhW7UaSNbj9sC1GWs
         XwwXS28sf5pZoA5Uo9Bpe1Bf+UAw8FewIs6ZqxQh+UuOI8LglJmtEfqlvpcObBXkwF7g
         7ONPVl8vJcvL+d7REsalbnTr13hI7GuH3jy80GfRROYdlLMx6Y3yiODR8Mqapf+jBWDG
         Yy1DdaWPa/J63kGID26hoT4pt0NUBDjWssQtPwiQubyjRQyxkyq1GXTg7TA8lsf6/T1M
         VHpD1g0aANmqNnRCzlLX01NbuaeXDTF0aJtkwlBSU3CPA7mYX4Xb/iLEnRVhzZLQ0XM1
         jMzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RIP0odJ8FMWTLgnXtzkMr+Uyp/bX3hgDcgXzYlSMea4=;
        b=11m4AxX1s4EXARx0ey7J2WjWHH5rT4rA1vHeeDUHQ7Qf9gDml+7su7TqJC4COT4JvW
         Z+KXakkZxUavlncUNySRAej1JSgQrH8OtcvZOyYG5kz3z3GjhZf+Tr0joGIApnJDBTGv
         3pO8n/lr3MytCF9BmT1tBLr8IIIH6IehcSXl5i8mw9BCnuONBAfT4MZMc8cW0Uoonc9R
         CDsUTtZutBmtmvJxuDB9REU1NWVcusMSlCKYpt4loc6GcbcLouqF396/JuMbHGm626eR
         8BaM/y/1B3R2nRM4qvXjL64pMqnZxB3rfIv+RiFs8ISw2cmrtOfUYqnv+5yav42/+a6z
         05Gg==
X-Gm-Message-State: AOAM533lD+PeI4eBnHI545LhpthffywyyCrCtKK0VUtjNWfuVbFrLncs
        u1gUai6DrjNvKHwkfpM34+dLtCThZitSIpv6i7kDQ/f4Gw4=
X-Google-Smtp-Source: ABdhPJyf7cSAQIZ97hBPEyHZRO+ltdjYyvo4ENwvpOWDYd5w1PlmrMApuiRVL8aq2N2WoXOdbLo8tstJw0F3+LkBLKw=
X-Received: by 2002:a05:6e02:1888:b0:2c8:713f:dcff with SMTP id
 o8-20020a056e02188800b002c8713fdcffmr10282601ilu.289.1651070454933; Wed, 27
 Apr 2022 07:40:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220427143001.1443605-1-eugene.shalygin@gmail.com> <8698b0d9-e0c0-65b1-c44c-3cc765e1dfc8@roeck-us.net>
In-Reply-To: <8698b0d9-e0c0-65b1-c44c-3cc765e1dfc8@roeck-us.net>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Wed, 27 Apr 2022 16:40:43 +0200
Message-ID: <CAB95QAQ4-+5A5onNUMVN3oDjuTMa71xoTS3TSY-coh7Cc5-6pQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] asus-ec-sensors: add support for board families
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you, G=C3=BCnter!

> Series applied to hwmon-next.
