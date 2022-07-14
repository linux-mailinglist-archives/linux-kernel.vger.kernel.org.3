Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5500C5744AF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 07:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234981AbiGNFqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 01:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiGNFqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 01:46:05 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5C02AC73;
        Wed, 13 Jul 2022 22:46:03 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id bf9so1039226lfb.13;
        Wed, 13 Jul 2022 22:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vafiOnArmMbdFkw12ZkX8srj9GjEXyE3zEfZk0yyph8=;
        b=iscXerRkiLLlWMBAYhA8TXE3h5olodsXQDUzlHDh96YOfEf9JHeUR+yq2hn7Jw8R+o
         +x0HBvlToMU1Z0tcb5vFSAq+GeNVPnsQ3bLdfsHvHjbd63WfPatdE9fqKOUh6PuS6vzI
         GphVb+HXRxyzKuR9NQiE50Maoti75bkQJ5hT2pI/rC38aOZJxveWEmorzhD2HgznRnwz
         1PbKIfBtF1dB3yv15M04ZNafaJLYTYip2kwpyq+HoUPTLZjjLv52Dy0taETre4Trom62
         Mjt++h/NXMnQu/osLBh5kJ3XyfzTYO75O8bnDtRVMJzE14lSkPN17Bq8t9wY11r2uZkL
         ABrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vafiOnArmMbdFkw12ZkX8srj9GjEXyE3zEfZk0yyph8=;
        b=1fWE8NC9CVrMImU2SJ/RNAvgJW2SY4vPqtPNQClx2NaIyqJ1VPlRImETzza5vsWHn/
         erhrJHUQcYANUFRnkJ2JeJ34scQwnsUuww4qc188/IOElnH9uut6AU7sTF8p0eK6kTRN
         olGDVk56xgVRSyhM0+V07vWVqHO7b2jZuiXDEPgYeHLgtbUNAzsZCeSQc4X8iWqF/lyN
         p/AIXW0HBhX5s/PXlt7IWiCvrB1fyUzB9Snp1wHl5I85FHe3FRk1dtgDrR9kT12xzOdj
         zmQu5ukFT4hDjKrclgV6rF4k9wIr88kfehobL8J/xMAtsFFyX72IPD9YTxzuxSdxTvUa
         l5pQ==
X-Gm-Message-State: AJIora+hec+euTJmG6AxsnM1tbCk9Nrh4jrOVpQ14cdJ4P7iCWwbaTlv
        wp95nDVx0C6nmOfInXf1J9yWWeiGFU7hkx0JU4fpbVZKG5fblw==
X-Google-Smtp-Source: AGRyM1vuz7AcEk7yBbzuHjGT3m6seyH+2XU8NoxGTDIkTqbgJg+QqUcC/DHrl4m2eAzwLfUoHy7fWhQUUwenxJxrSa8=
X-Received: by 2002:a05:6512:3c98:b0:489:dee3:51d0 with SMTP id
 h24-20020a0565123c9800b00489dee351d0mr4038695lfv.606.1657777562004; Wed, 13
 Jul 2022 22:46:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220704122537.3407-1-lukas.bulwahn@gmail.com> <87sfn44wk4.fsf@meer.lwn.net>
In-Reply-To: <87sfn44wk4.fsf@meer.lwn.net>
From:   Alex Shi <seakeel@gmail.com>
Date:   Thu, 14 Jul 2022 13:45:25 +0800
Message-ID: <CAJy-AmnkRRqC25N1imgqRCHymh8J4ZE=LYx=-3tG4bhAggViSA@mail.gmail.com>
Subject: Re: [PATCH 00/11] docs: remove submitting-drivers.rst
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-doc-tw-discuss@lists.sourceforge.net,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Alex, can you fix the remaining references in zh_CN?
>
> For zh_TW I'm wondering ... that is increasingly looking like an
> unmaintained drive-by submission.  I suppose we can just brute-force
> remove the references, but I once again find myself wondering about the
> value of this translation.  Is there anybody out there who cares about
> it who could fix this up properly?

Hi Jon,

Both zh_CN and zh_TW were fixed on
https://lore.kernel.org/linux-doc/20220714054013.214031-1-alexs@kernel.org/T/#u

Sorry for the issue

Thanks
Alex
