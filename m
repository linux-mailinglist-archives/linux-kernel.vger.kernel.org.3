Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF76589932
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 10:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiHDIUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 04:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiHDIUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 04:20:53 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668FA3AB01;
        Thu,  4 Aug 2022 01:20:52 -0700 (PDT)
Received: from mail-ed1-f53.google.com ([209.85.208.53]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N8EdM-1nOIs61twG-014FpX; Thu, 04 Aug 2022 10:20:50 +0200
Received: by mail-ed1-f53.google.com with SMTP id x21so11612884edd.3;
        Thu, 04 Aug 2022 01:20:50 -0700 (PDT)
X-Gm-Message-State: ACgBeo3qCmGHQGzcvgoJdXArzBVHGmnEA1nCoDC73XO80bdiUxotmdZl
        ig2Hzrl7zhfprhTiDujORZFeobIyrElvkwtKtho=
X-Google-Smtp-Source: AA6agR7ORd4KG70Wl6o+kC+rp/r699AlqLFWL5ilATI+FmhJqlWv+y3TjEWa+JxU89xcC5qihPbX1bcO7QpZWyS+A3Q=
X-Received: by 2002:a05:6402:3495:b0:43d:d76e:e9ff with SMTP id
 v21-20020a056402349500b0043dd76ee9ffmr867116edc.227.1659601250156; Thu, 04
 Aug 2022 01:20:50 -0700 (PDT)
MIME-Version: 1.0
References: <Yutv/mvLNJRgDtOu@kili>
In-Reply-To: <Yutv/mvLNJRgDtOu@kili>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 4 Aug 2022 10:20:34 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1ychAteScPbzGymM3UOinxY93rVnGeLsLOggmsRCBB+g@mail.gmail.com>
Message-ID: <CAK8P3a1ychAteScPbzGymM3UOinxY93rVnGeLsLOggmsRCBB+g@mail.gmail.com>
Subject: Re: [PATCH] char: mwave: fix return type in ioctl
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:TN+J7Wq+V2PslLkxNsf8Y78M+zZwnuWMeT/T+ot06rKABXviwbG
 kBkWyHZIRByjeDg5sCOfdwFIn8ceD5cFNKeQK5LCB2QM1cA+lLuLu2Oqcm7VMvz1ozFjMwF
 4Y1yzoz8OpM3R002wix1DyVoX2elchLD5BXmDPLongTy1iuHdJMTmk31dSz0nYf+Ahne/VG
 gyNE4vEZpgUdGbxZRcjUg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xgGf8izmgKk=:DJGUoyILIyL6E+UPHoxjmW
 LmGFYAcmUTBRxQafbHO9NxdqJ3VawqkB1tfIBCmmmPQiP5BtpIc1MnG4SeXPHC6kNVGDLWXM6
 HsaGyb7Ioy8Y9Oq3tAfKdekP/kp9FfRv9mZC1JYMidIv3+1H6FSAJpYGleIVXorVTtzLswQ24
 WAjrtG2PeBwcqRKYTOgb6XrV5ojW3bvvvg/8190jHEl++9eafCMArWg4eCqTSD5DgvmhTZgf+
 pUQogNoqpuClvoVQu7l6aNpqfyEf2/L4fJQIkwMpYhA2flbLLekp+HlSzIvJvqfpNiFqPxhP8
 4ulq36GmEapWA/hSvG5IXydIlepIc+d/Ue7sqaUltGhBSEi5lbSUohUUX+D37BlB2BjNTijc5
 vGUmvLReU/8wWAfPOP0BKNnY+fSVlB5/COaC6J01PepT9YIP3LrY2RpdFiBoCLAKy9cfXyyNI
 xn7zmWmjcrcScwc2Ndx3U9RM9W5wzItL2Q/Sf9meGY8uxR/Rwr8US7qoOLedFB0amG8yEmIMv
 GQCcgW1VqzGCPp4R7mPuK++3FrbOz1BMGaggzUXcMdMTGYS2YB7WWKT5JJzk9t4mgHBHcb9Yk
 9k+PpauLNBGiYdZLqTQEiehtDy5Fdk1muKoYX5D6WnEATvJ+sloXqEZOAuPMQF7dF0Vl2fVhp
 JHCOWk/+JHDDQwD3t2Ob1BLpswQ0aRC6p7S7XTANaJZxvXrPf5BlMYg1jbYZHhwWr1E5rgH4y
 06t70wMExJnm7MTLrT/0CAmSck9ONAdt3dSUWUAOvjZNmq2snD7VvXFa8J4XwRigToT5F3EmI
 D1cxDnNYzHbUUxzCp5XJcGB3o+ZFRb5b4uO1SmfQRa+dUMcZbOEAKoskpiIrH07V6mji6Im0l
 E1PkB1FRUeZEi0XTDc2A==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 4, 2022 at 9:06 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> This function is supposed to return zero for success or negative error
> code on failure.  Unfortunately the "retval" is declared as unsigned int
> and the function returns type long.  That means that on 64 bit systems
> it will return positive values on error.
>
> Fixes: 909d145f0dec ("mwave: ioctl BKL pushdown")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> The Fixes tag is sort of debatable.  "retval" should have always been
> declared as an int.  But the BKL change is when the return type for
> the ioctl changed from int to long, so it's when the bug started to
> affect user space.

Nice catch, I wonder how many other drivers I broke in that series.
Have you gone through my BKL commits from that time period
to see if any others are affected?

Acked-by: Arnd Bergmann <arnd@arndb.de>
