Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E60C4967F1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 23:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbiAUWnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 17:43:10 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:40572 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbiAUWnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 17:43:09 -0500
Received: by mail-ot1-f53.google.com with SMTP id x31-20020a056830245f00b00599111c8b20so13572454otr.7;
        Fri, 21 Jan 2022 14:43:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fSCyBKp32UqtmME5uEE03YSNJoMhr1xa+A5W+klSh0M=;
        b=doi9jkvH+7ACLFFNk4RD7gSs+nWJiK4UjUjDCGMcKTKBAomTCrEaGuIeuinnACGgTi
         BF5OYG3InQ2gc80JGg0C3IBHTs5vueGHiULjN5eGhqYVNtUzmtjZZZyiyv8KUkhCbips
         g/1+9VxRNrpOjaT5aYw4D7Bnp2QfReRqyg4QJvNt+XwjdQmabj7fBWLzojU+fato7vbE
         bqZCkEhFgtx9zDAz25NUnp6w1RCifScGrKwlGVmb41z+BJxMs8U+R+hTWs7aSVX3PJd8
         hcfDvDjaOqXvL8H4LvPXMwUAlYMcNnxUNLMzsyBkScnqV5LQy62nAb3L3tt8p1nUSBy4
         b+QA==
X-Gm-Message-State: AOAM533ULW2P/fdJ7S1bmYXocK/ZvF3Wdc/KEB5wq7DlTQtFdYY0GHhn
        usYqA1d2PmHNMWUcvmsfs0S/5F1WeQ==
X-Google-Smtp-Source: ABdhPJwi/s/S/RjfhvcBBnx7DFAIM5Ln5eCBuljWjbPY5eEdgoZw+Bs7bH3H7LG56dAD1E8iFaTtOA==
X-Received: by 2002:a05:6830:440b:: with SMTP id q11mr4393367otv.270.1642804988479;
        Fri, 21 Jan 2022 14:43:08 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id c27sm1675363otd.69.2022.01.21.14.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 14:43:07 -0800 (PST)
Received: (nullmailer pid 1739739 invoked by uid 1000);
        Fri, 21 Jan 2022 22:43:06 -0000
Date:   Fri, 21 Jan 2022 16:43:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     alistair@alistair23.me, alistair23@gmail.com, andreas@kemnade.info,
        devicetree@vger.kernel.org, dmitry.torokhov@gmail.com,
        linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        maxime.ripard@bootlin.com, mylene.josserand@bootlin.com,
        rydberg@bitmath.org
Subject: Re: [PATCH v5 1/4] Input: Add driver for Cypress Generation 5
 touchscreen
Message-ID: <Yes2+ps8qTT52g3Z@robh.at.kernel.org>
References: <20220109115331.388633-2-alistair@alistair23.me>
 <20220119012637.1713748-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220119012637.1713748-1-pgwipeout@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 08:26:37PM -0500, Peter Geis wrote:
> Good Evening,
> 
> I tried using this with a cypress tma448 and thought there was an issue
> with the driver.
> Further investigation found the tma448 in question had no configuration
> burned into it, thus max size and pressure are zero.
> 
> I've added the patch below to extend the driver with device tree
> overrides.
> Unfortunately device_property_read_u16 is broken on arm64 currently, as
> it returns zero.

FYI, I replied to your bug report:

https://lore.kernel.org/all/CAMdYzYquceSBrOsvO8rW9wmJA_RO=HSwv_waVoS=0hsP414T-A@mail.gmail.com/

Rob
