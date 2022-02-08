Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB114AD12A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 06:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243569AbiBHFkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 00:40:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347128AbiBHFjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 00:39:42 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11AEC03C184
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 21:38:59 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id y5so16077264pfe.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 21:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w1ToBKvilZAnLsl88mTOhBoWn6o9AUkKYUjyzTMC1uc=;
        b=CJFYtc43lHuyGmlpLrVF+z71pylI0Zj0Gmg7Be1LIE6/wkILXgk5t4MJPAxctlpTwe
         92Ha5dQKE8WgrirZAcawdCkKEv500hRdAyExKqhtObw+9Fhh3a5OQxHG3sz1FW3Hhmjb
         ts5cAgKY60ZWOtTBKCWtatzkOkGUhyhME6yZjCvA79/k19ve5pQhOOhqL2TnjQUUN7/i
         P5p5ce2gFs7yr2JbnBpp0W/jgyqIRVHuYAggKMArpvSKpnNpWQtuTayqLrAxMKEHImwT
         sqp15upJV7ETX3PgRbL9MiCSTcCCUkYiVRfhmDS/avPr0/NQh1egHiqMY8DFFIwCoHfI
         ivPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w1ToBKvilZAnLsl88mTOhBoWn6o9AUkKYUjyzTMC1uc=;
        b=mB9JaI4+CwoDwgZ6whsQEPGoja0VZ6r0E/C/WUH7NdyXTdSJqXlG1t10P9N/QIuxv7
         PqdTLlGjNJGIbsgVsHUskOgEbA75IDfN5+muE0krVBLJUbN5K7haFgtSOWBkI1T7nG5+
         wp4j8ijxVrVFQ8H0DXZCP0NEBkJ2phBnsLywHnPRwilH4zgXk9+V+upSgKAoo90OVmST
         AoH7CYv962jyHaxKCF+JCM3sp1wSHAY+J0VA5Ct/TGJea0uSmWMFR8yhddQG1A0bAuHc
         fTX/ClhdjbMNfMZghTg4fFm5IJwj9QBEZJcQNTVRHEL1/y5ryKcikXdbpVYWEdrOmUVx
         nTZg==
X-Gm-Message-State: AOAM531ymEWXMgfjngfp3fAeCntXMbvXHI1RUVPm33FnnUKIEQ0+6EmR
        KfILBECRwK7nrBXrDEYx9Ea2DQ==
X-Google-Smtp-Source: ABdhPJxRH3e1fGO47pLA/QC1IV9ZXOj10+7A2obM7eqTYRXXCvlPNG6xSLseIw68AtvgSfd/70PyeA==
X-Received: by 2002:a63:36c8:: with SMTP id d191mr2247795pga.377.1644298738976;
        Mon, 07 Feb 2022 21:38:58 -0800 (PST)
Received: from google.com ([2401:fa00:1:10:4b6f:f14d:be50:86a])
        by smtp.gmail.com with ESMTPSA id k9sm14548102pfc.157.2022.02.07.21.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 21:38:58 -0800 (PST)
Date:   Tue, 8 Feb 2022 13:38:56 +0800
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        "open list:CHROMEOS EC USB TYPE-C DRIVER" 
        <chrome-platform@lists.linux.dev>
Subject: Re: [PATCH 4/4] platform/chrome: cros_ec_typec: Update mux flags
 during partner removal
Message-ID: <YgIB8N6fjxWcKK9/@google.com>
References: <20220207214026.1526151-1-pmalani@chromium.org>
 <20220207214026.1526151-5-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207214026.1526151-5-pmalani@chromium.org>
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

On Mon, Feb 07, 2022 at 09:40:30PM +0000, Prashant Malani wrote:
> In cros_typec_remove_partner(), we call
> cros_typec_usb_disconnect_state() which sets the switches/muxes to be in
> a disconnected state. This also happens in cros_typec_configure_mux().
> However, unlike there, here the mux_flags variable hasn't been updated
> to reflect that a disconnection has occurred. Update the flag here
> accordingly.

It is fine (at least to me) usually.

Since you would need to respin the series anyway, s/Update/Updates/.
