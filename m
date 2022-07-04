Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE80564B22
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 03:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbiGDBVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 21:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGDBVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 21:21:40 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCF9631E;
        Sun,  3 Jul 2022 18:21:39 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id 128so7596626pfv.12;
        Sun, 03 Jul 2022 18:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=G8Z3RSTP4w/kjFOxzrBKbneGz9gqfhb7U77qQZXOweA=;
        b=MQVsVVVh1OmUCFttkh5LZ9E5RQTWNXMyhMh1JOIzQP4riL/0Huyr77Uu1hDP10h0Du
         cGCEWY6o21L/nBSHDsMRK4M+CRVdVNeg1FDPRn0QLLBa53AoGSQpryadGovCZwk5abKE
         TjRu82RokAUDW2MWeVvYNzejHk2F13xct7cOn2DvbsSBwcpWOmNhU17uSqTLTiA5pFPM
         v9i5hybSPmVmNsi8GTWoKCsUU7TgnSpFCtkIuZqsI75gjdKy3lldR+ZS7fvqc2e22AZl
         y/HgxpfV43Etyby6ufg2cPTxjM/zRl64DtR98A43mEFZ76BfKcGDpMnrx8VaQB58+FhJ
         AhsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=G8Z3RSTP4w/kjFOxzrBKbneGz9gqfhb7U77qQZXOweA=;
        b=b9L3z/81dIWr7EzDpYfLs1n40YtS19WxiGBgD8vlIKTCKUSgjGoW86qHZw+JWRbYbM
         KhNzz3pFecPj9fJAO5WMLTJBpsvp3XPKKQkY8y+zt84IHr9pu2MzvnLWBPW/cXWsexPl
         9+8HFtkeAVHH7g76e2WP+VUr7jNsTDzoPn0X6U2dSfsO1yKl9k8DEgJxy8BmjGltT3oO
         mutv2eIC3UXPYo5+5669G0XPlXKxrHb3JzGors0fXQ5GySQTfMlzwnI3i0ZPQYkpdFSF
         sSHmXR7vFn8tgdar+z3iiwvBjcorVlDKfBDWESG5rvtu6Qz/0vn2GSIKwDNwjZqNVJj5
         nNaQ==
X-Gm-Message-State: AJIora9Jv0Rxx9V4i6F5YQR1L37/qoyJ0/Oe//WnAUSrJ7MLxtZ9LXBC
        o8HJKI4Fm0BEKZEz69LeyXs=
X-Google-Smtp-Source: AGRyM1vIfvQK3Yun3KvOckM4RqwqR8J3MVZeGBkspU5gZPPI6oohuENz+hUR3jmLX2qNhFKRbRe+0g==
X-Received: by 2002:a63:100d:0:b0:411:8781:121a with SMTP id f13-20020a63100d000000b004118781121amr21432842pgl.583.1656897698984;
        Sun, 03 Jul 2022 18:21:38 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-80.three.co.id. [180.214.232.80])
        by smtp.gmail.com with ESMTPSA id nk3-20020a17090b194300b001ef8407f6d2sm1487933pjb.46.2022.07.03.18.21.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Jul 2022 18:21:38 -0700 (PDT)
Message-ID: <6648dbad-c3f0-a549-af91-a5e19b55ef48@gmail.com>
Date:   Mon, 4 Jul 2022 08:21:32 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [v6 14/14] docs: iio: add documentation for BNO055 driver
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     kernel test robot <lkp@intel.com>,
        Andrea Merello <andrea.merello@iit.it>,
        Jonathan Cameron <jic23@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>, kbuild-all@lists.01.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        jmondi <jacopo@jmondi.org>
References: <20220613120534.36991-15-andrea.merello@iit.it>
 <202207031509.DlBrHyaw-lkp@intel.com> <YsGVa8KFmdvGY92e@debian.me>
 <CAHp75VfDYRZMiz4j9KN5+ZJnudT0jfh-o_f7HBk5yc+FHqvXZg@mail.gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <CAHp75VfDYRZMiz4j9KN5+ZJnudT0jfh-o_f7HBk5yc+FHqvXZg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/3/22 21:00, Andy Shevchenko wrote:
> On Sun, Jul 3, 2022 at 3:11 PM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>> On Sun, Jul 03, 2022 at 03:58:15PM +0800, kernel test robot wrote:
> 
> Please, submit it properly.
> You may add my Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> (I deliberately put it on a wrong line so no tools will catch it up
> with improper commit message)

OK, thanks.

-- 
An old man doll... just what I always wanted! - Clara
