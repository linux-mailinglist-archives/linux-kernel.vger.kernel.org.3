Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945EA4E22EB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 10:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345672AbiCUJHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 05:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235161AbiCUJHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 05:07:40 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED619D06B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 02:06:15 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id qx21so28357233ejb.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 02:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=mt0VFhB/cCuPyGbbmavpLIyzsTNFvG4Vc/AfIj3zApY=;
        b=NmF37/lEaxfT5M2TGcYPyQIp9c0iopepl58SqhUvDu9K7LZLiOuaayFWTWseflPfsO
         JX7NDUoyGbjVXeIm3W8JbWd/4HDJ8tOLTCB63wZ6L8Nr+YUduPkGHzFfI1fiF9zqkT9m
         P3rPfvEoF5AmJnQtZWRXc2xgKq/pnaQmrewjS56TwrIr6tEJ8DZOTM538mc24TKZFmpE
         0k0bakJcvUSgedXhBQKYIyTpeKrtPfTstKfB/JNDF1h6SXHVu7s4trOgUoYY3YcQYqFy
         j1pSJ3xQF9LTlKY2oepQQ13IkmDkqnu7zYHM2IePJXV/q2+LOk8mgyLw0uqwztmMFagu
         QkuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=mt0VFhB/cCuPyGbbmavpLIyzsTNFvG4Vc/AfIj3zApY=;
        b=6NOgRUjse8gyDgOKpKjhQUORAzjMgMiGQRanjPlF3tpRcursAorNlW2JIZdiU2tk9n
         tBezzYRmrAgze6DXM7mME6LyqiEc5FyFwUNANWn9JJCVDSLt70OIe8xinY6El32Xv8+g
         jxNyXvz6D4pUGlGagtCibqtgTpezUE34EjjBnvmmSJCO7mXHuMkF5VVTpYlqO0k14X2W
         ofT2eFzsSK+FTwvsfqCSi3kgLdzA/U2PK+jLfZUkkOSjcPDFN1aa/zAaShoDmxISHX4k
         KUfZSvRO946Ba4n2EUxD/DdxCtE8sXQURuOLhLG+ljn0toQsSWnSB/8rmHYqFf91gjiY
         UTqA==
X-Gm-Message-State: AOAM531AbdLIDtM0YyLSDJESgusoUapiR9coa7cK7wcAmcNyRo2sQIpa
        Zn5JNgTfqCwsWgh9m2hZJLY=
X-Google-Smtp-Source: ABdhPJwVFF2qOVXbaAyFvG0JRg6aagD1KaDmyF5Ceu3CSRh8UkE/rrnLpGcJIX3kct91TcwxEhpPtw==
X-Received: by 2002:a17:907:7e97:b0:6db:c1ef:6a68 with SMTP id qb23-20020a1709077e9700b006dbc1ef6a68mr18932062ejc.475.1647853574492;
        Mon, 21 Mar 2022 02:06:14 -0700 (PDT)
Received: from smtpclient.apple (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.gmail.com with ESMTPSA id w19-20020a05640234d300b00416baf4cdcasm7771528edc.48.2022.03.21.02.06.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Mar 2022 02:06:14 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [PATCH] staging: greybus: codecs: fix type confusion with
 dedicated list iterator variable
From:   Jakob Koschel <jakobkoschel@gmail.com>
In-Reply-To: <20220321084844.GG3293@kadam>
Date:   Mon, 21 Mar 2022 10:06:13 +0100
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
Content-Transfer-Encoding: 7bit
Message-Id: <23587784-B0EB-4FDD-B5BC-DC1B16404DA7@gmail.com>
References: <20220319202058.2518847-1-jakobkoschel@gmail.com>
 <20220321084844.GG3293@kadam>
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


> On 21. Mar 2022, at 09:48, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> 
> The subject says that it fixes a bug but it does not.

Thank you for your review!

I don't agree that this doesn't fix a bug:

> +		}
> 	}
> 	if (!data) {
> -		dev_err(dai->dev, "%s:%s DATA connection missing\n",
> -			dai->name, module->name);

Using 'module' when data == NULL is *guaranteed* to be a type confused
bogus pointer. It fundamentally can never be correct.

If I should still change the wording please let me know.

> +		dev_err(dai->dev, "%s DATA connection missing\n",
> +			dai->name);
> 		mutex_unlock(&codec->lock);
> 		return -ENODEV;
> 	}


> 
> On Sat, Mar 19, 2022 at 09:20:58PM +0100, Jakob Koschel wrote:
>> If the list does not exit early then data == NULL and 'module' does not
>> point to a valid list element.
>> Using 'module' in such a case is not valid and was therefore removed.
> 
> This paragraph is confusing jumble words.  Just say: "This code is fine".
> 
>> 
>> In preparation to limit the scope of the list iterator to the list
>> traversal loop, use a dedicated pointer pointing to the found element [1].
> 
> This paragraph is the information we need.  Just add something like
> "This patch has no effect on runtime".

As mentioned above, this code effects runtime (in one out of the two cases).

> 
> regards,
> dan carpenter

Thanks,
Jakob

