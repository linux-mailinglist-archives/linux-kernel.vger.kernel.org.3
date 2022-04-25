Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7201150DE5B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 13:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241601AbiDYLDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 07:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236072AbiDYLDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 07:03:08 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555E88BF08;
        Mon, 25 Apr 2022 04:00:05 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id k4so14582577plk.7;
        Mon, 25 Apr 2022 04:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8w9f5PNtLEl7ZLk63CUD7eXiyQq65I/krAjjIwxYN/I=;
        b=mFLITgqplJs5mRnQtmPw57KqDc7oFwKeQ/4Xy187E/VOS9/pipsaGD/rv28qbGguqm
         sOA4Dn3gmntR/4pgrjVt51tq7cytjMwNu81vncONy/svCxNEo00FJKIwzL4gMkO0Hwuf
         q37SjvRpADxgv6CIEoIVuBle8stVTlqhR88u+4NwOe/Hnz7tDDm0iCQ9/MGo56gvhmhs
         8Puvf6EtKmiktzJGv31F86Lo42mEQeubgmb7KB6oDnSlzl4YX1kkaP9e2SNt5zUOt0hZ
         WOYkXUZy4MdD4rpOBuIv80ERNJPUlGmFpI221nBjn6c+w0+6bm3ud1/EjONvM85ltkTB
         NGGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8w9f5PNtLEl7ZLk63CUD7eXiyQq65I/krAjjIwxYN/I=;
        b=hQA6gt9dSqMOz5uHUrZ3tjlanoElf6CWoOu/oQG3wnPeExqIYSfh/WNb9323YM4AHJ
         Zk1bSvKBjCv5+9ab+FRSghD/9FNucCTVw5RDe0QXOSIJmDu6UapZfHMfLrSNo+mhqgHa
         3GyLXT6YQi+laRBJQrKIw3D/EZ/zPmmaylrGRQ3qbMdd4I66XnLtNseAOlJinhf3Oyzo
         5AuCr7+TTAIbQOYz45WjI3xijE/a2iEsKfsJX/Q8YJUU61sVijGetaXroyT8ggP938FK
         Co188ir8WQYF0bxKxtw1albZ1mX4tjD1DL06yjFffYyg3DfnWmrgb0Iz3nP+DcwcduTp
         Mjxw==
X-Gm-Message-State: AOAM5316tZse08ntQrO9zCX2LHfZwwQ6UrtA4Txhk34pYZOYqjDg8PFq
        ZvQetOOsGxEQqz0nkEilynycMENjrJKxhXnsvQ4=
X-Google-Smtp-Source: ABdhPJxvUTUDJSrvCw6wnWTU9BopbW2+XVnkCjuKf0UxDEW7SnsoexUeF2YKLnYx2Go8N/kc+Qg/w9/S5cOeO3lSGus=
X-Received: by 2002:a17:90a:c20a:b0:1d7:4cd5:ac82 with SMTP id
 e10-20020a17090ac20a00b001d74cd5ac82mr21471769pjt.212.1650884404905; Mon, 25
 Apr 2022 04:00:04 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20220422120240epcms2p24bdcb416becf76b417f7c39006aa40f2@epcms2p1>
 <1891546521.01650629881201.JavaMail.epsvc@epcpadp4> <DM6PR04MB6575EB87D425CE431CC4A8F8FCF79@DM6PR04MB6575.namprd04.prod.outlook.com>
 <CAM36TBtsU0k1e+8-_Ew4ve3SJ0yExUFwPAYnmQy_-AXUHGoeZw@mail.gmail.com> <0f061fc0-d7ee-aa48-278b-4ca7dc3ce53f@acm.org>
In-Reply-To: <0f061fc0-d7ee-aa48-278b-4ca7dc3ce53f@acm.org>
From:   Jinyoung Choi <ychoijy@gmail.com>
Date:   Mon, 25 Apr 2022 19:59:45 +0900
Message-ID: <CAM36TBuch4Zrb8AWdh+q5oTCMB+T3KgFhR4q49T8G_pwk2NFgg@mail.gmail.com>
Subject: Re: [PATCH] scsi: ufs: wb: Add Manual Flush sysfs and cleanup toggle functions
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Avri Altman <Avri.Altman@wdc.com>,
        "j-young.choi@samsung.com" <j-young.choi@samsung.com>,
        ALIM AKHTAR <alim.akhtar@samsung.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        Daejun Park <daejun7.park@samsung.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> On 4/23/22 07:24, jin young choi wrote:
>
> >>> +static DEVICE_ATTR_RW(wb_flush_on);
> >> Maybe wb_flush_enable ?
> >>
> > 'wb_on' sysfs already existed. So I named it in the same format (_on)
> > I'll change both. (_on -> _enable)
>
> sysfs attributes constitute an ABI. Breaking the user space ABI is not
> allowed. Hence, renaming existing sysfs attributes is not an option.
>
> Thanks,
>
> Bart.
I got it. Applied to v2 patch.
I sent a mail from Google Web,
but the mailing list was messed up with a tab problem.
(Changed to git send-email)
I'll be careful.

Thanks,
Jinyoung.
