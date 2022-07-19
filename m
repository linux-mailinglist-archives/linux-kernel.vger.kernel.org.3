Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C233357A697
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 20:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238794AbiGSSh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 14:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233698AbiGSShZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 14:37:25 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835AD4D147;
        Tue, 19 Jul 2022 11:37:24 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id r193-20020a4a37ca000000b0043578138958so2792521oor.4;
        Tue, 19 Jul 2022 11:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=gf82HO1596zr/ZdVJzwHUoOwQLVuNiT/mo6nU8RmnGQ=;
        b=jeIFGH+KzDKcl+MBCucwjiQRaU0pRfTTCh9SJj++4Osn6QQR73xSYQLvIuI63x7ffl
         9VkEyM+FY3onrDQaFNgFyPCVYfeXSJ+r84k3HI8jq/fqMxd2Mm80ApYgDg/E8KGk2LLm
         0AXTwuXwIQEnej0dTh0OJMgcvhK/8LyXaainPd3F7x3iQ23dr+CjnHAWodEq2ohxzcyg
         I8ewG9gCaz/urqgROryMdBwuwX+cAxBySsOFMWf0y2ulVBOVzn8pfgeFQZ/6mRDJHfYW
         7aLmho2QpsLOFDYWnRehI2leiQOzjNY+pOTTBYft9Vnt0wn8NLF3RlpjjXlt7txx5JmU
         C0/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gf82HO1596zr/ZdVJzwHUoOwQLVuNiT/mo6nU8RmnGQ=;
        b=fD9Z+BJmHeM5lB9LZt1MyxS3l54d3+w/6KoLlqUzRnWXcNjPp7uzmuBdCKVbUJ9bcv
         4WOj+PFgatB0+iISP17Snnm1L7ZVRqecwYjnh6P3+f988FphMW8tckk4c8K0sjoQhsEj
         SEAKDA55kauqrKJMUCgxo5XSfYnt+OHYEWGe7c43BCoXwS0GdWzh2iaFkAsBPVWrhlsh
         wlt4ghGgkUbDl0TK9QOR0ATnojrFCvIYS61ASarmOyqrOC5nPcp0x3s6EWWI/k/UyfCc
         JRPiJB+w557LF9TwArk+9ua7VM8U+oqeqrU+DbALoR4ZOF8r8vbxm9zZmMlpF1wXTdSX
         eDJA==
X-Gm-Message-State: AJIora9iJseV/q1wibKF+bKm61AQBQdE9LqqSVuJi3Cn1K3h/wlE0j1E
        eXrJtP7rV21ZL6AM/4ZWWSU=
X-Google-Smtp-Source: AGRyM1tt0u4BvgNqwgDe4zS80Vp20ZUXB1ZBsZUjkl3fsyZyxbDag+KEFYkMXfP5E9TiwL7bgNQNqA==
X-Received: by 2002:a4a:ca8d:0:b0:435:772d:fca0 with SMTP id x13-20020a4aca8d000000b00435772dfca0mr9282989ooq.94.1658255843853;
        Tue, 19 Jul 2022 11:37:23 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:18b3:c058:b2c3:9b8? ([2600:1700:2442:6db0:18b3:c058:b2c3:9b8])
        by smtp.gmail.com with ESMTPSA id l15-20020a05683016cf00b0061c98bd6278sm3630859otr.73.2022.07.19.11.37.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 11:37:23 -0700 (PDT)
Message-ID: <aac636b3-eb69-2add-86f3-b2961c30fd07@gmail.com>
Date:   Tue, 19 Jul 2022 13:37:22 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 0/2] of: overlay: Miscellaneous improvements
Content-Language: en-US
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1657893306.git.geert+renesas@glider.be>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <cover.1657893306.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/15/22 09:03, Geert Uytterhoeven wrote:
> 	Hi,
> 
> While performing the long-overdue rebase of my topic/overlays branch[1]
> on top of the overlay rework in v5.19-rc1, I identified a few areas for
> improvement in the upstream code.
> 
> Thanks for your comments!
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git/log/?h=topic/overlays
> 
> Geert Uytterhoeven (2):
>   of: overlay: Move devicetree_corrupt() check up
>   of: overlay: Simplify of_overlay_fdt_apply() tail
> 
>  drivers/of/overlay.c | 20 +++++++-------------
>  1 file changed, 7 insertions(+), 13 deletions(-)
> 

For the entire series:

Reviewed-by: Frank Rowand <frank.rowand@sony.com>
Tested-by: Frank Rowand <frank.rowand@sony.com>
