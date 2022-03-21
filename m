Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A7B4E234F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 10:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343793AbiCUJ2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 05:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233695AbiCUJ2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 05:28:38 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A674F479
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 02:27:13 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id h1so17038281edj.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 02:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=lFsDWl+VJdRlH1sYqyaS7hLxexcdMEqqhguN78mfy8c=;
        b=dC0lgqZosvcUacMyEqwuW0ThHJ/D8J1xh/TRRKdTaooqxUcUYptD0K+yYArEJf3H/j
         xXIWQF9ijHb8L8hyx3uv0m4EtG8YMXlOi4ODzlF4+AOND4m8vETjo0oYLDb2MLJNKKyR
         mQ1Z0AyJK86dnEdxOMJxrLknU0zo0VMcqtyaYMA2l8AvR0BpMmMf9URZFaFyEnLGmJha
         1QERrkE6Qk9LOcpQWLgT+yGRYRg6x3h6rFA6fw9n1jW7c2Ssl0PR8YTXS4zu02lKxl1A
         7XZOyv9YD4eYY7f/lgWQbyDCf/yqeKu1Jnzy180i3zfPxeuBd8+HpWWeT0JFg/01QA18
         Um5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=lFsDWl+VJdRlH1sYqyaS7hLxexcdMEqqhguN78mfy8c=;
        b=CCbiCuhUebLDTXS7V/SYxdQfZ9LPM++YJlaJzVUIXN4TfZKzhSguhEPzP2LD3xJNdZ
         iE92M4ymyyynoH8MFADRo4g5igH6r2Dsi5GbR8B1VkgxHsAblmYU6wg46xU9dzTBdlBD
         ek9BkwNq2PfaohoUdjNNJvZur95FUOAXbjd429gEph7iqE+fNxSBv17lDWZeny8D6TdM
         PQXzzBwqBZUd1p0S9Vgz0Lq65kSZH0/1oBMysinDMU1aTOMdihQ8GNu9pS7LTLLZB4Xm
         DriefkxO1+m3G6SpNTEmEVSCW4QArExu61X55NuM1YjvRHfATR5xATZZmPkYu6OuhsQj
         bfwg==
X-Gm-Message-State: AOAM532Av+QmSzgIeoHYH5pggbysKs8y1qSCecWtoHz/xjA3WQLN2oW7
        PEQa2gDhPCzyK3OOwOUyY78=
X-Google-Smtp-Source: ABdhPJzRs23bgn/uEHK3maxGciOp0ZhqC5tIWli5C8r3oBZ6fKGbzendUzVLC+nR+wC1Q+v4tPr1MQ==
X-Received: by 2002:a05:6402:4247:b0:419:3990:3db6 with SMTP id g7-20020a056402424700b0041939903db6mr4593102edb.193.1647854832264;
        Mon, 21 Mar 2022 02:27:12 -0700 (PDT)
Received: from smtpclient.apple (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.gmail.com with ESMTPSA id l12-20020a056402028c00b00418f7fc4bd8sm6133003edv.91.2022.03.21.02.27.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Mar 2022 02:27:11 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [PATCH] staging: greybus: codecs: fix type confusion with
 dedicated list iterator variable
From:   Jakob Koschel <jakobkoschel@gmail.com>
In-Reply-To: <20220321092132.GI3293@kadam>
Date:   Mon, 21 Mar 2022 10:27:10 +0100
Cc:     Vaibhav Agarwal <vaibhav.sr@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        Mark Greer <mgreer@animalcreek.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mike Rapport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Content-Transfer-Encoding: quoted-printable
Message-Id: <56102C8D-DBFF-43A5-9641-04577F01AB6D@gmail.com>
References: <20220319202058.2518847-1-jakobkoschel@gmail.com>
 <20220321084844.GG3293@kadam>
 <23587784-B0EB-4FDD-B5BC-DC1B16404DA7@gmail.com>
 <20220321092132.GI3293@kadam>
To:     Dan Carpenter <dan.carpenter@oracle.com>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 21. Mar 2022, at 10:21, Dan Carpenter <dan.carpenter@oracle.com> =
wrote:
>=20
> On Mon, Mar 21, 2022 at 10:06:13AM +0100, Jakob Koschel wrote:
>>=20
>>> On 21. Mar 2022, at 09:48, Dan Carpenter <dan.carpenter@oracle.com> =
wrote:
>>>=20
>>> The subject says that it fixes a bug but it does not.
>>=20
>> Thank you for your review!
>>=20
>> I don't agree that this doesn't fix a bug:
>>=20
>>> +		}
>>> 	}
>>> 	if (!data) {
>>> -		dev_err(dai->dev, "%s:%s DATA connection missing\n",
>>> -			dai->name, module->name);
>>=20
>> Using 'module' when data =3D=3D NULL is *guaranteed* to be a type =
confused
>> bogus pointer. It fundamentally can never be correct.
>=20
> Ah.  I did not read all the way to the end of the patch.
>=20
> The bugfix needs to be sent as it's own patch.  Just the one liner.  =
It
> needs a fixes tag as well.
>=20
> [PATCH] staging: greybus: fix Oops in error message
>=20
> The "module" pointer is invalid here.  It's the list iterator and we
> exited the loop without finding a valid entry.
>=20
> Fixes: 6dd67645f22c ("greybus: audio: Use single codec driver =
registration")
> Signed-off-by: You
>=20
> 	if (!data) {
> -		dev_err(dai->dev, "%s:%s DATA connection missing\n",
> -			dai->name, module->name);
> +		dev_err(dai->dev, "%s DATA connection missing\n",
> +			dai->name);
> 		mutex_unlock(&codec->lock);
>=20
> We're happy to apply the other stuff as well, but we don't mix =
cleanups
> and bug fixes like that.

ok great, I'll separate and resubmit both. Thanks!

>=20
> regards,
> dan carpenter

	Jakob

