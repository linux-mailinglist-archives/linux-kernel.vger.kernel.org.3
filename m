Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFEE14BB2B1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 07:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbiBRGso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 01:48:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbiBRGsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 01:48:43 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E168A237CF;
        Thu, 17 Feb 2022 22:48:27 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 27so1831526pgk.10;
        Thu, 17 Feb 2022 22:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FWuUXrbw5x2/qImXPJ4m0VWAswQO3LBNwv7AWn7ka80=;
        b=n2H6TdywL69Pq7M/UEx2Xts7Qzc+MCx8/TZCRgP+7mmX7c5bNAtl6Ro3vIoO+uK35n
         k6zkkakGLDIiOFqBrHyFxeyD3WfEKdHG4Bk4l5vbPRBhstJTwhgZYnGhZUaVlEMdfHYV
         rLYsHordZCbDvReNFRFfImvVHdB8s+Scbb3gTKmw4Udl4Sp2IHNwsuYn1QWNJ04q71Oj
         HSmmSuTdmqQ3iE0egqeYEfcxo0kTPWEG0gmRwU07464YPpx099OM00XsLY8pNnIRYEYK
         oZ16ZCnWKIlO245rLHPnVYFA+0bbIkCFsB+lwsHadrK4NMXihgmvUNbpicfLXIHSX4Fh
         5uAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FWuUXrbw5x2/qImXPJ4m0VWAswQO3LBNwv7AWn7ka80=;
        b=H20rIyrbIAbSjcJ0JUqw7CxMT6Bwws4lHO2y+teDhEwtF6FkyCcRVwka8Ca4voxhz5
         A7m86JxmOmNID1W3aOWB51wMKYFGHxVlhuPnH9lCwBxoQC5QVnTaqRJ/vQRQf25aXrXM
         ramdP3bDqahosxq4JuyS8Xvu3qEnnDttFI+fO7FV49foqbvc1cu02OBIExse+K21bDOH
         DXvj5zOEgGaPD+cK9EW78jyHrn2trD48bGqTDer+cHC3VuXoSVjv5/kmQ7i3r32o9DAi
         OgUay1gGjI4eLcKj9F80TGj/mdKJ91VKGRqblngNylhrK536SP0NF2gQk02yFI9TP3Y+
         0FSg==
X-Gm-Message-State: AOAM531dRUI5X6EWa3k7O3y6LR6dJVJkBUPQlM45H6hz+tcjSNjYrueS
        bSr3tIwxtZd+cMYJ3W9AIxQ=
X-Google-Smtp-Source: ABdhPJz7RX996wM1S3lI17LbQb3ma+ycBRSQMOQAJYP0nEkSh3rGPhnHjai6tduSjqeDz951zQkNKA==
X-Received: by 2002:a05:6a00:1152:b0:4be:ab79:fcfa with SMTP id b18-20020a056a00115200b004beab79fcfamr6358576pfm.3.1645166907270;
        Thu, 17 Feb 2022 22:48:27 -0800 (PST)
Received: from google.com ([2620:15c:202:201:9800:6e8c:a0db:87e7])
        by smtp.gmail.com with ESMTPSA id g126sm9731901pgc.31.2022.02.17.22.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 22:48:26 -0800 (PST)
Date:   Thu, 17 Feb 2022 22:48:23 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Bastien Nocera <hadess@hadess.net>
Cc:     William Mahon <wmahon@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        William Mahon <wmahon@google.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org
Subject: Re: [PATCH] HID: Add mapping for KEY_APP_LAUNCHER
Message-ID: <Yg9BN1wU87t5ddoC@google.com>
References: <20220217053354.1.I3a7746ad05d270161a18334ae06e3b6db1a1d339@changeid>
 <93e5dc0bbeb0b44c9b225946b3ab81d3af3a1789.camel@hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93e5dc0bbeb0b44c9b225946b3ab81d3af3a1789.camel@hadess.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 11:35:24AM +0100, Bastien Nocera wrote:
> On Thu, 2022-02-17 at 05:33 +0000, William Mahon wrote:
> > The App Launcher key is used to bring up the Launcher menu.
> > 
> > This patch adds a new key definition KEY_APP_LAUNCHER and maps
> > 0x0c02a28
>  
> Is this a typo? It's not the same format as in your other patch.
> 
> KEY_DASHBOARD as used in the Mac keyboard drivers looks like a good
> match for KEY_APP_LAUNCHER. If not, it would be good to explain why in
> the commit message.
> 
> See 437184ae8bd1ef923a40b009e37801deae66ad55 for the KEY_DASHBOARD
> addition.

I agree that the spirit of KEY_DASHBOARD is what I think we want here,
but IMO neither KEY_DASHBOARD nor KEY_APP_LAUNCHER are good names for
this. Maybe we could use KEY_ALL_APPLICATIONS (and alias
KEY_KEY_DASHBOARD to it for compatibility)?

Thanks.

-- 
Dmitry
