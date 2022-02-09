Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D003F4AE86F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 05:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343622AbiBIEKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 23:10:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347262AbiBIDjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 22:39:25 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159A8C043183
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 19:32:32 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id z13so2013104pfa.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 19:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GOQ0sWfM4FjwKkl33/hNhQ8lpkr9qvoQNXOdfZoCGy4=;
        b=WPh+JZAupBRMfuEu+D0pwyvzDFFX2NJCAoSOCCWQY+6t/ldquzG3RHI7/JWZGyQRL6
         e27N96UhOUznbX4Y6v3TO/ES3k7XZKupg6PrNvOAJd4yUlz4Z17JwkMvC7cs4EGVkaoX
         4HJFcQ3I+gkEgMhvujrfc/e64hKNNB26SLuBnYBPWyAKEKCPwSmzK4qroViO9xXNw5Zp
         hAJ2sRdkv0I610ubtyoyf5X+lpG5oXvCvsqBf6SLMuxjMIruVcpoVxe6xaxcEN+GTLmb
         dg4U8hSC+7xN9EtudaCVc60tZpjJV5Wi/D3p8Oac+Yj6D3FfnjyATGsODsZwd22wAKPX
         +EQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GOQ0sWfM4FjwKkl33/hNhQ8lpkr9qvoQNXOdfZoCGy4=;
        b=1cghiRTJAh9oKJgijCmSkv55fW7x08IDMR/ZV+9R+N2SfQ2OFb+VcAzjxU15Aq53Fh
         Gqxg2cbuiHVL9HVRBzzekvYz2WSUOtkJuX+oW4CC5QsB1nIZfbjDJJf24V4S3+iG7eHv
         YnarBgV+sPmqRCt/auvvzUaL4vlpaf3RqoBQR1ARt0H7/DFuI7yRvNGPRUMryCbcDwlF
         OgO5dm5PUo/j9vKZOu/ca/tbGknbkIbA3dukoUi6NdU6l8hQNxXCns0wpKR0PuPedbk6
         +JLDw4CKMzKhqNzxEZH3wlWqzTiXl2sYCSVqdhH6+J5oBdaYBnfvHlNYSLWqfcyU2MBu
         VFYg==
X-Gm-Message-State: AOAM532nzmk3SvISHoFdYZmPG/ZykSRr6BW98ClNYtMcH2fsaHOTKl0Q
        Xmv1g1VqIcexH/paa/lo++FpUQ==
X-Google-Smtp-Source: ABdhPJz51Gwp5ZjbgRK9o+938031p99GlYbBhM3IxPTtiQ0jNOjrMfO/AhFmHZFU+kutJ57icCkOEA==
X-Received: by 2002:a63:6a06:: with SMTP id f6mr364233pgc.576.1644377551404;
        Tue, 08 Feb 2022 19:32:31 -0800 (PST)
Received: from google.com ([2401:fa00:1:10:4b6f:f14d:be50:86a])
        by smtp.gmail.com with ESMTPSA id y193sm18393977pfb.7.2022.02.08.19.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 19:32:31 -0800 (PST)
Date:   Wed, 9 Feb 2022 11:32:28 +0800
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        "open list:CHROMEOS EC USB TYPE-C DRIVER" 
        <chrome-platform@lists.linux.dev>
Subject: Re: [PATCH v2 4/4] platform/chrome: cros_ec_typec: Update mux flags
 during partner removal
Message-ID: <YgM1zM7Vpn/FlHv7@google.com>
References: <20220208184721.1697194-1-pmalani@chromium.org>
 <20220208184721.1697194-5-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208184721.1697194-5-pmalani@chromium.org>
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

On Tue, Feb 08, 2022 at 06:47:24PM +0000, Prashant Malani wrote:
> In cros_typec_remove_partner(), we call
> cros_typec_usb_disconnect_state() which sets the switches/muxes to be in
> a disconnected state. This also happens in cros_typec_configure_mux().
> However, unlike there, here the mux_flags variable hasn't been updated
> to reflect that a disconnection has occurred. Update the flag here
> accordingly.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
