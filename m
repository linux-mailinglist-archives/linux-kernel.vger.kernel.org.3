Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17BB4584932
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 02:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbiG2Apo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 20:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiG2Apm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 20:45:42 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E573796BD;
        Thu, 28 Jul 2022 17:45:37 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id z19so3234560plb.1;
        Thu, 28 Jul 2022 17:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Yv1PtdcD7vG4XonP5wiRklbkcOgrxKWB5amAdWZBrU8=;
        b=q7G5Nkzmq7URRivyuyip625fFmr7aCadj3OeknjknvbUGmgE/R5e7JeqsumKpzgxLm
         fCmGiL2DWTOlBVEb5tSlW62HGMJRNvBTzKlJ2okH8gFpHqSbuayC1HmLvYfTWIuOMu4e
         GB3lnA3y7ub9B+ks0m6e6GRPFS9Mm6FlS5eu+v400uuQHbcMLRS4nCmDOqhBQfSB1Ufu
         12SM/bYa2pWYxIDB0WvwnMpAgFhAQConKvX1M9HrXQKhV0SkTeYCEYymA2IEIxqBER6c
         AIv+JFRZjeTYCHhLhajf9CTmYGJ6qUUS2NiK8IMssD+GopMhgcOcIw3WMlLbSOkIbSWy
         e7ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Yv1PtdcD7vG4XonP5wiRklbkcOgrxKWB5amAdWZBrU8=;
        b=ICCbeyrSmf4gmIFoqbnN7O5fy3HeSzBwgkwkWDwys4gm5mclQEN+05sYCgOpLLt7n2
         /vw7/CxsysvDdak+qlzUceMVqBPDrEPKKuKGisljWQY85cZLQ1cbDq2eHhSxu6l0GtX4
         9A6LEb9uwmK1WR1hrHdfhz05vvv142mzAR/FR7EfWOLntuxpemuPfVIszbRXwH10w6/R
         KUeh5jO6dtx33eJSF1ZHkPrTKMAKZacoffD5KzVXz0YrOhFf+x8vXUBCbs7J6oAW8QO4
         aRgP6ebvm0yNQaCZZUi8rL9u1NKE1942LE4LZXaWkoDyD68YeNBt+hIVgVgpFeYhWxlv
         ywXg==
X-Gm-Message-State: ACgBeo0qVQBkbbJgCq4CgUWt0KB04cH8XQtq8IDw97PYZCAwEDIfH5hZ
        sUMs2lm0OIhfL1ywuyNbv/E=
X-Google-Smtp-Source: AA6agR680LUtpZw/1/PnvSyS9qa2Tk/Z2ka+nx33lF1adIOPPgGE3o9kj4Pm0wGY6tLfmUqbGyExUw==
X-Received: by 2002:a17:90a:fb4b:b0:1f3:1cbb:8912 with SMTP id iq11-20020a17090afb4b00b001f31cbb8912mr1953056pjb.239.1659055537031;
        Thu, 28 Jul 2022 17:45:37 -0700 (PDT)
Received: from [10.10.4.41] (125-228-123-29.hinet-ip.hinet.net. [125.228.123.29])
        by smtp.gmail.com with ESMTPSA id a21-20020a1709027d9500b0016c1cdd2de3sm1897761plm.281.2022.07.28.17.45.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 17:45:36 -0700 (PDT)
Message-ID: <d5f6a7e0-60e7-5afe-30c7-8ba76ab12a5c@gmail.com>
Date:   Fri, 29 Jul 2022 08:43:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 1/2] iio: humidity: hdc100x: switch to probe_new
 callback
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Patrick Williams <patrick@stwcx.xyz>,
        Potin Lai <potin.lai@quantatw.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220728125435.3336618-1-potin.lai.pt@gmail.com>
 <20220728125435.3336618-2-potin.lai.pt@gmail.com>
 <CAHp75Vf+4Ew2eaccPb3sQY4wAjjsqR7o_uyTUb7eguY=JeDtQA@mail.gmail.com>
From:   Potin Lai <potin.lai.pt@gmail.com>
In-Reply-To: <CAHp75Vf+4Ew2eaccPb3sQY4wAjjsqR7o_uyTUb7eguY=JeDtQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/22 04:41, Andy Shevchenko wrote:
> On Thu, Jul 28, 2022 at 3:32 PM Potin Lai <potin.lai.pt@gmail.com> wrote:
>> Switch to probe_new callback due to probe is deprecated soon.
> Just noticed that commit message is a bit not okay in a few ways:
> 1) we refer to the callbacks like ->probe_new();
> 2) we don't know when we deprecate it, the point here is not that, but
> unused id parameter in the current code.
>
>
Thanks for point it out, is it OK leave the message as it is? or you prefer to submit another version to fix it?
If new version required, I will also add another patch for struct device pointer you mentioned in the other reply.

Just want to confirm that is the new message looks OK?
New message:
Switch ->porbe() to new callback ->probe_new()

Thanks,
Potin



