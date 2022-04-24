Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E85050D39E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 18:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235858AbiDXQwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 12:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiDXQwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 12:52:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23EC13E3B;
        Sun, 24 Apr 2022 09:49:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 433D9611B4;
        Sun, 24 Apr 2022 16:49:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A5FEC385A9;
        Sun, 24 Apr 2022 16:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650818942;
        bh=77Pl2K8NTUry4sZCW3/QnIlnyl6J6z/j1k9mYvZOCNA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kdsEauZAbdyOaUz5DthJxSnOJEmeWAVplJlacmyj7v9YOhXxwSJ3QNDBaZ/DZGTPn
         iyVQZjm1gYG9Hvn602mhdq4OZ0OhiGn1TmvhAJM4D3Hu0bv4nfxSjxufJzWMoCNDTn
         flAFp7ovZxhBqPmRwDO6tt4UidF9y+8T+oeD//grWD9TO28cL9yjgA+ceTV6KAz2Lw
         CdzSt9Of5Wj3JDItjTyltDEodBdgV8clKz+B5WeE6yDMgAV4DV5TK064aY7Ldxug4o
         ydao8O9k6Dt27TZs+t4NU3WY2rzbn046Wiv2rOuPAIvFS8i0wga8FmIwT+U39xN9SK
         YvVQvYFTFMsAg==
Date:   Sun, 24 Apr 2022 17:57:10 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Arnaud Ferraris <arnaud.ferraris@collabora.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v2 0/2] iio: stk3310: Export near level property for
 proximity sensor
Message-ID: <20220424175710.0453ab11@jic23-huawei>
In-Reply-To: <20220420112540.91907-1-arnaud.ferraris@collabora.com>
References: <20220420112540.91907-1-arnaud.ferraris@collabora.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Apr 2022 13:25:38 +0200
Arnaud Ferraris <arnaud.ferraris@collabora.com> wrote:

> Userspace tools like iio-sensor-proxy need to be instructed the value from
> which they should consider an object is "near". This threshold can be
> exported through the sysfs ABI based on the "proximity-near-level"
> device-tree property.
> 
> This patchset implements this property for the stk3310 driver and adds the
> necessary bits to export its value to userspace. It is based on similar
> changes applied to the vcnl4000 and ltr501 drivers.
> 
Series applied to the togreg branch of iio.git and pushed out as testing for
0-day to work it's magic.

Thanks,

Jonathan

> Changes in v2:
>   - drop zero-assignment as the variable won't be modified if DT property
>     is missing
> 
> Arnaud Ferraris (2):
>   dt-bindings: iio: light: stk33xx: Add proximity-near-level
>   iio: stk3310: Export near level property for proximity sensor
> 
>  .../bindings/iio/light/stk33xx.yaml           |  6 +++++
>  drivers/iio/light/stk3310.c                   | 25 +++++++++++++++++++
>  2 files changed, 31 insertions(+)
> 

