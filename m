Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D78F4AD792
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357003AbiBHLf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:35:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349623AbiBHLQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 06:16:03 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B38BC03FEC0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 03:16:02 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id c5-20020a17090a1d0500b001b904a7046dso238434pjd.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 03:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P3thgQ+zSj04vKKZCiXaKT5NnbhXmsspNLhy1DSjGPo=;
        b=iZ3nawHHxyXLGpoHI81EkPmFqhuqUTCmnIohINaeXf2No0Gz3tGSoFBFxXJxk00a2k
         lMMbPSFim/wvaISL97bc7/TcCn7r2hD4lThZg8qosb02ebUOmnlAeNWXAZA0uajJIzT/
         YnzsEzWlwXXHCsV3YzSB4f2hBBoBZvrORTEBU1YrihaVEveHDVz6R2AHl3biSPJIF4yJ
         w/h7CNDMBgdAsVbWFzx5XiCsObhtKGoL+DYAj5MWj61g1u2hxynX4wTkn8Wj6BRgQM5l
         SN0QHy99TZJpc1xm0FeK/UtW3ssSWUfBT5RjglqJD3L6sEctWSVKtKmG1EjMW3YjIz0R
         BIhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P3thgQ+zSj04vKKZCiXaKT5NnbhXmsspNLhy1DSjGPo=;
        b=IT7MSMjLcLqZM85FcHP5YrFXGp0F9tcQjTCvpAJmQid+nWu2mULTt5l2qGZj1liuZy
         z7qmL/PbABpkOPdzU3sDOR3/7IKw0WdRn2c00sAi+FhT9ySQTkxGrt3RL4UoQeRbYUou
         efwV9DEahvl717SizDpKEQ6zBzAk/YSfQHszMawEI3XD/jMLVFvmmO+ZGjB0D88IBTQi
         T02h9X8w5xr45cHJlDwnxtwQUwsVyVB7qvkF2Kmkn97gzcPzhX7Rzq+zJhWYTuMVWQ8u
         EBmSPt21wyl8U65UVFt7Qmr5INUjF44cQ/ndwYVwohJjano9bpr0r8T+uYo6QolLxWzR
         QduA==
X-Gm-Message-State: AOAM53397aWe31vDoK8KG/Vdpq2h+48db7SzeFosQ54WcHUQk+qcBLyq
        kdWYyd6tZl6xfHlFgvYUDyumHQ==
X-Google-Smtp-Source: ABdhPJzk07GU3cOQZXIPEWFkIrBzO0AzeU+5y72yavAhuejps6giNLBY5vTrlvpus7PFKbFyb6PqkA==
X-Received: by 2002:a17:90b:4b52:: with SMTP id mi18mr811701pjb.74.1644318961662;
        Tue, 08 Feb 2022 03:16:01 -0800 (PST)
Received: from google.com ([2401:fa00:1:10:4b6f:f14d:be50:86a])
        by smtp.gmail.com with ESMTPSA id h11sm14734018pfe.214.2022.02.08.03.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 03:16:01 -0800 (PST)
Date:   Tue, 8 Feb 2022 19:15:58 +0800
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        "open list:CHROMEOS EC USB TYPE-C DRIVER" 
        <chrome-platform@lists.linux.dev>
Subject: Re: [PATCH 4/4] platform/chrome: cros_ec_typec: Update mux flags
 during partner removal
Message-ID: <YgJQ7nvYivWozvdT@google.com>
References: <20220207214026.1526151-1-pmalani@chromium.org>
 <20220207214026.1526151-5-pmalani@chromium.org>
 <YgIB8N6fjxWcKK9/@google.com>
 <CACeCKafPyaT9-raroFh-UTunq93Yvh-uPb29oF9NbGZRZjv=Yw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACeCKafPyaT9-raroFh-UTunq93Yvh-uPb29oF9NbGZRZjv=Yw@mail.gmail.com>
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

On Mon, Feb 07, 2022 at 10:15:12PM -0800, Prashant Malani wrote:
> On Mon, Feb 7, 2022 at 9:38 PM Tzung-Bi Shih <tzungbi@google.com> wrote:
> > On Mon, Feb 07, 2022 at 09:40:30PM +0000, Prashant Malani wrote:
> > > In cros_typec_remove_partner(), we call
> > > cros_typec_usb_disconnect_state() which sets the switches/muxes to be in
> > > a disconnected state. This also happens in cros_typec_configure_mux().
> > > However, unlike there, here the mux_flags variable hasn't been updated
> > > to reflect that a disconnection has occurred. Update the flag here
> > > accordingly.
> >
> > It is fine (at least to me) usually.
> >
> > Since you would need to respin the series anyway, s/Update/Updates/.
> 
> Again, "update" is fine. Please see:
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes
> 
> Quoting from the above: " Describe your changes in imperative mood,"
> 
> So, imperative usage is actually preferred, and "updates/makes" is discouraged.

Ack, thanks for correcting my so-long-time misunderstanding.
