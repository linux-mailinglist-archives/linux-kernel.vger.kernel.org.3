Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F12580E5B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 10:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237883AbiGZIAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 04:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbiGZIAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 04:00:15 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A92DF6C
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 01:00:13 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id j22so24731327ejs.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 01:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jvhJ4Fls319vpzmEH9ooehhSgHL0qybM4Gnky//U4Ws=;
        b=SGGItEkWoRZnogOpdDsWIBP0ikX0WYtqIocRcezh6YFq6LmeKIq2ntQpGOTCbhxQCu
         eiCsOvaJuy7iOuSG4U0e5o4utyz1qizCrfGMMiJJLgWkw7Jo3ea0MaikRHvG8TEO2/JG
         VSzT3hUBb3A0Y+D8WTnGuKnJX1VOtcn7kW34T7Qm7GPcKFWeFgRfgyddCDMTmX8h7Bdb
         QdqFpLvbptV41ltYgS4Q7yiJG0gAt2dQ/cb4gSScsUw8OOMOOm+xHP3iHYtCaG1v1fXJ
         8OVIavFA9O5V5GogZ8cPr3HRCsn2sKG2oBMdR/Wqke1mrOeh8rXNxizPKygz0qrfL10P
         ZxPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jvhJ4Fls319vpzmEH9ooehhSgHL0qybM4Gnky//U4Ws=;
        b=07rkY5PMDhOfyeXzIXiVqs2oT5g39nd7scTj2MMWSiO9Kdxi6pLWrfbr/IT/3KT5wW
         2Px8sYjnrqeD7Q9VMQoye/xg4vkNgnpYy0bBB4sPRr8wVHIAftYXtxp1Gg98VnZLXBdf
         r52Ad1p7o4hJG/d6DVc46sMDLX9pr2Oh/JMo1BkgRRRnejpobLW0uOj3Pp89x7lbxUNg
         4mPu/l27DAeBr26Mssrlp7T62zEj+fjTyGXjROXwDpmDEMG47G3pDtc3K6Jk3puYx8RK
         icDGpztQ2HQ18d5wTdYlpAAfg1AmBuhKNg8op1p+QeN2uewMh/k5wQBLEik4WlmH8ezL
         boOg==
X-Gm-Message-State: AJIora9ffbqf4J5uZA6EHAd5V+4snVjNGQ/xIQZKYj7Q1hO4i4PyfbQh
        /TpB+0JvsbIAWGFhVVis9YFi/avdtVdEjwS7LuTGt91Ep4l/cA==
X-Google-Smtp-Source: AGRyM1ukU/Q2TD/EJ8wkpf2Gk/d0GLunk5GZ39zifsJtfIZGizYCyImsOfB5UsuURoUetWFIYGMWwwi2Sd1yEiuGOIo=
X-Received: by 2002:a17:907:1ddd:b0:72b:49ff:d39e with SMTP id
 og29-20020a1709071ddd00b0072b49ffd39emr12990573ejc.500.1658822411958; Tue, 26
 Jul 2022 01:00:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220722220810.28894-1-mario.limonciello@amd.com>
In-Reply-To: <20220722220810.28894-1-mario.limonciello@amd.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 26 Jul 2022 10:00:01 +0200
Message-ID: <CACRpkdZcskUNwso+ZN3XbwGCFpurJ6cgKhhrHYF+FMcS2da94w@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl: amd: Fix newline declaration in debugfs output
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 23, 2022 at 12:08 AM Mario Limonciello
<mario.limonciello@amd.com> wrote:

> Currently the debugfs output for pinctrl-amd puts the first line
> combined with "GPIO bank".  This makes it a little harder to process
> as the file needs to be manually corrected for the mistake.
>
> Change this to be a new line character instead.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Patch applied as obviously correct.

Yours,
Linus Walleij
