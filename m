Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72AD58B845
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 22:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbiHFUqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 16:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiHFUqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 16:46:20 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64EF160F5
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 13:46:19 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id pm17so5637152pjb.3
        for <linux-kernel@vger.kernel.org>; Sat, 06 Aug 2022 13:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=YzqtcGqN0L2rq2pswMCoulyCAGZdtTSnYYDw0hYySOY=;
        b=Wn3k+xAUHbBzpeyRCFdNVhuaPNjc3Bil1+782KGI48yqMIUwUmq2ao9OEfA0MLBq/l
         Zi1FWKWmW2OmGbZidlaRGSdD41TOciU4lfXMfIU65o4Km3ih5OMQ+RSoveCBr1MAgcQc
         DlLu27kKVk6ugm18RL/KCSxoMi1t3u8naTkMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=YzqtcGqN0L2rq2pswMCoulyCAGZdtTSnYYDw0hYySOY=;
        b=JUZDdwSOI/PapogEkp+qsw7vWjY5m5bd8WfQzlsTmzXNxgTx23Itd1N63Z6Bzg+RCL
         IceuupTDZwhfYOEzM9R7auneqBmU67XpYEr1WwZ/Hm1EFaKBNqY4Mq2PxcbS9kk8A3j1
         OL5VuNpEZOgGLqVZs9EiiGVnfEARxi5zP9atVhOxzb2BcJf4445TpvGbvNMA/DjCsJm2
         RB0n5u5tYMGR2cXWfZrkF/MS2CIzWypGJXe3ORTVWRcem1Nvyk5rs0gV3Z5MoXkarcxM
         W/vNSM4yJdq7iIwfGp4h7myIKbb05S+fmbt9Fc4/U3K35Z9TfceRI17XhVefc23zje9V
         zvzQ==
X-Gm-Message-State: ACgBeo3Q4vWiTytVLpzfjSxAHSMH8d8a87Y2oXpX4i9PhFIk7sL1gVS/
        rwgF2Tp4NdGQZlmeEf59s4I7rg==
X-Google-Smtp-Source: AA6agR52kGQIUMo1Zs7sRS09nHLKeqqWiI3gxI135mtBjyQIcpintCGliKMhlBJbs/F9/md7fC+I0g==
X-Received: by 2002:a17:902:d651:b0:16b:f55e:c626 with SMTP id y17-20020a170902d65100b0016bf55ec626mr12631018plh.78.1659818778882;
        Sat, 06 Aug 2022 13:46:18 -0700 (PDT)
Received: from chromium.org ([2620:15c:7c:200:43d8:ac7e:8aab:d91e])
        by smtp.gmail.com with ESMTPSA id n16-20020a170902e55000b0016d5626af4fsm5610020plf.21.2022.08.06.13.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 13:46:18 -0700 (PDT)
Date:   Sat, 6 Aug 2022 13:46:16 -0700
From:   Jack Rosenthal <jrosenth@chromium.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Julius Werner <jwerner@chromium.org>
Subject: Re: [PATCH v7] firmware: google: Implement cbmem in sysfs driver
Message-ID: <Yu7TGDYTyzFLoVe4@chromium.org>
References: <YuuBrUmiRYoaSmPw@google.com>
 <20220804142856.306032-1-jrosenth@chromium.org>
 <CAE-0n51UcauP1ojoskV9_2+CFPoJrs08jGHVPCZdSA_oXX1zUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE-0n51UcauP1ojoskV9_2+CFPoJrs08jGHVPCZdSA_oXX1zUw@mail.gmail.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-04 at 15:59 -0500, Stephen Boyd wrote:
> I suspect this won't work because the driver can be unbound, and thus
> the mapping can be destroyed by devm, but then the kobject and sysfs
> file like 'mem' can be held by userspace after the driver is unbound.
> Userspace access after that time will try to read/write unmapped memory.

When the driver is unbound, read()/write() will return -ENODEV, and
mmap() isn't supported.

> Why not make this in the bus driver (coreboot-table.c)? In fact, most
> things could probably be created there instead of in a 'driver' that
> really isn't doing much 'driving' at all.

In v8, I moved the coreboot_kobj to coreboot-table.c.  I imagine in the
future we could move some of the other things (e.g., "vpd") under this
object for consistency.  So now the structure is:

   /sys/firmware/coreboot/cbmem/<id>/...
