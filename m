Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28EDE4A7D61
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 02:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348678AbiBCBRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 20:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234817AbiBCBRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 20:17:11 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE142C061714;
        Wed,  2 Feb 2022 17:17:10 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id 9so1377176iou.2;
        Wed, 02 Feb 2022 17:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Atk87UBrLdgJ/4opBYK4rxjaslsdOKBSpYu0KC0YsxQ=;
        b=otKYisaXlGcz6Z+IV/RDvJswEORs8zuCZGzmillZ+Zb/fiLNDV9t1G9FhhkakI6nln
         Y12baMMsBYY3pBpxARbr621JzMC57kHB2MWCgy51vGcJIkPOSRihGRtafd3cMUEavSFE
         SZTN78p4FuksM/PQoOhgKsInnr6OiQIFxbIjLSBx0wUS6DqhkB2w9QrlZ4MziRLn2sRN
         YBgZ9RsnJEmsS7rjnpmZWBsshvsb3GoIOMX8r0fV2zOcMe5VGYC6JtMiVD8RYDCL1eHp
         sn8WiZqeUjIEy9TmXJW6PQAOBIspoxpAADIEc62QEjnxvzEh+/HSFeDfZtIc4nRXCSSK
         o1Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Atk87UBrLdgJ/4opBYK4rxjaslsdOKBSpYu0KC0YsxQ=;
        b=l6cru0REZ1ZVuj8fP5I61eG137wHxyG24Dji3tWTJZcnb/g/nKF5UBhjW6yJkv/hvK
         nqJS7018w+DCyyTDtpJtQWdELQcR8OKVER9Hk8S02DZsns4cj5tOjCHGE2/cm8tM5LjI
         aw0JKt6/AiZ0HfELFim/mz+bdsH/x1lJsWNceJx8fo3uQZjxbUzfzDMdE6p/us6oCD61
         PT7BGTOQ3KJ/rRk14xCZruEr+H5GCpJgfrcHJvEHPxbMSpfyiEPl5zRaYOeVoWFiMVkA
         M85AmN/H2ms97wcy7/n1WQb7DPfQad01zNZCIvbQ6n7G3h+n0145JsGGdMXVqTMYRXuf
         hjWQ==
X-Gm-Message-State: AOAM532cAGjuUBdli55e9z2s83R3l8YBs5zyfeTyFS6HUfX+yd5yUs4R
        W2zeYlvJ8UczioQuGI6Ah8eXhsAZQGRUhM74NN+7uqw1RzO8KQ==
X-Google-Smtp-Source: ABdhPJzP1d5MTNCIbxdxeWkhhxKtbUS8oBKU49hnYPvQ4DUOcFHpVqqnduIWHedeyefiLTXlR4S0ukZzbZtp5W3uWAk=
X-Received: by 2002:a05:6602:1484:: with SMTP id a4mr16680190iow.133.1643851030433;
 Wed, 02 Feb 2022 17:17:10 -0800 (PST)
MIME-Version: 1.0
References: <20220124015658.687309-1-eugene.shalygin@gmail.com>
 <CAB95QASxE8Z_z046mnOBD1Zk1oeg=xB-wS+J8Oeuj=akm8171Q@mail.gmail.com> <c613f73b-9c91-9aad-e367-87b9d8b17530@roeck-us.net>
In-Reply-To: <c613f73b-9c91-9aad-e367-87b9d8b17530@roeck-us.net>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Thu, 3 Feb 2022 02:16:59 +0100
Message-ID: <CAB95QASv2nY6kttOw1rwReUuucfpSgoByA6yrAbuQPRcTUQJBQ@mail.gmail.com>
Subject: Re: [ASUS EC Sensors v8 0/3]
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Denis Pauk <pauk.denis@gmail.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Jean Delvare <jdelvare@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I was waiting for someone to send me a Tested-by: for the series,

Oleksandr sent an informal one already.

> since you dropped the previous feedback.

Does it mean it is possible to update patches while keeping it?

Eugene
