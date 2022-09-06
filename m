Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B179E5AE23E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 10:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238924AbiIFIOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 04:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbiIFIOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 04:14:01 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04EC175CC7;
        Tue,  6 Sep 2022 01:14:00 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id m9so5150170qvv.7;
        Tue, 06 Sep 2022 01:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=MLVQ063bu5ioYbCH6dZoF3Ghddzfco+xPeZ0Ad2Zooc=;
        b=i0JHJr6lbaDHDPtYXboC5QuANOdolIuKA7eW5LAyjpiKBQknJygEOxQjTvlQPUZexB
         SmeagQsuV79n6D2p2JXQh7vC+x+Ru3xIaGuRMRrf6/iNtUTLmnRObcUq7mxjNzJaOXDk
         0Li2qpYYv8XhU5hWR9yeXK7Fta7RIZhXB/WA24uvHxt76MVpYSiXEA0lSNZsRNEEqyQF
         mpwa5RXiNyYa8PYh1DBk65OXyVbOGpewF7HEBUEm/uMgTk3KkQVJ4lgodWvZeamimZDj
         G0YZEc/bP9i2HcLIMDjLxLn8tvSUTqq0ObC3eoBfGKyddafWD5zzDwtshdf7k056EyD2
         YJRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=MLVQ063bu5ioYbCH6dZoF3Ghddzfco+xPeZ0Ad2Zooc=;
        b=Ce9LeIigqvy9Sr/BGF3zyEcffFuOgQpa04LFpw59t9yDf615/kLd0shXhzf7GOQ1cR
         9z2BfgEsM48UEo1As+SSIsNfWVBROP1lwoDfrDbb5Db2YgojMEVHru7lXvzcadGA4ifa
         4Mdb/mXzmIPCo/k4ikuml9mnTihczDgUq+7gnMYjYy+uyfjPeqaYK4FC8Jl05s7aGs7S
         2Yw1ASMG//QkPZ2hfZDSCW0RUgTKGKQ8pGzM2dwKXah2nhROeMUdb6axP7MLxf8bEbWW
         48yQKhWO/PqarVrYBryfK8bD5sBNNb7uX35uLGxIiMHGp2evMpBBRv3IZWFhwWLDKy4V
         0s7g==
X-Gm-Message-State: ACgBeo1CHHpOjVdNqIqLjUnAsEQFjxsKxubvBUwlTXHqOuvzZeS4wUQa
        5il6huA+attP87kpXH6VhseLTXTnFGiWN4y55fi/JYhcvijzy54+k/w=
X-Google-Smtp-Source: AA6agR7gQf0DVAbMgzlBiNIkVJ3Bpi6Pg3O+8sLzPFGU7oVCAnku1tVscJ3nQwMTmAkMmwXqol8e8KYuFbmjMC8Gne8=
X-Received: by 2002:a05:6214:29e2:b0:499:26ac:eed4 with SMTP id
 jv2-20020a05621429e200b0049926aceed4mr23356909qvb.84.1662452038999; Tue, 06
 Sep 2022 01:13:58 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsO+kB2t5QyHY-rUe76npr1m0-5JOtt8g8SiHUo34ur7Ww@mail.gmail.com>
 <87ilm3vbzq.wl-tiwai@suse.de> <875yi3froa.wl-tiwai@suse.de>
 <CABXGCsMQ5H23np6fMN=58CZ6cBiHFF4WGdKdbtYLFyAAeAu5rQ@mail.gmail.com>
 <874jxml7a4.wl-tiwai@suse.de> <87o7vuj8ao.wl-tiwai@suse.de>
In-Reply-To: <87o7vuj8ao.wl-tiwai@suse.de>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Tue, 6 Sep 2022 13:13:48 +0500
Message-ID: <CABXGCsNBzjRB4G-fRbnOOPcmsX4EcibCMtE5UTs0iiq7T_Nedg@mail.gmail.com>
Subject: Re: [BUG] commit a8d302a0b77057568350fe0123e639d02dba0745 cause
 IO_PAGE_FAULT and a lot of errors
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-sound@vger.kernel.org
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

On Mon, Sep 5, 2022 at 5:49 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> Even a simpler one below with a proper changelog.
>

Thanks!
I checked both the latest patches. Both solved the IO_PAGE_FAULT issue
and didn't cause any side effects.
Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

-- 
Best Regards,
Mike Gavrilov.
