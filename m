Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74F84C14E8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 14:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241307AbiBWN7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 08:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241290AbiBWN7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 08:59:34 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94939B0D01;
        Wed, 23 Feb 2022 05:59:06 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id i6so15372972pfc.9;
        Wed, 23 Feb 2022 05:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=X6Dow0Ktg3f7s9R18PXLBZ+c8Wk6NqWpU+XTTN91E7I=;
        b=RX18hLk8t4yl1UuCrwmxyKV6FBLuOZ3CuRlfI8mh5eLsCRMcu7yYNlt4TqZChs1x90
         YIF1QcDiax/U7D1b/RxbvjQRQTVmNorNcAm2EjluWo36Ky98SoJ2mDVvniaWOCHo0wLo
         MrSTyWM6L8qAmA0oII5XoNSDDIfmKZ1oIHE6ZxTnfimKV1g7qwJDZEPJc1+Qj1H3XeUV
         95ooAE+V+bgUjidm2NmsrNzjbPnQ2qE0ciZ43KufM6ki9Tm8fFXAxzDBPAfPRpo1zW8m
         aSUj24sOun3OrPu5xgc0aLDj+s2zNX1RKkjE4Hee5BEkzB+pQddCpFs7pxkuuYgKii0X
         +jQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=X6Dow0Ktg3f7s9R18PXLBZ+c8Wk6NqWpU+XTTN91E7I=;
        b=lvjDaKvMBZp2IcJyLbWNz07OPbK82E0akO96AGAURRKt4qJNAlt5WM2BmVlcpgMv51
         y+M62v40Qm87mHcV7NxgYs/bUUaWeXBEr7uyoD3K+iNdrJW0ZARNwYQRw9G5EpShUhoH
         x2vzzgjXv5BEZxr4t+ea5tIrMCHuPi73fHrOaizSZbWTPKp+OinmldiQCKnIY6XJRgX+
         rytk7U/uYbyyq7hpsPbkaRVNjTVXZj3dkvcSoUytEtdpDKwxZv7ZQp3PoquOo6TRA0mn
         CzFOCurOUtwCldRCPYGm/EcdmsTLw40rnrAJVCv8kPfLmvElOVkTGaDCGMaIAnSGsh5o
         Giig==
X-Gm-Message-State: AOAM530t1ap6bkfV1w6oF2Fq0r2l0yDHc66NG+4gGv3d6Q/BMRHih7IX
        Q4RvqJPEDwMcHZixpT2quP4=
X-Google-Smtp-Source: ABdhPJzh6lTbjHeHmAyasMYIQHn/EZf6R89kUL1gUNz+eL3VXPSutvjf0y7809cEOUpc8J6UGsMlOA==
X-Received: by 2002:a05:6a00:2405:b0:4e1:5008:adcc with SMTP id z5-20020a056a00240500b004e15008adccmr30100114pfh.35.1645624746021;
        Wed, 23 Feb 2022 05:59:06 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id 16sm24688182pgz.76.2022.02.23.05.59.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 05:59:05 -0800 (PST)
Message-ID: <721f860a-a662-0f0c-a82d-eacf80841eb3@gmail.com>
Date:   Wed, 23 Feb 2022 22:59:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] scripts: kernel-doc: Check existence of FILE arg
Content-Language: en-US
To:     =?UTF-8?B?VG9tYXN6IFdhcm5pZcWCxYJv?= <tomasz.warniello@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
References: <1c71e5d2-f87e-6c8e-6176-e5ce42e4d41b@gmail.com>
 <20220223144713.6e2284e3@fuji.fritz.box>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20220223144713.6e2284e3@fuji.fritz.box>
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

On Wed, 23 Feb 2022 14:47:13 +0100,
Tomasz Warnie=C5=82=C5=82o wrote:
> On Wed, 23 Feb 2022 15:07:30 +0900
> Akira Yokosawa <akiyks@gmail.com> wrote:
>=20
>> Currently, when no FILE argument is given following switches such
>> as -man, -rst, and -none, kernel-doc ends up in the error of (long
>> msg from perl folded):
>>
>>     Use of uninitialized value $ARGV[0] in pattern match (m//)
>>     at ./scripts/kernel-doc line 438.
>=20
> It's a warning not an error.

Good catch!

Will amend in v2 with proper attribution.

        Thanks Akira
