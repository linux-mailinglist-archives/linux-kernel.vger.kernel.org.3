Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5BC488687
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 22:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbiAHV6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 16:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233141AbiAHV6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 16:58:47 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C553FC06173F
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jan 2022 13:58:47 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id n16so8799879plc.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jan 2022 13:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ewMb6x8qSgRhiQLnj41jmD5Jf2Gw2+saUAqctPrcO2c=;
        b=w9/7KlPbT9FQyV+9mSQdPl9F78lvYzYDszYA2ivdbja+c4oJE5crdNClxmu/GffdUA
         /TSjYcOlabCO7psTxdZJvCm1egr3Gp31fR/asnrlJSZFHZdPCPHWaiEfySl7BcQm1y9I
         GonrvTbMoJOFAwAvSK7FffJn49ehieE7WBF6fk+zEZLOr3MjqFlHP1zwiucbCJj/o133
         z1DTkurh+zVTV2zzGYiiMyeZStpw6CdqPW7t7K4t7aaSf09LgvtiWLapirj46h6o4iZz
         6oL23Ttl2mjYK+fmOgXEX5Eps4VCbAG8MEbn/WwQ/SjvqMITgM5r9qO5jQvG05kUuqTw
         HrjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ewMb6x8qSgRhiQLnj41jmD5Jf2Gw2+saUAqctPrcO2c=;
        b=Bpa5HFtZS6v1G6Q8uBg0aXhn1bqwDuqNv3J8ALuhhBgJFXwSQtBEfOzwm5Hs7/vlsk
         oWeuEIl31mrlIDcsBNhB1hcxAuxEdHBtX70C+KNDff8qfhQsrrlxQ9Bjw7aTBE9fLYPC
         qEKPcSINuWpgDGtWAR9AWZgw5qWxLStDe/FnmW670kWPcysRmI9MmsrR75EN9jGtWBQg
         yRkWCeM+pkUdx6fz3Xf6+XtPqRgKXF8GaQhWRjyHWlnFALIYgErwz9vKadZfRK7ldp/V
         ry3nFOW4wPZpK2oS98degH3mPkQE9LcbbZC7XbzuuHTeKfeAgCi91VpEBtkb1ufGudXf
         S97A==
X-Gm-Message-State: AOAM533Nf0OeQBvq5lfDW9XcrNqvy4A+Qx7UQ6AdsgZ/QuXt6gGYmzpN
        yncJX+votEP+eIsqirIHUaJ0Gp9IDzCauQ==
X-Google-Smtp-Source: ABdhPJwxLq2cEmd460c6VV/QK+DLhkjh2M1rDHCU9wbX7c4uGX+Td1WeqSvq3fdLkFCxPAEho1fNKg==
X-Received: by 2002:a63:6b07:: with SMTP id g7mr62621216pgc.234.1641679127302;
        Sat, 08 Jan 2022 13:58:47 -0800 (PST)
Received: from localhost (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id s8sm2862623pfu.58.2022.01.08.13.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 13:58:46 -0800 (PST)
Date:   Sat, 8 Jan 2022 13:58:40 -0800
From:   Olof Johansson <olof@lixom.net>
To:     Hector Martin <marcan@marcan.st>
Cc:     SoC Team <soc@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Apple SoC MAINTAINERS updates for 5.17
Message-ID: <YdoJEMjEr5jKwLf7@lx2k>
References: <24ae6871-3e67-5c7f-2060-28048db439a2@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24ae6871-3e67-5c7f-2060-28048db439a2@marcan.st>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 08, 2022 at 02:13:49PM +0900, Hector Martin wrote:
> Hi SoC folks,
> 
> Please merge this trivial MAINTAINERS change for 5.17.
> 
> This commit was waiting on the watchdog driver to be merged, but I only
> just now realized that it silently did. Sorry for the last-minute pull.
> If this can't make it into the 5.17 merge window, it can be added as a
> fix later instead.
> 
> The branch is based on asahi-soc-dt-5.17-v2 to avoid a merge conflict
> with other changes that happened there.

Hi,

I've merged a bunch of outstanding pull requests into an arm/late branch, but
I'm holding on to this one for a bit, we'll merge it once the main branches
have gone in, since it contains a bunch of that contents. Since it's just
a MAINTAINERS update it's fine to merge late, no need to soak in -next.


-Olof
