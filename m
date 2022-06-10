Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED003546910
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 17:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237704AbiFJPIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 11:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232609AbiFJPId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 11:08:33 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58AB3F29D1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 08:08:31 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id kq6so41008397ejb.11
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 08:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t05rvtsB/T3sOZN/4oJBFLGvWKQGNZBpJYVRSJjTMno=;
        b=QBgLYzCMOcGXBskoo8CH8F9b+PjZdO6A7JHFiWkk9vy30p0XOTBjcpmq/XxqLyIvpx
         qpV5cwbBvb94yD8E5BwejzUTO6JTtAetpoxI7m60ywdr89eAC3KaNR4R8KBhZrkwysAt
         DwHVXLm/0mquHHk1ccKpFe/nqWnQ+NBIIH0gHmxZlV8BPM1DZ82XW1XR59LoWnVb5dnw
         fhcXXFnMfWQeI9WxTHdSyWFY6D0zKhoYJQKJbtHlMVijEAluyILwi3p7jZRJoy4uqt/A
         OFYbLcWavSBNiT5aIbrBVyMGPNrSl2ovmRkJUcO3HiAFvNQK2Qvq3gxouc4Lw6Dgg3MJ
         MFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t05rvtsB/T3sOZN/4oJBFLGvWKQGNZBpJYVRSJjTMno=;
        b=M5DXNc1uhTID7AULPrwktsF61k7k8O0Bo7hGnq6u/O1esdxOY8diSRO/3ePmxkUcUy
         k2wpF9cWvjngagARzSR1OH9Z2/ZYCc+lRAhjxAr1a8n6BuW0aSAR7C1GeTuDJMJHF2iO
         JmvuP94JOvQUXX2/2xC9Wp9eptPQubrW/w6mCY/YRqYdp3PdlmqAWijbGpgF/4PCaZOj
         l5aW1I0ly0jvdsEmyLNkpfvWwOepGaXMe/sWr7mzC+4L+Tx4Nes8T7GX1KOXY9VUIWnn
         gEiiCwizNd+LnOA/COE5uzTm+FkMPd8jKu5IPCMdn4VosrLqQYksjeGru/cMoNVjJfcD
         vgbA==
X-Gm-Message-State: AOAM533+Z5dZt8zcUsNtVxJqivK9gOsR0/o8FEDBOaSiNOSGxivBmw4Y
        TemVL9Pl3KexRONRWlKWZg8mPhaFGtojFeDmaA/3Rw==
X-Google-Smtp-Source: ABdhPJyHurq1FK1Va943z8vc88m5ROrIH3Wy0ceSIRu1hWNJ8zRBuVzOLJVlASYN21jD/QmGSSRdGMM2rEtdISLRJOo=
X-Received: by 2002:a17:906:4d50:b0:70d:afd4:1e63 with SMTP id
 b16-20020a1709064d5000b0070dafd41e63mr37489536ejv.618.1654873710284; Fri, 10
 Jun 2022 08:08:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220610133342.3735012-1-ajye_huang@compal.corp-partner.google.com>
In-Reply-To: <20220610133342.3735012-1-ajye_huang@compal.corp-partner.google.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Fri, 10 Jun 2022 08:08:17 -0700
Message-ID: <CABXOdTe8=mADxxPdbLrmvhwn-FJcZvt1aeqP+tK8gq=0foJzNA@mail.gmail.com>
Subject: Re: [PATCH v1] media: platform: cros-ec: Add kinox to the match table
To:     Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Zhuohao Lee <zhuohao@chromium.org>,
        linux-media@vger.kernel.org,
        "open list:CHROME HARDWARE PLATFORM SUPPORT" 
        <chrome-platform@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 6:34 AM Ajye Huang
<ajye_huang@compal.corp-partner.google.com> wrote:
>
> The Google Kinox device uses the same approach as the Google Brask
> which enables the HDMI CEC via the cros-ec-cec driver.
>
> Signed-off-by: Ajye Huang <ajye_huang@compal.corp-partner.google.com>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>  drivers/media/cec/platform/cros-ec/cros-ec-cec.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
> index 8c8d8fc5e63e..093aa4fc6692 100644
> --- a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
> +++ b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
> @@ -217,6 +217,8 @@ static const struct cec_dmi_match cec_dmi_match_table[] = {
>         { "Google", "Fizz", "0000:00:02.0", "Port B" },
>         /* Google Brask */
>         { "Google", "Brask", "0000:00:02.0", "Port B" },
> +       /* Google Kinox */
> +       { "Google", "Kinox", "0000:00:02.0", "Port B" },
>  };
>
>  static struct device *cros_ec_cec_find_hdmi_dev(struct device *dev,
> --
> 2.25.1
>
