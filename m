Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 210E1507C90
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 00:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358185AbiDSWfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 18:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239995AbiDSWfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 18:35:03 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25F427B2A;
        Tue, 19 Apr 2022 15:32:19 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id ay36-20020a05600c1e2400b0038ebc885115so1524275wmb.1;
        Tue, 19 Apr 2022 15:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+PTnmzEG+tuThpv8cGHIrd6DNmaKC0BUsX1pkxVZEfY=;
        b=J/hMLqNmwDzPDAKl02cqLJ5pjGpWQt1Lh99uMsaHyUeJQR6BD1UOnLTm7zvmU8yabS
         iFJznehjHhqT681LI2pYoO6G+3imjYsvLuow1pBojSLn5VJVHCvV4gwDnv45qrr2sjYc
         4O9SQcI9XOXXER5iuPPAULEfDQjkJF9AYMLyJ52qG/YBfDPmxmSvcMKPY8xxzpgJ5qh2
         867MxlKQsUvkTqw2e4rHxcM1iCAcw23A/u3tQj5Q7mOQHEn+JYLcAgJ0nnNkX/OFDusI
         sfdGQNg38NlUd+BbcbXMZoFDheV5n1bnftO6LXvdWlKXQd3XMydWS8PJBUtZJFqtruES
         UVKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+PTnmzEG+tuThpv8cGHIrd6DNmaKC0BUsX1pkxVZEfY=;
        b=NJT9xJBn8LjkasQbvdlZPMpvdreFZTcxeI+sKdewuZ4LveRPf6ELoBNdtsHKMljAkg
         KS/vLQ/pN0nWWfWVg6pfj5Pkk6da4WhTR9nvvvWkwGYI512kuh7co+hGf2p9MhtIgKm+
         iVfwYJmao3RKVtOBaKK4jRjkKXzO2U/jvO4FUFjxJ6uI5mev0xwOpoR4yj3o0x7SRZP7
         6Qkxnju5F+rPR4dhGARtmtpaLY05yvilsbLrYWmBZOsZ4ixyCAH/BtQ/sqOJ+mEk7C0g
         3a4Ep5VQ7/ezBRlaA1Q+O+kNP/3UkURflhrQo3vXWt4vg9hBcrZMtyM9dOOIH/TSasD3
         oDeA==
X-Gm-Message-State: AOAM532CX5crao09gNmB4mv8i1+J0za9Iem9AESMAv4BCth04dhtBiTa
        h3GEZ41zNKnBwH2YLY8cR4oKRMxp3DN0bA==
X-Google-Smtp-Source: ABdhPJwqT47a0UBxIwT27dybEiLJubfsh5ZbT+kQZYeZZ3ca3qDOt/eM9ffhfXHk5Qn+vKt9kaXYag==
X-Received: by 2002:a7b:c5d0:0:b0:355:482a:6f44 with SMTP id n16-20020a7bc5d0000000b00355482a6f44mr674259wmk.58.1650407538346;
        Tue, 19 Apr 2022 15:32:18 -0700 (PDT)
Received: from tp440p.steeds.sam ([69.63.75.250])
        by smtp.gmail.com with ESMTPSA id o11-20020a05600002cb00b0020a88c4ecb5sm9709726wry.3.2022.04.19.15.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 15:32:17 -0700 (PDT)
Date:   Wed, 20 Apr 2022 00:32:13 +0200
From:   Sicelo <absicsz@gmail.com>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] power: supply: bq27xxx: expose battery data when CI=1
Message-ID: <Yl84bed9pZaF7H4x@tp440p.steeds.sam>
References: <20220419213647.1186284-1-absicsz@gmail.com>
 <20220419220959.jnyhycaarxtucymo@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220419220959.jnyhycaarxtucymo@pali>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 12:09:59AM +0200, Pali Rohár wrote:
> NAC (Nominal Available Capacity) is exported via CHARGE_NOW property.
> 
> So what about implementing CHARGE_NOW property also writable and write
> operation would do this WRTNAC seeding? So userspace would be able to do
> 'echo new_value > charge_now' and for Nokia N900 case just directly
> 'cat .../rx51_battery/charge_full_design > .../bq27200/charge_now'
Thank you for this suggestion. I'm afraid implementing it would be a bit
too involved for my current level of experience.  If someone beats me to
implementing WRTNAC ability, all the better.  Otherwise I will
definitely want to look into it in the future.

The challenge with seeding via rx51_battery is that it provides
CHARGE_FULL_DESIGN, so one must still calculate a NAC value from the
voltage. In my userspace script [1], I am currently using a linear
calculation, but obviously this is not really correct.

I might mention, in passing, that I also wish to later add the 
VOLTAGE_MIN_DESIGN property (which will be taken from EDVF). It may help
userspace (e.g. upower) know when to shutdown the device if CI is set,
as capacity cannot be trusted.

Regards
Sicelo

[1] https://gist.github.com/sicelo/0a0e895d81a6b73b26555d215dee296d#file-rx51_seed_bq27xxx-sh-L34-L42
