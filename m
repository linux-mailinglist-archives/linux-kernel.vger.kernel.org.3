Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B7E4E30CF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 20:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352683AbiCUTed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 15:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237280AbiCUTe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 15:34:29 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B3817E2F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 12:33:02 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id a5so16407016pfv.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 12:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tirotech-co-nz.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mTcv/jcGvlCAzFAcpV2LN2VRjOMjiLq8TD7kn8LXK64=;
        b=cUHCZSKDLzgOvN8a9hJMwdQoWOvXCM7ye0Tmipjyk7EOzzSFIb6WL/DnTxEHoBIPD8
         WOL7d+ENtPoxcPuhNQ7aJ6irVJxTEVpwZfSOfZqD4JAQJBp7LzKDnddCTo9T3o5yMW8W
         wCysltdt32BHaijo5A76Hxt3m1hisXLoR+DJKDJ/2j1mUUWbY5GaNs8QfcqADSIgvdKh
         ENw9GDCcsX3r7XthVX5ceVEKlBfyz3cMtIoq0QW5viuDp4QJsi0i5FFtjYlftdi/Y1Xt
         Y+TbBDh/I+Lu0yhvq0/F2XTpzwBHIK6KTyy7xE1enFFZLuGVkOpVrv+ZvHmOLToGNJHe
         TXGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mTcv/jcGvlCAzFAcpV2LN2VRjOMjiLq8TD7kn8LXK64=;
        b=D0vGYCSTdVsUq+jNPqCa/8NM8A4FiujUW8yIXbaJ4O3BFL7AEFKShvgzGkza9IRokH
         J57RvEfURCiGVpGZmN5ySk9gnMIdWt4Yl3/e+e/EfPPDsS0QpbDgfvXxCRxa9jH9jJOT
         yY9ejSswcEUVzSvCq2bU90hNE1U68lFZA7QlPyTUuzOaB9kQ8A+4bqby2tCMWJqADx6h
         F1KYjU5LpLTu565Ircf5Z9L71/xSnrviI/F0RB83fu7AP8Ll/urMm/W/CcrwIvLrQTAy
         sOs0jYMAM3rdEinIyt9BSsstf1f2+Zm9+BkI3I7gI8KR/6UzQmeug7ZK+YIEXG3GK1Ej
         SAXg==
X-Gm-Message-State: AOAM530rUY8Z/gpEuA5AKlnusXqLH8tc4kJeOMHixbu2NW+OYcnzK2Im
        WUofyIyqVAgo6R42kgYRHHYJzw==
X-Google-Smtp-Source: ABdhPJxK/70IoXPFutwY/2eM1ULfeu/nA8weeeXYaYqv58PPnbYwvUTCR5I+Y7vGuAWAGhDa4S1Vug==
X-Received: by 2002:a65:6091:0:b0:35e:d274:5f54 with SMTP id t17-20020a656091000000b0035ed2745f54mr19060386pgu.200.1647891182016;
        Mon, 21 Mar 2022 12:33:02 -0700 (PDT)
Received: from localhost ([121.99.145.49])
        by smtp.gmail.com with ESMTPSA id 18-20020a17090a001200b001c6320f8581sm233604pja.31.2022.03.21.12.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 12:33:01 -0700 (PDT)
Date:   Tue, 22 Mar 2022 08:32:58 +1300
From:   Daniel Beer <daniel.beer@tirotech.co.nz>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] winmate-fm07-keys: Winmate FM07/FM07P buttons
Message-ID: <20220321193258.GA31646@nyquist.nev>
References: <6237f057.1c69fb81.1689.fec7@mx.google.com>
 <2cf4e8b2-dfaa-dd7d-9c00-c7d58eeb367b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cf4e8b2-dfaa-dd7d-9c00-c7d58eeb367b@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 11:22:40AM +0100, Hans de Goede wrote:
> Do you have control of the firmware on this device?
> 
> If yes then IMHO it would be better to implement this in ACPI
> using the intel-hid fw API for this, see:

Hi Hans,

Unfortunately not. I don't work for Winmate and they haven't provided
any documentation on this.

Cheers,
Daniel

-- 
Daniel Beer
Software Development Manager
Tirotech Ltd
