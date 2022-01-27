Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E95449D812
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 03:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235164AbiA0CbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 21:31:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235159AbiA0CbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 21:31:20 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56785C061747
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 18:31:20 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d18so1281739plg.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 18:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/+eRF4BZ3tTy/ASyWDjy8fK3DAjpfZ5B0yUKffA62sc=;
        b=RtBFwQLvghr0bKZt8o0ujYoZIxrqrrdMuDfo+8ozx8bZzBA0MJYkMcImqh+werc/2B
         ILxbYf6ot/VZjtxWnp36bXvSZd7zD5HyTTIKFJ+w46s7fx1zXQyOjw4Un53UE0QxAKi7
         OZRAnuRSD5/+d/hKYiHmgvWtbVxIpk6gvPbToTY+z851QK9pHzz0k/I2pC21h+Xzpmtj
         8GQm+LGWSxWztGwDONZABzEuPXAiA6+7WdcttenQjI6/1TvD9L7bPSexhUrY8FY9nzPy
         sXLJKiR0zcG/UBPNVSill1UaCojE8mqumnGGczeBCMXH7vcQeLUakqwAsMTuoODnmcDI
         T6QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/+eRF4BZ3tTy/ASyWDjy8fK3DAjpfZ5B0yUKffA62sc=;
        b=sKBMjO1cQ4q1Pi5SQi71UmmMt2eBuwJ781truJc5xGwOEON1DqezdP5mV0qC2UIh+M
         cWeNwVf27J59HconH5OFHv+OhiZRTrmxUq323IUFZS4hZJLXYczVGANUxYZ67mg7T5yt
         jWRYpOHWB2H+5Sz+r78nMjxUBVc8tscuCvbe/yE2jcd2r+2Wko+PYegL4jZG/1iMoT5q
         P6wjCcAGXvjqb10Qj9BJhoyZHvPFzD+uN1aZ+b2KeJLlEWhs1EQuDbug5SRONzwBrNMk
         vhbsakGAGOu+kQmJK65KYNFataqGMIBwXA6Ey5ITfmWlj+JlnJKDSvVmGgLUa0fWtcxZ
         ernQ==
X-Gm-Message-State: AOAM530lt5FPxUbbXsl0V7xG9FeBwUaIGWpErr1WvkrTnxhj4/mmoHGo
        53NXxrCw5Gvig7WP+J8Y+UHHTA==
X-Google-Smtp-Source: ABdhPJzGyJlDx3Aj8sNJy4V12gMazAiPRsegp4PUfw8oEBeqklGKdQepPr+NCUGhTLgShKgRjnaXgA==
X-Received: by 2002:a17:902:d4cb:: with SMTP id o11mr1332120plg.43.1643250679584;
        Wed, 26 Jan 2022 18:31:19 -0800 (PST)
Received: from google.com ([2401:fa00:1:10:c283:8675:30a2:a4ed])
        by smtp.gmail.com with ESMTPSA id s2sm8260862pgq.38.2022.01.26.18.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 18:31:19 -0800 (PST)
Date:   Thu, 27 Jan 2022 10:31:16 +0800
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     "Dustin L. Howett" <dustin@howett.net>
Cc:     linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Michael Niksa <michael.niksa@live.com>
Subject: Re: [PATCH v2 0/2] platform/chrome: add support for the Framework
 Laptop
Message-ID: <YfID9LgDOW0GkJ26@google.com>
References: <20220126180020.15873-1-dustin@howett.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126180020.15873-1-dustin@howett.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 12:00:18PM -0600, Dustin L. Howett wrote:
> This patch series adds support for the Framework Laptop to the cros_ec
> LPC driver.
> 
> The Framework Laptop is a non-Chromebook laptop that uses the ChromeOS
> Embedded Controller. Since the machine was designed to present a more
> normal device profile, it does not report all 512 I/O ports that are
> typically used by cros_ec_lpcs. Because of this, changes to the driver's
> port reservation scheme were required.
> 
> Since this EC driver probes the MEC range first, and uses only the MEC
> range if that probe succeeds[^1], we can get by without requesting the
> entire port range required by non-MEC embedded controllers until
> absolutely necessary.
> 
> [^1]: this includes "memory mapped" read - where the traditional LPC EC
> requires I/O ports 0x900-0x9FF, the MEC EC multiplexes reads/writes
> over the same eight ports, 0x800-0x807.
> 
> Changelog in v2:
>   Cleaned up the commit subjects per request.
> 
> Dustin L. Howett (2):
>   platform/chrome: cros_ec_lpcs: detect the Framework Laptop
>   platform/chrome: cros_ec_lpcs: reserve the MEC LPC I/O ports first

For the series,
Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
