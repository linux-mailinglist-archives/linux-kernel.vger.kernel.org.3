Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214AF4C13DC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 14:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240837AbiBWNRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 08:17:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234560AbiBWNRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 08:17:01 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C0F271A;
        Wed, 23 Feb 2022 05:16:34 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id i6so15267905pfc.9;
        Wed, 23 Feb 2022 05:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+VpbJdgqUesqeroMLeLdo41RKTiOXezLGeN3mJqa6AQ=;
        b=iUvdBHxfl/IXUeOyKcobXaHA4/Uui6w4QmrR1sDVIXKpW9bpixs67q5R/kp79ON6X7
         v1ihBIsTPYVOriWKquuyFfyfvb5isNaoDuPu5moMuDl53dX5M2aiFxezY3tSHoiyarIP
         ENDuLHk4AX0ZG0UJM11+DvunOSqkvoKUKisSs86whvR8t+Sgkcgi5XwwQ/RGJBFPnjoI
         uIOdptXEp31b7s6n6sij4zK12sE9E3EW4iql4q3SjrQeij9KuLmHkk5Ipa4ssoz+CzNv
         0z40hwf5gPfLV7aQUqOWstvrw8TCbRRNo4P+7YOSdhbqrchceN+zdenUlmF8UqMq5Wlg
         75QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+VpbJdgqUesqeroMLeLdo41RKTiOXezLGeN3mJqa6AQ=;
        b=3UbEiY7ldbIZTB26HKPle+VbI/C9WpsNKY4q/nLl/X02Biak6PGZX6KUpQv2Nj0Aj4
         tcabE7rwDkodrvZN8lSPXVbTsXNDYDTj0K8DABXW2W+9wM5wTEAVyc+hq+TfV3TzJGSE
         QUHioKFOiSZ0FvOmNdNdXHdBR6S7O2m5fjPUS6cpBq/hFUqsoSUmzhuchW5BBdiPRElo
         maj3Ck3Z7C7cTFlc209Fdc9+ppfhocfCl8kAr+N8UPEt7X8P0XmlB03eJxbBFK8nMfwr
         C2QwmBqhWOwSUz8vGECrU2gxByXYRoWctSmld8u8uPmqjvCV96KzNlPieMJmacVk/lQY
         6w8Q==
X-Gm-Message-State: AOAM533wd4XaNipwY6UpXvrb75MwixcRiav0LlmeLIC8VnWzAchdW4XK
        IfpTrux6REcpDYVh0n2GZ3ZGfmTt8fI=
X-Google-Smtp-Source: ABdhPJziEkZjFZEH9VUtfRZLLq2DxDDuDoTPhQ/YRirZW67cOz7qqkexo9nD2IeXWkNobvhOt6d1UA==
X-Received: by 2002:a63:ac58:0:b0:373:9e90:3b7a with SMTP id z24-20020a63ac58000000b003739e903b7amr23172651pgn.262.1645622193486;
        Wed, 23 Feb 2022 05:16:33 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id n15sm24173903pgd.17.2022.02.23.05.16.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 05:16:33 -0800 (PST)
Message-ID: <1abcb226-dbfd-b3d2-5453-208af7faa0c2@gmail.com>
Date:   Wed, 23 Feb 2022 22:16:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 00/11] Transform documentation into POD
Content-Language: en-US
To:     =?UTF-8?B?VG9tYXN6IFdhcm5pZcWCxYJv?= <tomasz.warniello@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
References: <525f3696-91f4-5a4a-c9ef-24758ccaa2bb@infradead.org>
 <ff98f455-0221-7ff0-08ed-8dea9f08694b@gmail.com>
 <939ef119-8a84-9206-bd7c-cfd215bb0200@gmail.com>
 <20220223135548.27babd85@fuji.fritz.box>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20220223135548.27babd85@fuji.fritz.box>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Feb 2022 13:55:48 +0100,
Tomasz Warnie=C5=82=C5=82o wrote:
> Hi Akira,
>=20
> Take a look at `man perl` and you will find a synopsis also.

When I do "man perl", I want to see a detailed explanation, and
somewhat hard-to-parse synopsis is ok.

I'm saying that I don't like to see such a thing when I type
"./scripts/kerneldoc -h".  I expect a hint to recall which option I
should use.  I don't want to scroll back the terminal.

It would be nice if the verbose man page can be shown by
"./scripts/kerneldoc -v -h" or "perldoc -F ./scripts/kerneldoc".

>                                                              It's simpl=
y
> better in depicting grammar relations than a flat switch list. Especial=
ly
> when the grammar gets complex. I dislike it also. And I don't think it
> looks good. Rather creepy and overwhelming.
>=20
>>> I don't see much point for such a non-user-facing script having nice-=
looking
>>> well-structured documentation in the first place.
>=20
> You're touching the very essence of kernel-doc here. What and who is it=
 for?
> Not just the script - all of it.

Sorry, I have no idea what I am being asked.
Could you rephrase above for a non-native speaker of English, please?

        Thanks, Akira

>=20
> Regards,
>=20
> Tomasz
