Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2A650CD2F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 21:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236875AbiDWT1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 15:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbiDWT07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 15:26:59 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF5D26551;
        Sat, 23 Apr 2022 12:24:02 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id t4so6993176ilo.12;
        Sat, 23 Apr 2022 12:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UA3QohFgoTs+y2joxZ4ax/9P0q1Vw6kdh1yN4oESd/U=;
        b=HLCK/fwrcM13PWW/3uLxyfR7galgZjfIGI/rIe2u2z0MfnkzlyV3jX3pk4hWRQItJc
         lG0ruWeh9coqsLcatkvu2czN03g8uqXSwODM3sMrp8V+fh/s8+dASmV+wpjrIFX9DxFB
         xQzJUNQRRJ0vfJNE/D+f+B6dTmP+cIQ5SAQ2S6A5u7Bf+rONg9bXOljMqtgrsSOT00Xm
         VtQJYicDk57xs0drIqjKm9SpLbJXmJoVNsrfvr8lYl/YbzvDcg05BV9OB6cy/FkZpLDm
         pbstwKZijeabcKADOfneBu3Q7vAY3dh5ftGQgC8DRyUb8tS2lQSQFqOGlmJFSum0VCRy
         AlMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UA3QohFgoTs+y2joxZ4ax/9P0q1Vw6kdh1yN4oESd/U=;
        b=p2A/fYhnTxiQ3DRPYZHvAR/1VLvgCAVO6kSyJVEdGdfjnXMjbV4mgHMWt3oCV3oXOi
         opeJFvgm3XND3kPcxj1yVceCHff10D+1nbD67Nut4fvOPGtPOM39oCNo69V5R4n6Ooa/
         I1giCaqPkwoMF7HnNcUE58sIY9m9y2++7uu6P4w0fL7QNXmBwxGlufGyAAlZrEEuB7nz
         pyyHIFnov9bRLqZTcinM3+dvnIrukXa0g0uVgHVQjmBUDNcHuxnOLrNCCWykXP2kAlZO
         7nKt9Z8JOR+pG6YNiCXg+vi4tO3jMAmBwnajL6H/YF4HecVSsYk3hv3KW/jikzbj5n20
         V7Qw==
X-Gm-Message-State: AOAM531MppqkV6g4HnYeJgNv97ahiU3//w6kQPsVENcjx3lzBSC8niRr
        VmQgvnAT0sR3bTuDDJHN1KL29IPsjc1NM+h3BPXPhBlMIfvqdg==
X-Google-Smtp-Source: ABdhPJyRicslakAW7kNlD9yO8jbe8tvy0ieEPEVAm4EE5nhWQT7CqRsG1BjQRX5/XvilYkJ5WftsIIqEMK0TMFdkXCQ=
X-Received: by 2002:a05:6e02:1c2d:b0:2cc:4986:3f61 with SMTP id
 m13-20020a056e021c2d00b002cc49863f61mr4173291ilh.246.1650741841468; Sat, 23
 Apr 2022 12:24:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220422111737.1352610-1-eugene.shalygin@gmail.com> <20220423191701.GA3971291@roeck-us.net>
In-Reply-To: <20220423191701.GA3971291@roeck-us.net>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Sat, 23 Apr 2022 21:23:50 +0200
Message-ID: <CAB95QAS3+m1bw1DwXw3PObyWwD80BqGoQCv_tGupWpAyitAKYQ@mail.gmail.com>
Subject: Re: [PATCH] hwmon: (asus-ec-sensors) add ProArt X570 Creator WIFI board
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-hwmon@vger.kernel.org,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

Thank you!

On Sat, 23 Apr 2022 at 21:17, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Fri, Apr 22, 2022 at 01:17:37PM +0200, Eugene Shalygin wrote:
> > Basing on information and testing provided by users [1] add support for
> > another board, ASUS ProArt X570 Creator WiFi.
> >
> > [1] https://github.com/zeule/asus-ec-sensors/issues/17
> >
> > Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
>
> Applied.
>
> Thanks,
> Guenter
