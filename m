Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1053649C7AF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 11:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240086AbiAZKjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 05:39:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240080AbiAZKj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 05:39:29 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B65DC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 02:39:29 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id w11so12782518wra.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 02:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3PKx+wgkHSWhWqOvoZTHz3Rmd0Wk1o8dzzj6Rm5kLe0=;
        b=Fi3FeyqRQ1h7EDmh73+ZBbv8oTzQALZE+VjpOrPuiTszZ6WCai3jx08PtxmItxgz9v
         I266zv2nOcIcaNai41IRwS8tSlitYKZIK5n7Oh3P9f1hNom6UrDLp76na/lHy5Rmt/db
         XCQpR0zgCjDCDxQlks51nHNPP2vkIkVLMGSOxV6+LPZZ3Yeu0zQifI1vjbTjnZcYOj4e
         HJ+7vEkZVHoFx9hJ6SLXeQr5+8VoEMQemIlSEfUvPuv1gvOKrq7VgxOxsigjt9ZEhtWn
         94iTiqu0PURrOJJBIIh5pvQlGpkuoIV/wZwygG/9pyBjoTb1xyNfMGlCqa5+K9G7df86
         bmyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3PKx+wgkHSWhWqOvoZTHz3Rmd0Wk1o8dzzj6Rm5kLe0=;
        b=AJ1vcS5wLMoZW0Z+e+m8h5Ob+E0BFNYB8s/2km+9zlHk+qeceSRvQZNN2trJORVSjg
         REGmZP4ip14eznicblh5V0EegvhUmDwC0CA/kc8x5riMjjgeL1KbgqHGZ0ix5rMNsGq9
         WchYbZCFNpJVlR9FBGx61YubvH/yec+pgeHwXdK20Dg+0WYeSG1v0OkU+6UCxKGlJqaf
         RAWAlAAgCk4a4Pz5CrLQvRP1JLTZvVUqMnUrnQBYS2bWwuSGEtHDO/ugpO5v3o65mbyV
         KQfdNgB3yke/TFiWkuc7t7vss5gWUZo8jmLHUeP1dVfrRDVfbIInJGczWPoiZr7ozFme
         uNEw==
X-Gm-Message-State: AOAM533Xi0jxk+uCyCB2bS7iti6G6V46a7kgt3C+m/q7pyxBKWePb4w+
        Qm8/E4CohScodIrG2mnm2tmBURDg1vchCQ==
X-Google-Smtp-Source: ABdhPJzB/6vPoMYphNI7RndINT/0Bt0+E4vGR//EccEoWHSSkwRoQTSYXl+eVU+BUF2MXizZjeRUkQ==
X-Received: by 2002:a05:6000:184f:: with SMTP id c15mr8533004wri.208.1643193567773;
        Wed, 26 Jan 2022 02:39:27 -0800 (PST)
Received: from google.com ([2a00:79e0:d:209:bd2e:4d3b:b065:fa46])
        by smtp.gmail.com with ESMTPSA id j15sm3656384wmq.19.2022.01.26.02.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 02:39:26 -0800 (PST)
Date:   Wed, 26 Jan 2022 10:39:22 +0000
From:   David Brazdil <dbrazdil@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Frank Rowand <frowand.list@gmail.com>,
        Will Deacon <will@kernel.org>,
        Andrew Scull <ascull@google.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/2] Driver for Open Profile for DICE
Message-ID: <YfEk2oPcDdjHKOnC@google.com>
References: <20220104100645.1810028-1-dbrazdil@google.com>
 <YfEOlN8Wshoa/aaB@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfEOlN8Wshoa/aaB@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Wed, Jan 26, 2022 at 10:04:20AM +0100, Greg Kroah-Hartman wrote:
> On Tue, Jan 04, 2022 at 10:06:43AM +0000, David Brazdil wrote:
> > Open Profile for DICE is an open protocol for measured boot compatible
> > with the Trusted Computing Group's Device Identifier Composition
> > Engine (DICE) specification. The generated Compound Device Identifier
> > (CDI) certificates represent the measured hardware/software combination
> > and can be used by userspace for remote attestation and sealing.
> > 
> > This patchset adds DeviceTree bindings for the DICE device referencing
> > a reserved memory region containing the CDIs, and a driver that exposes
> > the memory region to userspace via a misc device.
> > 
> > See https://pigweed.googlesource.com/open-dice for more details.
> > 
> > The patches are based on top of v5.16-rc8 and can also be found here:
> >   https://android-kvm.googlesource.com/linux topic/dice_v6
> > 
> > Changes since v5:
> >   * replaced 'additionalProperties' with 'unevaluatedProperties' in DT YAML
> 
> I am going to drop this version from my review queue as I think you have
> a new one instead, right?

Sorry for the radio silence and yes, please drop from your queue. I need
to post a new one and get back to Wedson. Hopefully today.

David
