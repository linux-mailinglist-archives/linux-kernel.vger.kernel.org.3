Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED4654ED72
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 00:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378920AbiFPWmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 18:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbiFPWmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 18:42:07 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545B162118;
        Thu, 16 Jun 2022 15:42:07 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id u13so945475uaq.10;
        Thu, 16 Jun 2022 15:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rtXi3XcHaWTSLE0xazM/+cN14meBDo7Hzib7AWabWuQ=;
        b=I6mscbSBbv0wmFevrmDaS2Kt8uiHxgfp2uYDdPc+jPs9zt47x5o6o+OREw0HF4ZW3u
         l8cQlOrX5MpJlzlToGD/b3LTx+4hR/VN7EaZ42ewvTcrCqPGE4eqZ6cA1oudSOBfVlM7
         OnIRj52AH5paiHKk+XOo4D175tHIQyOlUlLaEJ6zTfNnWorTjGSWv6GNTrwCHjGI+F3Y
         N5pdGqBKNsOda5o3NEWEPXIq9YFGGdfrXF3WTyYtA6jm3Eng65nTIlOZN9iP3+Z6ifu2
         TJ1UnJ92tUcIPoiGVdHY1jWcqhBNRXbePP+nYH9ccmZJShRDW/a/yzuudXfwpxl93FC9
         90Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rtXi3XcHaWTSLE0xazM/+cN14meBDo7Hzib7AWabWuQ=;
        b=dkeSLzkJmUD5fHajrhgg1XxnXppMRu+5vEN893Y/RYmJtFArEYhQI8rlpr+LcWMOH0
         cL63B/eXJV/E5cL2RgpXNtaPnDLqUvCqiCi31hoOLLFGMKI7ra0sxuep4v5A+LJn3cAC
         Vdz5Yxi7yoYilo/70AtswcXy5d5OuAkM5Fa/ai2Zi+Q+Go0hPlqHPEsxA1YbpV6cEK0P
         mRhNUKnMzowFknCMBF/XujpiNzTw7zmEoBBLa5ChsqMSGnZ97NCsRCh2t1POSqf+PF+A
         gIoOZbk/WFK0swDcBAvjq5AQfz4skkKudP4jHMjnQhc0BrsROH8RefBt2WiZrEgr5+xF
         0XPA==
X-Gm-Message-State: AJIora/rgzBaH663GH4vN2BejY+8PVG6kpRttLbs8VKo3oZmM09Fq9tJ
        5sv9w7uK2OiBtfFqvaccdTuQJTumhzxvZu+urs61dZjB
X-Google-Smtp-Source: AGRyM1sGG3dZe7xY8AqwQZA5ZNlecZo2ekiWzbuJmCOUwIZ0JVu5VO1IaPSLIfziEKNwDRCeqL+jkq4fOjYXuM4ef0w=
X-Received: by 2002:ab0:281a:0:b0:379:555e:d442 with SMTP id
 w26-20020ab0281a000000b00379555ed442mr3272717uap.96.1655419326329; Thu, 16
 Jun 2022 15:42:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220617083415.58099b8c@canb.auug.org.au>
In-Reply-To: <20220617083415.58099b8c@canb.auug.org.au>
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 16 Jun 2022 17:41:55 -0500
Message-ID: <CAH2r5mu8zbi6PYMf7tRxHjQD+tSKnMu-Hc9vhv6zERr18Zwr8w@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the cifs tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fixed

On Thu, Jun 16, 2022 at 5:34 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Commits
>
>   a284f0491590 ("cifs: periodically query network interfaces from server")
>   d6758ffc0dbb ("cifs: during reconnect, update interface if necessary")
>   dacfaed48632 ("cifs: change iface_list from array to sorted linked list")
>
> are missing a Signed-off-by from their committer.
>
> --
> Cheers,
> Stephen Rothwell



-- 
Thanks,

Steve
