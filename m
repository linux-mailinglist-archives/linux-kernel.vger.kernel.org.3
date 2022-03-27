Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1178B4E8708
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 10:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbiC0IwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 04:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbiC0IwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 04:52:05 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825FF193E2;
        Sun, 27 Mar 2022 01:50:26 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id l129so1410125pga.3;
        Sun, 27 Mar 2022 01:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=KDCMuuDQX9Mk03+k/luGIpkllIh0BseCRuZMYg4QBhE=;
        b=bF0Xc3uY4jKCFIsekknhKJ1qWSKcPHC25x76rwoIPMc7W3nOL1Ddii32xAZmxcDn4O
         /Cu7e2/3CuivFp9QxY54bjAv6jhPhBdZCRzwokmfli0+cYxKLbitO0AgtToobC/CeTRe
         5AHy18yQLb6w4bOY6VtIKYoIUHcAKd6ZJ808+Z5i3aiB92d707wXLLIiIAFxUcxqG0ID
         vTRuTwWwqBFBFjNgj4R4OBYwfPMAKjMWkD8Zm5UfKY57wWP23Fi+phIxjP7Dx9xG+P8S
         ZeQuQNbBWlp57dfsE2ZmTaZWRavkA2jguAoHxJVwLvIPj4Uwy34o4eMv5HAS+UrKHIhV
         BRWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KDCMuuDQX9Mk03+k/luGIpkllIh0BseCRuZMYg4QBhE=;
        b=lSasgskiB/l0jG07T/gSEGABFh18OHtFoJcMuULyXIlacBIzHFbPsLmy6I1lObeQSo
         yGqmMIQ6ack+bT1sWjqcA1xGtEicHTK3k/zoPnKkHgY7QrX5XfZM6oBTs8kojgn7QiOU
         Re7OA6DwiJiLuhUXRVm8Ynxc8ijO4kFbtt2j+RVuHw44ExEtq0F4ZciyotYEsS5blmX7
         q0YOHIvY6YBEV6AGxUVHyZTKJk9qWEuBwg/1oSn60AzsgR4CaEzswi689/Nzdhw2Mh52
         3OFeTyBW4KrV99VLt+SG7kxpKjRzSR3htiWuw2ItLTEvsb+EOyTO7hclFeHTjKn/o14e
         HFvw==
X-Gm-Message-State: AOAM530tQXTt3rvPOp1WnGMsi3mj+jLylLnmV5CExxmk75nreIk/vo+t
        0XpYdbL7NP37feIiX0pM82Q=
X-Google-Smtp-Source: ABdhPJw56wj2lDzzaannn1dHBGqq+qN3VLtID5GBUIIvrg4PF8C8uihnSgEaAznPLnzrTV7b1ckdhg==
X-Received: by 2002:a05:6a00:1687:b0:4e1:45d:3ded with SMTP id k7-20020a056a00168700b004e1045d3dedmr17666708pfc.0.1648371025936;
        Sun, 27 Mar 2022 01:50:25 -0700 (PDT)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id ml16-20020a17090b361000b001c6c9141b0csm10755189pjb.45.2022.03.27.01.50.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Mar 2022 01:50:25 -0700 (PDT)
Message-ID: <63efab39-68aa-f4c5-1d5d-d708188eb7b0@gmail.com>
Date:   Sun, 27 Mar 2022 17:50:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/2] Documentation: kernel-doc: Promote "Writing
 kernel-doc comments" to page title
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
References: <20220326123337.642536-1-bagasdotme@gmail.com>
 <20220326123337.642536-2-bagasdotme@gmail.com>
 <20220326145332.0698a849@coco.lan>
 <49829de5-efe5-9065-d87a-2494d16b9465@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <49829de5-efe5-9065-d87a-2494d16b9465@gmail.com>
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

Hello Bagas,

On Sun, 27 Mar 2022 12:27:20 +0700,
Bagas Sanjaya wrote:
> On 26/03/22 20.56, Mauro Carvalho Chehab wrote:
>> Hmm... I can't really see any differences... What this patch seems to =
be
>> doing is to just change the markups for each level.
>>
>> See, on Sphinx, the first markup (whatever it is) is level 1, level 2
>> the second different markup and so on.
>>
>> So, before this patch, kernel-doc.rst had:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0level 1: Writing kernel-doc comments
>> =C2=A0=C2=A0=C2=A0=C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0level 2: How to format kernel-doc comments
>> =C2=A0=C2=A0=C2=A0=C2=A0------------------------------------------
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0level 3: Function parameters
>> =C2=A0=C2=A0=C2=A0=C2=A0~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> And after it, it will have:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> =C2=A0=C2=A0=C2=A0=C2=A0level 1: Writing kernel-doc comments
>> =C2=A0=C2=A0=C2=A0=C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0level 2: How to format kernel-doc comments
>> =C2=A0=C2=A0=C2=A0=C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0level 3: Function parameters
>> =C2=A0=C2=A0=C2=A0=C2=A0----------------------------
>>
>> No semantic changes at all.
>>
>> The only (eventual) value of a change like that would be to make the
>> levels more uniform, but IMO, it is not worth to apply a change like
>> that, as:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A01. There are a lot other documents that don't =
use the more commonly
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 used level standard;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A02. Making all .rst files to use the same defin=
itions is hard;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A03. Even if we place everything using identical=
 markups for every
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 level, as new stuff gets added, d=
ifferent (still valid)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 markups could be used on newer do=
cuments.
>>
>> Regards,
>> Mauro
>>
>=20
> Indeed, fixing heading levels when adding title heading is required bec=
ause
> without it, Sphinx will complain "indentation inconsistency" error.

I think all you'd need to do would be to promote both of two headings
of

    Title A
    =3D=3D=3D=3D=3D=3D=3D

to

    =3D=3D=3D=3D=3D=3D=3D
    Title A
    =3D=3D=3D=3D=3D=3D=3D

, namely "Writing kernel-doc comments" and "Including kernel-doc
comments".  They deserve their own chapters in PDF.

As Mauro says, such changes won't have any effect on the resulting
pretty-printed docs.  So I'm afraid I don't see any point in 1/2.

        Thanks, Akira

>=20
> Maybe better splitting indentation level changes into its own patch, ri=
ght?
>=20
