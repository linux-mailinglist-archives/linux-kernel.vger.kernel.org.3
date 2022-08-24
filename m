Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5223159F842
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 12:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236627AbiHXK7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 06:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236378AbiHXK7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 06:59:14 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827266613F;
        Wed, 24 Aug 2022 03:59:13 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id x19so15342142plc.5;
        Wed, 24 Aug 2022 03:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=Q3LzJlvifUAGbTLxcQoH7AaagIP6GFnZFwsKVBw+lLI=;
        b=plA1uj00ujDSe0KzXRc7a0wMWpT/Xk5/wm+TKlbkdJoXAXxij2ZFImAK+sv+sa35JP
         ahHMsDXRsDuHzhXSJLUoVaJxqBLLGM7MuhhhCGt+UhRUIxzARhQv3Oik/PkPGp/l/75B
         2WcsHcsv0NrACmVgyLBtpdxR8BGNb1IAgqsv3yUWmYjJa2wPFpXDD8zZ50GBGoDUXKEX
         zOskCrSh4NDxj3r7uOX7Yf1VBXeLGUlYYAbJ6lA7oHvb4CDzOZ6wGw5uD8OCqct3qJyH
         e5uO1JiRW8er9zjUsPB0PWkSrQJBAmBbXEN/bw9+SX15sMaUDXrBfFZx6ZEMeCVnixgG
         uZNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=Q3LzJlvifUAGbTLxcQoH7AaagIP6GFnZFwsKVBw+lLI=;
        b=hof03kGOsMM4m1WteinUgPhD7y55SECC+P2WB8QPIwPQVKrAagkGLKpa+ggLzKSpPn
         QMukAKls7s05oOM0y/2KbhDOtDB6LLxSBEwVB63mVRkx4F8MhxGH3i+MIN5uS8a8Dy7M
         RaRmGqkSIlu7cs1VQ4333v6BxkRAHHDI+IvellW5RzWP1Wk2LCfD6sS2RKGjUx3NYzrW
         NkdfvSK0fvvjS5k1tCQTUt64xhr+yvR66TbF9NrIsc/dRjCJzcM0nyN2+8jlQgi+ulqV
         NMskF+OUxTpuJ5RE+07RiPGIWwHcnOWAaFVGRUNQEwNPvzSD/OQt/yLD432KBv7qj3tk
         6crw==
X-Gm-Message-State: ACgBeo2nWFsaX8y8qfOQRUIxFeps4e4vMDNMnHtygcya9dM+K3JpK1gc
        XUUInkGZeOgpiZX+/y5THBU=
X-Google-Smtp-Source: AA6agR50ZGuvdB8+3Su+9vbP/9fi4BkOnb4p20DmyU2aYynxvE+qLNhRQ+m3UExS11ggL1jijcUZkg==
X-Received: by 2002:a17:902:ecc1:b0:172:dd1f:5b76 with SMTP id a1-20020a170902ecc100b00172dd1f5b76mr15558404plh.28.1661338752781;
        Wed, 24 Aug 2022 03:59:12 -0700 (PDT)
Received: from AA2000783-NB2.corpnet.asus (125-229-150-10.hinet-ip.hinet.net. [125.229.150.10])
        by smtp.gmail.com with ESMTPSA id z6-20020a170902ccc600b0017315b11bb8sm1186774ple.213.2022.08.24.03.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 03:59:12 -0700 (PDT)
Date:   Wed, 24 Aug 2022 18:59:08 +0800
From:   PaddyKP Yao <ispaddy@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Hans de Goede <hdegoede@redhat.com>, PaddyKP_Yao@asus.com,
        acpi4asus-user@lists.sourceforge.net, andy.shevchenko@gmail.com,
        corentin.chary@gmail.com, linux-kernel@vger.kernel.org,
        luke@ljones.dev, mgross@linux.intel.com,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v3 1/1] platform/x86: asus-wmi: Add mic-mute LED classdev
 support
Message-ID: <20220824105908.GA111@AA2000783-NB2.corpnet.asus>
References: <d7e2a109-c1b7-9f8c-c2b2-b765f016a9a3@redhat.com>
 <20220711115125.2072508-1-PaddyKP_Yao@asus.com>
 <e120ac7c-7abb-4999-efe8-6b3b697d12d6@redhat.com>
 <20220824100622.GB1049@bug>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824100622.GB1049@bug>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On Wed, Aug 24, 2022 at 12:06:22PM +0200, Pavel Machek wrote:
> 
> It would be good to get the API right before it hits mainline release.
> 

What do you mean about API you mentioned?

Best Regards, Paddy
