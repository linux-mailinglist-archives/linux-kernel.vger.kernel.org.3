Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8D3496C9B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 14:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233586AbiAVNeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 08:34:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233294AbiAVNeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 08:34:12 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D99C06173B
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 05:34:12 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id k25so7911262ejp.5
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 05:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e8hh0ttf5WPVcY+RjJGEBP+0C6QN/+UHlasoRckpvYA=;
        b=DAH1vUg+pWl4l4xR5PDM7YO/P7l6uHCABIctrRJ8cuwxYZzMhTIeavOJpv2vhPFkXR
         0kmkNOgFxXfopXIt0T4JSvOPYXf5QqXKEFxtwqncHEWVnaO9DDgpIghrKxhkGrC55fqS
         6lqCIJphynvCHXv3N3z0acq7iqbU37Wo3BMow4f4+W/n0iDFmLPPUdchX3HUBSGeGPYI
         DQk03O9FizCHE+dtCtWJKp/g9ALb3sUgP0qXztOR5iiWcmgnggCx6mpycVBF7Q/Jg7Q/
         886Rzie38TPE3rzT21/EMgQMBnHrMY4njYnJcmcVDr3NhtHK0bh2WbA5YHuwr8c2r0gc
         dz/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e8hh0ttf5WPVcY+RjJGEBP+0C6QN/+UHlasoRckpvYA=;
        b=gGbY7rrAeeBtw33VCSLEkf3FTLZSVCWwQcpgWU66itdoAZsqNHyNgc0zpGVZ61EXva
         0HyaXHq/Q7EO6vmrlnTL3Vb500Xth5Qr1XDXzd/C7LB5C14qJrb3HAPPuoVuUtqIldPT
         QnWQNdMj4gROBTSzcGTEHUe7zVYoEztNtbQEegbwDPUB+ni/iOQcx1SNKJmIy0Gf6jjP
         AjHB/GjEC+Ym/8rsXND/h8CP+Ow1JpjtO4Chh2ewzV5RqPmYmbEdDcaojf/50tcS9i3k
         7CBLI6uQfyoDdFOOojLJUmjW7y7uEtYqd2Db7KWLZSBnd+SAm+B/miQNZn+d11k+uDmA
         y/Sw==
X-Gm-Message-State: AOAM531g+mEwrAMf46f4d11RPEHcnBJbKrIHWSI9nse3agMHzyG8ctz3
        o6dx2VOK3cGhAMtvBPKyFW4pxyrOdTpUjnRPOx8=
X-Google-Smtp-Source: ABdhPJz15xCQwDBgEuc+XPcP4i6Bw/2wu1X1SCyF/jbi3hUsBR7++TQZJ4MsGPk9gQg9TgX0gILjLS53cSZnYuKJlCE=
X-Received: by 2002:a17:906:274f:: with SMTP id a15mr6678000ejd.492.1642858450621;
 Sat, 22 Jan 2022 05:34:10 -0800 (PST)
MIME-Version: 1.0
References: <20220121165436.30956-1-sampaio.ime@gmail.com> <20220121165436.30956-2-sampaio.ime@gmail.com>
In-Reply-To: <20220121165436.30956-2-sampaio.ime@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sat, 22 Jan 2022 10:33:58 -0300
Message-ID: <CAOMZO5DX-zzQGi6hWj66yHDYAHXd7yzJ6CQqtHVQHt-U4LVq8g@mail.gmail.com>
Subject: Re: [PATCH 01/31] gpu: nouveau: nouveau_led: changing LED_FULL to
 actual value
To:     Luiz Sampaio <sampaio.ime@gmail.com>
Cc:     Ben Skeggs <bskeggs@redhat.com>, Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, nouveau@lists.freedesktop.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luiz,

On Sat, Jan 22, 2022 at 7:44 AM Luiz Sampaio <sampaio.ime@gmail.com> wrote:
>
> The enum led_brightness, which contains the declaration of LED_OFF,
> LED_ON, LED_HALF and LED_FULL is obsolete, as the led class now supports
> max_brightness.

Your Signed-off-by tag is missing.

Please run ./scripts/checkpatch.pl on your patch and it helps detect
this kind of issue.

Regards,

Fabio Estevam
