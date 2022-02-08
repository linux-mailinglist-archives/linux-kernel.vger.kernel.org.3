Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69E04AD163
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 07:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242310AbiBHGPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 01:15:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbiBHGPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 01:15:25 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C644C0401DC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 22:15:24 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id g14so46845177ybs.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 22:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I8+dQJhsjqqbxKuceiXCXbyjwpL8VMS5N/fsdGvmZH0=;
        b=OgWTF52eBDySkOlE6VvK0QUJlyMrcqpuR5p2rp5xD7iDxchWUWAm021yvSJN6vk++c
         qmL5N2DDvvVTz3LVAEBvh4BmWE5iu2IGdjfnxLN722L81snTdYxUT5ngwJDmKrc/4beE
         pW+jx1nZPWn/0NThjLMQ4pSpZhdQhfDasokok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I8+dQJhsjqqbxKuceiXCXbyjwpL8VMS5N/fsdGvmZH0=;
        b=Xfu1fpAZZiiYtggcFFXgC3sBpVC6fkvqVedLiSGLSqzBOy73jQmQsnQBK/LgLprxkV
         sOWaBAXz35MkTEGiOXZ9r6G7HSCguFZLaOqIT+MK7pZzO/dyLRl2tcxC+APy5+Wjrjok
         MVZ2guC7Xyn0TzP/QTgMSPDK7YCerysLAFj6vEshRVXH1aD5Cehul/WFE7GL5BbqABt9
         odoyt0wLXrz4eBH4ZDmqOlnAkYu45cOG6G1NRaxCRZryNYy9jBpZ+1Wy/B2Yxq884OVx
         Cs6lCykczoRZBinaYCViayEVPCFyuypidA9AV3W2e6i8PCVoH0XUhJUd53Wdm6oS8XI0
         iw6g==
X-Gm-Message-State: AOAM532E6lkcsNapIaPxWws93kvFvjr/fGjEZMnwsXmZ3whYMbFIuKQN
        RzceRVZLAM2YoRegOC+LIwNK/j+wf9JkKvfoQco/kw==
X-Google-Smtp-Source: ABdhPJwb83sfyn4nAn4uchT/JF8O2drzC/LsS7VmMws6TjmKzUL7JJM+Sr3zPKZYK+tf7SPUsEoc9jmVmQhaB+Kntt8=
X-Received: by 2002:a25:ae25:: with SMTP id a37mr3201580ybj.646.1644300923353;
 Mon, 07 Feb 2022 22:15:23 -0800 (PST)
MIME-Version: 1.0
References: <20220207214026.1526151-1-pmalani@chromium.org>
 <20220207214026.1526151-5-pmalani@chromium.org> <YgIB8N6fjxWcKK9/@google.com>
In-Reply-To: <YgIB8N6fjxWcKK9/@google.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Mon, 7 Feb 2022 22:15:12 -0800
Message-ID: <CACeCKafPyaT9-raroFh-UTunq93Yvh-uPb29oF9NbGZRZjv=Yw@mail.gmail.com>
Subject: Re: [PATCH 4/4] platform/chrome: cros_ec_typec: Update mux flags
 during partner removal
To:     Tzung-Bi Shih <tzungbi@google.com>
Cc:     linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        "open list:CHROMEOS EC USB TYPE-C DRIVER" 
        <chrome-platform@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tzung-Bi,

Thanks for reviewing the series.

On Mon, Feb 7, 2022 at 9:38 PM Tzung-Bi Shih <tzungbi@google.com> wrote:
>
> On Mon, Feb 07, 2022 at 09:40:30PM +0000, Prashant Malani wrote:
> > In cros_typec_remove_partner(), we call
> > cros_typec_usb_disconnect_state() which sets the switches/muxes to be in
> > a disconnected state. This also happens in cros_typec_configure_mux().
> > However, unlike there, here the mux_flags variable hasn't been updated
> > to reflect that a disconnection has occurred. Update the flag here
> > accordingly.
>
> It is fine (at least to me) usually.
>
> Since you would need to respin the series anyway, s/Update/Updates/.

Again, "update" is fine. Please see:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes

Quoting from the above: " Describe your changes in imperative mood,"

So, imperative usage is actually preferred, and "updates/makes" is discouraged.

(I grabbed an older version of the documentation in my other replies,
but the description is the same).

Thanks!
