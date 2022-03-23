Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173BB4E57DC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 18:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238942AbiCWRxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 13:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbiCWRxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 13:53:50 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE1683B2F;
        Wed, 23 Mar 2022 10:52:21 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id b130so328830pga.13;
        Wed, 23 Mar 2022 10:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TFRXJEScuv6NoH0MKXIcE9CGacdsgUSrF/Tlmi+1uH8=;
        b=QkSoN9aTGcSYlvcc8LQoZ0aNOYAbC33cFCiM7XjkCmjyFNfvPbvMZ+ZopySUnJr6o7
         1oTfm+ayDTSdlXGqUtdZn0SmavDAF3RbNhdbJAfNV5K/OabiQmMQcmveCwZ10wjqLx7B
         gUvZqA+0tKQr96CGX6e8D7ASj02qj/9tAmtIMjP0favfcNwGV2rROA9XoLGOE9fdIvV8
         RVUKcB9wMvj1nMRloeCv/BAfyhGdvw+n4mv7hzqAgMNeZHI8lQv69prVOoJvpS4M7Xsm
         3EbbMRcNOcvlGFkdOylmD1pXxmYmqxNno9hnQ7ZdsfnWdOqQeKjXW4MKuqIlfspoNMDk
         0ktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TFRXJEScuv6NoH0MKXIcE9CGacdsgUSrF/Tlmi+1uH8=;
        b=R7TtzUogsojr1qJPTu44h7U6JwYiAlNivYbptbhWBjAtSd2rcqdlVIi04A/t9eg1iw
         ROmwOHTl+0sGFQM4LoHDWdqh6tGSKnX8lQEP2nePBZFTPGy4A3P8KHmZflM5naEUzeAO
         Nf/aCi6HrZg/ZzOgTXDlaMsAGiKGWdh/NGLYl8Sm8hdngQtycoFslCYUHw/A1hGAbMGf
         ybvV683VvVa+oG6z3yZEouzsy/6uERQa1c6YSbyo1DzLYh2guYztILv1MlZH4iy12q3A
         h5abdLoezSngjninhzqeKs+YGtADIayEjtHiGcy2yUcBrIF0Z16sJqCGAvc3h0hA/52E
         1rJg==
X-Gm-Message-State: AOAM533KO11aMZyk9qdr0043PnMKh4BfL4EGZtjZeM8kocTN08+STu+W
        hG3l9QECq/GuaDA04t26X2Ic/DYUB3w=
X-Google-Smtp-Source: ABdhPJzXCu/aArjxa+Nc49g+eQ1BFK3lIWn6QqnHh1xRTHvRdXujIly9H5/H5iF2SlvQgPj/gCYPvA==
X-Received: by 2002:a05:6a00:421a:b0:4fa:9396:638f with SMTP id cd26-20020a056a00421a00b004fa9396638fmr872561pfb.63.1648057940495;
        Wed, 23 Mar 2022 10:52:20 -0700 (PDT)
Received: from 9a2d8922b8f1 ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id u9-20020a056a00158900b004faad3ae570sm533498pfk.189.2022.03.23.10.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 10:52:20 -0700 (PDT)
Date:   Wed, 23 Mar 2022 23:22:14 +0530
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Vladimir Zapolskiy <vz@mleia.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: dts: lpc18xx: Update SPI dma properties
Message-ID: <20220323175214.GA92241@9a2d8922b8f1>
References: <20220312180615.68929-1-singh.kuldeep87k@gmail.com>
 <20220312180615.68929-3-singh.kuldeep87k@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220312180615.68929-3-singh.kuldeep87k@gmail.com>
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 12, 2022 at 11:36:15PM +0530, Kuldeep Singh wrote:
> SPI pl022 describes dma-names as RX,TX.
> Reorder dmas and dma-names properties to follow specified convention.
> And while at it, also fix entries order within dma pairs.
> 
> Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>

Kindly consider this patch obsolete as it's not required.
Thanks for your time and patience.

Regards
Kuldeep
