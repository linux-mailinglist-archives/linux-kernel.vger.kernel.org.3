Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19CA4AE4B3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346269AbiBHWeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:34:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386594AbiBHU5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 15:57:49 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A6CC0612C3;
        Tue,  8 Feb 2022 12:57:49 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id w1so398572plb.6;
        Tue, 08 Feb 2022 12:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=lER0Yn2EpeMSnVJPYoZJVlBcAkY3FCI93VU6xZwJrHE=;
        b=DR4hOjfQMDg56Ra5Gcb+pNcHpV3LBEcOn5SQ/ZzCsKGrKBq1HQFmyEzf7GgN42JujR
         nzXgmsfhSsO2CDqmgur4Hi/VMyUrx0wGzZtTiLIiGVI2ZYwxgOqJeAks9XECFpd/AgcG
         1QyRsg9s0BTKMJPVb+8c/SS7JVko9ew1/oEZE/LVhESBmLzBv7gDHZiSHDDyF8N+4HF/
         XtRxoBUBoMNdeKRi1obyUsESFfYu5Yp4lIe2vxx/4fnk3WaBwiIdxhIMtetuYbdjBe9g
         BB3kTzDOVS8vJc4GG0HfhqSbSW1Gk1PpV+2EathmCnaTpaK7W1leiapaOvDDMKgjJ6jV
         t+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=lER0Yn2EpeMSnVJPYoZJVlBcAkY3FCI93VU6xZwJrHE=;
        b=OG6cLLmFi4r9bTxy3hu2PVsKWJlf3xpEAmLUyBiqunmEt+pZjKTXQ+JTzuL446uB8h
         azf72FT7mCWAn4sLIa6fZLTZckhjVIAzHepnGGaZPKA5TCZ8TF2WI2/zHCPp0nYwzHeN
         VFoGxvoViu68ab6bDMRsPRV/xWJRURnNnDCd2UZm00qVi+JZyhA4jNALNzt8f4q2q0G0
         l78wPHXnajjz9hlrmnudpSRJaw8+83dyYo68Yd6gqJlcIGl5zEYPSRtAeeAvD9vhmQZb
         cppluBxdX15WXhWzQ8+MSvVrUc9pc88455bllyOSR3LnsVGR3JGAf+Gcvc1ylY+6PQkQ
         3gnQ==
X-Gm-Message-State: AOAM530NNQr86ZLYp9jpCZ4dP/ARWnmktAL68HwmPfEPmO6JA/Ngo1gl
        7etvZpXq1fqBDRCofUSTWMlF9NgFbQc=
X-Google-Smtp-Source: ABdhPJyD1XSVqyDQR8eoIbfVTTIK7WZth2TwLe+zSUDXHBELSyDkPp+Hst2Y7r4jyog9YA4ytner2Q==
X-Received: by 2002:a17:902:e844:: with SMTP id t4mr6280526plg.104.1644353867631;
        Tue, 08 Feb 2022 12:57:47 -0800 (PST)
Received: from google.com ([2620:15c:202:201:3a7a:5580:400f:1e51])
        by smtp.gmail.com with ESMTPSA id b24sm12184296pgs.1.2022.02.08.12.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 12:57:46 -0800 (PST)
Date:   Tue, 8 Feb 2022 12:57:44 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
Cc:     rydberg@bitmath.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Hutterer <peter.hutterer@who-t.net>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH RESEND v3] Input: clear BTN_RIGHT/MIDDLE on buttonpads
Message-ID: <YgLZSNqx0BN1JXhC@google.com>
References: <20220208174806.17183-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220208174806.17183-1-jose.exposito89@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 06:48:06PM +0100, José Expósito wrote:
> Buttonpads are expected to map the INPUT_PROP_BUTTONPAD property bit
> and the BTN_LEFT key bit.
> 
> As explained in the specification, where a device has a button type
> value of 0 (click-pad) or 1 (pressure-pad) there should not be
> discrete buttons:
> https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/touchpad-windows-precision-touchpad-collection#device-capabilities-feature-report
> 
> However, some drivers map the BTN_RIGHT and/or BTN_MIDDLE key bits even
> though the device is a buttonpad and therefore does not have those
> buttons.
> 
> This behavior has forced userspace applications like libinput to
> implement different workarounds and quirks to detect buttonpads and
> offer to the user the right set of features and configuration options.
> For more information:
> https://gitlab.freedesktop.org/libinput/libinput/-/merge_requests/726
> 
> In order to avoid this issue clear the BTN_RIGHT and BTN_MIDDLE key
> bits when the input device is register if the INPUT_PROP_BUTTONPAD
> property bit is set.
> 
> Notice that this change will not affect udev because it does not check
> for buttons. See systemd/src/udev/udev-builtin-input_id.c.
> 
> List of known affected hardware:
> 
>  - Chuwi AeroBook Plus
>  - Chuwi Gemibook
>  - Framework Laptop
>  - GPD Win Max
>  - Huawei MateBook 2020
>  - Prestigio Smartbook 141 C2
>  - Purism Librem 14v1
>  - StarLite Mk II   - AMI firmware
>  - StarLite Mk II   - Coreboot firmware
>  - StarLite Mk III  - AMI firmware
>  - StarLite Mk III  - Coreboot firmware
>  - StarLabTop Mk IV - AMI firmware
>  - StarLabTop Mk IV - Coreboot firmware
>  - StarBook Mk V
> 
> Acked-by: Peter Hutterer <peter.hutterer@who-t.net>
> Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Acked-by: Jiri Kosina <jkosina@suse.cz>
> Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> 

Applied, thank you.

-- 
Dmitry
