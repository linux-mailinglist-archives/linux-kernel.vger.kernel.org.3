Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6ACB586E5E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 18:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbiHAQNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 12:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbiHAQNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 12:13:50 -0400
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6E9371BA;
        Mon,  1 Aug 2022 09:13:49 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id h145so8729854iof.9;
        Mon, 01 Aug 2022 09:13:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=HOeZrXGvQWgmw/kn9A6WzMB35arB2Qy0jWKFW84PCac=;
        b=oKIKrJcWFoBT5P0i3byKK5S8Sbc47oRpQQWfkN7bSDKMWS0grCiEPa3Ja0ks1zTx6u
         KS4B1RIyRPJTIzBZcdEl4qWiqCrTLMFqJwthobVhJoYzDC6F2MisNJHpjkzyrn70gDhX
         qJBeOJZUuvInLL5+5HUvLkvBHVGXEt7QZxyDwicunsW1DyOVrNYOQJy8nF/Ph3lRr17J
         YCvJntb7XGZU4WauhMseG1aWv0xoLuPOK1A05hXHYp1HhwGFY7o0Uy+cR5kKE7iL4UzG
         /FYYuNr2p1o/8NVGIyXhfv/cgkfriAw+PL/O7/8hZjOGr72f7bxG7lMN0z+idgMkUQ78
         zmAg==
X-Gm-Message-State: ACgBeo3hfXcTHATSGM/aNH5CVmQwR/mRx78JOfi5K2Te7fRbgauJhGwu
        WCtUm5NUOhR6zIX4f1Orjg==
X-Google-Smtp-Source: AA6agR77X6e+kL2ohXCtQSY24Igj/v2LMUzRDPzkde/WIrjwQSvtJo5GAXuSc8asvPT97SJBCMliVQ==
X-Received: by 2002:a02:ccb3:0:b0:342:712e:98a3 with SMTP id t19-20020a02ccb3000000b00342712e98a3mr2936945jap.204.1659370428907;
        Mon, 01 Aug 2022 09:13:48 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id u13-20020a02b1cd000000b0034272104854sm1912896jah.115.2022.08.01.09.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 09:13:48 -0700 (PDT)
Received: (nullmailer pid 1112748 invoked by uid 1000);
        Mon, 01 Aug 2022 16:13:47 -0000
Date:   Mon, 1 Aug 2022 10:13:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Xu Qiang <xuqiang36@huawei.com>
Cc:     linux-kernel@vger.kernel.org, frowand.list@gmail.com,
        weiyongjun1@huawei.com, robh+dt@kernel.org, guohanjun@huawei.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH -next] of/fdt: declared return type does not match actual
 return type
Message-ID: <20220801161347.GA1112588-robh@kernel.org>
References: <20220801120506.11461-1-xuqiang36@huawei.com>
 <20220801120506.11461-2-xuqiang36@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220801120506.11461-2-xuqiang36@huawei.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Aug 2022 12:05:06 +0000, Xu Qiang wrote:
> The commit 649cab56de8e (“of: properly check for error returned
> by fdt_get_name()”) changed the return value type from bool to int,
> but forgot to change the return value simultaneously.
> 
> populate_node was only called in unflatten_dt_nodes, and returns
> with values greater than or equal to 0 were discarded without further
> processing. Considering that return 0 usually indicates success,
> return 0 instead of return true.
> 
> Fixes: 649cab56de8e (“of: properly check for error returned by fdt_get_name()”)
> Signed-off-by: Xu Qiang <xuqiang36@huawei.com>
> ---
>  drivers/of/fdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
