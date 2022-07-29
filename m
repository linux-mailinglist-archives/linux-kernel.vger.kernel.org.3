Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C03584B64
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 08:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbiG2GJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 02:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233773AbiG2GJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 02:09:12 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12347D7AE
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 23:09:11 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id w5so4564506edd.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 23:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=F15yzA8MEk1kj7dgO+uysf48NlZcdhWRCvVLxCtDqSw=;
        b=jCk1tar75x6j04emFxhPlViERasH7LFUp4nze8ZkzuOIhV7BuIQE5JqFeQtcp3Gfat
         2cl9sCTtG2RpbbFY8P7QoQqXtiTi/yCYFSWY2H5dqchS8pJ1Dz2et498/h9l24AH3AOZ
         xxBnewGeJwuDpVwIpIguKAJRlXSmmV4nKRjMyhQEkGNjcVrx1ezUYFuJ08cZmhIAPZg4
         ak887o0FdiyBf8hZaS31J0erT2dS78QK5//CIFAHNsK2ebtOse659shZEMcGElKe0BQS
         ziVOwRvKksYMxUSpQyYXzJJve4w92qOn+27wk3FNbECtMoGYtCaI5Y6jOUSLXfZzN42c
         ZzSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=F15yzA8MEk1kj7dgO+uysf48NlZcdhWRCvVLxCtDqSw=;
        b=4KUgcw03N7QzJ48PgtebrLDAwJgO2QcV0m8fh5ITqlPD7sP+PP14IZWF+BCwWGPVWW
         ssv3pTtpKNfE9q23XGmXNracTx4oPrd5ev5vkDIIjosGRgnMNIRwq9aG7074lqP31fvO
         X/CPZ0QLVOjltrfH0WJEDMESXQsVmhIz7PH62MlODaGlUTob+m/YTlohWv3rnXC+ogAN
         O9sve74CDGH3c6/1zXrLkdgfXt3G0+LloRrtLF9y1N0pNUYhKICfbjCMbrRbH2OZNvcE
         dCnI5/Z5Gx/XFVADtQZgiE1tJurSmgV04Tn+7mkv1HaXGCrGxVvJZzhR80AzskjB6xGe
         2Y4g==
X-Gm-Message-State: AJIora/r1HXcccqT7c+Z8MvXJ27U2qYCT2X3R+ITUrcOE7OOHcZzAxCl
        StkqQR8oMvcfW6AAJJfW0zU=
X-Google-Smtp-Source: AGRyM1sSSl5OUrnyQCEPGznn7Uyt5hmlABmTqUv4WVkkycUAYtiY4vbjGJRZa9EjIkgGFMMdknbiww==
X-Received: by 2002:aa7:cc13:0:b0:43d:4c1:3806 with SMTP id q19-20020aa7cc13000000b0043d04c13806mr2031322edt.129.1659074950060;
        Thu, 28 Jul 2022 23:09:10 -0700 (PDT)
Received: from [192.168.1.100] (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id n3-20020aa7db43000000b0043ce5d4d2c3sm1813330edt.14.2022.07.28.23.09.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 23:09:09 -0700 (PDT)
Message-ID: <c5fb97b9-8d7b-f998-3f28-fb848738477b@gmail.com>
Date:   Fri, 29 Jul 2022 08:09:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/2] staging: r8188eu: more error code cleanups
Content-Language: en-US
To:     Phillip Potter <phil@philpotter.co.uk>, gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        paskripkin@gmail.com, martin@kaiser.cx, straube.linux@gmail.com,
        fmdefrancesco@gmail.com, abdun.nihaal@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220728231150.972-1-phil@philpotter.co.uk>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20220728231150.972-1-phil@philpotter.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 7/29/22 01:11, Phillip Potter wrote:
> This small series addresses a cleanup suggestion discussed by Greg
> Kroah-Hartman and Dan Carpenter, and also includes another function
> conversion. It would be a larger series, but my time being what it is,
> I intend to chip away at these slowly and steadily.
> 
> Phillip Potter (2):
>    staging: r8188eu: remove initializer from ret in rtw_pwr_wakeup
>    staging: r8188eu: convert rtw_set_802_11_add_wep error code semantics
> 
>   drivers/staging/r8188eu/core/rtw_ioctl_set.c    | 8 ++++----
>   drivers/staging/r8188eu/core/rtw_pwrctrl.c      | 2 +-
>   drivers/staging/r8188eu/include/rtw_ioctl_set.h | 2 +-
>   drivers/staging/r8188eu/os_dep/ioctl_linux.c    | 5 ++---
>   4 files changed, 8 insertions(+), 9 deletions(-)
> 

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
