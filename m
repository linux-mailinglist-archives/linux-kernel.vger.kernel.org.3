Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1B450ADD2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 04:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443306AbiDVCiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 22:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245153AbiDVCiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 22:38:10 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C57C4B412;
        Thu, 21 Apr 2022 19:35:18 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id z16so6687188pfh.3;
        Thu, 21 Apr 2022 19:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:to:cc:references:subject
         :content-language:from:in-reply-to:content-transfer-encoding;
        bh=jD+K1WkYJnDTBHBCP/EPU0SMGi2nP553lkds/fydb8g=;
        b=nSQEeIFsHgVF9fS80AyNUBl92gHuRpGumy0vP5oGAn40B/2OoBJGYcujPc/Bh988Oz
         KM8eSm65Vj6DrdoVEIG5v10ZkwkB0MJBNFAanwW+gpPCcXLLnGbUK0zwp0MH1jrRwKM3
         C4kzelMXqMX/aUShl8Yzqo8Z1+b3ztAuJ2Bw1Q2+RxtoPK88Cj6y5bPP/Ve4KnTxu1Sl
         9ujRIqSQLu5dktiriNWoXDxlLpRZrCs8mjq0m1D3jgdj4KTn+sZKI26R4Q4CpLadKCIn
         Z80yJKvjvsKfOWpZ+x6zt2IGh5Rq3cN6Qeu0D+ItWJlw5Ct+X8ia8aMtzSiNkC3wLuSc
         Gjag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:to:cc
         :references:subject:content-language:from:in-reply-to
         :content-transfer-encoding;
        bh=jD+K1WkYJnDTBHBCP/EPU0SMGi2nP553lkds/fydb8g=;
        b=Jifyr0/Yi+ynIfZ71H5nKR4q/yKAzTULROtdRUa1SmbwsLr+NmHnGYTnZdJJ3tMknx
         DFepASLKlu0w9OIbWT22u6nXm8IfpuRXKKNtbmVbRBkouWqK/Gk5aRMns9rB2HCf5ow8
         uJ6yZgq44JnULiDY34sCehI63lQdBk940immq0eglXMj8ZQQvEPzFfL8ziYL3e0UA39O
         /te78YM3WPySXtR3bMA+QLrdoYKACRAE+YVYRyBy9e3pOnz8vYoFFyk/GudJnf8OTid5
         UKi4qv7fJjqxN5+UbFlrldC6DU9cOcF6kiShHr2BImkNLX2sGKWp5PEjvEFgvh3daZxB
         trPA==
X-Gm-Message-State: AOAM5311mGBxufGIuPdIxEQwing3ub0EAd0R2sAV/Yo4OXGe7mzk+tu2
        KXmGlFL/hqcD2mOX57Tzwf8fPnuVkc0=
X-Google-Smtp-Source: ABdhPJxE+6oysZTN4g1bhJxaWkhWFOwPI9HU4tiQP6ga/qeJZpkGgyGFdbRSW2t/weZ0JZybB9QPlw==
X-Received: by 2002:aa7:9882:0:b0:50a:777c:d107 with SMTP id r2-20020aa79882000000b0050a777cd107mr2647245pfl.9.1650594918105;
        Thu, 21 Apr 2022 19:35:18 -0700 (PDT)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id c17-20020a056a00249100b00508389d6a7csm476384pfv.39.2022.04.21.19.35.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 19:35:17 -0700 (PDT)
Message-ID: <0ce6944a-2328-90b1-a315-4a834bb8e367@gmail.com>
Date:   Fri, 22 Apr 2022 11:35:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
To:     baihaowen@meizu.com
Cc:     alexs@kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, seakeel@gmail.com,
        siyanteng01@gmail.com, siyanteng@loongson.cn
References: <93467d50-8ffb-0fb7-cafb-60eb2dd44130@meizu.com>
Subject: Re: [PATCH 0/2] sync with original text
 Documentation/vm/page_owner.rst
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <93467d50-8ffb-0fb7-cafb-60eb2dd44130@meizu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 22 Apr 2022 09:40:39 +0800,
baihaowen wrote:
> =E5=9C=A8 4/21/22 8:26 PM, yanteng si =E5=86=99=E9=81=93:
[...]
>> I'm not sure why, your different versions of the patch are in one
>> thread and they look like this inside
>> <https://lore.kernel.org/linux-doc/>=EF=BC=9A
>>
>> [PATCH V3] docs/zh_CN: sync with original text Documentation/vm/page_o=
wner.rst
>>  2022-04-20 12:46 UTC  (22+ messages)
>>     ` [PATCH V4] "
>>             ` [PATCH V5] "
>>                   ` [PATCH V6] "
>>                     ` [PATCH V7] "
>>                       ` [PATCH V8] "
>>                           ` [PATCH 0/2] "
>>                             ` [PATCH 1/2] docs/zh_CN: "
>>                             ` [PATCH 2/2] doc/vm/page_owner.rst: Fix
>> table display confusion
>=20
> I always reply mail using below method:
>=20
>   git send-email \
>     --in-reply-to=3D'CAEensMxtk8zJPAM-u7hvYkaNTBrVdmhKA7YzVsKmTw0TcOE=3D=
Pw@mail.gmail.com' \
>     --to=3Dsiyanteng01@gmail.com \
>     --cc=3Dalexs@kernel.org \
>     --cc=3Dbaihaowen@meizu.com \
>     --cc=3Dcorbet@lwn.net \
>     --cc=3Dlinux-doc@vger.kernel.org \
>     --cc=3Dlinux-kernel@vger.kernel.org \
>     --cc=3Dseakeel@gmail.com \
>     --cc=3Dsiyanteng@loongson.cn \
>     --subject=3D'Re: [PATCH 0/2] sync with original text Documentation/=
vm/page_owner.rst' \
>     /path/to/YOUR_REPLY
>=20
> link previous

You are not following the recommendation described in
Section "Explicit In-Reply-To headers" of
Documentation/process/submitting-patches.rst
(or "15) =E6=98=8E=E7=A1=AE=E5=9B=9E=E5=A4=8D=E9=82=AE=E4=BB=B6=E5=A4=B4(=
In-Reply-To)" in
Documentation/translations/zh_CN/process/submitting-patches.rst).

        Thanks, Akira
